// year_file.dart: Drift table for persisting YearFile documents.
import 'package:drift/drift.dart';

/// Persists complete yearly aggregation documents.
class YearFile extends Table {
  /// Business date in YYYY format.
  TextColumn get businessDate => text()();

  /// Business year, stored separately for date-based queries.
  IntColumn get year => integer()();

  /// Gzip-compressed UTF-8 JSON for the serialized YearSummary.
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
