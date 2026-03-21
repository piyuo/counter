// TOC:
//  - TelemetryDatabase.open: uses explicit file path and creates sqlite file
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
      await db.customSelect('SELECT 1').get();
      await db.close();

      expect(File(filePath).existsSync(), isTrue);
    });

    test('remove deletes existing database file', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_remove_test.db';

      final db = await TelemetryDatabase.open(filePath: filePath);
      await db.customSelect('SELECT 1').get();
      await db.close();

      expect(File(filePath).existsSync(), isTrue);

      await TelemetryDatabase.remove(filePath: filePath);

      expect(File(filePath).existsSync(), isFalse);
    });

    test('remove is no-op when file does not exist', () async {
      final filePath = '${tempDir.path}${Platform.pathSeparator}telemetry_missing_test.db';

      expect(File(filePath).existsSync(), isFalse);

      await TelemetryDatabase.remove(filePath: filePath);

      expect(File(filePath).existsSync(), isFalse);
    });
  });
}
