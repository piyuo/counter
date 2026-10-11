// TOC:
//  - DriftPayloadQueueRepository: SQLite-backed PayloadQueueRepository
//
// Storage notes:
//  - All timestamps are stored as UTC milliseconds-since-epoch integers.
//  - Serialized payload (JSON) is stored verbatim from Observation.toJson().
//  - startMs store payload window bounds for event-time inspection.
//  - All payload rows (pending or uploaded) are retained for 7 days.

import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:drift/drift.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

import 'drift_telemetry_database.dart';

/// SQLite-backed implementation of [core_domain.TelemetryQueue] built
/// on Drift.  All timestamps are stored as UTC milliseconds since epoch.
class DriftTelemetryQueue implements core_domain.TelemetryQueue {
  DriftTelemetryQueue(this._dbFactory);

  final TelemetryDatabaseFun _dbFactory;

  /// Enqueues [payload] for upload.
  ///
  /// Idempotent on duplicate [core_domain.Observation.id].
  /// Duplicate rows are ignored to preserve existing upload state.
  @override
  Future<void> enqueue(core_domain.Observation observation) async {
    final nowMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    final id = observation.id.toString();
    final encodedJson = jsonEncode(observation.toJson());
    final db = _dbFactory();
    if (db == null) {
      return; // db is not available , probably in reset state, ignore operation
    }
    await db
        .into(db.telemetryQueue)
        // Detection engine payload IDs are unique; if a duplicate appears,
        // keep the existing row as-is (do not reset/overwrite upload state).
        .insert(
          TelemetryQueueCompanion.insert(id: id, serializedPayload: encodedJson, createdAtMs: nowMs, startMs: 0),
          mode: InsertMode.insertOrIgnore,
        );
    appkit.logDebug('[TelemetryQueue] add payload: $id');
  }

  /// Returns all payload rows created within the last [daysBack] days. defaults to 7.
  ///
  /// Upload status is not part of this filter. Both pending and uploaded
  /// rows are included if createdAtMs is after the cutoff.
  @override
  Future<List<core_domain.QueuedObservation>> fetchRecent({int daysBack = 7}) async {
    final db = _dbFactory();
    if (db == null) {
      return []; // db is not available, return empty list
    }
    // Availability is based on enqueue time only.
    final cutoffMs = DateTime.now().toUtc().subtract(Duration(days: daysBack)).millisecondsSinceEpoch;
    final rows =
        await (db.select(db.telemetryQueue)
              ..where((t) => t.createdAtMs.isBiggerThanValue(cutoffMs))
              ..orderBy([(t) => OrderingTerm.desc(t.createdAtMs)]))
            .get();
    return rows.map(_toModel).toList();
  }

  /// Returns up to [limit] payloads in the pending queue that have not yet
  /// been successfully uploaded.
  /// Excludes payloads where uploadedAtMs is set.
  @override
  Future<List<core_domain.QueuedObservation>> fetchReady({int limit = 10}) async {
    final db = _dbFactory();
    if (db == null) {
      return []; // db is not available, return empty list
    }
    final rows =
        await (db.select(db.telemetryQueue)
              ..where((t) => t.isPending)
              // Oldest first — ensures no payload is starved during retries.
              ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)])
              ..limit(limit))
            .get();
    return rows.map(_toModel).toList();
  }

  @override
  Future<void> appendUploadLog(core_domain.UploadLog log) async {
    final db = _dbFactory();
    if (db == null) {
      return; // db is not available, ignore operation
    }
    final attemptedAtUtc = log.attemptedAtUtc.toUtc();
    await db
        .into(db.telemetryUploadLog)
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
    final db = _dbFactory();
    if (db == null) {
      return []; // db is not available, return empty list
    }
    final cutoffMs = DateTime.now().toUtc().subtract(Duration(days: daysBack)).millisecondsSinceEpoch;
    final rows =
        await (db.select(db.telemetryUploadLog)
              ..where((t) => t.isAttemptedAfter(cutoffMs))
              ..orderBy([(t) => OrderingTerm.desc(t.attemptedAtMs)])
              ..limit(limit))
            .get();
    return rows.map(_toUploadLogList).toList();
  }

  @override
  Future<core_domain.UploadLog?> fetchUploadLogById(int id) async {
    final db = _dbFactory();
    if (db == null) {
      return null; // db is not available
    }
    final row = await (db.select(db.telemetryUploadLog)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toUploadLog(row);
  }

  @override
  Future<void> pruneUploadLogs(DateTime before) async {
    final db = _dbFactory();
    if (db == null) {
      return; // db is not available, ignore operation
    }
    final beforeMs = before.toUtc().millisecondsSinceEpoch;
    await (db.delete(db.telemetryUploadLog)..where((t) => t.isAttemptedBefore(beforeMs))).go();
  }

  /// Removes all payload rows enqueued before [before].
  /// Deletes all queued payloads created before [before].
  ///
  /// Expiry is based only on `createdAtMs`, regardless of upload status.
  @override
  Future<void> pruneExpired(DateTime before) async {
    final db = _dbFactory();
    if (db == null) {
      return; // db is not available, ignore operation
    }
    final beforeMs = before.toUtc().millisecondsSinceEpoch;
    await (db.delete(db.telemetryQueue)..where((t) => t.isCreatedBefore(beforeMs))).go();
  }

  @override
  Future<void> markUploadedBatch(List<int> observationIds) async {
    if (observationIds.isEmpty) return; // Avoid unnecessary database call
    final db = _dbFactory();
    if (db == null) {
      return; // db is not available, ignore operation
    }
    final nowMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    final ids = observationIds.map((id) => id.toString()).toList(growable: false);
    // Batch update all payloads in a single WHERE IN clause for efficiency.
    await (db.update(
      db.telemetryQueue,
    )..where((t) => t.id.isIn(ids))).write(TelemetryQueueCompanion(uploadedAtMs: Value(nowMs)));
  }

  @override
  Future<int> pendingCount() async {
    final db = _dbFactory();
    if (db == null) {
      return 0; // db is not available, return 0 pending count
    }
    final count = countAll();
    final query = db.selectOnly(db.telemetryQueue)
      ..addColumns([count])
      ..where(db.telemetryQueue.isPending);
    return await query.map((row) => row.read(count) ?? 0).getSingle();
  }

  /// Clears all telemetry data from the database.
  ///
  /// Deletes all queued payloads and upload logs, effectively resetting the
  /// database to an empty state while maintaining the database connection.
  /// This is useful for clearing accumulated telemetry data and starting fresh.
  @override
  Future<void> reset() async {
    final db = _dbFactory();
    if (db == null) {
      return; // db is not available , probably in reset state, ignore operation
    }
    await db.reset();
    appkit.logInfo('[TelemetryQueue] telemetry database reset');
  }

  /// Converts a Drift row to a domain [core_domain.QueuedObservation].
  core_domain.QueuedObservation _toModel(TelemetryQueueData row) {
    final storedJson = jsonDecode(row.serializedPayload) as Map<String, dynamic>;
    final observationJson = storedJson['observation'] as Map<String, dynamic>?;
    final observation = observationJson == null
        ? core_domain.Observation.fromJson(storedJson)
        : _decodeLegacyObservation(observationJson, storedJson['occupancies'] as Map<String, dynamic>?);
    return core_domain.QueuedObservation(
      observation: observation,
      createdAtUtc: DateTime.fromMillisecondsSinceEpoch(row.createdAtMs, isUtc: true),
      uploadedAtUtc: row.uploadedAtMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(row.uploadedAtMs!, isUtc: true),
    );
  }

  core_domain.Observation _decodeLegacyObservation(Map<String, dynamic> json, Map<String, dynamic>? occupancies) {
    final areas = (json['areas'] as List<dynamic>).map((value) {
      final area = Map<String, dynamic>.from(value as Map);
      final areaId = area['areaId'].toString();
      area.putIfAbsent('lastOccupancy', () => (occupancies?[areaId] as num?)?.toInt() ?? 0);
      return area;
    }).toList();
    return core_domain.Observation.fromJson({...json, 'areas': areas});
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
