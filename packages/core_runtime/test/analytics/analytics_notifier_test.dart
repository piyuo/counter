// TOC
// 1. AnalyticsNotifier persistence tests

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/analytics/analytics_notifier.dart';
import 'package:core_runtime/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

core_domain.Observation _observation({
  required int hour,
  required int minute,
  int year = 2026,
  int month = 10,
  int day = 16,
  core_domain.ObservationGranularity granularity = core_domain.ObservationGranularity.minutes5,
  int frameCount = 1,
}) {
  return core_domain.Observation(
    granularity: granularity,
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    confidenceSum: 0,
    confidenceSampleCount: 0,
    coveredSeconds: 300,
    areas: const [],
    frameCount: frameCount,
  );
}

Uint8List _gzipJson(String json) => Uint8List.fromList(GZipCodec().encode(utf8.encode(json)));

core_domain.DaySummary _decodeSummary(DayFileData row) {
  final json = utf8.decode(GZipCodec().decode(row.data));
  return core_domain.DaySummary.fromJson(jsonDecode(json) as Map<String, dynamic>);
}

void main() {
  late Directory tempDirectory;
  late String databasePath;
  late AppDatabase database;
  late AppDatabaseFun openedDatabaseFactory;
  late AppDatabaseFun activeDatabaseFactory;
  late ProviderContainer container;
  late AnalyticsNotifier notifier;
  late int nowMs;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp('analytics_notifier_test_');
    databasePath = '${tempDirectory.path}${Platform.pathSeparator}analytics.db';
    openedDatabaseFactory = await AppDatabase.open(filePath: databasePath);
    database = openedDatabaseFactory()!;
    activeDatabaseFactory = () => database;
    nowMs = DateTime.utc(2026, 10, 16).millisecondsSinceEpoch;
    container = ProviderContainer(
      overrides: [
        analyticsProvider.overrideWith(
          () => AnalyticsNotifier(
            databaseFactory: () => activeDatabaseFactory(),
            nowProvider: () => DateTime.fromMillisecondsSinceEpoch(nowMs, isUtc: true),
          ),
        ),
      ],
    );
    notifier = container.read(analyticsProvider.notifier);
  });

  tearDown(() async {
    container.dispose();
    await database.close();
    await AppDatabase.removeFile(filePath: databasePath);
    if (await tempDirectory.exists()) await tempDirectory.delete(recursive: true);
  });

  Future<DayFileData?> readDay(String businessDate) {
    return (database.select(database.dayFile)..where((row) => row.businessDate.equals(businessDate))).getSingleOrNull();
  }

  group('AnalyticsNotifier', () {
    test('creates a DayFile for a valid five-minute observation', () async {
      await notifier.add(_observation(hour: 10, minute: 0));

      final row = await readDay('2026-10-16');
      expect(row, isNotNull);
      final savedRow = row!;
      expect(savedRow.year, 2026);
      expect(savedRow.month, 10);
      expect(savedRow.day, 16);
      expect(savedRow.schemaVersion, core_domain.kSchemaVersion);
      expect(savedRow.createdAtMs, nowMs);
      expect(savedRow.updatedAtMs, nowMs);
      expect(savedRow.data.take(2).toList(), [0x1f, 0x8b]);
      final summary = _decodeSummary(savedRow);
      expect(summary.fiveMinuteObservations, hasLength(1));
      expect(savedRow.data.length, lessThan(utf8.encode(jsonEncode(summary.toJson())).length));
      final matchingRows =
          await (database.select(database.dayFile)
                ..where((dayFile) => dayFile.year.equals(2026))
                ..where((dayFile) => dayFile.month.equals(10))
                ..where((dayFile) => dayFile.day.equals(16)))
              .get();
      expect(matchingRows, [savedRow]);
    });

    test('updates an existing day and recalculates hourly and daily summaries', () async {
      await notifier.add(_observation(hour: 10, minute: 0, frameCount: 2));
      final original = (await readDay('2026-10-16'))!;
      nowMs += 100;

      await notifier.add(_observation(hour: 10, minute: 5, frameCount: 3));

      final updated = (await readDay('2026-10-16'))!;
      final summary = _decodeSummary(updated);
      expect(summary.fiveMinuteObservations, hasLength(2));
      expect(summary.hourlyObservations, hasLength(1));
      expect(summary.hourlyObservations.single.frameCount, 5);
      expect(summary.dailyObservation.frameCount, 5);
      expect(updated.createdAtMs, original.createdAtMs);
      expect(updated.updatedAtMs, nowMs);
      expect(updated.data, isNot(original.data));
    });

    test('creates separate DayFiles for different business dates', () async {
      await notifier.add(_observation(hour: 23, minute: 55));
      await notifier.add(_observation(year: 2026, month: 10, day: 17, hour: 0, minute: 0));

      expect(await readDay('2026-10-16'), isNotNull);
      expect(await readDay('2026-10-17'), isNotNull);
      expect(await database.select(database.dayFile).get(), hasLength(2));
    });

    test('retrieves and decodes a DaySummary by business date', () async {
      await notifier.add(_observation(hour: 10, minute: 0, frameCount: 8));

      final summary = await notifier.getDaySummary(2026, 10, 16);

      expect(summary, isNotNull);
      expect(summary!.businessDate, '2026-10-16');
      expect(summary.dailyObservation.frameCount, 8);
    });

    test('returns null when no DaySummary exists for the business date', () async {
      expect(await notifier.getDaySummary(2026, 10, 16), isNull);
    });

    test('rejects invalid integer date components', () async {
      await expectLater(notifier.getDaySummary(2026, 2, 30), throwsArgumentError);
      await expectLater(notifier.getMonthSummary(2026, 13), throwsArgumentError);
      await expectLater(notifier.getYearSummary(999), throwsArgumentError);
    });

    test('builds the current month summary from its available days', () async {
      await notifier.add(_observation(hour: 10, minute: 0, day: 16, frameCount: 3));
      await notifier.add(_observation(hour: 11, minute: 0, day: 17, frameCount: 5));

      final summary = await notifier.getMonthSummary(2026, 10);

      expect(summary, isNotNull);
      expect(summary!.businessDate, '2026-10');
      expect(summary.dailyObservations.map((observation) => observation.day), [16, 17]);
      expect(summary.monthlyObservation.frameCount, 8);
      expect(await database.select(database.monthFile).get(), isEmpty);
    });

    test('builds and caches a historical month, then returns the cached summary', () async {
      await notifier.add(_observation(year: 2025, month: 9, day: 2, hour: 10, minute: 0, frameCount: 3));

      final built = await notifier.getMonthSummary(2025, 9);

      expect(built, isNotNull);
      expect(built!.monthlyObservation.frameCount, 3);
      final saved =
          await (database.select(database.monthFile)
                ..where((row) => row.year.equals(2025))
                ..where((row) => row.month.equals(9)))
              .getSingle();
      expect(saved.year, 2025);
      expect(saved.month, 9);
      expect(saved.schemaVersion, core_domain.kSchemaVersion);
      expect(saved.data.take(2).toList(), [0x1f, 0x8b]);

      await notifier.add(_observation(year: 2025, month: 9, day: 2, hour: 10, minute: 5, frameCount: 4));
      final cached = await notifier.getMonthSummary(2025, 9);

      expect(cached!.monthlyObservation.frameCount, 3);
    });

    test('builds and caches a historical year from available months', () async {
      await notifier.add(_observation(year: 2025, month: 1, day: 2, hour: 10, minute: 0, frameCount: 3));
      await notifier.add(_observation(year: 2025, month: 3, day: 4, hour: 10, minute: 0, frameCount: 5));

      final summary = await notifier.getYearSummary(2025);

      expect(summary, isNotNull);
      expect(summary!.businessDate, '2025');
      expect(summary.monthlyObservations.map((observation) => observation.month), [1, 3]);
      expect(summary.yearlyObservation.frameCount, 8);
      final saved = await (database.select(database.yearFile)..where((row) => row.year.equals(2025))).getSingle();
      expect(saved.year, 2025);
      expect(saved.schemaVersion, core_domain.kSchemaVersion);
      expect(saved.data.take(2).toList(), [0x1f, 0x8b]);
    });

    test('rebuilds the current year and does not cache it', () async {
      await notifier.add(_observation(year: 2026, month: 10, day: 16, hour: 10, minute: 0, frameCount: 3));

      final first = await notifier.getYearSummary(2026);
      await notifier.add(_observation(year: 2026, month: 10, day: 17, hour: 10, minute: 0, frameCount: 5));
      final second = await notifier.getYearSummary(2026);

      expect(first!.yearlyObservation.frameCount, 3);
      expect(second!.yearlyObservation.frameCount, 8);
      expect(await database.select(database.yearFile).get(), isEmpty);
    });

    test('returns null and preserves invalid stored DayFile data on read', () async {
      await database
          .into(database.dayFile)
          .insert(
            DayFileCompanion.insert(
              businessDate: '2026-10-16',
              year: 2026,
              month: 10,
              day: 16,
              data: _gzipJson('{}'),
              schemaVersion: core_domain.kSchemaVersion + 1,
              createdAtMs: 10,
              updatedAtMs: 20,
            ),
          );

      expect(await notifier.getDaySummary(2026, 10, 16), isNull);

      final row = (await readDay('2026-10-16'))!;
      expect(row.schemaVersion, core_domain.kSchemaVersion + 1);
      expect(utf8.decode(GZipCodec().decode(row.data)), '{}');
    });

    test('uses the aggregator identity result to skip duplicate DayFile writes', () async {
      final first = _observation(hour: 10, minute: 0, frameCount: 2);
      await notifier.add(first);
      final original = (await readDay('2026-10-16'))!;
      nowMs += 100;
      final repeated = _observation(hour: 10, minute: 0, frameCount: 200);
      final summary = _decodeSummary(original);

      expect(identical(const core_domain.SummaryBuilder().addObservationToDay(summary, repeated), summary), isTrue);

      await notifier.add(repeated);

      final unchanged = (await readDay('2026-10-16'))!;
      expect(unchanged, original);
      expect(_decodeSummary(unchanged).dailyObservation.frameCount, 2);
    });

    test('asserts on granularities other than five minutes', () async {
      final hourly = _observation(hour: 10, minute: -1, granularity: core_domain.ObservationGranularity.hour);

      await expectLater(notifier.add(hourly), throwsAssertionError);
      expect(await database.select(database.dayFile).get(), isEmpty);
    });

    test('rebuilds documents with unsupported JSON schema versions', () async {
      const unsupportedVersion = core_domain.kSchemaVersion + 1;
      await database
          .into(database.dayFile)
          .insert(
            DayFileCompanion.insert(
              businessDate: '2026-10-16',
              year: 2026,
              month: 10,
              day: 16,
              data: _gzipJson('{}'),
              schemaVersion: unsupportedVersion,
              createdAtMs: 10,
              updatedAtMs: 20,
            ),
          );

      await notifier.add(_observation(hour: 10, minute: 0, frameCount: 4));

      final row = (await readDay('2026-10-16'))!;
      expect(row.schemaVersion, core_domain.kSchemaVersion);
      expect(row.createdAtMs, 10);
      expect(row.updatedAtMs, nowMs);
      expect(_decodeSummary(row).dailyObservation.frameCount, 4);
    });

    test('rebuilds documents containing malformed JSON', () async {
      await database
          .into(database.dayFile)
          .insert(
            DayFileCompanion.insert(
              businessDate: '2026-10-16',
              year: 2026,
              month: 10,
              day: 16,
              data: _gzipJson('{not-json'),
              schemaVersion: core_domain.kSchemaVersion,
              createdAtMs: 10,
              updatedAtMs: 20,
            ),
          );

      await notifier.add(_observation(hour: 10, minute: 0, frameCount: 5));

      final row = (await readDay('2026-10-16'))!;
      expect(row.schemaVersion, core_domain.kSchemaVersion);
      expect(row.createdAtMs, 10);
      expect(row.updatedAtMs, nowMs);
      expect(_decodeSummary(row).dailyObservation.frameCount, 5);
    });

    test('rebuilds documents that decode to an invalid DaySummary', () async {
      await database
          .into(database.dayFile)
          .insert(
            DayFileCompanion.insert(
              businessDate: '2026-10-16',
              year: 2026,
              month: 10,
              day: 16,
              data: _gzipJson('{}'),
              schemaVersion: core_domain.kSchemaVersion,
              createdAtMs: 10,
              updatedAtMs: 20,
            ),
          );

      await notifier.add(_observation(hour: 10, minute: 0, frameCount: 7));

      final row = (await readDay('2026-10-16'))!;
      expect(row.createdAtMs, 10);
      expect(row.updatedAtMs, nowMs);
      expect(_decodeSummary(row).dailyObservation.frameCount, 7);
    });

    test('rebuilds documents whose summary date does not match the key', () async {
      final wrongDate = const core_domain.SummaryBuilder().createDaySummary(
        _observation(year: 2026, month: 10, day: 17, hour: 10, minute: 0),
      );
      await database
          .into(database.dayFile)
          .insert(
            DayFileCompanion.insert(
              businessDate: '2026-10-16',
              year: 2026,
              month: 10,
              day: 16,
              data: _gzipJson(jsonEncode(wrongDate.toJson())),
              schemaVersion: core_domain.kSchemaVersion,
              createdAtMs: 10,
              updatedAtMs: 20,
            ),
          );

      await notifier.add(_observation(hour: 10, minute: 0, frameCount: 6));

      final row = (await readDay('2026-10-16'))!;
      expect(row.createdAtMs, 10);
      expect(row.updatedAtMs, nowMs);
      expect(_decodeSummary(row).businessDate, '2026-10-16');
      expect(_decodeSummary(row).dailyObservation.frameCount, 6);
    });

    test('serializes concurrent additions without losing observations', () async {
      await Future.wait([
        for (var minute = 0; minute < 50; minute += 5) notifier.add(_observation(hour: 10, minute: minute)),
      ]);

      final summary = _decodeSummary((await readDay('2026-10-16'))!);
      expect(summary.fiveMinuteObservations, hasLength(10));
      expect(summary.dailyObservation.frameCount, 10);
    });

    test('a failed queued operation does not block the next addition', () async {
      var factoryCalls = 0;
      activeDatabaseFactory = () {
        factoryCalls++;
        return factoryCalls == 1 ? null : database;
      };

      final failed = notifier.add(_observation(hour: 10, minute: 0));
      final succeeded = notifier.add(_observation(hour: 10, minute: 5));

      await expectLater(failed, throwsStateError);
      await succeeded;

      final summary = _decodeSummary((await readDay('2026-10-16'))!);
      expect(summary.fiveMinuteObservations.map((item) => item.minute), [5]);
    });
  });
}
