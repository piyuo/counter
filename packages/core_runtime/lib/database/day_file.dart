// day_file.dart: Drift table for persisting DayFile documents.
import 'package:drift/drift.dart';

/// Persists complete daily aggregation documents.
class DayFile extends Table {
  /// Business date in YYYY-MM-DD format.
  TextColumn get businessDate => text()();

  /// Business year, stored separately for date-based queries.
  IntColumn get year => integer()();

  /// Business month, stored separately for date-based queries.
  IntColumn get month => integer()();

  /// Business day of month, stored separately for date-based queries.
  IntColumn get day => integer()();

  /// Gzip-compressed UTF-8 JSON for the serialized DaySummary.
  BlobColumn get data => blob()();

  /// Version of the persisted document format.
  IntColumn get schemaVersion => integer()();

  /// Milliseconds since epoch when this summary was first saved.
  IntColumn get createdAtMs => integer()();

  /// Milliseconds since epoch when this summary was last saved.
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {businessDate};
}
