// TOC
// 1. SummaryBuilder period-building tests

import 'package:core_domain/core_domain.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _fiveMinute({
  required int month,
  required int day,
  required int minute,
  required int frameCount,
  int year = 2026,
  int hour = 10,
  List<AreaMetrics> areas = const [],
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
      expect(summary.fiveMinuteObservations.map((observation) => observation.frameCount), [20, 40]);
      expect(summary.fiveMinuteObservations.map((observation) => observation.minute), [0, 5]);
      expect(summary.fiveMinuteObservations.map((observation) => observation.businessDate), [
        '2026-01-01',
        '2026-01-01',
      ]);
      expect(summary.hourlyObservations.map((observation) => observation.day), [1, 3]);
      expect(summary.hourlyObservations.map((observation) => observation.hour), [10, 10]);
      expect(summary.dailyObservations.map((observation) => observation.day), [1, 3]);
      expect(summary.monthlyObservation.granularity, ObservationGranularity.month);
      expect(summary.monthlyObservation.month, 1);
      expect(summary.monthlyObservation.day, -1);
      expect(summary.monthlyObservation.frameCount, 80);
      expect(summary.monthlyObservation.expectedSeconds, 31 * 86400);
    });

    test('derives typical event metrics from sums and sample counts', () {
      DaySummary makeDay(int day, int passBy) => summaryBuilder.createDaySummary(
        _fiveMinute(
          month: 1,
          day: day,
          minute: 0,
          frameCount: 1,
          areas: [AreaMetrics(areaId: 1, areaName: 'Zone', passBy: passBy.toDouble())],
        ),
      );

      final month = summaryBuilder.createMonthSummary([makeDay(1, 4), makeDay(2, 6)]);
      final year = summaryBuilder.createYearSummary([month]);
      final monthProfileMetrics = month.fiveMinuteObservations.single.areas.single;
      final yearProfileMetrics = year.fiveMinuteObservations.single.areas.single;
      final monthMetrics = month.monthlyObservation.areas.single;
      final yearMetrics = year.yearlyObservation.areas.single;

      expect(monthProfileMetrics.passBy, 5);
      expect(yearProfileMetrics.passBy, 5);
      expect(monthMetrics.passBy, 10);
      expect(yearMetrics.passBy, 10);
    });

    test('orders hourly observations by full business date and time', () {
      final dayOne = _day(summaryBuilder, 1, 1, [1], hour: 11);
      final dayThree = _day(summaryBuilder, 1, 3, [1], hour: 9);

      final summary = summaryBuilder.createMonthSummary([dayThree, dayOne]);

      expect(summary.hourlyObservations.map((observation) => observation.day), [1, 3]);
      expect(summary.hourlyObservations.map((observation) => observation.hour), [11, 9]);
    });

    test('averages yearly typical slots equally across monthly profiles', () {
      final januaryDayOne = _day(summaryBuilder, 1, 1, [10]);
      final januaryDayThree = _day(summaryBuilder, 1, 3, [30]);
      final marchDayTwo = _day(summaryBuilder, 3, 2, [90]);
      final january = summaryBuilder.createMonthSummary([januaryDayOne, januaryDayThree]);
      final march = summaryBuilder.createMonthSummary([marchDayTwo]);

      final summary = summaryBuilder.createYearSummary([march, january]);

      expect(summary.businessDate, '2026');
      expect(summary.fiveMinuteObservations, hasLength(1));
      expect(summary.fiveMinuteObservations.single.frameCount, 55);
      expect(summary.fiveMinuteObservations.single.businessDate, '2026-01-01');
      expect(summary.dailyObservations.map((observation) => observation.businessDate), [
        '2026-01-01',
        '2026-01-03',
        '2026-03-02',
      ]);
      expect(summary.monthlyObservations.map((observation) => observation.month), [1, 3]);
      expect(summary.yearlyObservation.granularity, ObservationGranularity.year);
      expect(summary.yearlyObservation.month, -1);
      expect(summary.yearlyObservation.day, -1);
      expect(summary.yearlyObservation.frameCount, 130);
      expect(summary.yearlyObservation.expectedSeconds, 365 * 86400);
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
      expect(summaryBuilder.createYearSummary([january, february]).monthlyObservations, hasLength(2));
    });
  });
}
