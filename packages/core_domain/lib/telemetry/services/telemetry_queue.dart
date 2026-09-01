// TOC:
//  - TelemetryQueueRepository: abstract persistent queue contract
//  - telemetryQueueRepositoryProvider: Riverpod provider (overridden in core_runtime)

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/queued_payload.dart';
import '../models/telemetry_payload.dart';
import '../models/upload_log.dart';
import '../models/upload_log_list.dart';

part 'telemetry_queue.g.dart';

abstract class TelemetryQueue {
  /// Persists [payload] so it will be uploaded on the next [UploadWorker]
  /// run.
  ///
  /// Idempotent when another row already exists with the same
  /// [TelemetryPayload.payloadId].
  Future<void> enqueue(TelemetryPayload payload);

  /// Returns all payload rows created within the last [daysBack] days. defaults to 7.
  ///
  /// Upload status is not part of this filter. Both pending and uploaded
  /// rows are included if createdAtMs is after the cutoff.
  Future<List<QueuedPayload>> fetchRecent({int daysBack = 7});

  /// Returns up to [limit] payloads that are pending upload.
  ///
  /// Excludes payloads already uploaded.
  Future<List<QueuedPayload>> fetchReady({int limit = 10});

  /// Persists one upload-attempt status record.
  ///
  /// Implementations may upsert by semantic ID so repeated attempts in the
  /// same hour/status bucket reuse the same row.
  Future<void> appendUploadLog(UploadLog log);

  /// Returns upload-attempt logs within the last [daysBack] days.
  ///
  /// Rows are ordered by newest attempt first.
  Future<List<UploadLogList>> fetchRecentUploadLogs({int daysBack = 7, int limit = 500});

  /// Returns a single upload-attempt log for the given semantic [id].
  ///
  /// Returns null when no row exists for that hour/status bucket.
  Future<UploadLog?> fetchUploadLogById(int id);

  /// Removes upload-attempt logs older than [before].
  Future<void> pruneUploadLogs(DateTime before);

  /// Marks multiple payloads as successfully uploaded in a single batch operation.
  /// Efficiently handles typical batches (1008 items) using SQL WHERE IN clause.
  Future<void> markUploadedBatch(List<String> ids);

  /// Removes all payload rows enqueued before [before].
  ///
  /// Expiry is based only on `createdAtMs`, regardless of upload status.
  Future<void> pruneExpired(DateTime before);

  /// Returns the number of payloads currently waiting to be sent (not uploaded).
  Future<int> pendingCount();

  /// Clears all telemetry data from the database.
  ///
  /// Deletes all queued payloads and upload logs, resetting the database
  /// to an empty state. Useful for clearing accumulated telemetry data
  /// and starting fresh without recreating the database connection.
  Future<void> reset();
}

@riverpod
TelemetryQueue telemetryQueue(Ref ref) {
  throw UnimplementedError('telemetryQueueProvider must be overridden');
}
