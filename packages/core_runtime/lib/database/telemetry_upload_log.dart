// TOC:
//  - TelemetryQueue: Drift table definition for the telemetry queue
//  - TelemetryQueue helpers: reusable query predicates for queue state
//  - TelemetryDatabase: @DriftDatabase that owns the table

import 'package:drift/drift.dart';

/// Drift table that persists one record per upload attempt.
@TableIndex.sql('''
  CREATE INDEX telemetry_upload_logs_attempted_at_idx
  ON telemetry_upload_log (attempted_at_ms DESC);
''')
@TableIndex.sql('''
  CREATE INDEX telemetry_upload_logs_attempted_at_success_idx
  ON telemetry_upload_log (attempted_at_ms DESC, success);
''')
class TelemetryUploadLog extends Table {
  /// Semantic primary key in UTC hour/status format: yyyyMMddHHs.
  ///
  /// Success digit:
  /// - 1: success
  /// - 0: failed
  ///
  /// Allows 2 records per hour (success/failure) without ID collisions during retries.
  IntColumn get id => integer()();

  /// True if the upload attempt succeeded.
  BoolColumn get success => boolean()();

  /// Milliseconds since epoch — timestamp of the upload attempt.
  IntColumn get attemptedAtMs => integer()();

  /// Serialized payload size sent in this attempt, rounded to KB.
  IntColumn get payloadSizeKb => integer().named('size_kb')();

  /// Number of payload items included in this upload attempt.
  IntColumn get payloadCount => integer().withDefault(const Constant(0))();

  /// Retry number captured for this upload attempt.
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// Human-readable error message from failed attempts.
  TextColumn get error => text().nullable()();

  /// Returns true when this log row was recorded before [beforeMs].
  Expression<bool> isAttemptedBefore(int beforeMs) => attemptedAtMs.isSmallerThanValue(beforeMs);

  /// Returns true when this log row was recorded after [cutoffMs].
  Expression<bool> isAttemptedAfter(int cutoffMs) => attemptedAtMs.isBiggerOrEqualValue(cutoffMs);

  @override
  Set<Column> get primaryKey => {id};
}
