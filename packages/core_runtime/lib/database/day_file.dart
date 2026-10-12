// telemetry_queue.dart: Drift table for persisting observation queue items.
import 'package:drift/drift.dart';

/// Current version of the serialized telemetry observation format.
const int kDayFileSchemaVersion = 1;

/// Persists complete DayFile documents.
@TableIndex.sql('''
  CREATE INDEX day_files_pending_ready_idx
  ON day_files (created_at_ms)
  WHERE delivered_at_ms IS NULL;
''')
// Full index for all-row time-window queries (fetchRecent/pruneExpired).
// ASC is sufficient because SQLite can scan a single-column index in reverse.
@TableIndex.sql('''
  CREATE INDEX day_files_created_at_idx
  ON day_files (created_at_ms);
''')
class DayFiles extends Table {
  /// Business date in YYYY-MM-DD format.
  TextColumn get businessDate => text()();

  /// Serialized DayFile JSON.
  TextColumn get data => text()();

  /// Version of the persisted document format.
  IntColumn get schemaVersion => integer()();

  /// Milliseconds since epoch — when this item was first enqueued.
  IntColumn get createdAtMs => integer()();

  /// Milliseconds since epoch when this document was last saved.
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {businessDate};
}
