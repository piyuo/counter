import 'dart:math';

import 'package:core_domain/model/activity.dart';
import 'package:core_domain/model/business_period.dart';
import 'package:core_domain/model/insight_state.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_payload.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:core_domain/services/dashboard_cache.dart';
import 'package:core_domain/services/dashboard_service.dart';
import 'package:core_domain/state/models/interest_area.dart';
import 'package:flutter_test/flutter_test.dart';

const _date = (year: 2026, month: 10, day: 29);

Observation _observation(int hour, int minute, {List<Activity> areas = const [], int coveredSeconds = 300}) =>
    Observation(
      year: _date.year,
      month: _date.month,
      day: _date.day,
      hour: hour,
      minute: minute,
      coveredSeconds: coveredSeconds,
      areas: areas,
      frameCount: 1,
    );

Activity _activity(
  int areaId, {
  double passBy = 0,
  double stagnant = 0,
  double entry = 0,
  double exit = 0,
  double appear = 0,
  double disappear = 0,
  int occupancySum = 0,
  int occupancySampleCount = 0,
  int occupancyMax = 0,
  int dwellSumSeconds = 0,
  int dwellSampleCount = 0,
  int dwellMaxSeconds = 0,
}) => Activity(
  areaId: areaId,
  areaName: 'Area $areaId',
  passBy: passBy,
  stagnant: stagnant,
  entry: entry,
  exit: exit,
  appear: appear,
  disappear: disappear,
  occupancySum: occupancySum,
  occupancySampleCount: occupancySampleCount,
  occupancyMax: occupancyMax,
  dwellSumSeconds: dwellSumSeconds,
  dwellSampleCount: dwellSampleCount,
  dwellMaxSeconds: dwellMaxSeconds,
);

InsightState _dashboard({
  List<Observation> today = const [],
  ObservationSeries? todaySeries,
  Observation? pastHour,
  List<Observation> comparison = const [],
  ObservationSeries? comparisonSeries,
  Observation? comparisonPastHour,
  String businessDate = '2026-10-29',
  TrafficComparisonPeriod comparisonPeriod = TrafficComparisonPeriod.yesterday,
}) => InsightState(
  businessDate: businessDate,
  comparisonPeriod: comparisonPeriod,
  todaySeries: todaySeries ?? ObservationSeries.fromObservations(today),
  recentHourTotal: pastHour,
  comparisonSeries: comparisonSeries ?? ObservationSeries.fromObservations(comparison),
  comparisonRecentHourTotal: comparisonPastHour,
);

List<DashboardAreaData> _cacheBuild(
  DashboardCache cache,
  InsightState dashboard, {
  List<InterestArea> customAreas = const [],
  List<BusinessPeriod> businessPeriods = const [],
  required DateTime now,
}) => cache.build(insightState: dashboard, customAreas: customAreas, businessPeriods: businessPeriods, now: now);

DashboardChartPoint _pointAt(DashboardCardData card, int minute) =>
    card.chartPoints.firstWhere((point) => point.minuteOfDay == minute);

double? _referenceChartValue(List<Observation> observations, int startMinute, int areaId, DashboardMetric metric) {
  final endMinute = startMinute + 60;
  final samples = <({Activity activity, int coveredSeconds})>[];
  for (final observation in observations) {
    final minute = observation.hour * 60 + observation.minute;
    if (minute < startMinute || minute >= endMinute) continue;
    for (final activity in observation.areas) {
      if (activity.areaId == areaId) {
        samples.add((activity: activity, coveredSeconds: observation.coveredSeconds));
        break;
      }
    }
  }
  if (samples.isEmpty) return null;

  final activities = samples.map((sample) => sample.activity).toList();
  final value = switch (metric) {
    DashboardMetric.passBy ||
    DashboardMetric.stagnant ||
    DashboardMetric.entry ||
    DashboardMetric.exit ||
    DashboardMetric.appear ||
    DashboardMetric.disappear => () {
      final coveredSeconds = samples.fold<int>(0, (total, sample) => total + sample.coveredSeconds);
      if (coveredSeconds <= 0) return null;
      final count = activities.fold<double>(
        0,
        (total, activity) =>
            total +
            switch (metric) {
              DashboardMetric.passBy => activity.passBy,
              DashboardMetric.stagnant => activity.stagnant,
              DashboardMetric.entry => activity.entry,
              DashboardMetric.exit => activity.exit,
              DashboardMetric.appear => activity.appear,
              DashboardMetric.disappear => activity.disappear,
              _ => 0,
            },
      );
      return count;
    }(),
    DashboardMetric.occupancyMean => () {
      final sampled = activities.where((activity) => activity.occupancySampleCount > 0);
      final count = sampled.fold<int>(0, (total, activity) => total + activity.occupancySampleCount);
      if (count == 0) return null;
      final sum = sampled.fold<int>(0, (total, activity) => total + activity.occupancySum);
      return sum / count;
    }(),
    DashboardMetric.occupancyPeak => () {
      final sampled = activities.where((activity) => activity.occupancySampleCount > 0).toList();
      if (sampled.isEmpty) return null;
      return sampled.map((activity) => activity.occupancyMax).reduce(max).toDouble();
    }(),
    DashboardMetric.dwellTimeMean => () {
      final sampled = activities.where((activity) => activity.dwellSampleCount > 0);
      final count = sampled.fold<int>(0, (total, activity) => total + activity.dwellSampleCount);
      if (count == 0) return null;
      final sum = sampled.fold<int>(0, (total, activity) => total + activity.dwellSumSeconds);
      return sum / count / 60;
    }(),
    DashboardMetric.dwellTimeMax => () {
      final sampled = activities.where((activity) => activity.dwellSampleCount > 0).toList();
      if (sampled.isEmpty) return null;
      return sampled.map((activity) => activity.dwellMaxSeconds).reduce(max) / 60;
    }(),
  };
  return value;
}

void main() {
  group('area ordering and applicable metrics', () {
    test('keeps configured custom order and puts global last', () {
      final result = DashboardCache().build(
        insightState: _dashboard(),
        customAreas: const [
          InterestArea(id: 42, name: 'Checkout'),
          InterestArea(id: 7, name: 'Entrance'),
        ],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      expect(result.map((area) => area.areaId), [42, 7, kGlobalAreaId]);
    });

    test('omits entry and exit cards for global area', () {
      final result = DashboardCache().build(
        insightState: _dashboard(),
        customAreas: const [],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      expect(result.single.cards.map((card) => card.metric), isNot(contains(DashboardMetric.entry)));
      expect(result.single.cards.map((card) => card.metric), isNot(contains(DashboardMetric.exit)));
    });
  });

  group('event rates', () {
    test('uses the full hour count as an actual hourly rate', () {
      final dashboard = _dashboard(
        pastHour: _observation(12, 0, coveredSeconds: 3600, areas: [_activity(kGlobalAreaId, passBy: 84)]),
      );

      final result = DashboardCache().build(
        insightState: dashboard,
        customAreas: const [],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      final passBy = result.single.card(DashboardMetric.passBy).primary!;
      expect(passBy.amount, 84);
      expect(passBy.estimated, isFalse);
    });

    test('estimates partial hourly coverage and keeps missing data unavailable', () {
      final dashboard = _dashboard(
        pastHour: _observation(12, 0, coveredSeconds: 1800, areas: [_activity(kGlobalAreaId, passBy: 42)]),
      );

      final result = DashboardCache().build(
        insightState: dashboard,
        customAreas: const [],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      final passBy = result.single.card(DashboardMetric.passBy).primary!;
      expect(passBy.amount, 84);
      expect(passBy.estimated, isTrue);
      expect(passBy.coveredSeconds, 1800);
      expect(result.single.card(DashboardMetric.occupancyMean).primary, isNull);
      expect(result.single.card(DashboardMetric.occupancyPeak).primary, isNull);
    });

    test('keeps partial-hour chart counts separate from normalized live rates', () {
      final observation = _observation(11, 0, coveredSeconds: 1800, areas: [_activity(9, passBy: 300)]);
      final result = DashboardCache().build(
        insightState: _dashboard(today: [observation], pastHour: observation),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );
      final passBy = result.first.card(DashboardMetric.passBy);
      final chartPoint = _pointAt(passBy, 11 * 60);

      expect(chartPoint.todayValue, 300);
      expect(chartPoint.todayCoveredSeconds, 1800);
      expect(chartPoint.todayEstimated, isTrue);
      expect(passBy.primary!.amount, 600);
      expect(passBy.primary!.estimated, isTrue);
    });

    test('applies the coverage tolerance at its boundary', () {
      bool isEstimated(int coveredSeconds) => DashboardCache()
          .build(
            insightState: _dashboard(
              pastHour: _observation(
                12,
                0,
                coveredSeconds: coveredSeconds,
                areas: [_activity(kGlobalAreaId, passBy: 42)],
              ),
            ),
            customAreas: const [],
            businessPeriods: const [],
            now: DateTime(2026, 10, 29, 12),
          )
          .single
          .card(DashboardMetric.passBy)
          .primary!
          .estimated;

      expect(isEstimated(3595), isFalse);
      expect(isEstimated(3420), isFalse);
      expect(isEstimated(3419), isTrue);
    });

    test('normalizes completed periods by their duration and ongoing periods by elapsed time', () {
      const breakfast = BusinessPeriod(id: 'breakfast', name: 'Breakfast', startMinute: 420, endMinute: 540);
      const lunch = BusinessPeriod(id: 'lunch', name: 'Lunch', startMinute: 690, endMinute: 810);
      final observations = [
        for (var index = 0; index < 24; index++)
          _observation(
            7 + (index * 5) ~/ 60,
            (index * 5) % 60,
            areas: [_activity(kGlobalAreaId, passBy: index == 0 ? 91 : 0)],
          ),
        for (var index = 0; index < 6; index++)
          _observation(11, 30 + index * 5, areas: [_activity(kGlobalAreaId, passBy: 1)]),
      ];
      final result = DashboardCache().build(
        insightState: _dashboard(today: observations, pastHour: observations.first),
        customAreas: const [],
        businessPeriods: const [breakfast, lunch],
        now: DateTime(2026, 10, 29, 12),
      );
      final passBy = result.single.card(DashboardMetric.passBy);

      expect(passBy.periods[0].primary!.amount, closeTo(45.5, 0.001));
      expect(passBy.periods[0].primary!.estimated, isFalse);
      expect(passBy.periods[1].primary!.amount, 12);
      expect(passBy.periods[1].primary!.estimated, isFalse);
    });
  });

  group('occupancy and dwell', () {
    test('uses sums and sample counts for means and maxima for peaks', () {
      final observations = [
        _observation(
          10,
          0,
          areas: [
            _activity(
              3,
              occupancySum: 6,
              occupancySampleCount: 2,
              occupancyMax: 4,
              dwellSumSeconds: 600,
              dwellSampleCount: 2,
              dwellMaxSeconds: 500,
            ),
          ],
        ),
        _observation(
          10,
          5,
          areas: [
            _activity(
              3,
              occupancySum: 9,
              occupancySampleCount: 3,
              occupancyMax: 7,
              dwellSumSeconds: 180,
              dwellSampleCount: 1,
              dwellMaxSeconds: 180,
            ),
          ],
        ),
      ];
      final result = DashboardCache().build(
        insightState: _dashboard(today: observations, pastHour: observations.first),
        customAreas: const [InterestArea(id: 3, name: 'Dining')],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 10, 10),
      );
      final occupancyMean = result.first.card(DashboardMetric.occupancyMean);
      final occupancyPeak = result.first.card(DashboardMetric.occupancyPeak);
      final dwellMean = result.first.card(DashboardMetric.dwellTimeMean);
      final dwellMax = result.first.card(DashboardMetric.dwellTimeMax);

      expect(occupancyMean.primary!.amount, 3);
      expect(occupancyPeak.primary!.amount, 4);
      expect(dwellMean.primary!.amount, 300);
      expect(dwellMax.primary!.amount, 500);
      expect(occupancyMean.periods.isEmpty, isTrue);
    });

    test('aggregates occupancy samples independently for each area', () {
      const period = BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 600, endMinute: 610);
      final result = DashboardCache().build(
        insightState: _dashboard(
          today: [
            _observation(
              10,
              0,
              areas: [
                _activity(3, occupancySum: 6, occupancySampleCount: 2),
                _activity(4, occupancySum: 100, occupancySampleCount: 1),
              ],
            ),
            _observation(
              10,
              5,
              areas: [
                _activity(3, occupancySum: 10, occupancySampleCount: 2),
                _activity(4, occupancySum: 100, occupancySampleCount: 1),
              ],
            ),
          ],
        ),
        customAreas: const [
          InterestArea(id: 3, name: 'Dining'),
          InterestArea(id: 4, name: 'Entrance'),
        ],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 10, 10),
      );

      expect(result[0].card(DashboardMetric.occupancyMean).periods.single.primary!.amount, 4);
      expect(result[1].card(DashboardMetric.occupancyMean).periods.single.primary!.amount, 100);
    });

    test('preserves measured zero occupancy and leaves no-sample dwell unavailable', () {
      final result = DashboardCache().build(
        insightState: _dashboard(
          pastHour: _observation(
            10,
            10,
            coveredSeconds: 300,
            areas: [_activity(5, occupancySum: 0, occupancySampleCount: 4)],
          ),
        ),
        customAreas: const [InterestArea(id: 5, name: 'Entry')],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 10, 10),
      );

      expect(result.first.card(DashboardMetric.occupancyMean).primary!.amount, 0);
      expect(result.first.card(DashboardMetric.occupancyPeak).primary!.amount, 0);
      expect(result.first.card(DashboardMetric.dwellTimeMean).primary, isNull);
      expect(result.first.card(DashboardMetric.dwellTimeMax).primary, isNull);
    });
  });

  test('sums twelve five-minute event observations without rate normalization', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          for (var minute = 0; minute < 60; minute += 5) _observation(9, minute, areas: [_activity(9, passBy: 5)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 10),
    );
    final card = result.first.card(DashboardMetric.passBy);

    expect(card.chartPoints, hasLength(24));
    expect(_pointAt(card, 540).todayValue, 60);
    expect(_pointAt(card, 540).todayCoveredSeconds, 3600);
    expect(_pointAt(card, 540).todayEstimated, isFalse);
    expect(_pointAt(card, 600).todayValue, isNull);
  });

  test('retains actual counts for partially covered completed hours', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(9, 0, coveredSeconds: 300, areas: [_activity(9, passBy: 7)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 10),
    );
    final card = result.first.card(DashboardMetric.passBy);

    expect(_pointAt(card, 540).todayValue, 7);
    expect(_pointAt(card, 540).todayCoveredSeconds, 300);
    expect(_pointAt(card, 540).todayEstimated, isTrue);
  });

  test('distinguishes observed zero from unavailable hours', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(9, 0, areas: [_activity(9, passBy: 0)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 23, 59),
    );
    final card = result.first.card(DashboardMetric.passBy);

    expect(_pointAt(card, 480).todayValue, isNull);
    expect(_pointAt(card, 540).todayValue, 0);
    expect(_pointAt(card, 600).todayValue, isNull);
  });

  test('aligns sparse comparison observations by clock hour', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(9, 0, areas: [_activity(9, passBy: 5)]),
        ],
        comparison: [
          _observation(9, 0, areas: [_activity(9, passBy: 10)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 16),
    );
    final card = result.first.card(DashboardMetric.passBy);

    expect(card.chartPoints, hasLength(24));
    expect(_pointAt(card, 540).todayValue, 5);
    expect(_pointAt(card, 540).comparisonValue, 10);
    expect(_pointAt(card, 900).todayValue, isNull);
    expect(_pointAt(card, 900).comparisonValue, isNull);
  });

  test('aggregates monthly and yearly typical profiles by clock hour', () {
    for (final period in [TrafficComparisonPeriod.lastMonthAverage, TrafficComparisonPeriod.lastYearAverage]) {
      final result = DashboardCache().build(
        insightState: _dashboard(
          comparisonPeriod: period,
          comparison: [
            for (var minute = 0; minute < 60; minute += 5) _observation(9, minute, areas: [_activity(9, passBy: 2.5)]),
          ],
        ),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 10),
      );

      final point = _pointAt(result.first.card(DashboardMetric.passBy), 540);
      expect(point.comparisonValue, 30);
      expect(point.comparisonCoveredSeconds, 3600);
    }
  });

  test('shows only completed today hours and retains full comparison day', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(9, 0, areas: [_activity(9, passBy: 5)]),
          _observation(12, 0, areas: [_activity(9, passBy: 8)]),
        ],
        comparison: [
          _observation(9, 0, areas: [_activity(9, passBy: 10)]),
          _observation(23, 55, areas: [_activity(9, passBy: 12)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12, 7),
    );
    final card = result.first.card(DashboardMetric.passBy);

    expect(_pointAt(card, 540).todayValue, 5);
    expect(_pointAt(card, 540).comparisonValue, 10);
    expect(_pointAt(card, 720).todayValue, isNull);
    expect(_pointAt(card, 720).comparisonValue, isNull);
    expect(_pointAt(card, 1380).todayValue, isNull);
    expect(_pointAt(card, 1380).comparisonValue, 12);
    expect(card.chartPoints, hasLength(24));
  });

  test('current hour becomes eligible exactly at the next hour boundary', () {
    final today = [
      _observation(12, 0, areas: [_activity(9, passBy: 11)]),
    ];
    final before = DashboardCache().build(
      insightState: _dashboard(today: today),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12, 59),
    );
    final atBoundary = DashboardCache().build(
      insightState: _dashboard(today: today),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 13),
    );

    expect(_pointAt(before.first.card(DashboardMetric.passBy), 720).todayValue, isNull);
    expect(_pointAt(atBoundary.first.card(DashboardMetric.passBy), 720).todayValue, 11);
  });

  test('handles midnight and the final clock hour without wrapping', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(23, 0, areas: [_activity(9, passBy: 4)]),
        ],
        comparison: [
          _observation(23, 55, areas: [_activity(9, passBy: 6)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 0),
    );

    final card = result.first.card(DashboardMetric.passBy);
    expect(_pointAt(card, 0).todayValue, isNull);
    expect(_pointAt(card, 1380).todayValue, isNull);
    expect(_pointAt(card, 1380).comparisonValue, 6);
  });

  test('preserves occupancy and dwell aggregation semantics by hour', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(
            9,
            0,
            areas: [
              _activity(
                9,
                occupancySum: 6,
                occupancySampleCount: 2,
                occupancyMax: 4,
                dwellSumSeconds: 180,
                dwellSampleCount: 1,
                dwellMaxSeconds: 180,
              ),
            ],
          ),
          _observation(
            9,
            5,
            areas: [
              _activity(
                9,
                occupancySum: 10,
                occupancySampleCount: 2,
                occupancyMax: 7,
                dwellSumSeconds: 80,
                dwellSampleCount: 1,
                dwellMaxSeconds: 500,
              ),
            ],
          ),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 10),
    );

    expect(_pointAt(result.first.card(DashboardMetric.occupancyMean), 540).todayValue, 4);
    expect(_pointAt(result.first.card(DashboardMetric.occupancyPeak), 540).todayValue, 7);
    expect(_pointAt(result.first.card(DashboardMetric.dwellTimeMean), 540).todayValue, closeTo(130 / 60, 1e-9));
    expect(_pointAt(result.first.card(DashboardMetric.dwellTimeMax), 540).todayValue, 500 / 60);
  });

  test('hourly chart coverage excludes other areas and preserves the estimation boundary', () {
    for (final coveredSeconds in [0, 3419, 3420, 3600]) {
      final result = DashboardCache().build(
        insightState: _dashboard(
          today: [
            _observation(9, 0, coveredSeconds: coveredSeconds, areas: [_activity(9, passBy: 7)]),
            _observation(9, 5, areas: [_activity(10, passBy: 50)]),
          ],
        ),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 10),
      );
      final point = _pointAt(result.first.card(DashboardMetric.passBy), 540);

      expect(point.todayValue, coveredSeconds == 0 ? isNull : 7);
      expect(point.todayCoveredSeconds, coveredSeconds);
      expect(point.todayEstimated, coveredSeconds > 0 && coveredSeconds < 3420);
    }
  });

  test('hourly chart means weight valid samples and peaks ignore unsampled maxima', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(
            9,
            0,
            areas: [
              _activity(
                9,
                occupancySum: 6,
                occupancySampleCount: 2,
                occupancyMax: 4,
                dwellSumSeconds: 600,
                dwellSampleCount: 2,
                dwellMaxSeconds: 500,
              ),
            ],
          ),
          _observation(
            9,
            5,
            areas: [
              _activity(
                9,
                occupancySum: 30,
                occupancySampleCount: 3,
                occupancyMax: 12,
                dwellSumSeconds: 180,
                dwellSampleCount: 1,
                dwellMaxSeconds: 180,
              ),
            ],
          ),
          _observation(
            9,
            10,
            areas: [_activity(9, occupancySum: 999, occupancyMax: 999, dwellSumSeconds: 999, dwellMaxSeconds: 999)],
          ),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 10),
    );

    for (final (metric, expected) in [
      (DashboardMetric.occupancyMean, 36 / 5),
      (DashboardMetric.occupancyPeak, 12.0),
      (DashboardMetric.dwellTimeMean, 260 / 60),
      (DashboardMetric.dwellTimeMax, 500 / 60),
    ]) {
      final point = _pointAt(result.first.card(metric), 540);
      expect(point.todayValue, closeTo(expected, 1e-9));
      expect(point.todayCoveredSeconds, 900);
      expect(point.todayEstimated, isFalse);
    }
  });

  test('preserves fractional event counts after much larger earlier prefixes', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(0, 0, areas: [_activity(9, passBy: 1e16)]),
          _observation(10, 0, areas: [_activity(9, passBy: 0.1)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 11),
    );

    expect(_pointAt(result.first.card(DashboardMetric.passBy), 600).todayValue, closeTo(0.1, 1e-9));
  });

  test('does not count coverage from observations missing the area', () {
    final result = DashboardCache().build(
      insightState: _dashboard(
        today: [
          _observation(10, 0, areas: [_activity(9, passBy: 1)]),
          _observation(10, 5, areas: [_activity(10, passBy: 50)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 11),
    );

    expect(_pointAt(result.first.card(DashboardMetric.passBy), 600).todayValue, 1);
  });

  test('matches actual hourly aggregation for randomized sparse chart data', () {
    List<Observation> observations(int seed) {
      final random = Random(seed);
      return [
        for (var slot = 0; slot < ObservationSeries.maxLength; slot++)
          if (random.nextInt(4) != 0)
            _observation(
              slot ~/ 12,
              slot % 12 * 5,
              coveredSeconds: random.nextInt(301),
              areas: random.nextInt(5) == 0
                  ? const []
                  : [
                      _activity(
                        10,
                        passBy: random.nextInt(20).toDouble(),
                        occupancySum: random.nextInt(50),
                        occupancySampleCount: random.nextInt(5),
                      ),
                      _activity(
                        9,
                        passBy: random.nextInt(200).toDouble() / 10,
                        stagnant: random.nextInt(200).toDouble() / 10,
                        entry: random.nextInt(200).toDouble() / 10,
                        exit: random.nextInt(200).toDouble() / 10,
                        appear: random.nextInt(200).toDouble() / 10,
                        disappear: random.nextInt(200).toDouble() / 10,
                        occupancySum: random.nextInt(50),
                        occupancySampleCount: random.nextInt(5),
                        occupancyMax: random.nextInt(20),
                        dwellSumSeconds: random.nextInt(5000),
                        dwellSampleCount: random.nextInt(5),
                        dwellMaxSeconds: random.nextInt(1000),
                      ),
                    ],
            ),
      ];
    }

    final today = observations(17);
    final comparison = observations(29);
    final result = DashboardCache().build(
      insightState: _dashboard(today: today, comparison: comparison),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12, 7),
    );
    const endpoints = [0, 60, 540, 600, 720, 780, 1380];

    for (final card in result.first.cards) {
      for (final endpoint in endpoints) {
        final point = _pointAt(card, endpoint);
        final expectedToday = endpoint < 720 ? _referenceChartValue(today, endpoint, 9, card.metric) : null;
        final expectedComparison = _referenceChartValue(comparison, endpoint, 9, card.metric);
        if (expectedToday == null) {
          expect(point.todayValue, isNull, reason: '${card.metric} at $endpoint today');
        } else {
          expect(point.todayValue, closeTo(expectedToday, 1e-9), reason: '${card.metric} at $endpoint today');
        }
        if (expectedComparison == null) {
          expect(point.comparisonValue, isNull, reason: '${card.metric} at $endpoint comparison');
        } else {
          expect(
            point.comparisonValue,
            closeTo(expectedComparison, 1e-9),
            reason: '${card.metric} at $endpoint comparison',
          );
        }
      }
    }
  });

  group('snapshot caching', () {
    test('live KPI updates reuse chart and period lists without rebuilding snapshots', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      const area = InterestArea(id: 9, name: 'Shop');
      const period = BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 540, endMinute: 630);
      final todaySeries = ObservationSeries.fromObservations([
        _observation(9, 0, areas: [_activity(9, passBy: 2)]),
        _observation(10, 0, areas: [_activity(9, passBy: 3)]),
      ]);
      final comparisonSeries = ObservationSeries.fromObservations([
        _observation(9, 0, areas: [_activity(9, passBy: 4)]),
      ]);
      final comparisonPastHour = _observation(10, 15, coveredSeconds: 3600, areas: [_activity(9, passBy: 5)]);
      InsightState dashboard(double livePassBy) => _dashboard(
        todaySeries: todaySeries,
        comparisonSeries: comparisonSeries,
        pastHour: _observation(10, 15, coveredSeconds: 3600, areas: [_activity(9, passBy: livePassBy)]),
        comparisonPastHour: comparisonPastHour,
      );

      final first = _cacheBuild(
        cache,
        dashboard(1),
        customAreas: const [area],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 10, 15),
      ).first.card(DashboardMetric.passBy);
      final second = _cacheBuild(
        cache,
        dashboard(2),
        customAreas: const [area],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 10, 15, 1),
      ).first.card(DashboardMetric.passBy);

      expect(first.primary!.amount, 1);
      expect(second.primary!.amount, 2);
      expect(second.comparisonValue, 5);
      expect(identical(first.chartPoints, second.chartPoints), isTrue);
      expect(identical(first.periods, second.periods), isTrue);
      expect(snapshotBuilds, 1);

      for (var index = 0; index < 5; index++) {
        final updated = _cacheBuild(
          cache,
          dashboard(index + 3),
          customAreas: const [area],
          businessPeriods: const [period],
          now: DateTime(2026, 10, 29, 10, 15, index + 2),
        ).first.card(DashboardMetric.passBy);
        expect(updated.primary!.amount, (index + 3).toDouble());
        expect(identical(first.chartPoints, updated.chartPoints), isTrue);
      }
      expect(snapshotBuilds, 1);
    });

    test('refreshes periods but not hourly chart values at a five-minute boundary', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final todaySeries = ObservationSeries.fromObservations([
        _observation(12, 0, areas: [_activity(9, passBy: 5)]),
      ]);
      final dashboard = _dashboard(todaySeries: todaySeries);
      const period = BusinessPeriod(id: 'noon', name: 'Noon', startMinute: 720, endMinute: 750);

      final before = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 12, 4),
      ).first.card(DashboardMetric.passBy);
      final after = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 12, 5),
      ).first.card(DashboardMetric.passBy);
      final atHourBoundary = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 13),
      ).first.card(DashboardMetric.passBy);

      expect(_pointAt(before, 720).todayValue, isNull);
      expect(_pointAt(after, 720).todayValue, isNull);
      expect(_pointAt(atHourBoundary, 720).todayValue, 5);
      expect(before.chartPoints, hasLength(24));
      expect(after.chartPoints, hasLength(24));
      expect(before.periods.single.primary, isNull);
      expect(after.periods.single.primary!.amount, 60);
      expect(identical(before.chartPoints, after.chartPoints), isTrue);
      expect(identical(after.chartPoints, atHourBoundary.chartPoints), isFalse);
      expect(snapshotBuilds, 3);
    });

    test('reuses chart points when a current-hour observation is appended', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final completedObservation = _observation(9, 0, areas: [_activity(9, passBy: 2)]);
      final comparisonSeries = ObservationSeries.empty;
      final firstSeries = ObservationSeries.fromObservations([completedObservation]);
      final updatedSeries = ObservationSeries.fromObservations([
        completedObservation,
        _observation(10, 5, areas: [_activity(9, passBy: 3)]),
      ]);

      final first = _cacheBuild(
        cache,
        _dashboard(todaySeries: firstSeries, comparisonSeries: comparisonSeries),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 29, 10, 5),
      ).first.card(DashboardMetric.passBy);
      final updated = _cacheBuild(
        cache,
        _dashboard(todaySeries: updatedSeries, comparisonSeries: comparisonSeries),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 29, 10, 10),
      ).first.card(DashboardMetric.passBy);

      expect(_pointAt(first, 540).todayValue, 2);
      expect(_pointAt(updated, 540).todayValue, 2);
      expect(_pointAt(updated, 600).todayValue, isNull);
      expect(identical(first.chartPoints, updated.chartPoints), isTrue);
      expect(snapshotBuilds, 2);
    });

    test('invalidates when a late completed observation replaces the series', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final firstSeries = ObservationSeries.fromObservations([
        _observation(10, 0, areas: [_activity(9, passBy: 1)]),
      ]);
      final updatedSeries = ObservationSeries.fromObservations([
        _observation(10, 0, areas: [_activity(9, passBy: 1)]),
        _observation(10, 5, areas: [_activity(9, passBy: 2)]),
      ]);
      const period = BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 600, endMinute: 630);

      final first = _cacheBuild(
        cache,
        _dashboard(todaySeries: firstSeries),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 11),
      ).first.card(DashboardMetric.passBy);
      final updated = _cacheBuild(
        cache,
        _dashboard(todaySeries: updatedSeries),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 11),
      ).first.card(DashboardMetric.passBy);

      expect(_pointAt(first, 600).todayValue, 1);
      expect(_pointAt(updated, 600).todayValue, 3);
      expect(first.periods.single.primary!.amount, 12);
      expect(updated.periods.single.primary!.amount, 18);
      expect(identical(first.chartPoints, updated.chartPoints), isFalse);
      expect(snapshotBuilds, 2);
    });

    test('invalidates chart points when a delayed observation arrives in a completed hour', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final nineAmObservation = _observation(9, 0, areas: [_activity(9, passBy: 2)]);
      final comparisonSeries = ObservationSeries.empty;
      final firstSeries = ObservationSeries.fromObservations([nineAmObservation]);
      final updatedSeries = ObservationSeries.fromObservations([
        nineAmObservation,
        _observation(9, 5, areas: [_activity(9, passBy: 3)]),
      ]);
      final now = DateTime(2026, 10, 29, 11, 15);

      final first = _cacheBuild(
        cache,
        _dashboard(todaySeries: firstSeries, comparisonSeries: comparisonSeries),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: now,
      ).first.card(DashboardMetric.passBy);
      final updated = _cacheBuild(
        cache,
        _dashboard(todaySeries: updatedSeries, comparisonSeries: comparisonSeries),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: now,
      ).first.card(DashboardMetric.passBy);

      expect(_pointAt(first, 540).todayValue, 2);
      expect(_pointAt(updated, 540).todayValue, 5);
      expect(identical(first.chartPoints, updated.chartPoints), isFalse);
      expect(snapshotBuilds, 2);
    });

    test('invalidates comparison data without changing today calculations', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final todaySeries = ObservationSeries.fromObservations([
        _observation(9, 0, areas: [_activity(9, passBy: 3)]),
      ]);
      final firstComparison = ObservationSeries.fromObservations([
        _observation(9, 0, areas: [_activity(9, passBy: 1)]),
      ]);
      final nextComparison = ObservationSeries.fromObservations([
        _observation(9, 0, areas: [_activity(9, passBy: 4)]),
      ]);

      final first = _cacheBuild(
        cache,
        _dashboard(
          todaySeries: todaySeries,
          comparisonSeries: firstComparison,
          comparisonPastHour: _observation(10, 0, coveredSeconds: 3600, areas: [_activity(9, passBy: 1)]),
        ),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 29, 10),
      ).first.card(DashboardMetric.passBy);
      final updated = _cacheBuild(
        cache,
        _dashboard(
          todaySeries: todaySeries,
          comparisonSeries: nextComparison,
          comparisonPastHour: _observation(10, 0, coveredSeconds: 3600, areas: [_activity(9, passBy: 2)]),
          comparisonPeriod: TrafficComparisonPeriod.sameDayLastWeek,
        ),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 29, 10),
      ).first.card(DashboardMetric.passBy);
      final comparisonKpiUpdated = _cacheBuild(
        cache,
        _dashboard(
          todaySeries: todaySeries,
          comparisonSeries: nextComparison,
          comparisonPastHour: _observation(10, 0, coveredSeconds: 3600, areas: [_activity(9, passBy: 3)]),
          comparisonPeriod: TrafficComparisonPeriod.sameDayLastWeek,
        ),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 29, 10),
      ).first.card(DashboardMetric.passBy);

      expect(_pointAt(first, 540).todayValue, 3);
      expect(_pointAt(updated, 540).todayValue, 3);
      expect(_pointAt(first, 540).comparisonValue, 1);
      expect(_pointAt(updated, 540).comparisonValue, 4);
      expect(first.comparisonValue, 1);
      expect(updated.comparisonValue, 2);
      expect(comparisonKpiUpdated.comparisonValue, 3);
      expect(_pointAt(comparisonKpiUpdated, 540).todayValue, 3);
      expect(identical(updated.chartPoints, comparisonKpiUpdated.chartPoints), isTrue);
      expect(snapshotBuilds, 2);
    });

    test('invalidates area order, enabled state, and names', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final dashboard = _dashboard();
      final first = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [
          InterestArea(id: 9, name: 'Shop'),
          InterestArea(id: 10, name: 'Entrance'),
        ],
        now: DateTime(2026, 10, 29, 10),
      );
      final updated = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [
          InterestArea(id: 10, name: 'Lobby'),
          InterestArea(id: 9, name: 'Disabled', enabled: false),
        ],
        now: DateTime(2026, 10, 29, 10),
      );

      expect(first.map((area) => area.areaId), [9, 10, kGlobalAreaId]);
      expect(updated.map((area) => area.areaId), [10, kGlobalAreaId]);
      expect(updated.first.name, 'Lobby');
      expect(updated.last.isGlobal, isTrue);
      expect(snapshotBuilds, 2);
    });

    test('invalidates period definitions and business-date rollover', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final todaySeries = ObservationSeries.fromObservations([
        _observation(10, 0, areas: [_activity(9, passBy: 1)]),
        _observation(10, 5, areas: [_activity(9, passBy: 2)]),
      ]);
      final dashboard = _dashboard(todaySeries: todaySeries);
      final original = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 600, endMinute: 610)],
        now: DateTime(2026, 10, 29, 10, 20),
      ).first.card(DashboardMetric.passBy);
      final changedPeriod = _cacheBuild(
        cache,
        dashboard,
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 605, endMinute: 610)],
        now: DateTime(2026, 10, 29, 10, 20),
      ).first.card(DashboardMetric.passBy);
      final nextDate = _cacheBuild(
        cache,
        _dashboard(todaySeries: todaySeries, businessDate: '2026-10-30'),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 605, endMinute: 610)],
        now: DateTime(2026, 10, 30, 10, 20),
      ).first.card(DashboardMetric.passBy);

      expect(original.periods.single.primary!.amount, 18);
      expect(changedPeriod.periods.single.primary!.amount, 24);
      expect(identical(original.periods, changedPeriod.periods), isFalse);
      expect(identical(changedPeriod.chartPoints, nextDate.chartPoints), isFalse);
      expect(snapshotBuilds, 3);
    });

    test('refreshes period status transitions within a five-minute slot', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final dashboard = _dashboard();
      const period = BusinessPeriod(id: 'opening', name: 'Opening', startMinute: 722, endMinute: 750);

      final beforeStart = _cacheBuild(
        cache,
        dashboard,
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 12, 1),
      ).single.card(DashboardMetric.passBy);
      final afterStart = _cacheBuild(
        cache,
        dashboard,
        businessPeriods: const [period],
        now: DateTime(2026, 10, 29, 12, 2),
      ).single.card(DashboardMetric.passBy);

      expect(beforeStart.periods.single.status, BusinessPeriodStatus.notStarted);
      expect(afterStart.periods.single.status, BusinessPeriodStatus.inProgress);
      expect(identical(beforeStart.periods, afterStart.periods), isFalse);
      expect(snapshotBuilds, 2);
    });

    test('invalidates cached data when the business date changes', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      final todaySeries = ObservationSeries.fromObservations([
        _observation(0, 0, areas: [_activity(9, passBy: 2)]),
      ]);
      final first = _cacheBuild(
        cache,
        _dashboard(todaySeries: todaySeries, comparisonSeries: ObservationSeries.empty),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 29, 1),
      ).first.card(DashboardMetric.passBy);
      final nextDate = _cacheBuild(
        cache,
        _dashboard(todaySeries: todaySeries, comparisonSeries: ObservationSeries.empty, businessDate: '2026-10-30'),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        now: DateTime(2026, 10, 30, 1),
      ).first.card(DashboardMetric.passBy);

      expect(_pointAt(first, 0).todayValue, 2);
      expect(_pointAt(nextDate, 0).todayValue, 2);
      expect(identical(first.chartPoints, nextDate.chartPoints), isFalse);
      expect(snapshotBuilds, 2);
    });

    test('keeps empty and missing observations unavailable', () {
      final cache = DashboardCache();
      final result = _cacheBuild(
        cache,
        _dashboard(),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 600, endMinute: 630)],
        now: DateTime(2026, 10, 29, 10, 15),
      );
      final card = result.first.card(DashboardMetric.passBy);

      expect(card.primary, isNull);
      expect(card.comparisonValue, isNull);
      expect(card.periods.single.primary, isNull);
      expect(card.chartPoints, hasLength(24));
      expect(card.chartPoints.first.minuteOfDay, 0);
      expect(card.chartPoints.last.minuteOfDay, 1380);
      expect([
        for (var index = 1; index < card.chartPoints.length; index++)
          card.chartPoints[index].minuteOfDay - card.chartPoints[index - 1].minuteOfDay,
      ], everyElement(60));
      expect(card.chartPoints.every((point) => point.todayValue == null && point.comparisonValue == null), isTrue);
    });

    test('zero coverage keeps event metrics unavailable without discarding occupancy samples', () {
      final observation = _observation(
        9,
        0,
        coveredSeconds: 0,
        areas: [_activity(9, passBy: 12, occupancySum: 6, occupancySampleCount: 2)],
      );
      final result = _cacheBuild(
        DashboardCache(),
        _dashboard(today: [observation], pastHour: observation),
        customAreas: const [InterestArea(id: 9, name: 'Shop')],
        businessPeriods: const [BusinessPeriod(id: 'morning', name: 'Morning', startMinute: 540, endMinute: 600)],
        now: DateTime(2026, 10, 29, 10),
      );
      final eventCard = result.first.card(DashboardMetric.passBy);
      final occupancyCard = result.first.card(DashboardMetric.occupancyMean);

      expect(eventCard.primary, isNull);
      expect(eventCard.periods.single.primary, isNull);
      expect(_pointAt(eventCard, 540).todayValue, isNull);
      expect(occupancyCard.primary!.amount, 3);
      expect(occupancyCard.periods.single.primary!.amount, 3);
      expect(_pointAt(occupancyCard, 540).todayValue, 3);
    });

    test('reuses snapshots when both observation series are absent', () {
      var snapshotBuilds = 0;
      final cache = DashboardCache(onSnapshotBuilt: () => snapshotBuilds++);
      const dashboard = InsightState(businessDate: '2026-10-29');

      final first = _cacheBuild(
        cache,
        dashboard,
        now: DateTime(2026, 10, 29, 10, 15),
      ).single.card(DashboardMetric.passBy);
      final second = _cacheBuild(
        cache,
        dashboard,
        now: DateTime(2026, 10, 29, 10, 15, 1),
      ).single.card(DashboardMetric.passBy);

      expect(identical(ObservationSeries.empty, ObservationSeries.empty), isTrue);
      expect(identical(first.chartPoints, second.chartPoints), isTrue);
      expect(snapshotBuilds, 1);
    });
  });
}
