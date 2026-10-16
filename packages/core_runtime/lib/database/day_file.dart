// day_file.dart: Drift table for persisting DayFile documents.
import 'package:drift/drift.dart';

/// Current version of the serialized telemetry observation format.
const int kDayFileSchemaVersion = 1;

/// Persists complete DayFile documents.
@TableIndex.sql('''
  CREATE INDEX day_file_pending_ready_idx
  ON day_file (created_at_ms)
  WHERE delivered_at_ms IS NULL;
''')
// Full index for all-row time-window queries (fetchRecent/pruneExpired).
// ASC is sufficient because SQLite can scan a single-column index in reverse.
@TableIndex.sql('''
  CREATE INDEX day_file_created_at_idx
  ON day_file (created_at_ms);
''')
class DayFile extends Table {
  /// Business date in YYYY-MM-DD format.
  TextColumn get businessDate => text()();

  /// Serialized DaySummary JSON.
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
