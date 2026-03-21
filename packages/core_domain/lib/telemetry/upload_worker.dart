// TOC:
//  - UploadWorker: drains the persistent queue in batches
//
// Behaviour:
//  - Calls configResolver on every run(); returns early when null (no backend).
//  - Prunes expired items before the upload loop.

import 'dart:math' as math;

import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

import 'models/telemetry_payload.dart';
import 'models/upload_log.dart';
import 'models/upload_session.dart';
import 'response_worker.dart';
import 'services/payload_queue_repository.dart';
import 'services/payload_serializer.dart';
import 'services/telemetry_transport.dart';

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
  final TelemetryQueueRepository queue;

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

  /// Last human-readable upload error message.
  String? lastError;

  /// Drains the queue in batches until empty or until a transport error occurs.
  ///
  /// Returns `true` when the run completes without upload issues.
  ///
  /// Returns `false` when no backend is configured or when any batch fails.
  Future<bool> run() async {
    final session = await _sessionResolver();
    if (session == null) {
      isLastUploadSuccess = false;
      lastError = 'session_unavailable';
      return false;
    }
    final config = session.config;
    final nowUtc = DateTime.now().toUtc();

    // Prune stale items first so they don't count against the batch limit.
    await queue.pruneExpired(nowUtc.subtract(Duration(days: config.payloadRetentionDays)));
    await queue.pruneUploadLogs(nowUtc.subtract(Duration(days: config.uploadLogRetentionDays)));

    while (true) {
      final batch = await queue.fetchReady(limit: config.maxBatchSize);
      if (batch.isEmpty) break;

      final uploaded = await _deliverBatch(
        session: session,
        payloads: batch.map((p) => p.payload).toList(growable: false),
        onSuccess: () async {
          // Mark all payloads as uploaded in a single batch operation.
          await queue.markUploadedBatch(batch.map((item) => item.id).toList(growable: false));
        },
      );
      if (!uploaded) return false;
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
    if (session == null) {
      isLastUploadSuccess = false;
      lastError = 'No telemetry backend is configured.';
      return false;
    }

    final batchSize = session.config.maxBatchSize <= 0 ? payloads.length : session.config.maxBatchSize;
    var cursor = 0;
    while (cursor < payloads.length) {
      final end = math.min(cursor + batchSize, payloads.length);
      final chunk = payloads.sublist(cursor, end);
      final uploaded = await _deliverBatch(session: session, payloads: chunk);
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
    int sizeKb = 0;
    try {
      final body = serializer.serialize(
        payloads,
        schemaVersion: TelemetryPayload.schemaVersion,
        deviceId: session.deviceId,
      );
      sizeKb = (body.length / 1024).round();
      final response = await transport.send(
        url: session.dataServer.url,
        bearerToken: session.bearerToken,
        body: body,
        contentType: serializer.contentType,
      );
      await responseWorker.process(response);
      if (!response.ok) {
        await _recordUploadOutcome(
          success: false,
          attemptedAt: DateTime.now().toUtc(),
          payloadSizeKb: sizeKb,
          payloadCount: payloads.length,
          error: response.error,
        );
        //        appkit.logError('[UploadWorker] rejected ${payloads.length} payload(s), $sizeKb KB  ${response.error}');
        return false;
      }

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
        error: '$error\n$stackTrace',
      );
      appkit.logError('[UploadWorker] failed: $error');
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
    String? error,
  }) async {
    // Update worker-level status so UI/callers can inspect the most recent outcome.
    lastUploadTimeUtc = attemptedAt;
    isLastUploadSuccess = success;
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
