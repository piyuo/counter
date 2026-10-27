// TOC
// 1. SummaryBuilder period-building tests

import 'dart:convert';

import 'package:core_domain/core_domain.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _fiveMinute({
  required int month,
  required int day,
  required int minute,
  required int frameCount,
  int year = 2026,
  int hour = 10,
  List<Activity> areas = const [],
}) {
  return Observation(
    granularity: ObservationGranularity.minutes5,
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    confidenceSum: 0,
    confidenceSampleCount: 0,
    coveredSeconds: 300,
    areas: areas,
    frameCount: frameCount,
  );
}

DaySummary _day(
  SummaryBuilder summaryBuilder,
  int month,
  int day,
  List<int> frameCounts, {
  int year = 2026,
  int hour = 10,
}) {
  var summary = summaryBuilder.createDaySummary(
    _fiveMinute(year: year, month: month, day: day, minute: 0, frameCount: frameCounts.first, hour: hour),
  );
  for (var index = 1; index < frameCounts.length; index++) {
    summary = summaryBuilder.addObservationToDay(
      summary,
      _fiveMinute(year: year, month: month, day: day, minute: index * 5, frameCount: frameCounts[index], hour: hour),
    );
  }
  return summary;
}

void main() {
  group('SummaryBuilder', () {
    const summaryBuilder = SummaryBuilder();

    test('creates monthly aggregates and an averaged typical-day profile', () {
      final dayOne = _day(summaryBuilder, 1, 1, [10]);
      final dayThree = _day(summaryBuilder, 1, 3, [30, 40]);

      final summary = summaryBuilder.createMonthSummary([dayThree, dayOne]);

      expect(summary.businessDate, '2026-01');
      expect(summary.weekdayFiveMinuteObservation.map((observation) => observation.frameCount), [10]);
      expect(summary.weekdayFiveMinuteObservation.map((observation) => observation.minute), [0]);
      expect(summary.weekendFiveMinuteObservation.map((observation) => observation.frameCount), [30, 40]);
      expect(summary.weekendFiveMinuteObservation.map((observation) => observation.minute), [0, 5]);
      expect(summary.weekendFiveMinuteObservation.every((observation) => observation.isWeekend), isTrue);
      expect(summary.weekdayFiveMinuteObservation.map((observation) => observation.businessDate), ['2026-01-01']);
      final restoredMonth = MonthSummary.fromJson(jsonDecode(jsonEncode(summary)) as Map<String, dynamic>);
      expect(restoredMonth.weekendFiveMinuteObservation.every((observation) => observation.isWeekend), isTrue);
      expect(summary.hourlyTotals.map((observation) => observation.day), [1, 3]);
      expect(summary.hourlyTotals.map((observation) => observation.hour), [10, 10]);
      expect(summary.dailyTotals.map((observation) => observation.day), [1, 3]);
      expect(summary.monthlyTotal.granularity, ObservationGranularity.month);
      expect(summary.monthlyTotal.month, 1);
      expect(summary.monthlyTotal.day, -1);
      expect(summary.monthlyTotal.frameCount, 80);
      expect(summary.monthlyTotal.expectedSeconds, 31 * 86400);
    });

    test('derives typical event metrics from sums and sample counts', () {
      DaySummary makeDay(int day, int passBy) => summaryBuilder.createDaySummary(
        _fiveMinute(
          month: 1,
          day: day,
          minute: 0,
          frameCount: 1,
          areas: [Activity(areaId: 1, areaName: 'Zone', passBy: passBy.toDouble())],
        ),
      );

      final month = summaryBuilder.createMonthSummary([makeDay(1, 4), makeDay(2, 6)]);
      final year = summaryBuilder.createYearSummary([month]);
      final monthProfileMetrics = month.weekdayFiveMinuteObservation.single.areas.single;
      final yearProfileMetrics = year.weekdayFiveMinuteObservation.single.areas.single;
      final monthMetrics = month.monthlyTotal.areas.single;
      final yearMetrics = year.yearlyTotal.areas.single;

      expect(monthProfileMetrics.passBy, 5);
      expect(yearProfileMetrics.passBy, 5);
      expect(monthMetrics.passBy, 10);
      expect(yearMetrics.passBy, 10);
    });

    test('orders hourly observations by full business date and time', () {
      final dayOne = _day(summaryBuilder, 1, 1, [1], hour: 11);
      final dayThree = _day(summaryBuilder, 1, 3, [1], hour: 9);

      final summary = summaryBuilder.createMonthSummary([dayThree, dayOne]);

      expect(summary.hourlyTotals.map((observation) => observation.day), [1, 3]);
      expect(summary.hourlyTotals.map((observation) => observation.hour), [11, 9]);
    });

    test('averages yearly typical slots equally across monthly profiles', () {
      final januaryDayOne = _day(summaryBuilder, 1, 1, [10]);
      final januaryDayThree = _day(summaryBuilder, 1, 3, [30]);
      final marchDayTwo = _day(summaryBuilder, 3, 2, [90]);
      final january = summaryBuilder.createMonthSummary([januaryDayOne, januaryDayThree]);
      final march = summaryBuilder.createMonthSummary([marchDayTwo]);

      final summary = summaryBuilder.createYearSummary([march, january]);

      expect(summary.businessDate, '2026');
      expect(summary.weekdayFiveMinuteObservation, hasLength(1));
      expect(summary.weekdayFiveMinuteObservation.single.frameCount, 50);
      expect(summary.weekdayFiveMinuteObservation.single.businessDate, '2026-01-01');
      expect(summary.weekendFiveMinuteObservation, hasLength(1));
      expect(summary.weekendFiveMinuteObservation.single.frameCount, 30);
      expect(summary.weekendFiveMinuteObservation.single.isWeekend, isTrue);
      final restoredYear = YearSummary.fromJson(jsonDecode(jsonEncode(summary)) as Map<String, dynamic>);
      expect(restoredYear.weekendFiveMinuteObservation.single.isWeekend, isTrue);
      expect(summary.dailyTotals.map((observation) => observation.businessDate), [
        '2026-01-01',
        '2026-01-03',
        '2026-03-02',
      ]);
      expect(summary.monthlyTotals.map((observation) => observation.month), [1, 3]);
      expect(summary.yearlyTotal.granularity, ObservationGranularity.year);
      expect(summary.yearlyTotal.month, -1);
      expect(summary.yearlyTotal.day, -1);
      expect(summary.yearlyTotal.frameCount, 130);
      expect(summary.yearlyTotal.expectedSeconds, 365 * 86400);
    });

    test('rejects duplicate or cross-year month summaries', () {
      final januaryDay = _day(summaryBuilder, 1, 1, [1]);
      final februaryDay = _day(summaryBuilder, 2, 1, [1]);
      final nextYearDay = _day(summaryBuilder, 1, 1, [1], year: 2027);
      final january = summaryBuilder.createMonthSummary([januaryDay]);
      final february = summaryBuilder.createMonthSummary([februaryDay]);
      final nextYear = summaryBuilder.createMonthSummary([nextYearDay]);

      expect(() => summaryBuilder.createMonthSummary([januaryDay, februaryDay]), throwsArgumentError);
      expect(() => summaryBuilder.createYearSummary([january, nextYear]), throwsArgumentError);
      expect(() => summaryBuilder.createYearSummary([january, january]), throwsArgumentError);
      expect(summaryBuilder.createYearSummary([january, february]).monthlyTotals, hasLength(2));
    });
  });
}
