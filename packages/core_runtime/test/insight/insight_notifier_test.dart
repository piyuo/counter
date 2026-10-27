// TOC
// 1. InsightNotifier refresh tests

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:core_runtime/insight/insight_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

core_domain.Observation _observation(
  DateTime date, {
  required int hour,
  required int minute,
  required int frameCount,
  core_domain.ObservationGranularity granularity = core_domain.ObservationGranularity.minutes5,
}) {
  return core_domain.Observation(
    granularity: granularity,
    year: date.year,
    month: date.month,
    day: date.day,
    hour: hour,
    minute: minute,
    areas: const [],
    frameCount: frameCount,
  );
}

ObservationSeries _series(DateTime date, int firstFrameCount) {
  return ObservationSeries.fromObservations([
    _observation(date, hour: 10, minute: 35, frameCount: firstFrameCount),
    _observation(date, hour: 11, minute: 0, frameCount: firstFrameCount + 1),
  ]);
}

core_domain.DaySummary _daySummary(DateTime date, int firstFrameCount) {
  return core_domain.DaySummary(
    year: date.year,
    month: date.month,
    day: date.day,
    fiveMinuteObservations: _series(date, firstFrameCount),
    hourlyTotals: const [],
    dailyTotal: _observation(
      date,
      hour: -1,
      minute: -1,
      frameCount: firstFrameCount,
      granularity: core_domain.ObservationGranularity.day,
    ),
  );
}

void main() {
  test('refresh builds and publishes dashboard data for each comparison period', () async {
    final now = DateTime(2026, 10, 26, 11, 35);
    final todaySummary = _daySummary(now, 10);
    final yesterday = _daySummary(DateTime(2026, 10, 25), 20);
    final lastWeek = _daySummary(DateTime(2026, 10, 19), 30);
    final weekdaySeries = _series(now, 40);
    final weekendSeries = _series(DateTime(2026, 10, 25), 50);
    final monthSummary = core_domain.MonthSummary(
      year: 2026,
      month: 10,
      weekdayFiveMinuteObservation: weekdaySeries,
      weekendFiveMinuteObservation: weekendSeries,
      hourlyTotals: const [],
      dailyTotals: const [],
      monthlyTotal: _observation(
        now,
        hour: -1,
        minute: -1,
        frameCount: 60,
        granularity: core_domain.ObservationGranularity.month,
      ),
    );
    final yearSummary = core_domain.YearSummary(
      year: 2026,
      weekdayFiveMinuteObservation: weekdaySeries,
      weekendFiveMinuteObservation: weekendSeries,
      dailyTotals: const [],
      monthlyTotals: const [],
      yearlyTotal: _observation(
        now,
        hour: -1,
        minute: -1,
        frameCount: 70,
        granularity: core_domain.ObservationGranularity.year,
      ),
    );
    final analytics = _FakeAnalyticsService(
      daySummaries: {'2026-10-26': todaySummary, '2026-10-25': yesterday, '2026-10-19': lastWeek},
      monthSummary: monthSummary,
      yearSummary: yearSummary,
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        insightProvider.overrideWith(() => InsightNotifier(nowProvider: () => now)),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    final periodExpectations = [
      (
        period: core_domain.TrafficComparisonPeriod.yesterday,
        expectedSeries: yesterday.fiveMinuteObservations,
        expectedTotal: yesterday.dailyTotal,
        expectedFrames: 41,
      ),
      (
        period: core_domain.TrafficComparisonPeriod.sameDayLastWeek,
        expectedSeries: lastWeek.fiveMinuteObservations,
        expectedTotal: lastWeek.dailyTotal,
        expectedFrames: 61,
      ),
      (
        period: core_domain.TrafficComparisonPeriod.monthlyAverage,
        expectedSeries: weekdaySeries,
        expectedTotal: monthSummary.monthlyTotal,
        expectedFrames: 81,
      ),
      (
        period: core_domain.TrafficComparisonPeriod.yearlyAverage,
        expectedSeries: weekdaySeries,
        expectedTotal: yearSummary.yearlyTotal,
        expectedFrames: 81,
      ),
    ];

    for (final expectation in periodExpectations) {
      notifier.setComparisonPeriod(expectation.period);
      final snapshot = notifier.snapshots.first;
      await notifier.refresh();
      final dashboard = await snapshot;

      expect(dashboard, notifier.state);
      expect(dashboard.businessDate, '2026-10-26');
      expect(dashboard.comparisonPeriod, expectation.period);
      expect(dashboard.todaySeries, todaySummary.fiveMinuteObservations);
      expect(dashboard.pastHourObservation?.frameCount, 21);
      expect(dashboard.comparisonSeries, expectation.expectedSeries);
      expect(dashboard.comparisonTypicalDay, expectation.expectedTotal);
      expect(dashboard.comparisonPastHourObservation?.frameCount, expectation.expectedFrames);
    }
    expect(analytics.monthRequests, ['2026-10']);
    expect(analytics.yearRequests, [2026]);
  });

  test('caches comparison summary until period or business date changes', () async {
    var now = DateTime(2026, 10, 26, 11, 35);
    final analytics = _FakeAnalyticsService(
      daySummaries: {
        '2026-10-26': _daySummary(now, 10),
        '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20),
        '2026-10-19': _daySummary(DateTime(2026, 10, 19), 30),
      },
      monthSummary: null,
      yearSummary: null,
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        insightProvider.overrideWith(() => InsightNotifier(nowProvider: () => now)),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    notifier.setComparisonPeriod(core_domain.TrafficComparisonPeriod.yesterday);
    await notifier.refresh();
    notifier.setComparisonPeriod(core_domain.TrafficComparisonPeriod.yesterday);
    await notifier.refresh();
    expect(analytics.dayRequests.where((date) => date == '2026-10-25'), hasLength(1));

    notifier.setComparisonPeriod(core_domain.TrafficComparisonPeriod.sameDayLastWeek);
    await notifier.refresh();
    expect(analytics.dayRequests.where((date) => date == '2026-10-19'), hasLength(1));

    notifier.setComparisonPeriod(core_domain.TrafficComparisonPeriod.yesterday);
    await notifier.refresh();
    expect(analytics.dayRequests.where((date) => date == '2026-10-25'), hasLength(2));
    await notifier.refresh();
    expect(analytics.dayRequests.where((date) => date == '2026-10-25'), hasLength(2));

    final previousDateRequestCount = analytics.dayRequests.where((date) => date == '2026-10-26').length;
    now = DateTime(2026, 10, 27, 11, 35);
    await notifier.refresh();
    expect(notifier.state.businessDate, '2026-10-27');
    expect(analytics.dayRequests.where((date) => date == '2026-10-26'), hasLength(previousDateRequestCount + 1));
  });
}

class _FakeAnalyticsService implements core_domain.AnalyticsService {
  _FakeAnalyticsService({required this.daySummaries, required this.monthSummary, required this.yearSummary});

  final Map<String, core_domain.DaySummary> daySummaries;
  final core_domain.MonthSummary? monthSummary;
  final core_domain.YearSummary? yearSummary;
  final dayRequests = <String>[];
  final monthRequests = <String>[];
  final yearRequests = <int>[];

  @override
  core_domain.AnalyticsState get state => const core_domain.AnalyticsState();

  @override
  Future<void> add(core_domain.Observation observation) async {}

  @override
  Future<core_domain.DaySummary?> getDaySummary(int year, int month, int day) async {
    final key =
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    dayRequests.add(key);
    return daySummaries[key];
  }

  @override
  Future<core_domain.MonthSummary?> getMonthSummary(int year, int month) async {
    monthRequests.add('$year-${month.toString().padLeft(2, '0')}');
    return monthSummary;
  }

  @override
  Future<core_domain.YearSummary?> getYearSummary(int year) async {
    yearRequests.add(year);
    return yearSummary;
  }
}
