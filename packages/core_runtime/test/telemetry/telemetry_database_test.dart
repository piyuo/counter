// TOC:
//  - TelemetryDatabase.open: uses explicit file path and creates sqlite file
//  - TelemetryDatabase.open: enables WAL journal mode
//  - TelemetryDatabase.open: configures busy timeout to 5000 ms
//  - TelemetryDatabase.open: configures synchronous mode to NORMAL
//  - TelemetryDatabase.open: configures WAL checkpoint and journal size limits
//  - TelemetryDatabase.open: recovers from a corrupted database file
//  - TelemetryDatabase.open: recovers from corrupted WAL ancillary files
//  - TelemetryDatabase.open: rethrows transient errors without deleting DB
//  - TelemetryDatabase.vacuum: defragments the database without error
//  - TelemetryDatabase.remove: deletes existing database file
//  - TelemetryDatabase.remove: no-op when file does not exist

import 'dart:io';

import 'package:core_runtime/telemetry/telemetry_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('telemetry_database_test_');
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('TelemetryDatabase', () {
    test('open uses explicit file path and creates sqlite file', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_open_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      await db().customSelect('SELECT 1').get();
      await db().close();

      expect(File(filePath).existsSync(), isTrue);
    });

    test('open enables WAL journal mode', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_wal_mode_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      final result = await db().customSelect('PRAGMA journal_mode').get();
      await db().close();

      expect(result.first.read<String>('journal_mode'), 'wal');
    });

    test('open configures busy timeout to 5000 ms', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_busy_timeout_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      final result = await db().customSelect('PRAGMA busy_timeout').get();
      await db().close();

      expect(result.first.read<int>('timeout'), 5000);
    });

    test('open configures synchronous mode to NORMAL', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_synchronous_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      final result = await db().customSelect('PRAGMA synchronous').get();
      await db().close();

      expect(result.first.read<int>('synchronous'), 1);
    });

    test('open configures WAL checkpoint and journal size limits', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_wal_limits_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      final checkpointResult = await db().customSelect('PRAGMA wal_autocheckpoint').get();
      final limitResult = await db().customSelect('PRAGMA journal_size_limit').get();
      await db().close();

      expect(checkpointResult.first.read<int>('wal_autocheckpoint'), 5000);
      expect(limitResult.first.read<int>('journal_size_limit'), 52428800); // 50 MB
    });

    test('open recovers from a corrupted database file', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_corrupt_test.db';

      // Write garbage bytes — simulates a corrupt DB header.
      await File(filePath).writeAsBytes(List.filled(4096, 0xFF));

      final db = await TelemetryDatabase.open(filePath: filePath);
      // If recovery worked the DB is usable and the corrupted file is gone.
      await db().customSelect('SELECT 1').get();
      await db().close();

      expect(File(filePath).existsSync(), isTrue);
    });

    test('open recovers from corrupted WAL ancillary files', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_wal_test.db';

      // Create a valid DB first, then corrupt the WAL file.
      final good = await TelemetryDatabase.open(filePath: filePath);
      await good().customSelect('SELECT 1').get();
      await good().close();
      await File('$filePath-wal').writeAsBytes(List.filled(512, 0xFF));

      final db = await TelemetryDatabase.open(filePath: filePath);
      await db().customSelect('SELECT 1').get();
      await db().close();

      expect(File(filePath).existsSync(), isTrue);
    });

    test('open rethrows transient errors without deleting DB', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_transient_test.db';

      // Create a valid DB first.
      final good = await TelemetryDatabase.open(filePath: filePath);
      await good().customSelect('SELECT 1').get();
      await good().close();

      expect(File(filePath).existsSync(), isTrue);

      // Replace the file with a directory — causes "can't open" error, not corruption.
      await File(filePath).delete();
      await Directory(filePath).create();

      // Attempting to open should fail, but not try to delete the directory.
      expect(() => TelemetryDatabase.open(filePath: filePath), throwsA(isA<Object>()));

      // Verify the directory is still there (not deleted).
      expect(Directory(filePath).existsSync(), isTrue);
    });

    test('vacuum defragments the database without error', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_vacuum_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      // Vacuum should succeed without error even on an empty database.
      await db().vacuum();
      await db().close();

      expect(File(filePath).existsSync(), isTrue);
    });

    test('remove deletes existing database file', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_remove_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      await db().customSelect('SELECT 1').get();
      await db().close();

      expect(File(filePath).existsSync(), isTrue);

      await TelemetryDatabase.removeFile(filePath: filePath);

      expect(File(filePath).existsSync(), isFalse);
    });

    test('remove is no-op when file does not exist', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_missing_test.db';

      expect(File(filePath).existsSync(), isFalse);

      await TelemetryDatabase.removeFile(filePath: filePath);

      expect(File(filePath).existsSync(), isFalse);
    });
  });
}
