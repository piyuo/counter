import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_notifier.g.dart';

@Riverpod(keepAlive: true)
class AnalyticsNotifier extends _$AnalyticsNotifier
    implements core_domain.AnalyticsService {
  AnalyticsNotifier({
    AppDatabaseFun? databaseFactory,
    DateTime Function()? nowProvider,
  }) : _databaseFactory = databaseFactory ?? AppDatabase.dbFactory,
       _nowProvider = nowProvider ?? DateTime.now;

  final AppDatabaseFun _databaseFactory;
  final DateTime Function() _nowProvider;
  final core_domain.SummaryBuilder _summaryBuilder =
      const core_domain.SummaryBuilder();
  String? _todaySummaryBusinessDate;
  core_domain.DaySummary? _todaySummary;
  int _todaySummaryGeneration = 0;

  @override
  core_domain.AnalyticsState build() {
    return const core_domain.AnalyticsState();
  }

  @override
  Future<void> add(core_domain.Observation observation) async {
    assert(
      observation.granularity == core_domain.ObservationGranularity.minutes5,
      'AnalyticsNotifier accepts only minutes5 observations',
    );
    final db = _databaseFactory();
    if (db == null) throw StateError('AppDatabase is not available');

    final businessDate = observation.businessDate;
    final existing = await (db.select(
      db.dayFile,
    )..where((row) => row.businessDate.equals(businessDate))).getSingleOrNull();
    final saved = existing == null
        ? null
        : _tryDecodeDay(existing.data, businessDate);

    final updated = saved == null
        ? _summaryBuilder.createDaySummary(observation)
        : _summaryBuilder.addObservationToDay(saved, observation);
    if (identical(updated, saved)) return; // duplicate, keep the first one

    final nowMs = _nowProvider().toUtc().millisecondsSinceEpoch;
    final data = Uint8List.fromList(
      GZipCodec(level: ZLibOption.maxLevel)
          .encode(utf8.encode(jsonEncode(updated.toJson()))),
    );

    if (existing == null) {
      await db
          .into(db.dayFile)
          .insert(
            DayFileCompanion.insert(
              businessDate: businessDate,
              year: observation.year,
              month: observation.month,
              day: observation.day,
              data: data,
              schemaVersion: core_domain.kSchemaVersion,
              createdAtMs: nowMs,
              updatedAtMs: nowMs,
            ),
          );
    } else {
      await (db.update(
        db.dayFile,
      )..where((row) => row.businessDate.equals(businessDate))).write(
        DayFileCompanion(
          data: Value(data),
          schemaVersion: const Value(core_domain.kSchemaVersion),
          updatedAtMs: Value(nowMs),
        ),
      );
    }

    _invalidateTodaySummary();
    state = state.copyWith(lastUpdatedUtc: _nowProvider().toUtc());
  }

  core_domain.DaySummary? _tryDecodeDay(Uint8List data, String businessDate) {
    try {
      final decoded = jsonDecode(utf8.decode(GZipCodec().decode(data)));
      if (decoded is! Map<String, dynamic>) {
        throw FormatException('DaySummary data must be a JSON object');
      }
      final summary = core_domain.DaySummary.fromJson(decoded);
      if (summary.businessDate != businessDate) {
        throw FormatException(
          'DaySummary data date ${summary.businessDate} does not match its key',
        );
      }
      return summary;
    } catch (error) {
      appkit.logDebug(
        '[AnalyticsNotifier] Invalid DaySummary for $businessDate: $error',
      );
      return null;
    }
  }

  /// Retrieves a day summary for the specified business date components.
  ///
  /// Returns the day summary if it exists, or `null` if no summary is available
  /// for the given business date.
  @override
  Future<core_domain.DaySummary?> getDaySummary(
    int year,
    int month,
    int day,
  ) async {
    _validateYear(year);
    if (month < 1 || month > 12) {
      throw ArgumentError.value(month, 'month', 'must be between 1 and 12');
    }
    final date = DateTime.utc(year, month, day);
    if (day < 1 ||
        date.year != year ||
        date.month != month ||
        date.day != day) {
      throw ArgumentError.value(
        day,
        'day',
        'must be valid for the specified month and year',
      );
    }
    final businessDate = _formatBusinessDate(year, month, day);
    final now = _nowProvider();
    final isToday =
        businessDate == _formatBusinessDate(now.year, now.month, now.day);
    if (isToday &&
        _todaySummary != null &&
        _todaySummaryBusinessDate == businessDate) {
      return _todaySummary;
    }
    final cacheGeneration = _todaySummaryGeneration;
    final db = _databaseFactory();
    if (db == null) return null;

    final row =
        await (db.select(db.dayFile)
              ..where((dayFile) => dayFile.year.equals(year))
              ..where((dayFile) => dayFile.month.equals(month))
              ..where((dayFile) => dayFile.day.equals(day)))
            .getSingleOrNull();
    if (row == null) return null;

    try {
      final json = utf8.decode(GZipCodec().decode(row.data));
      final decoded = jsonDecode(json);
      if (decoded is! Map<String, dynamic>) {
        throw FormatException('DayFile data must be a JSON object');
      }
      final summary = core_domain.DaySummary.fromJson(decoded);
      if (summary.businessDate != businessDate) {
        throw FormatException(
          'DayFile data date ${summary.businessDate} does not match its key',
        );
      }
      if (isToday && cacheGeneration == _todaySummaryGeneration) {
        _cacheTodaySummary(businessDate, summary);
      }
      return summary;
    } catch (error) {
      appkit.logDebug(
        '[AnalyticsNotifier] Unable to read DayFile for $businessDate: $error',
      );
      return null;
    }
  }

  void _cacheTodaySummary(String businessDate, core_domain.DaySummary summary) {
    _todaySummaryBusinessDate = businessDate;
    _todaySummary = summary;
  }

  void _invalidateTodaySummary() {
    _todaySummaryGeneration++;
    _todaySummaryBusinessDate = null;
    _todaySummary = null;
  }

  @override
  Future<core_domain.MonthSummary?> getMonthSummary(int year, int month) async {
    _validateYear(year);
    if (month < 1 || month > 12) {
      throw ArgumentError.value(month, 'month', 'must be between 1 and 12');
    }
    final businessMonth = _formatBusinessMonth(year, month);

    final db = _databaseFactory();
    if (db == null) return null;
    final now = _nowProvider();
    final isCurrentMonth = year == now.year && month == now.month;

    if (!isCurrentMonth) {
      final saved =
          await (db.select(db.monthFile)
                ..where((row) => row.year.equals(year))
                ..where((row) => row.month.equals(month)))
              .getSingleOrNull();
      if (saved != null) {
        try {
          final json = utf8.decode(GZipCodec().decode(saved.data));
          final decoded = jsonDecode(json);
          if (decoded is! Map<String, dynamic>) {
            throw FormatException('MonthFile data must be a JSON object');
          }
          final summary = core_domain.MonthSummary.fromJson(decoded);
          if (summary.businessDate != businessMonth) {
            throw FormatException(
              'MonthFile data date ${summary.businessDate} does not match its key',
            );
          }
          return summary;
        } catch (error) {
          appkit.logDebug(
            '[AnalyticsNotifier] Unable to read MonthFile for $businessMonth: $error',
          );
        }
      }
    }

    final dayRows =
        await (db.select(db.dayFile)
              ..where((row) => row.year.equals(year))
              ..where((row) => row.month.equals(month))
              ..orderBy([(row) => OrderingTerm.asc(row.day)]))
            .get();
    final days = <core_domain.DaySummary>[];
    for (final row in dayRows) {
      try {
        final json = utf8.decode(GZipCodec().decode(row.data));
        final decoded = jsonDecode(json);
        if (decoded is! Map<String, dynamic>) {
          throw FormatException('DayFile data must be a JSON object');
        }
        final summary = core_domain.DaySummary.fromJson(decoded);
        if (summary.businessDate != row.businessDate) {
          throw FormatException(
            'DayFile data date ${summary.businessDate} does not match its key',
          );
        }
        days.add(summary);
      } catch (error) {
        appkit.logDebug(
          '[AnalyticsNotifier] Unable to read DayFile for ${row.businessDate}: $error',
        );
      }
    }
    if (days.isEmpty) return null;

    final summary = _summaryBuilder.createMonthSummary(days);
    if (!isCurrentMonth) {
      final nowMs = now.toUtc().millisecondsSinceEpoch;
      final encodedJson = jsonEncode(summary.toJson());
      final encodedData = Uint8List.fromList(
        GZipCodec(level: ZLibOption.maxLevel).encode(utf8.encode(encodedJson)),
      );
      final existing =
          await (db.select(db.monthFile)
                ..where((row) => row.year.equals(year))
                ..where((row) => row.month.equals(month)))
              .getSingleOrNull();
      if (existing == null) {
        await db
            .into(db.monthFile)
            .insert(
              MonthFileCompanion.insert(
                businessDate: businessMonth,
                year: year,
                month: month,
                data: encodedData,
                schemaVersion: core_domain.kSchemaVersion,
                createdAtMs: nowMs,
                updatedAtMs: nowMs,
              ),
            );
      } else {
        /// Update existing month file with new data, the exists one may have format issues
        await (db.update(db.monthFile)
              ..where((row) => row.year.equals(year))
              ..where((row) => row.month.equals(month)))
            .write(
              MonthFileCompanion(
                data: Value(encodedData),
                schemaVersion: Value(core_domain.kSchemaVersion),
                updatedAtMs: Value(nowMs),
              ),
            );
      }
    }
    return summary;
  }

  @override
  Future<core_domain.YearSummary?> getYearSummary(int year) async {
    _validateYear(year);
    final businessYear = _formatBusinessYear(year);
    final db = _databaseFactory();
    if (db == null) return null;
    final now = _nowProvider();
    final isCurrentYear = year == now.year;

    if (!isCurrentYear) {
      final saved = await (db.select(
        db.yearFile,
      )..where((row) => row.year.equals(year))).getSingleOrNull();
      if (saved != null) {
        try {
          if (saved.schemaVersion != core_domain.kSchemaVersion) {
            throw FormatException(
              'Unsupported YearFile schema version ${saved.schemaVersion}',
            );
          }
          final json = utf8.decode(GZipCodec().decode(saved.data));
          final decoded = jsonDecode(json);
          if (decoded is! Map<String, dynamic>) {
            throw FormatException('YearFile data must be a JSON object');
          }
          final summary = core_domain.YearSummary.fromJson(decoded);
          if (summary.businessDate != businessYear) {
            throw FormatException(
              'YearFile data date ${summary.businessDate} does not match its key',
            );
          }
          return summary;
        } catch (error) {
          appkit.logDebug(
            '[AnalyticsNotifier] Unable to read YearFile for $businessYear: $error',
          );
        }
      }
    }

    final months = <core_domain.MonthSummary>[];
    for (var month = 1; month <= 12; month++) {
      final monthSummary = await getMonthSummary(year, month);
      if (monthSummary != null) months.add(monthSummary);
    }
    if (months.isEmpty) return null;

    final summary = _summaryBuilder.createYearSummary(months);
    if (!isCurrentYear) {
      final nowMs = now.toUtc().millisecondsSinceEpoch;
      final encodedJson = jsonEncode(summary.toJson());
      final encodedData = Uint8List.fromList(
        GZipCodec(level: ZLibOption.maxLevel).encode(utf8.encode(encodedJson)),
      );
      final existing = await (db.select(
        db.yearFile,
      )..where((row) => row.year.equals(year))).getSingleOrNull();
      if (existing == null) {
        await db
            .into(db.yearFile)
            .insert(
              YearFileCompanion.insert(
                businessDate: businessYear,
                year: year,
                data: encodedData,
                schemaVersion: core_domain.kSchemaVersion,
                createdAtMs: nowMs,
                updatedAtMs: nowMs,
              ),
            );
      } else {
        await (db.update(
          db.yearFile,
        )..where((row) => row.year.equals(year))).write(
          YearFileCompanion(
            data: Value(encodedData),
            schemaVersion: Value(core_domain.kSchemaVersion),
            updatedAtMs: Value(nowMs),
          ),
        );
      }
    }
    return summary;
  }
}

void _validateYear(int year) {
  if (year < 1000 || year > 9999) {
    throw ArgumentError.value(
      year,
      'year',
      'must be a four-digit business year',
    );
  }
}

String _formatBusinessYear(int year) => year.toString().padLeft(4, '0');

String _formatBusinessMonth(int year, int month) =>
    '${_formatBusinessYear(year)}-${month.toString().padLeft(2, '0')}';

String _formatBusinessDate(int year, int month, int day) =>
    '${_formatBusinessMonth(year, month)}-${day.toString().padLeft(2, '0')}';
