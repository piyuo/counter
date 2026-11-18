// TOC
// 1. InsightNotifier refresh tests

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:core_runtime/insight/insight_notifier.dart';
import 'package:core_runtime/observation/observation_notifier.dart'
    as observation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

core_domain.Observation _observation(
  DateTime date, {
  required int hour,
  required int minute,
  required int frameCount,
  int coveredSeconds = 0,
  core_domain.ObservationGranularity granularity =
      core_domain.ObservationGranularity.minutes5,
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

core_domain.DaySummary _daySummaryWithObservations(
  DateTime date,
  List<core_domain.Observation> observations,
) {
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
  test(
    'build starts with an empty state for today and compares to yesterday',
    () {
      final now = DateTime(2026, 10, 26, 11, 37);
      final container = ProviderContainer(
        overrides: [
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);

      final state = container.read(insightProvider);

      expect(state.businessDate, '2026-10-26');
      expect(state.comparisonPeriod, core_domain.TrafficPeriod.yesterday);
      expect(state.recentHourTotal, isNull);
      expect(state.comparisonRecentHourTotal, isNull);
      expect(state.todaySeries, isNull);
      expect(state.comparisonSeries, isNull);
      expect(state.comparisonTotal, isNull);
    },
  );

  test(
    'refresh builds and publishes dashboard data for each comparison period',
    () async {
      final now = DateTime(2026, 10, 26, 11, 35);
      final todaySummary = _daySummary(now, 10);
      final yesterday = _daySummary(DateTime(2026, 10, 25), 20);
      final lastWeek = _daySummary(DateTime(2026, 10, 19), 30);
      final weekdaySeries = _series(now, 40);
      final weekendSeries = _series(DateTime(2026, 10, 25), 50);
      final monthSummary = core_domain.MonthSummary(
        year: 2026,
        month: 9,
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
        year: 2025,
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
        daySummaries: {
          '2026-10-26': todaySummary,
          '2026-10-25': yesterday,
          '2026-10-19': lastWeek,
        },
        monthSummary: monthSummary,
        yearSummary: yearSummary,
      );
      final liveObservation = _observation(
        now,
        hour: 11,
        minute: 35,
        frameCount: 0,
        coveredSeconds: 300,
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          observation.observationProvider.overrideWith(
            () => _FakeObservationNotifier(liveObservation),
          ),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      final periodExpectations = [
        (
          period: core_domain.TrafficPeriod.yesterday,
          expectedSeries: yesterday.fiveMinuteObservations,
          expectedTotal: yesterday.dailyTotal,
          expectedFrames: 21,
        ),
        (
          period: core_domain.TrafficPeriod.sameDayLastWeek,
          expectedSeries: lastWeek.fiveMinuteObservations,
          expectedTotal: lastWeek.dailyTotal,
          expectedFrames: 31,
        ),
        (
          period: core_domain.TrafficPeriod.lastMonthAverage,
          expectedSeries: weekdaySeries,
          expectedTotal: monthSummary.monthlyTotal,
          expectedFrames: 41,
        ),
        (
          period: core_domain.TrafficPeriod.lastYearAverage,
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
        expect(dashboard.recentHourTotal?.frameCount, 11);
        expect(dashboard.comparisonSeries, expectation.expectedSeries);
        expect(dashboard.comparisonTotal, expectation.expectedTotal);
        expect(
          dashboard.comparisonRecentHourTotal?.frameCount,
          expectation.expectedFrames,
        );
      }
      expect(analytics.monthRequests, ['2026-09']);
      expect(analytics.yearRequests, [2025]);
    },
  );

  test(
    'observation lookups return the requested day and period series',
    () async {
      final now = DateTime(2026, 10, 26, 11, 37);
      final todayObservations = [
        for (var hour = 0; hour < 24; hour++)
          for (var minute = 0; minute < 60; minute += 5)
            _observation(
              now,
              hour: hour,
              minute: minute,
              frameCount: hour * 60 + minute,
            ),
      ];
      final today = _daySummaryWithObservations(now, todayObservations);
      final yesterday = _daySummary(DateTime(2026, 10, 25), 20);
      final lastWeek = _daySummary(DateTime(2026, 10, 19), 30);
      final weekdaySeries = _series(now, 40);
      final weekendSeries = _series(DateTime(2026, 10, 25), 50);
      final analytics = _FakeAnalyticsService(
        daySummaries: {
          '2026-10-26': today,
          '2026-10-25': yesterday,
          '2026-10-19': lastWeek,
        },
        monthSummary: core_domain.MonthSummary(
          year: 2026,
          month: 9,
          weekdayFiveMinuteObservation: weekdaySeries,
          weekendFiveMinuteObservation: weekendSeries,
          hourlyTotals: const [],
          dailyTotals: const [],
          monthlyTotal: _observation(
            now,
            hour: -1,
            minute: -1,
            frameCount: 0,
            granularity: core_domain.ObservationGranularity.month,
          ),
        ),
        yearSummary: core_domain.YearSummary(
          year: 2025,
          weekdayFiveMinuteObservation: weekdaySeries,
          weekendFiveMinuteObservation: weekendSeries,
          dailyTotals: const [],
          monthlyTotals: const [],
          yearlyTotal: _observation(
            now,
            hour: -1,
            minute: -1,
            frameCount: 0,
            granularity: core_domain.ObservationGranularity.year,
          ),
        ),
      );
      final liveObservation = _observation(
        now,
        hour: 11,
        minute: 35,
        frameCount: 99,
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          observation.observationProvider.overrideWith(
            () => _FakeObservationNotifier(liveObservation),
          ),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      expect(
        await notifier.getObservationsByDate(DateTime(2026, 10, 19, 15)),
        lastWeek.fiveMinuteObservations,
      );
      await expectLater(
        notifier.getObservationsByDate(now),
        throwsAssertionError,
      );
      await expectLater(
        notifier.getObservationsByDate(DateTime(2026, 10, 27)),
        throwsAssertionError,
      );
      expect(
        await notifier.getObservationsFromYesterday(),
        yesterday.fiveMinuteObservations,
      );
      expect(
        await notifier.getObservationsFromSameDayLastWeek(),
        lastWeek.fiveMinuteObservations,
      );
      expect(await notifier.getObservationsFromLastMonth(), weekdaySeries);
      expect(await notifier.getObservationsFromLastYear(), weekdaySeries);

      final savedToday = await notifier.getObservationsFromToday();
      expect(savedToday, today.fiveMinuteObservations);
      expect(savedToday?.at(11, 35)?.frameCount, 695);

      final liveToday = await notifier.getObservationsFromLiveToday();
      expect(liveToday?.length, ObservationSeries.maxLength);
      expect(liveToday?.at(11, 35)?.frameCount, 99);

      await notifier.refresh();
      final recentHour = notifier.getObservationsFromRecentHour();
      expect(recentHour.length, 12);
      expect(recentHour.items.first.hour, 10);
      expect(recentHour.items.first.minute, 40);
      expect(recentHour.at(11, 35)?.frameCount, 99);
      expect(recentHour.items.last.frameCount, 99);
    },
  );

  test('getObservationsFromLiveToday overlays the live slot', () async {
    final now = DateTime(2026, 10, 26, 11, 37);
    final savedSeries = _daySummaryWithObservations(now, [
      _observation(now, hour: 11, minute: 30, frameCount: 10),
      _observation(now, hour: 11, minute: 35, frameCount: 20),
    ]);
    final analytics = _FakeAnalyticsService(
      daySummaries: {'2026-10-26': savedSeries},
      monthSummary: null,
      yearSummary: null,
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(
          () => _FakeObservationNotifier(
            _observation(now, hour: 11, minute: 35, frameCount: 99),
          ),
        ),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    final result = await notifier.getObservationsFromLiveToday();

    expect(result?.length, 2);
    expect(result?.at(11, 30)?.frameCount, 10);
    expect(result?.at(11, 35)?.frameCount, 99);
  });

  test(
    'getObservationsFromRecentHour uses saved and live observations',
    () async {
      final now = DateTime(2026, 10, 26, 11, 37);
      final today = _daySummaryWithObservations(now, [
        _observation(now, hour: 10, minute: 35, frameCount: 10),
        _observation(now, hour: 10, minute: 40, frameCount: 20),
        _observation(now, hour: 11, minute: 35, frameCount: 30),
      ]);
      final analytics = _FakeAnalyticsService(
        daySummaries: {'2026-10-26': today},
        monthSummary: null,
        yearSummary: null,
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          observation.observationProvider.overrideWith(
            () => _FakeObservationNotifier(
              _observation(now, hour: 11, minute: 35, frameCount: 99),
            ),
          ),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);
      await notifier.refresh();

      final result = notifier.getObservationsFromRecentHour();

      expect(result.length, 2);
      expect(result.at(10, 40)?.frameCount, 20);
      expect(result.at(10, 35), isNull);
      expect(result.at(11, 35)?.frameCount, 99);
    },
  );

  test(
    'observation average periods select weekend profiles on weekends',
    () async {
      final now = DateTime(2026, 10, 25, 11, 37);
      final weekdaySeries = _series(DateTime(2026, 10, 26), 40);
      final weekendSeries = _series(now, 50);
      final analytics = _FakeAnalyticsService(
        daySummaries: {},
        monthSummary: core_domain.MonthSummary(
          year: 2026,
          month: 9,
          weekdayFiveMinuteObservation: weekdaySeries,
          weekendFiveMinuteObservation: weekendSeries,
          hourlyTotals: const [],
          dailyTotals: const [],
          monthlyTotal: _observation(
            now,
            hour: -1,
            minute: -1,
            frameCount: 0,
            granularity: core_domain.ObservationGranularity.month,
          ),
        ),
        yearSummary: core_domain.YearSummary(
          year: 2025,
          weekdayFiveMinuteObservation: weekdaySeries,
          weekendFiveMinuteObservation: weekendSeries,
          dailyTotals: const [],
          monthlyTotals: const [],
          yearlyTotal: _observation(
            now,
            hour: -1,
            minute: -1,
            frameCount: 0,
            granularity: core_domain.ObservationGranularity.year,
          ),
        ),
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      expect(await notifier.getObservationsFromLastMonth(), weekendSeries);
      expect(await notifier.getObservationsFromLastYear(), weekendSeries);
    },
  );

  test(
    'caches observation monthly and yearly averages by business date',
    () async {
      var now = DateTime(2026, 10, 26, 11, 37);
      final series = _series(now, 40);
      final analytics = _FakeAnalyticsService(
        daySummaries: {},
        monthSummary: core_domain.MonthSummary(
          year: 2026,
          month: 9,
          weekdayFiveMinuteObservation: series,
          weekendFiveMinuteObservation: series,
          hourlyTotals: const [],
          dailyTotals: const [],
          monthlyTotal: _observation(
            now,
            hour: -1,
            minute: -1,
            frameCount: 0,
            granularity: core_domain.ObservationGranularity.month,
          ),
        ),
        yearSummary: core_domain.YearSummary(
          year: 2025,
          weekdayFiveMinuteObservation: series,
          weekendFiveMinuteObservation: series,
          dailyTotals: const [],
          monthlyTotals: const [],
          yearlyTotal: _observation(
            now,
            hour: -1,
            minute: -1,
            frameCount: 0,
            granularity: core_domain.ObservationGranularity.year,
          ),
        ),
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      for (var index = 0; index < 2; index++) {
        await notifier.getObservationsFromLastMonth();
        await notifier.getObservationsFromLastYear();
      }
      expect(analytics.monthRequests, ['2026-09']);
      expect(analytics.yearRequests, [2025]);

      now = DateTime(2026, 10, 27, 11, 37);
      await notifier.getObservationsFromLastMonth();
      await notifier.getObservationsFromLastYear();
      expect(analytics.monthRequests, ['2026-09', '2026-09']);
      expect(analytics.yearRequests, [2025, 2025]);

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.sameDayLastWeek);
      await notifier.getObservationsFromLastMonth();
      await notifier.getObservationsFromLastYear();
      expect(analytics.monthRequests, ['2026-09', '2026-09']);
      expect(analytics.yearRequests, [2025, 2025]);

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.lastMonthAverage);
      now = DateTime(2026, 10, 28, 11, 37);
      await notifier.getObservationsFromLastMonth();
      await notifier.refresh();
      expect(analytics.monthRequests, ['2026-09', '2026-09', '2026-09']);

      now = DateTime(2026, 10, 29, 11, 37);
      await Future.wait([
        notifier.refresh(),
        notifier.getObservationsFromLastMonth(),
      ]);
      expect(analytics.monthRequests, hasLength(4));
    },
  );

  test('retries null and failed observation monthly average loads', () async {
    final now = DateTime(2026, 10, 26, 11, 37);
    final series = _series(now, 40);
    final monthSummary = core_domain.MonthSummary(
      year: 2026,
      month: 9,
      weekdayFiveMinuteObservation: series,
      weekendFiveMinuteObservation: series,
      hourlyTotals: const [],
      dailyTotals: const [],
      monthlyTotal: _observation(
        now,
        hour: -1,
        minute: -1,
        frameCount: 0,
        granularity: core_domain.ObservationGranularity.month,
      ),
    );
    var attempts = 0;
    final failedLoad = Completer<core_domain.MonthSummary?>();
    final analytics = _FakeAnalyticsService(
      daySummaries: {},
      monthSummary: null,
      yearSummary: null,
      monthSummaryLoader: (_, _) async {
        attempts++;
        if (attempts == 1) return null;
        if (attempts == 2) return failedLoad.future;
        return monthSummary;
      },
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    expect(await notifier.getObservationsFromLastMonth(), isNull);
    final failedCalls = [
      notifier.getObservationsFromLastMonth(),
      notifier.getObservationsFromLastMonth(),
    ];
    final failureExpectations = Future.wait([
      expectLater(failedCalls[0], throwsStateError),
      expectLater(failedCalls[1], throwsStateError),
    ]);
    expect(analytics.monthRequests, hasLength(2));
    failedLoad.completeError(StateError('temporary analytics failure'));
    await failureExpectations;
    expect(await notifier.getObservationsFromLastMonth(), series);
    expect(analytics.monthRequests, hasLength(3));
  });

  test(
    'a stale cache completion does not clear a newer business date entry',
    () async {
      var now = DateTime(2026, 10, 26, 11, 37);
      final oldLoad = Completer<core_domain.MonthSummary?>();
      final newLoad = Completer<core_domain.MonthSummary?>();
      final series = _series(now, 40);
      final monthSummary = core_domain.MonthSummary(
        year: 2026,
        month: 9,
        weekdayFiveMinuteObservation: series,
        weekendFiveMinuteObservation: series,
        hourlyTotals: const [],
        dailyTotals: const [],
        monthlyTotal: _observation(
          now,
          hour: -1,
          minute: -1,
          frameCount: 0,
          granularity: core_domain.ObservationGranularity.month,
        ),
      );
      var attempts = 0;
      final analytics = _FakeAnalyticsService(
        daySummaries: {},
        monthSummary: null,
        yearSummary: null,
        monthSummaryLoader: (_, _) {
          attempts++;
          return attempts == 1 ? oldLoad.future : newLoad.future;
        },
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      await notifier.refresh();
      final oldLookup = notifier.getObservationsFromLastMonth();

      now = DateTime(2026, 10, 27, 11, 37);
      final rolloverRefresh = notifier.refresh();
      final newLookup = notifier.getObservationsFromLastMonth();
      oldLoad.complete(null);
      expect(await oldLookup, isNull);

      final repeatedNewLookup = notifier.getObservationsFromLastMonth();
      expect(analytics.monthRequests, hasLength(2));
      newLoad.complete(monthSummary);
      expect(await newLookup, series);
      expect(await repeatedNewLookup, series);
      await rolloverRefresh;
    },
  );

  test(
    'caches comparison summary until period or business date changes',
    () async {
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
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.yesterday);
      await notifier.refresh();
      notifier.setComparisonPeriod(core_domain.TrafficPeriod.yesterday);
      await notifier.refresh();
      expect(
        analytics.dayRequests.where((date) => date == '2026-10-25'),
        hasLength(1),
      );

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.sameDayLastWeek);
      await notifier.refresh();
      expect(
        analytics.dayRequests.where((date) => date == '2026-10-19'),
        hasLength(1),
      );

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.yesterday);
      await notifier.refresh();
      expect(
        analytics.dayRequests.where((date) => date == '2026-10-25'),
        hasLength(2),
      );
      await notifier.refresh();
      expect(
        analytics.dayRequests.where((date) => date == '2026-10-25'),
        hasLength(2),
      );

      final previousDateRequestCount = analytics.dayRequests
          .where((date) => date == '2026-10-26')
          .length;
      now = DateTime(2026, 10, 27, 11, 35);
      await notifier.refresh();
      expect(notifier.state.businessDate, '2026-10-27');
      expect(
        analytics.dayRequests.where((date) => date == '2026-10-26'),
        hasLength(previousDateRequestCount + 1),
      );
    },
  );

  test(
    'recentHourTotal combines completed observations with the live observation',
    () async {
      final now = DateTime(2026, 10, 26, 11, 37);
      final completed = [
        for (var index = 0; index < 11; index++)
          () {
            final time = DateTime(
              2026,
              10,
              26,
              10,
              40,
            ).add(Duration(minutes: index * 5));
            return _observation(
              now,
              hour: time.hour,
              minute: time.minute,
              frameCount: 1,
              coveredSeconds: 300,
            );
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
      final liveObservation = _observation(
        now,
        hour: 11,
        minute: 35,
        frameCount: 2,
        coveredSeconds: 120,
      );
      final liveNotifier = _FakeObservationNotifier(liveObservation);
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          observation.observationProvider.overrideWith(() => liveNotifier),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      await notifier.refresh();

      expect(notifier.recentHourTotal()?.frameCount, 13);
      expect(notifier.recentHourTotal()?.coveredSeconds, 3420);
      expect(notifier.state.recentHourTotal?.frameCount, 13);
      final todaySeries = notifier.state.todaySeries;
      final comparisonSeries = notifier.state.comparisonSeries;

      final updatedObservation = liveObservation.copyWith(frameCount: 3);
      liveNotifier.emit(updatedObservation);
      await notifier.onObservationChanged();

      expect(notifier.state.recentHourTotal?.frameCount, 14);
      expect(identical(notifier.state.todaySeries, todaySeries), isTrue);
      expect(
        identical(notifier.state.comparisonSeries, comparisonSeries),
        isTrue,
      );
    },
  );

  test('recentHourTotal advances slots at rollover without losing or double counting the finalized slot', () async {
    var now = DateTime(2026, 10, 26, 11, 34, 59);
    final windowOrigin = DateTime(2026, 10, 26, 10, 30);
    int slotFrames(DateTime time) =>
        1 << (time.difference(windowOrigin).inMinutes ~/ 5);
    core_domain.Observation slot(DateTime time, {int coveredSeconds = 300}) =>
        _observation(
          time,
          hour: time.hour,
          minute: time.minute,
          frameCount: slotFrames(time),
          coveredSeconds: coveredSeconds,
        );

    final completed = [
      for (var index = 0; index < 12; index++)
        slot(windowOrigin.add(Duration(minutes: index * 5))),
    ];
    var todaySummary = _daySummaryWithObservations(now, completed);
    final analytics = _FakeAnalyticsService(
      daySummaries: {
        '2026-10-26': todaySummary,
        '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20),
      },
      monthSummary: null,
      yearSummary: null,
    );
    final liveNotifier = _FakeObservationNotifier(
      slot(DateTime(2026, 10, 26, 11, 30), coveredSeconds: 299),
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    await notifier.refresh();
    expect(notifier.recentHourTotal()?.frameCount, 8190);

    now = DateTime(2026, 10, 26, 11, 35);
    final finalized1130 = slot(DateTime(2026, 10, 26, 11, 30));
    todaySummary = _daySummaryWithObservations(now, [
      ...completed,
      finalized1130,
    ]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();

    final observation1135 = slot(
      DateTime(2026, 10, 26, 11, 35),
      coveredSeconds: 0,
    );
    liveNotifier.emit(observation1135);
    await notifier.onObservationChanged();
    expect(notifier.recentHourTotal()?.frameCount, 16380);

    now = DateTime(2026, 10, 26, 11, 37);
    final updatedObservation1135 = slot(
      DateTime(2026, 10, 26, 11, 35),
      coveredSeconds: 120,
    );
    liveNotifier.emit(updatedObservation1135);
    await notifier.onObservationChanged();
    expect(notifier.recentHourTotal()?.frameCount, 16380);
    expect(notifier.recentHourTotal()?.coveredSeconds, 3420);

    final revisedFinalized1130 = finalized1130.copyWith(
      frameCount: slotFrames(DateTime(2026, 10, 26, 11, 30)) + 1000,
    );
    todaySummary = _daySummaryWithObservations(now, [
      ...completed,
      revisedFinalized1130,
    ]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();
    expect(notifier.recentHourTotal()?.frameCount, 17380);

    now = DateTime(2026, 10, 26, 11, 40);
    final finalized1135 = updatedObservation1135.copyWith(coveredSeconds: 300);
    todaySummary = _daySummaryWithObservations(now, [
      ...completed,
      revisedFinalized1130,
      finalized1135,
    ]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();

    final observation1140 = slot(
      DateTime(2026, 10, 26, 11, 40),
      coveredSeconds: 0,
    );
    liveNotifier.emit(observation1140);
    await notifier.onObservationChanged();
    expect(notifier.recentHourTotal()?.frameCount, 33760);

    final revisedFinalized1135 = finalized1135.copyWith(
      frameCount: slotFrames(DateTime(2026, 10, 26, 11, 35)) + 2000,
    );
    todaySummary = _daySummaryWithObservations(now, [
      ...completed,
      revisedFinalized1130,
      revisedFinalized1135,
    ]);
    analytics.daySummaries['2026-10-26'] = todaySummary;
    await notifier.refresh();
    expect(notifier.recentHourTotal()?.frameCount, 35760);
  });

  test('recentHourTotal works from the live observation when today has no completed slots', () async {
    final now = DateTime(2026, 10, 26, 11, 37);
    final emptySummary = _daySummaryWithObservations(now, const []);
    final analytics = _FakeAnalyticsService(
      daySummaries: {
        '2026-10-26': emptySummary,
        '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20),
      },
      monthSummary: null,
      yearSummary: null,
    );
    final liveObservation = _observation(
      now,
      hour: 11,
      minute: 35,
      frameCount: 7,
      coveredSeconds: 120,
    );
    final liveNotifier = _FakeObservationNotifier(liveObservation);
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);

    await notifier.refresh();

    expect(notifier.recentHourTotal()?.frameCount, 7);
    expect(notifier.recentHourTotal()?.coveredSeconds, 120);
    expect(notifier.state.recentHourTotal?.frameCount, 7);
  });

  test('recentHourTotal ignores cached slots from the previous business date after midnight', () async {
    var now = DateTime(2026, 10, 26, 23, 55);
    final previousDateEarlySlot = _observation(
      now,
      hour: 0,
      minute: 5,
      frameCount: 100,
    );
    final analytics = _FakeAnalyticsService(
      daySummaries: {
        '2026-10-26': _daySummaryWithObservations(now, [previousDateEarlySlot]),
        '2026-10-25': _daySummaryWithObservations(
          DateTime(2026, 10, 25),
          const [],
        ),
      },
      monthSummary: null,
      yearSummary: null,
    );
    final liveNotifier = _FakeObservationNotifier(
      _observation(now, hour: 23, minute: 55, frameCount: 1),
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);
    await notifier.refresh();

    now = DateTime(2026, 10, 27, 0, 10);
    liveNotifier.emit(_observation(now, hour: 0, minute: 10, frameCount: 2));

    expect(notifier.recentHourTotal()?.frameCount, 2);
  });

  test(
    'overlapping observation updates at midnight keep the latest live value',
    () async {
      var now = DateTime(2026, 10, 26, 23, 55);
      final today = _daySummaryWithObservations(now, const []);
      final yesterday = _daySummaryWithObservations(
        DateTime(2026, 10, 25),
        const [],
      );
      final nextDate = DateTime(2026, 10, 27);
      final pendingNextDate = Completer<core_domain.DaySummary?>();
      final analytics = _FakeAnalyticsService(
        daySummaries: {'2026-10-26': today, '2026-10-25': yesterday},
        monthSummary: null,
        yearSummary: null,
        pendingDaySummaries: {'2026-10-27': pendingNextDate},
      );
      final liveNotifier = _FakeObservationNotifier(
        _observation(now, hour: 23, minute: 55, frameCount: 1),
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          observation.observationProvider.overrideWith(() => liveNotifier),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);
      await notifier.refresh();

      now = nextDate;
      liveNotifier.emit(_observation(now, hour: 0, minute: 0, frameCount: 2));
      final olderUpdate = notifier.onObservationChanged();
      await Future<void>.delayed(Duration.zero);

      liveNotifier.emit(_observation(now, hour: 0, minute: 0, frameCount: 7));
      await notifier.onObservationChanged();
      analytics.pendingDaySummaries.remove('2026-10-27');
      pendingNextDate.complete(_daySummaryWithObservations(now, const []));
      await olderUpdate;

      expect(notifier.state.businessDate, '2026-10-27');
      expect(notifier.state.recentHourTotal?.frameCount, 7);
    },
  );

  test('a new live slot replaces the previous live slot', () async {
    var now = DateTime(2026, 10, 26, 14, 20);
    final analytics = _FakeAnalyticsService(
      daySummaries: {
        '2026-10-26': _daySummaryWithObservations(now, const []),
        '2026-10-25': _daySummaryWithObservations(
          DateTime(2026, 10, 25),
          const [],
        ),
      },
      monthSummary: null,
      yearSummary: null,
    );
    final liveNotifier = _FakeObservationNotifier(
      _observation(now, hour: 14, minute: 20, frameCount: 5),
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);
    await notifier.refresh();
    expect(notifier.state.recentHourTotal?.frameCount, 5);

    now = DateTime(2026, 10, 26, 14, 25);
    liveNotifier.emit(_observation(now, hour: 14, minute: 25, frameCount: 8));
    await notifier.onObservationChanged();

    final recentHour = notifier.getObservationsFromRecentHour();
    expect(notifier.state.recentHourTotal?.frameCount, 8);
    expect(recentHour.length, 1);
    expect(recentHour.at(14, 20), isNull);
    expect(recentHour.at(14, 25)?.frameCount, 8);
  });

  test('recent-hour KPI uses saved observations when live data is missing at a slot boundary', () async {
    var now = DateTime(2026, 10, 26, 14, 24, 59);
    final savedObservation = _observation(
      now,
      hour: 14,
      minute: 20,
      frameCount: 3,
    );
    final analytics = _FakeAnalyticsService(
      daySummaries: {
        '2026-10-26': _daySummaryWithObservations(now, [savedObservation]),
        '2026-10-25': _daySummaryWithObservations(
          DateTime(2026, 10, 25),
          const [],
        ),
      },
      monthSummary: null,
      yearSummary: null,
    );
    final liveNotifier = _FakeObservationNotifier(
      _observation(now, hour: 14, minute: 20, frameCount: 5),
    );
    final container = ProviderContainer(
      overrides: [
        core_domain.analyticsServiceProvider.overrideWithValue(analytics),
        observation.observationProvider.overrideWith(() => liveNotifier),
        insightProvider.overrideWith(
          () => InsightNotifier(nowProvider: () => now),
        ),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(insightProvider.notifier);
    await notifier.refresh();
    expect(notifier.state.recentHourTotal?.frameCount, 5);

    now = DateTime(2026, 10, 26, 14, 25);
    await notifier.onObservationChanged();

    expect(notifier.state.recentHourTotal?.frameCount, 3);
    expect(notifier.recentHourTotal()?.frameCount, 3);
    final recentHour = notifier.getObservationsFromRecentHour();
    expect(recentHour.at(14, 20)?.frameCount, 3);
  });

  test(
    'the next refresh includes an observation saved during the prior refresh',
    () async {
      final now = DateTime(2026, 10, 26, 14, 25);
      final dateKey = '2026-10-26';
      final initialSummary = _daySummaryWithObservations(now, const []);
      final savedObservation = _observation(
        now,
        hour: 14,
        minute: 20,
        frameCount: 6,
      );
      final updatedSummary = _daySummaryWithObservations(now, [
        savedObservation,
      ]);
      final pendingToday = Completer<core_domain.DaySummary?>();
      final analytics = _FakeAnalyticsService(
        daySummaries: {
          dateKey: initialSummary,
          '2026-10-25': _daySummaryWithObservations(
            DateTime(2026, 10, 25),
            const [],
          ),
        },
        monthSummary: null,
        yearSummary: null,
        pendingDaySummaries: {dateKey: pendingToday},
      );
      final liveNotifier = _FakeObservationNotifier(
        _observation(now, hour: 14, minute: 25, frameCount: 2),
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          observation.observationProvider.overrideWith(() => liveNotifier),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      final refreshDuringSave = notifier.refresh();
      await Future<void>.delayed(Duration.zero);
      analytics.daySummaries[dateKey] = updatedSummary;
      analytics.pendingDaySummaries.remove(dateKey);
      pendingToday.complete(initialSummary);
      await refreshDuringSave;
      expect(notifier.state.todaySeries, initialSummary.fiveMinuteObservations);

      await notifier.refresh();

      expect(notifier.state.todaySeries?.at(14, 20)?.frameCount, 6);
    },
  );

  test(
    'an older refresh cannot overwrite the latest comparison period',
    () async {
      final now = DateTime(2026, 10, 26, 11, 37);
      final delayedYesterday = Completer<core_domain.DaySummary?>();
      final weekdaySeries = _series(now, 40);
      final monthSummary = core_domain.MonthSummary(
        year: 2026,
        month: 9,
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
        daySummaries: {
          '2026-10-26': _daySummary(now, 10),
          '2026-10-25': _daySummary(DateTime(2026, 10, 25), 20),
        },
        monthSummary: monthSummary,
        yearSummary: null,
        pendingDaySummaries: {'2026-10-25': delayedYesterday},
      );
      final container = ProviderContainer(
        overrides: [
          core_domain.analyticsServiceProvider.overrideWithValue(analytics),
          insightProvider.overrideWith(
            () => InsightNotifier(nowProvider: () => now),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(insightProvider.notifier);

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.yesterday);
      final olderRefresh = notifier.refresh();
      await Future<void>.delayed(Duration.zero);

      notifier.setComparisonPeriod(core_domain.TrafficPeriod.lastMonthAverage);
      await notifier.refresh();
      expect(
        notifier.state.comparisonPeriod,
        core_domain.TrafficPeriod.lastMonthAverage,
      );

      delayedYesterday.complete(_daySummary(DateTime(2026, 10, 25), 20));
      await olderRefresh;

      expect(
        notifier.state.comparisonPeriod,
        core_domain.TrafficPeriod.lastMonthAverage,
      );
      expect(notifier.state.comparisonTotal, monthSummary.monthlyTotal);
      await notifier.refresh();
      expect(notifier.state.comparisonTotal, monthSummary.monthlyTotal);
    },
  );
}

class _FakeObservationNotifier extends observation.ObservationNotifier {
  _FakeObservationNotifier(this._observation);

  final core_domain.Observation _observation;

  @override
  core_domain.ObservationState build() => core_domain.ObservationState(
    liveObservation: _observation,
    status: core_domain.ObservationStatus.started,
  );

  void emit(core_domain.Observation next) =>
      state = core_domain.ObservationState(
        liveObservation: next,
        status: core_domain.ObservationStatus.started,
      );
}

class _FakeAnalyticsService implements core_domain.AnalyticsService {
  _FakeAnalyticsService({
    required this.daySummaries,
    required this.monthSummary,
    required this.yearSummary,
    this.pendingDaySummaries = const {},
    this.monthSummaryLoader,
  });

  final Map<String, core_domain.DaySummary> daySummaries;
  final core_domain.MonthSummary? monthSummary;
  final core_domain.YearSummary? yearSummary;
  final Map<String, Completer<core_domain.DaySummary?>> pendingDaySummaries;
  final Future<core_domain.MonthSummary?> Function(int year, int month)?
  monthSummaryLoader;
  final dayRequests = <String>[];
  final monthRequests = <String>[];
  final yearRequests = <int>[];

  @override
  Future<void> add(core_domain.Observation observation) async {}

  @override
  Future<core_domain.DaySummary?> getDaySummary(
    int year,
    int month,
    int day,
  ) async {
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
    final loader = monthSummaryLoader;
    if (loader != null) return loader(year, month);
    return monthSummary;
  }

  @override
  Future<core_domain.YearSummary?> getYearSummary(int year) async {
    yearRequests.add(year);
    return yearSummary;
  }
}
