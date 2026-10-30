import 'package:core_domain/aggregation/insight_data_builder.dart';
import 'package:core_domain/model/activity.dart';
import 'package:core_domain/model/business_period.dart';
import 'package:core_domain/model/insight_dashboard.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_payload.dart';
import 'package:core_domain/model/observation_series.dart';
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
  double entry = 0,
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
  entry: entry,
  occupancySum: occupancySum,
  occupancySampleCount: occupancySampleCount,
  occupancyMax: occupancyMax,
  dwellSumSeconds: dwellSumSeconds,
  dwellSampleCount: dwellSampleCount,
  dwellMaxSeconds: dwellMaxSeconds,
);

InsightDashboard _dashboard({
  List<Observation> today = const [],
  Observation? pastHour,
  List<Observation> comparison = const [],
  Observation? comparisonPastHour,
}) => InsightDashboard(
  businessDate: '2026-10-29',
  todaySeries: ObservationSeries.fromObservations(today),
  pastHourObservation: pastHour,
  comparisonSeries: ObservationSeries.fromObservations(comparison),
  comparisonPastHourObservation: comparisonPastHour,
);

void main() {
  const builder = InsightDashboardDataBuilder();

  group('area ordering and applicable metrics', () {
    test('keeps configured custom order and puts global last', () {
      final result = builder.build(
        dashboard: _dashboard(),
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
      final result = builder.build(
        dashboard: _dashboard(),
        customAreas: const [],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      expect(result.single.cards.map((card) => card.metric), isNot(contains(InsightMetric.entry)));
      expect(result.single.cards.map((card) => card.metric), isNot(contains(InsightMetric.exit)));
    });
  });

  group('event rates', () {
    test('uses the full hour count as an actual hourly rate', () {
      final dashboard = _dashboard(
        pastHour: _observation(12, 0, coveredSeconds: 3600, areas: [_activity(kGlobalAreaId, passBy: 84)]),
      );

      final result = builder.build(
        dashboard: dashboard,
        customAreas: const [],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      final passBy = result.single.card(InsightMetric.passBy).primary!;
      expect(passBy.value, 84);
      expect(passBy.estimated, isFalse);
    });

    test('estimates partial hourly coverage and keeps missing data unavailable', () {
      final dashboard = _dashboard(
        pastHour: _observation(12, 0, coveredSeconds: 1800, areas: [_activity(kGlobalAreaId, passBy: 42)]),
      );

      final result = builder.build(
        dashboard: dashboard,
        customAreas: const [],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 12),
      );

      final passBy = result.single.card(InsightMetric.passBy).primary!;
      expect(passBy.value, 84);
      expect(passBy.estimated, isTrue);
      expect(result.single.card(InsightMetric.occupancy).primary, isNull);
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
      final result = builder.build(
        dashboard: _dashboard(today: observations),
        customAreas: const [],
        businessPeriods: const [breakfast, lunch],
        now: DateTime(2026, 10, 29, 12),
      );
      final passBy = result.single.card(InsightMetric.passBy);

      expect(passBy.periods[0].primary!.value, closeTo(45.5, 0.001));
      expect(passBy.periods[0].primary!.estimated, isFalse);
      expect(passBy.periods[1].primary!.value, 12);
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
      final result = builder.build(
        dashboard: _dashboard(today: observations),
        customAreas: const [InterestArea(id: 3, name: 'Dining')],
        businessPeriods: const [],
        now: DateTime(2026, 10, 29, 10, 10),
      );
      final occupancy = result.first.card(InsightMetric.occupancy);
      final dwell = result.first.card(InsightMetric.dwellTime);

      expect(occupancy.periods.isEmpty, isTrue);
      expect(occupancy.chartPoints.map((point) => point.todayValue), [3, 3]);
      expect(dwell.chartPoints.map((point) => point.todayValue), [5, 3]);
    });

    test('preserves measured zero occupancy and leaves no-sample dwell unavailable', () {
      final result = builder.build(
        dashboard: _dashboard(
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

      expect(result.first.card(InsightMetric.occupancy).primary!.value, 0);
      expect(result.first.card(InsightMetric.dwellTime).primary, isNull);
    });
  });

  test('chart points keep raw event counts and omit future observations', () {
    final result = builder.build(
      dashboard: _dashboard(
        today: [
          _observation(11, 55, areas: [_activity(9, passBy: 3)]),
          _observation(12, 0, areas: [_activity(9, passBy: 5)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12),
    );

    expect(result.first.card(InsightMetric.passBy).chartPoints.map((point) => point.todayValue), [3]);
  });

  test('zero-coverage event observations remain chart gaps', () {
    final result = builder.build(
      dashboard: _dashboard(
        today: [
          _observation(11, 55, coveredSeconds: 0, areas: [_activity(9, passBy: 0)]),
        ],
      ),
      customAreas: const [InterestArea(id: 9, name: 'Shop')],
      businessPeriods: const [],
      now: DateTime(2026, 10, 29, 12),
    );

    expect(result.first.card(InsightMetric.passBy).chartPoints.single.todayValue, isNull);
  });
}
