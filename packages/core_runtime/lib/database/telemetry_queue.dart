// telemetry_queue.dart: Drift table for persisting observation queue items.
import 'package:drift/drift.dart';

/// Current version of the serialized telemetry observation format.
const int kTelemetryQueueSchemaVersion = 1;

/// Drift table that persists observation waiting to be (re-)sent.
// Partial index for pending-only scans (fetchReady): keeps index small and hot.
@TableIndex.sql('''
  CREATE INDEX telemetry_queue_pending_ready_idx
  ON telemetry_queue (created_at_ms)
  WHERE delivered_at_ms IS NULL;
''')
// Full index for all-row time-window queries (fetchRecent/pruneExpired).
// ASC is sufficient because SQLite can scan a single-column index in reverse.
@TableIndex.sql('''
  CREATE INDEX telemetry_queue_created_at_idx
  ON telemetry_queue (created_at_ms);
''')
class TelemetryQueue extends Table {
  /// observation id like 202006112230
  IntColumn get id => integer()();

  /// Serialized observation JSON.
  TextColumn get data => text()();

  /// Version of the persisted document format.
  IntColumn get schemaVersion => integer()();

  /// Milliseconds since epoch — when this item was first enqueued.
  IntColumn get createdAtMs => integer()();

  /// Milliseconds since epoch — when this item was successfully uploaded.
  /// NULL if not yet uploaded.
  /// Uses legacy column name for backward compatibility with existing databases.
  IntColumn get uploadedAtMs => integer().named('delivered_at_ms').nullable()();

  /// Returns `true` when the payload has been uploaded.
  Expression<bool> get isUploaded => uploadedAtMs.isNotNull();

  /// Returns `true` when the payload is still pending upload.
  Expression<bool> get isPending => uploadedAtMs.isNull();

  /// Returns `true` when the payload was uploaded on or after [cutoffMs].
  Expression<bool> isUploadedAfter(int cutoffMs) => isUploaded & uploadedAtMs.isBiggerOrEqualValue(cutoffMs);

  /// Returns `true` when the payload was enqueued before [beforeMs].
  Expression<bool> isCreatedBefore(int beforeMs) => createdAtMs.isSmallerThanValue(beforeMs);

  @override
  Set<Column> get primaryKey => {id};
}
