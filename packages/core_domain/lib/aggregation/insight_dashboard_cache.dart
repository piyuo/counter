import 'package:core_domain/aggregation/insight_dashboard_snapshot.dart';
import 'package:core_domain/aggregation/insight_metric_calculator.dart';

import '../model/business_period.dart';
import '../model/insight_dashboard.dart';
import '../model/observation.dart';
import '../model/observation_payload.dart';
import '../model/observation_series.dart';
import '../state/models/interest_area.dart';
import 'insight_data_type.dart';

class InsightDashboardCache {
  InsightDashboardCache({this.onSnapshotBuilt});

  /// Called after snapshot inputs change; intended for diagnostics and tests.
  final void Function()? onSnapshotBuilt;

  ({InsightDashboardSnapshot snapshot, _SnapshotKey key, _ChartKey chartKey})? _cached;

  List<InsightAreaData> build({
    required InsightDashboard dashboard,
    required List<InterestArea> customAreas,
    required List<BusinessPeriod> businessPeriods,
    required DateTime now,
  }) {
    final snapshotKey = _SnapshotKey.fromInputs(
      dashboard: dashboard,
      customAreas: customAreas,
      businessPeriods: businessPeriods,
      now: now,
    );
    var cached = _cached;
    if (cached == null || !cached.key.matches(snapshotKey)) {
      final chartKey = _ChartKey.fromInputs(dashboard: dashboard, customAreas: customAreas, now: now);
      final canReuseChart = cached != null && cached.chartKey.matches(chartKey);
      final cachedChartPoints = canReuseChart ? _chartPointsFromSnapshot(cached.snapshot) : null;
      final snapshot = buildInsightDashboardSnapshot(
        dashboard: dashboard,
        customAreas: customAreas,
        businessPeriods: businessPeriods,
        now: now,
        cachedChartPoints: cachedChartPoints,
      );
      cached = (snapshot: snapshot, key: snapshotKey, chartKey: chartKey);
      _cached = cached;
      onSnapshotBuilt?.call();
    }
    print('Using cached snapshot: ${cached.snapshot}');
    return _buildInsightAreas(dashboard, cached.snapshot);
  }

  void dispose() => _cached = null;
}

List<InsightAreaData> _buildInsightAreas(InsightDashboard dashboard, InsightDashboardSnapshot snapshot) =>
    List.unmodifiable([
      for (final area in snapshot.areas)
        InsightAreaData(
          areaId: area.areaId,
          name: area.name,
          isGlobal: area.isGlobal,
          cards: List.unmodifiable([
            for (final card in area.cards)
              InsightCardData(
                metric: card.metric,
                primary: calculateInsightMetricFromAggregate(
                  dashboard.recentHourObservation,
                  area.areaId,
                  card.metric,
                  expectedSeconds: 3600,
                ),
                comparisonValue: calculateInsightMetricFromAggregate(
                  dashboard.comparisonRecentHourObservation,
                  area.areaId,
                  card.metric,
                  expectedSeconds: 3600,
                )?.value,
                periods: card.periods,
                chartPoints: card.chartPoints,
              ),
          ]),
        ),
    ]);

Map<(int, InsightMetric), List<InsightChartPoint>> _chartPointsFromSnapshot(InsightDashboardSnapshot snapshot) => {
  for (final area in snapshot.areas)
    for (final card in area.cards) (area.areaId, card.metric): card.chartPoints,
};

class _ChartKey {
  _ChartKey({
    required this.businessDate,
    required this.comparisonPeriod,
    required this.completedTodayObservations,
    required this.comparisonSeries,
    required this.completedHourCount,
    required this.areaConfiguration,
  });

  factory _ChartKey.fromInputs({
    required InsightDashboard dashboard,
    required List<InterestArea> customAreas,
    required DateTime now,
  }) => _ChartKey(
    businessDate: dashboard.businessDate,
    comparisonPeriod: dashboard.comparisonPeriod,
    // Only completed hours affect charts; the in-progress hour is intentionally ignored.
    completedTodayObservations: [
      for (final observation in dashboard.todaySeries ?? ObservationSeries.empty)
        if (observation.hour >= 0 && observation.hour < now.hour) observation,
    ],
    comparisonSeries: dashboard.comparisonSeries ?? ObservationSeries.empty,
    completedHourCount: now.hour,
    areaConfiguration: [
      for (final area in customAreas)
        if (area.enabled && area.id != kGlobalAreaId) (area.id, area.name),
    ],
  );

  final String businessDate;
  final TrafficComparisonPeriod comparisonPeriod;
  final List<Observation> completedTodayObservations;
  final ObservationSeries comparisonSeries;
  final int completedHourCount;
  final List<(int, String)> areaConfiguration;

  bool matches(_ChartKey other) {
    if (businessDate != other.businessDate ||
        comparisonPeriod != other.comparisonPeriod ||
        !identical(comparisonSeries, other.comparisonSeries) ||
        completedHourCount != other.completedHourCount ||
        !_sameValues(completedTodayObservations, other.completedTodayObservations) ||
        !_sameValues(areaConfiguration, other.areaConfiguration)) {
      return false;
    }
    return true;
  }
}

class _SnapshotKey {
  _SnapshotKey({
    required this.businessDate,
    required this.comparisonPeriod,
    required this.todaySeries,
    required this.comparisonSeries,
    required this.currentSlotEnd,
    required this.areaConfiguration,
    required this.periodConfiguration,
    required this.periodTimeState,
  });

  factory _SnapshotKey.fromInputs({
    required InsightDashboard dashboard,
    required List<InterestArea> customAreas,
    required List<BusinessPeriod> businessPeriods,
    required DateTime now,
  }) {
    final currentSlotEnd = (now.hour * 60 + now.minute) ~/ 5 * 5;
    final areaConfiguration = <(int, String)>[
      for (final area in customAreas)
        if (area.enabled && area.id != kGlobalAreaId) (area.id, area.name),
    ];
    final periodConfiguration = <(String, String, int, int)>[
      for (final period in businessPeriods) (period.id, period.name, period.startMinute, period.endMinute),
    ];
    final periodTimeState = <(BusinessPeriodStatus, int)>[];
    for (final period in businessPeriods) {
      final periodState = insightPeriodState(period, now);
      periodTimeState.add((periodState.status, periodState.endMinute));
    }
    return _SnapshotKey(
      businessDate: dashboard.businessDate,
      comparisonPeriod: dashboard.comparisonPeriod,
      todaySeries: dashboard.todaySeries ?? ObservationSeries.empty,
      comparisonSeries: dashboard.comparisonSeries ?? ObservationSeries.empty,
      currentSlotEnd: currentSlotEnd,
      areaConfiguration: areaConfiguration,
      periodConfiguration: periodConfiguration,
      periodTimeState: periodTimeState,
    );
  }

  final String businessDate;
  final TrafficComparisonPeriod comparisonPeriod;
  final ObservationSeries todaySeries;
  final ObservationSeries comparisonSeries;
  final int currentSlotEnd;
  final List<(int, String)> areaConfiguration;
  final List<(String, String, int, int)> periodConfiguration;
  final List<(BusinessPeriodStatus, int)> periodTimeState;

  bool matches(_SnapshotKey other) {
    if (businessDate != other.businessDate ||
        comparisonPeriod != other.comparisonPeriod ||
        !identical(todaySeries, other.todaySeries) ||
        !identical(comparisonSeries, other.comparisonSeries) ||
        currentSlotEnd != other.currentSlotEnd) {
      return false;
    }
    return _sameValues(areaConfiguration, other.areaConfiguration) &&
        _sameValues(periodConfiguration, other.periodConfiguration) &&
        _sameValues(periodTimeState, other.periodTimeState);
  }
}

bool _sameValues<T>(List<T> left, List<T> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
