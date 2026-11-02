// TOC
// 1. InsightNotifier refresh tests

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:core_runtime/insight/insight_notifier.dart';
import 'package:core_runtime/observation/observation_notifier.dart' as observation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

core_domain.Observation _observation(
  DateTime date, {
  required int hour,
  required int minute,
  required int frameCount,
  int coveredSeconds = 0,
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
    coveredSeconds: coveredSeconds,
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

core_domain.DaySummary _daySummaryWithObservations(DateTime date, List<core_domain.Observation> observations) {
  return core_domain.DaySummary(
    year: date.year,
    month: date.month,
    day: date.day,
    fiveMinuteObservations: ObservationSeries.fromObservations(observations),
    hourlyTotals: const [],
    dailyTotal: _observation(
      date,
      hour: -1,
      minute: -1,
      frameCount: 0,
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
        expectedFrames: 21,
      ),
      (
        period: core_domain.TrafficComparisonPeriod.sameDayLastWeek,
        expectedSeries: lastWeek.fiveMinuteObservations,
        expectedTotal: lastWeek.dailyTotal,
        expectedFrames: 31,
      ),
      (
        period: core_domain.TrafficComparisonPeriod.monthlyAverage,
        expectedSeries: weekdaySeries,
        expectedTotal: monthSummary.monthlyTotal,
        expectedFrames: 41,
      ),
      (
        period: core_domain.TrafficComparisonPeriod.yearlyAverage,
        expectedSeries: weekdaySeries,
        expectedTotal: yearSummary.yearlyTotal,
        expectedFrames: 41,
      ),
    ];

    for (final expectation in periodExpectations) {
      notifier.setComparisonPeriod(expectation.period);
      await notifier.refresh();
      final dashboard = notifier.state;

      expect(dashboard, notifier.state);
      expect(dashboard.businessDate, '2026-10-26');
      expect(dashboard.comparisonPeriod, expectation.period);
      expect(dashboard.todaySeries, todaySummary.fiveMinuteObservations);
      expect(dashboard.recentHourObservation?.frameCount, 11);
      expect(dashboard.comparisonSeries, expectation.expectedSeries);
      expect(dashboard.comparisonTypicalDay, expectation.expectedTotal);
      expect(dashboard.comparisonRecentHourObservation?.frameCount, expectation.expectedFrames);
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

  test('recentHourTotal combines completed observations with the live observation', () async {
    final now = DateTime(2026, 10, 26, 11, 37);
    final completed = [
      for (var index = 0; index < 11; index++)
        () {
          final time = DateTime(2026, 10, 26, 10, 40).add(Duration(minutes: index * 5));
          return _observation(now, hour: time.hour, minute: time.minute, frameCount: 1, coveredSeconds: 300);
        }(),
    ];
    final todaySummary = core_domain.DaySummary(
      year: now.year,
      month: now.month,
      day: now.day,
      fiveMinuteObservations: ObservationSeries.fromObservations(completed),
      hourlyTotals: const [],
      dailyTotal: _observation(
        now,
        hour: -1,
        minute: -1,
        frameCount: 0,
        granularity: core_domain.ObservationGranularity.day,
      ),
    );
    final yesterday = _daySummary(DateTime(2026, 10, 25), 20);
    final analytics = _FakeAnalyticsService(
      daySummaries: {'2026-10-26': todaySummary, '2026-10-25': yesterday},
      monthSummary: null,
      yearSummary: null,
    );
    final liveObservation = _observation(now, hour: 11, minute: 35, frameCount: 2, coveredSeconds: 120);
    final liveNotifier = _FakeObservationNotifier(liveObservation);
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(() => InsightNotifier(nowProvider: () => now)),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    await notifier.refresh();

    expect(notifier.recentHourTotal()?.frameCount, 13);
    expect(notifier.recentHourTotal()?.coveredSeconds, 3420);
    expect(notifier.state.recentHourObservation?.frameCount, 13);

    final updatedObservation = liveObservation.copyWith(frameCount: 3);
    liveNotifier.emit(updatedObservation);
    notifier.onObservationChanged();

    expect(notifier.state.recentHourObservation?.frameCount, 14);
  });

  test('recentHourTotal advances slots at rollover without losing or double counting the finalized slot', () async {
    var now = DateTime(2026, 10, 26, 11, 34, 59);
    final windowOrigin = DateTime(2026, 10, 26, 10, 30);
    int slotFrames(DateTime time) => 1 << (time.difference(windowOrigin).inMinutes ~/ 5);
    core_domain.Observation slot(DateTime time, {int coveredSeconds = 300}) => _observation(
      time,
      hour: time.hour,
      minute: time.minute,
      frameCount: slotFrames(time),
      coveredSeconds: coveredSeconds,
    );

    final completed = [for (var index = 0; index < 12; index++) slot(windowOrigin.add(Duration(minutes: index * 5)))];
    var todaySummary = _daySummaryWithObservations(now, completed);
    final analytics = _FakeAnalyticsService(
      daySummaries: {'2026-10-26': todaySummary, '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20)},
      monthSummary: null,
      yearSummary: null,
    );
    final liveNotifier = _FakeObservationNotifier(slot(DateTime(2026, 10, 26, 11, 30), coveredSeconds: 299));
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(() => InsightNotifier(nowProvider: () => now)),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    await notifier.refresh();
    expect(notifier.recentHourTotal()?.frameCount, 8190);

    now = DateTime(2026, 10, 26, 11, 35);
    final finalized1130 = slot(DateTime(2026, 10, 26, 11, 30));
    todaySummary = _daySummaryWithObservations(now, [...completed, finalized1130]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();

    final observation1135 = slot(DateTime(2026, 10, 26, 11, 35), coveredSeconds: 0);
    liveNotifier.emit(observation1135);
    notifier.onObservationChanged();
    expect(notifier.recentHourTotal()?.frameCount, 16380);

    now = DateTime(2026, 10, 26, 11, 37);
    final updatedObservation1135 = slot(DateTime(2026, 10, 26, 11, 35), coveredSeconds: 120);
    liveNotifier.emit(updatedObservation1135);
    notifier.onObservationChanged();
    expect(notifier.recentHourTotal()?.frameCount, 16380);
    expect(notifier.recentHourTotal()?.coveredSeconds, 3420);

    final revisedFinalized1130 = finalized1130.copyWith(frameCount: slotFrames(DateTime(2026, 10, 26, 11, 30)) + 1000);
    todaySummary = _daySummaryWithObservations(now, [...completed, revisedFinalized1130]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();
    expect(notifier.recentHourTotal()?.frameCount, 17380);

    now = DateTime(2026, 10, 26, 11, 40);
    final finalized1135 = updatedObservation1135.copyWith(coveredSeconds: 300);
    todaySummary = _daySummaryWithObservations(now, [...completed, revisedFinalized1130, finalized1135]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();

    final observation1140 = slot(DateTime(2026, 10, 26, 11, 40), coveredSeconds: 0);
    liveNotifier.emit(observation1140);
    notifier.onObservationChanged();
    expect(notifier.recentHourTotal()?.frameCount, 33760);

    final revisedFinalized1135 = finalized1135.copyWith(frameCount: slotFrames(DateTime(2026, 10, 26, 11, 35)) + 2000);
    todaySummary = _daySummaryWithObservations(now, [...completed, revisedFinalized1130, revisedFinalized1135]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();
    expect(notifier.recentHourTotal()?.frameCount, 35760);
  });

  test('recentHourTotal works from the live observation when today has no completed slots', () async {
    final now = DateTime(2026, 10, 26, 11, 37);
    final emptySummary = _daySummaryWithObservations(now, const []);
    final analytics = _FakeAnalyticsService(
      daySummaries: {'2026-10-26': emptySummary, '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20)},
      monthSummary: null,
      yearSummary: null,
    );
    final liveObservation = _observation(now, hour: 11, minute: 35, frameCount: 7, coveredSeconds: 120);
    final liveNotifier = _FakeObservationNotifier(liveObservation);
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(() => InsightNotifier(nowProvider: () => now)),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    await notifier.refresh();

    expect(notifier.recentHourTotal()?.frameCount, 7);
    expect(notifier.recentHourTotal()?.coveredSeconds, 120);
    expect(notifier.state.recentHourObservation?.frameCount, 7);
  });

  test('an older refresh cannot overwrite the latest comparison period', () async {
    final now = DateTime(2026, 10, 26, 11, 37);
    final delayedYesterday = Completer<core_domain.DaySummary?>();
    final weekdaySeries = _series(now, 40);
    final monthSummary = core_domain.MonthSummary(
      year: 2026,
      month: 10,
      weekdayFiveMinuteObservation: weekdaySeries,
      weekendFiveMinuteObservation: weekdaySeries,
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
    final analytics = _FakeAnalyticsService(
      daySummaries: {'2026-10-26': _daySummary(now, 10), '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20)},
      monthSummary: monthSummary,
      yearSummary: null,
      pendingDaySummaries: {'2026-10-25': delayedYesterday},
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
    final olderRefresh = notifier.refresh();
    await Future<void>.delayed(Duration.zero);

    notifier.setComparisonPeriod(core_domain.TrafficComparisonPeriod.monthlyAverage);
    await notifier.refresh();
    expect(notifier.state.comparisonPeriod, core_domain.TrafficComparisonPeriod.monthlyAverage);

    delayedYesterday.complete(_daySummary(DateTime(2026, 10, 25), 20));
    await olderRefresh;

    expect(notifier.state.comparisonPeriod, core_domain.TrafficComparisonPeriod.monthlyAverage);
    expect(notifier.state.comparisonTypicalDay, monthSummary.monthlyTotal);
    await notifier.refresh();
    expect(notifier.state.comparisonTypicalDay, monthSummary.monthlyTotal);
  });
}

class _FakeObservationNotifier extends observation.ObservationNotifier {
  _FakeObservationNotifier(this._observation);

  final core_domain.Observation _observation;

  @override
  core_domain.ObservationState build() =>
      core_domain.ObservationState(liveObservation: _observation, status: core_domain.ObservationStatus.active);

  void emit(core_domain.Observation next) =>
      state = core_domain.ObservationState(liveObservation: next, status: core_domain.ObservationStatus.active);
}

class _FakeAnalyticsService implements core_domain.AnalyticsService {
  _FakeAnalyticsService({
    required this.daySummaries,
    required this.monthSummary,
    required this.yearSummary,
    this.pendingDaySummaries = const {},
  });

  final Map<String, core_domain.DaySummary> daySummaries;
  final core_domain.MonthSummary? monthSummary;
  final core_domain.YearSummary? yearSummary;
  final Map<String, Completer<core_domain.DaySummary?>> pendingDaySummaries;
  final dayRequests = <String>[];
  final monthRequests = <String>[];
  final yearRequests = <int>[];

  @override
  Future<void> add(core_domain.Observation observation) async {}

  @override
  Future<core_domain.DaySummary?> getDaySummary(int year, int month, int day) async {
    final key =
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    dayRequests.add(key);
    final pending = pendingDaySummaries[key];
    if (pending != null) return pending.future;
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
