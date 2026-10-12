// TOC:
//  - AppDatabase: @DriftDatabase that owns the table

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

import 'telemetry_queue.dart';
import 'telemetry_upload_log.dart';

part 'app_database.g.dart';

typedef AppDatabaseFun = AppDatabase? Function();

// Set to true to enable verbose Drift logging for debugging.
const _kEnableDriftLogging = false;

@DriftDatabase(tables: [TelemetryQueue, TelemetryUploadLog])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal(super.executor, {required this.filePath});

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
  static AppDatabase? _db;

  /// Returns a function that returns the singleton database instance.
  static AppDatabaseFun dbFactory = () => _db;

  /// Opens the database at an explicit filesystem path.
  ///
  /// If the file is corrupted (bad header, unrecoverable WAL, etc.) the
  /// corrupted files are deleted and a fresh database is returned.
  /// Telemetry loss on corruption is acceptable.
  ///
  /// Transient errors (file locks, I/O, permissions) are rethrown.
  static Future<AppDatabaseFun> open({required String filePath}) async {
    appkit.logDebug('[AppDatabase] open database: $filePath');
    _db = AppDatabase._internal(_openExecutor(filePath), filePath: filePath);
    try {
      // NativeDatabase is lazy — probe forces the real connection so corruption
      // is detected here rather than silently failing on first production query.
      await _db!.customSelect('SELECT 1').get();
      return dbFactory;
    } catch (error, stackTrace) {
      if (_isCorruptionError(error)) {
        appkit.logError('[AppDatabase] database corrupted, recreating: $error', stackTrace: stackTrace);
        await _db!.close();
        await removeFile(filePath: filePath);
        _db = AppDatabase._internal(_openExecutor(filePath), filePath: filePath);
        return dbFactory;
      } else {
        appkit.logError('[AppDatabase] transient error opening database, rethrowing: $error', stackTrace: stackTrace);
        await _db!.close();
        rethrow;
      }
    }
  }

  /// Defragments the database file by removing unused pages.
  ///
  /// routine vacuuming is unnecessary. Keep this as a manual maintenance tool.
  Future<void> vacuum() async {
    appkit.logDebug('[AppDatabase] vacuum database');
    await customSelect('VACUUM').get();
  }

  /// Closes and deletes this database.
  ///
  /// After this call, this database instance is permanently unusable.
  /// Create a new AppDatabase by calling [open].
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

  /// Deletes the database file if it exists.
  ///
  /// Also cleans up SQLite WAL (-wal) and SHM (-shm) ancillary files.
  /// Test-only helper to keep test runs isolated.
  static Future<void> removeFile({required String filePath}) async {
    final dbFile = File(filePath);
    if (await dbFile.exists()) {
      appkit.logDebug('[AppDatabase] delete database: $filePath');
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
