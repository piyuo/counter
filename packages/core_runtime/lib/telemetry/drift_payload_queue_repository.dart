// TOC:
//  - DriftPayloadQueueRepository: SQLite-backed PayloadQueueRepository
//
// Storage notes:
//  - All timestamps are stored as UTC milliseconds-since-epoch integers.
//  - Serialized payload (JSON) is stored verbatim from TelemetryPayload.toJson().
//  - startMs/endMs store payload window bounds for event-time inspection.
//  - All payload rows (pending or uploaded) are retained for 7 days.

import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:drift/drift.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

import 'telemetry_database.dart';

/// SQLite-backed implementation of [core_domain.TelemetryQueueRepository] built
/// on Drift.  All timestamps are stored as UTC milliseconds since epoch.
class DriftPayloadQueueRepository implements core_domain.TelemetryQueueRepository {
  DriftPayloadQueueRepository(this._db);

  final TelemetryDatabase _db;

  /// Enqueues [payload] for upload.
  ///
  /// Idempotent on duplicate [core_domain.TelemetryPayload.payloadId].
  /// Duplicate rows are ignored to preserve existing upload state.
  @override
  Future<void> enqueue(core_domain.TelemetryPayload payload) async {
    final nowMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    final startLocalHm = _formatLocalHourMinute(payload.startUtc);
    final endLocalHm = _formatLocalHourMinute(payload.endUtc);
    await _db
        .into(_db.telemetryQueue)
        // Detection engine payload IDs are unique; if a duplicate appears,
        // keep the existing row as-is (do not reset/overwrite upload state).
        .insert(
          TelemetryQueueCompanion.insert(
            id: payload.id,
            serializedPayload: jsonEncode(payload.toJson()),
            createdAtMs: nowMs,
            startMs: payload.startUtc.toUtc().millisecondsSinceEpoch,
            endMs: payload.endUtc.toUtc().millisecondsSinceEpoch,
          ),
          mode: InsertMode.insertOrIgnore,
        );
    appkit.logInfo('[TelemetryQueue] add payload: $startLocalHm-$endLocalHm, ');
  }

  /// Returns all payload rows created within the last [daysBack] days. defaults to 7.
  ///
  /// Upload status is not part of this filter. Both pending and uploaded
  /// rows are included if createdAtMs is after the cutoff.
  @override
  Future<List<core_domain.QueuedPayload>> fetchRecent({int daysBack = 7}) async {
    // Availability is based on enqueue time only.
    final cutoffMs = DateTime.now().toUtc().subtract(Duration(days: daysBack)).millisecondsSinceEpoch;
    final rows =
        await (_db.select(_db.telemetryQueue)
              ..where((t) => t.createdAtMs.isBiggerThanValue(cutoffMs))
              ..orderBy([(t) => OrderingTerm.desc(t.createdAtMs)]))
            .get();
    return rows.map(_toModel).toList();
  }

  /// Returns up to [limit] payloads in the pending queue that have not yet
  /// been successfully uploaded.
  /// Excludes payloads where uploadedAtMs is set.
  @override
  Future<List<core_domain.QueuedPayload>> fetchReady({int limit = 10}) async {
    final rows =
        await (_db.select(_db.telemetryQueue)
              ..where((t) => t.isPending)
              // Oldest first — ensures no payload is starved during retries.
              ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  @override
  Future<void> appendUploadLog(core_domain.UploadLog log) async {
    final attemptedAtUtc = log.attemptedAtUtc.toUtc();
    await _db
        .into(_db.telemetryUploadLog)
        .insertOnConflictUpdate(
          TelemetryUploadLogCompanion.insert(
            id: Value(log.id),
            attemptedAtMs: attemptedAtUtc.millisecondsSinceEpoch,
            success: log.success,
            payloadSizeKb: log.payloadSizeKb,
            payloadCount: Value(log.payloadCount),
            retryCount: Value(log.retryCount),
            error: Value(log.error),
          ),
        );
  }

  @override
  Future<List<core_domain.UploadLogList>> fetchRecentUploadLogs({int daysBack = 7, int limit = 500}) async {
    final cutoffMs = DateTime.now().toUtc().subtract(Duration(days: daysBack)).millisecondsSinceEpoch;
    final rows =
        await (_db.select(_db.telemetryUploadLog)
              ..where((t) => t.isAttemptedAfter(cutoffMs))
              ..orderBy([(t) => OrderingTerm.desc(t.attemptedAtMs)])
              ..limit(limit))
            .get();
    return rows.map(_toUploadLogList).toList();
  }

  @override
  Future<core_domain.UploadLog?> fetchUploadLogById(int id) async {
    final row = await (_db.select(_db.telemetryUploadLog)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toUploadLog(row);
  }

  @override
  Future<void> pruneUploadLogs(DateTime before) async {
    final beforeMs = before.toUtc().millisecondsSinceEpoch;
    await (_db.delete(_db.telemetryUploadLog)..where((t) => t.isAttemptedBefore(beforeMs))).go();
  }

  /// Removes all payload rows enqueued before [before].
  /// Deletes all queued payloads created before [before].
  ///
  /// Expiry is based only on `createdAtMs`, regardless of upload status.
  @override
  Future<void> pruneExpired(DateTime before) async {
    final beforeMs = before.toUtc().millisecondsSinceEpoch;
    await (_db.delete(_db.telemetryQueue)..where((t) => t.isCreatedBefore(beforeMs))).go();
  }

  @override
  Future<void> markUploadedBatch(List<String> ids) async {
    if (ids.isEmpty) return; // Avoid unnecessary database call
    final nowMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    // Batch update all payloads in a single WHERE IN clause for efficiency.
    await (_db.update(
      _db.telemetryQueue,
    )..where((t) => t.id.isIn(ids))).write(TelemetryQueueCompanion(uploadedAtMs: Value(nowMs)));
  }

  @override
  Future<int> pendingCount() async {
    final count = countAll();
    final query = _db.selectOnly(_db.telemetryQueue)
      ..addColumns([count])
      ..where(_db.telemetryQueue.isPending);
    return await query.map((row) => row.read(count) ?? 0).getSingle();
  }

  String _formatLocalHourMinute(DateTime utcTime) {
    final local = utcTime.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Converts a Drift row to a domain [core_domain.QueuedPayload].
  core_domain.QueuedPayload _toModel(TelemetryQueueData row) {
    return core_domain.QueuedPayload(
      id: row.id,
      payload: core_domain.TelemetryPayload.fromJson(jsonDecode(row.serializedPayload) as Map<String, dynamic>),
      createdAtUtc: DateTime.fromMillisecondsSinceEpoch(row.createdAtMs, isUtc: true),
      uploadedAtUtc: row.uploadedAtMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(row.uploadedAtMs!, isUtc: true),
    );
  }

  core_domain.UploadLog _toUploadLog(TelemetryUploadLogData row) {
    return core_domain.UploadLog(
      id: row.id,
      attemptedAtUtc: DateTime.fromMillisecondsSinceEpoch(row.attemptedAtMs, isUtc: true),
      success: row.success,
      payloadSizeKb: row.payloadSizeKb,
      payloadCount: row.payloadCount,
      retryCount: row.retryCount,
      error: row.error,
    );
  }

  core_domain.UploadLogList _toUploadLogList(TelemetryUploadLogData row) {
    return core_domain.UploadLogList(
      id: row.id,
      success: row.success,
      datetime: DateTime.fromMillisecondsSinceEpoch(row.attemptedAtMs, isUtc: true).toLocal(),
      payloadSizeKb: row.payloadSizeKb,
      payloadCount: row.payloadCount,
      error: row.error,
    );
  }
}
