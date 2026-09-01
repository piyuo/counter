// TOC:
//  - TelemetryQueue: Drift table definition for the telemetry queue
//  - TelemetryQueue helpers: reusable query predicates for queue state
//  - TelemetryDatabase: @DriftDatabase that owns the table

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

part 'telemetry_database.g.dart';

typedef TelemetryDatabaseFun = DriftTelemetryDatabase? Function();

// Set to true to enable verbose Drift logging for debugging.
const _kEnableDriftLogging = false;

/// Drift table that persists payloads waiting to be (re-)sent.
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
  /// UUID v4 string; primary key. Matches [core_domain.TelemetryPayload.payloadId].
  TextColumn get id => text()();
  TextColumn get serializedPayload => text()();

  /// Milliseconds since epoch — when this item was first enqueued.
  IntColumn get createdAtMs => integer()();

  /// Milliseconds since epoch — observed window start time (UTC).
  IntColumn get startMs => integer()();

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

@DriftDatabase(tables: [TelemetryQueue, TelemetryUploadLog])
class DriftTelemetryDatabase extends _$TelemetryDatabase {
  DriftTelemetryDatabase._internal(super.executor, {required this.filePath});

  /// Path to the database file on disk. Used for logging and deletion.
  final String filePath;

  /// Returns true if [error] indicates database file corruption (not transient issues).
  ///
  /// Only deletes the DB on corruption-specific SQLite errors:
  /// - SQLITE_CORRUPT (11): corrupted database pages
  /// - SQLITE_NOTADB (26): file is not a valid database
  ///
  /// Transient errors (locked, I/O, permissions) are not deletion-candidates.
  static bool _isCorruptionError(Object error) {
    final message = error.toString();
    // Check for SQLite error codes in the error message.
    // sqlite3 package formats messages like "SqliteException(11): database disk image is malformed"
    return message.contains('(11)') || // SQLITE_CORRUPT
        message.contains('(26)') || // SQLITE_NOTADB
        message.contains('database disk image is malformed') ||
        message.contains('file is not a database') ||
        message.contains('database corruption');
  }

  /// Creates a [NativeDatabase] with WAL mode and busy-timeout configured.
  ///
  /// - WAL mode: concurrent readers don't block writers; crash-safe for
  ///   long-running processes with mixed read/write workloads.
  /// - busy_timeout: retries for up to 5 s on transient lock contention
  ///   instead of immediately throwing SQLITE_BUSY.
  /// - synchronous=NORMAL: keeps WAL writes durable enough for telemetry while
  ///   avoiding the extra fsync cost of FULL on every commit.
  /// - wal_autocheckpoint: checkpoint every 5000 pages (balances WAL growth vs I/O).
  /// - journal_size_limit: cap WAL at 50 MB to prevent unbounded growth on
  ///   long-running devices.
  static NativeDatabase _openExecutor(String filePath) => NativeDatabase(
    File(filePath),
    logStatements: _kEnableDriftLogging,
    setup: (db) {
      db.execute('PRAGMA journal_mode=WAL;');
      db.execute('PRAGMA busy_timeout=5000;');
      db.execute('PRAGMA synchronous=NORMAL;');
      db.execute('PRAGMA foreign_keys=ON;');
      db.execute('PRAGMA wal_autocheckpoint=5000;');
      db.execute('PRAGMA journal_size_limit=52428800;'); // 50 MB
    },
  );

  /// Singleton instance of the database. Lazily initialized on first open.
  static DriftTelemetryDatabase? _db;

  /// Returns a function that returns the singleton database instance.
  static TelemetryDatabaseFun dbFactory = () => _db;

  /// Opens the database at an explicit filesystem path.
  ///
  /// If the file is corrupted (bad header, unrecoverable WAL, etc.) the
  /// corrupted files are deleted and a fresh database is returned.
  /// Telemetry loss on corruption is acceptable.
  ///
  /// Transient errors (file locks, I/O, permissions) are rethrown.
  static Future<TelemetryDatabaseFun> open({required String filePath}) async {
    appkit.logDebug('[Telemetry] open database: $filePath');
    _db = DriftTelemetryDatabase._internal(_openExecutor(filePath), filePath: filePath);
    try {
      // NativeDatabase is lazy — probe forces the real connection so corruption
      // is detected here rather than silently failing on first production query.
      await _db!.customSelect('SELECT 1').get();
      return dbFactory;
    } catch (error, stackTrace) {
      if (_isCorruptionError(error)) {
        appkit.logError('[Telemetry] database corrupted, recreating: $error', stackTrace: stackTrace);
        await _db!.close();
        await removeFile(filePath: filePath);
        _db = DriftTelemetryDatabase._internal(_openExecutor(filePath), filePath: filePath);
        return dbFactory;
      } else {
        appkit.logError('[Telemetry] transient error opening database, rethrowing: $error', stackTrace: stackTrace);
        await _db!.close();
        rethrow;
      }
    }
  }

  /// Defragments the database file by removing unused pages.
  ///
  /// Telemetry is expected to remain small and reach a steady-state size, so
  /// routine vacuuming is unnecessary. Keep this as a manual maintenance tool.
  Future<void> vacuum() async {
    appkit.logDebug('[Telemetry] vacuum database');
    await customSelect('VACUUM').get();
  }

  /// Closes and deletes this database.
  ///
  /// After this call, this database instance is permanently unusable.
  /// Create a new TelemetryDatabase by calling [open].
  Future<void> reset() async {
    final oldDb = _db;
    _db = null;
    if (oldDb != null) {
      await oldDb.close();
    }
    // sleep for 2 seconds to ensure the file is released before deletion. This is a workaround for occasional file-locking issues on some platforms.
    await Future.delayed(const Duration(seconds: 2));
    await removeFile(filePath: filePath);
    await open(filePath: filePath);
  }

  /// Deletes the telemetry database file if it exists.
  ///
  /// Also cleans up SQLite WAL (-wal) and SHM (-shm) ancillary files.
  /// Test-only helper to keep test runs isolated.
  static Future<void> removeFile({required String filePath}) async {
    final dbFile = File(filePath);
    if (await dbFile.exists()) {
      appkit.logDebug('[Telemetry] delete database: $filePath');
      await dbFile.delete();
    }
    // Clean up SQLite ancillary files (WAL/SHM) for test isolation
    try {
      await File('$filePath-wal').delete();
    } catch (_) {}
    try {
      await File('$filePath-shm').delete();
    } catch (_) {}
  }

  @override
  int get schemaVersion => 1;
}
