// TOC:
//  - UploadWorker: drains the persistent queue in batches
//
// Behaviour:
//  - Calls configResolver on every run(); returns early when null (no backend).
//  - Prunes expired items before the upload loop.

import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/core_domain.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

/// Prune queued payloads older than this many days.
const int kPayloadRetentionDays = 7;

/// Maximum records bundled into a single upload request.
/// 1008 ≈ 3.5 days per batch — since we only keep 7 days of data, so two batches would cover the retention period.
const int kMaxBatchSize = 1008;

/// Drains the persistent queue by sending batches to the backend.
///
/// Each call to [run] loops until either:
/// - the queue is empty (all payloads uploaded), or
/// - a network/server error occurs (upload stops for this run).
class UploadWorker {
  UploadWorker({
    required this.queue,
    required this.serializer,
    required this.transport,
    this.responseWorker = const ResponseWorker(),

    /// Returns the current [UploadConfig], or null when no backend is
    /// configured (e.g. first-run, unspecified backend).  Run is a no-op when
    /// null is returned.
    required Future<UploadSession?> Function() sessionResolver,
  }) : _sessionResolver = sessionResolver;

  /// Persistent queue of payloads awaiting upload.
  final TelemetryQueue queue;

  /// Encodes payloads to bytes for transmission.
  final PayloadSerializer serializer;

  /// Delivers serialized bytes to the backend endpoint.
  final TelemetryTransport transport;

  /// Parses the raw [TelemetryResponse] from the backend into a normalised
  /// result (ok / error code / client-error flag).
  final ResponseWorker responseWorker;
  final Future<UploadSession?> Function() _sessionResolver;

  /// UTC timestamp for the most recent upload attempt (success or failure).
  DateTime? lastUploadTimeUtc;

  /// Outcome of the most recent upload attempt.
  ///
  /// - `true`: last attempt succeeded
  /// - `false`: last attempt failed
  /// - `null`: no attempt has happened yet
  bool? isLastUploadSuccess;

  /// Machine-readable error code from the last failed attempt.
  core_domain.TelemetryErrorCode? lastErrorCode;

  /// Last human-readable upload error message.
  String? lastError;

  String? lastUrl;

  /// Groups [items] by businessDate, preserving oldest-first order within each group.
  /// Returns an ordered list of groups so earlier dates are uploaded first.
  List<List<QueuedPayload>> _splitByBusinessDate(List<QueuedPayload> items) {
    final Map<String, List<QueuedPayload>> grouped = {};
    for (final item in items) {
      final date = item.payload.businessDate;
      (grouped[date] ??= []).add(item);
    }
    // Preserve chronological order of dates.
    return grouped.values.toList();
  }

  /// Drains the queue in batches until empty or until a transport error occurs.
  ///
  /// Returns `true` when the run completes without upload issues.
  ///
  /// Returns `false` when no backend is configured or when any batch fails.
  Future<bool> run() async {
    // Prune stale items first so they don't count against the batch limit.
    final nowUtc = DateTime.now().toUtc();
    await queue.pruneExpired(nowUtc.subtract(Duration(days: kPayloadRetentionDays)));
    await queue.pruneUploadLogs(nowUtc.subtract(Duration(days: kPayloadRetentionDays)));

    // check for a configured backend; if none, return early (no-op).
    final session = await _sessionResolver();
    if (session == null) {
      isLastUploadSuccess = false;
      lastError = 'No backend is configured';
      return false;
    }

    while (true) {
      final batch = await queue.fetchReady(limit: kMaxBatchSize);
      if (batch.isEmpty) break;

      // Split by businessDate — server requires all payloads in a batch share the same date.
      final dateGroups = _splitByBusinessDate(batch);
      for (final group in dateGroups) {
        appkit.logInfo('[UploadWorker] uploading ${group.length} payload(s) for ${group.first.payload.businessDate}');
        lastError = null;
        lastErrorCode = null;
        lastUrl = null;
        final uploaded = await _deliverBatch(
          session: session,
          payloads: group.map((p) => p.payload).toList(growable: false),
          onSuccess: () async {
            await queue.markUploadedBatch(group.map((item) => item.id).toList(growable: false));
          },
        );
        if (!uploaded) {
          // no further attempts this run; next run will retry the same batch.
          return false;
        }
      }
    }
    return true;
  }

  /// Sends [payloads] directly to backend in config-sized batches.
  ///
  /// This bypasses queue persistence and is intended for user-triggered resend
  /// flows where payloads are explicitly selected from history.
  ///
  /// Returns true when all batches are uploaded successfully.
  Future<bool> sendPayloadsDirect(List<TelemetryPayload> payloads) async {
    if (payloads.isEmpty) return true;

    final session = await _sessionResolver();
    assert(
      session != null,
      'UploadWorker.sendPayloadsDirect() called but no backend is configured; check sessionResolver',
    );

    final batchSize = kMaxBatchSize <= 0 ? payloads.length : kMaxBatchSize;
    var cursor = 0;
    while (cursor < payloads.length) {
      final end = math.min(cursor + batchSize, payloads.length);
      final chunk = payloads.sublist(cursor, end);
      final uploaded = await _deliverBatch(session: session!, payloads: chunk);
      if (!uploaded) return false;
      cursor = end;
    }

    return true;
  }

  Future<bool> _deliverBatch({
    required UploadSession session,
    required List<TelemetryPayload> payloads,
    Future<void> Function()? onSuccess,
  }) async {
    lastUrl = getUrlFromDataServer(session.dataServer);
    if (lastUrl == null) {
      assert(false, '[UploadWorker] no URL for data server ${session.dataServer}');
      return false;
    }
    int sizeKb = 0;
    try {
      final body = serializer.serialize(
        payloads,
        schemaVersion: TelemetryPayload.schemaVersion,
        deviceId: session.deviceId,
        projectId: getProjectIdFromDataServer(session.dataServer),
        assignId: getAssignedIdFromDataServer(session.dataServer),
      );
      sizeKb = (body.length / 1024).round();
      final response = await transport.send(
        url: lastUrl!,
        bearerToken: session.bearerToken,
        body: body,
        contentType: serializer.contentType,
      );
      if (!response.ok) {
        await _recordUploadOutcome(
          success: false,
          attemptedAt: DateTime.now().toUtc(),
          payloadSizeKb: sizeKb,
          payloadCount: payloads.length,
          errorCode: response.errorCode,
          error: response.error,
        );
        return false;
      }
      await responseWorker.process(response);

      if (onSuccess != null) await onSuccess();
      await _recordUploadOutcome(
        success: true,
        attemptedAt: DateTime.now().toUtc(),
        payloadSizeKb: sizeKb,
        payloadCount: payloads.length,
      );
      appkit.logInfo('[Telemetry] Uploaded batch of ${payloads.length} payload(s), $sizeKb KB');
      return true;
    } catch (error, stackTrace) {
      await _recordUploadOutcome(
        success: false,
        attemptedAt: DateTime.now().toUtc(),
        payloadSizeKb: sizeKb,
        payloadCount: payloads.length,
        errorCode: TelemetryErrorCode.httpUnknownError,
        error: '$error\n$stackTrace',
      );
      appkit.logDebug('[UploadWorker] failed: $error');
      return false;
    }
  }

  /// Records an upload attempt outcome by updating worker status and persisting to database.
  ///
  /// This combines updating internal state fields with logging the attempt to the queue,
  /// ensuring status and persistence are always kept in sync.
  Future<void> _recordUploadOutcome({
    required DateTime attemptedAt,
    required bool success,
    required int payloadSizeKb,
    required int payloadCount,
    core_domain.TelemetryErrorCode? errorCode,
    String? error,
  }) async {
    // Update worker-level status so UI/callers can inspect the most recent outcome.
    lastUploadTimeUtc = attemptedAt;
    isLastUploadSuccess = success;
    lastErrorCode = errorCode;
    lastError = error;

    int retryCount = 0;
    final id = UploadLog.generateIdFromUtcTime(attemptedAt, success: success);
    final latestLogForHour = await queue.fetchUploadLogById(id);
    if (latestLogForHour != null) {
      retryCount = latestLogForHour.retryCount + 1;
    }

    // Persist the outcome to the queue for diagnostics/UI history.
    await queue.appendUploadLog(
      UploadLog(
        id: id,
        attemptedAtUtc: attemptedAt,
        success: success,
        payloadSizeKb: payloadSizeKb,
        payloadCount: payloadCount,
        retryCount: retryCount,
        error: error,
      ),
    );
  }
}
