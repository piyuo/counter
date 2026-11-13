import 'package:core_domain/services/dashboard_metric_calculator.dart';
import 'package:core_domain/services/dashboard_service.dart';

import '../model/business_period.dart';
import '../model/insight_state.dart';
import '../model/observation_payload.dart';
import '../model/observation_series.dart';
import '../state/models/interest_area.dart';

InsightDashboardSnapshot buildInsightDashboardSnapshot({
  required InsightState dashboard,
  required List<InterestArea> customAreas,
  required List<BusinessPeriod> businessPeriods,
  required DateTime now,
  Map<(int, DashboardMetric), List<DashboardChartPoint>>? cachedChartPoints,
}) {
  final today = dashboard.todaySeries ?? ObservationSeries.empty;
  final comparison = dashboard.comparisonSeries ?? ObservationSeries.empty;
  final areas = <InsightAreaSnapshot>[
    for (final area in customAreas.where((area) => area.enabled && area.id != kGlobalAreaId))
      _buildAreaSnapshot(
        areaId: area.id,
        name: area.name,
        isGlobal: false,
        today: today,
        comparison: comparison,
        businessPeriods: businessPeriods,
        now: now,
        cachedChartPoints: cachedChartPoints,
      ),
  ];
  areas.add(
    _buildAreaSnapshot(
      areaId: kGlobalAreaId,
      name: null,
      isGlobal: true,
      today: today,
      comparison: comparison,
      businessPeriods: businessPeriods,
      now: now,
      cachedChartPoints: cachedChartPoints,
    ),
  );
  return InsightDashboardSnapshot(List.unmodifiable(areas));
}

InsightAreaSnapshot _buildAreaSnapshot({
  required int areaId,
  required String? name,
  required bool isGlobal,
  required ObservationSeries today,
  required ObservationSeries comparison,
  required List<BusinessPeriod> businessPeriods,
  required DateTime now,
  required Map<(int, DashboardMetric), List<DashboardChartPoint>>? cachedChartPoints,
}) {
  final metrics = [
    DashboardMetric.passBy,
    DashboardMetric.stagnant,
    if (!isGlobal) DashboardMetric.entry,
    if (!isGlobal) DashboardMetric.exit,
    DashboardMetric.appear,
    DashboardMetric.disappear,
    DashboardMetric.occupancyMean,
    DashboardMetric.occupancyPeak,
    DashboardMetric.dwellTimeMean,
    DashboardMetric.dwellTimeMax,
  ];
  return InsightAreaSnapshot(
    areaId: areaId,
    name: name,
    isGlobal: isGlobal,
    cards: List.unmodifiable([
      for (final metric in metrics)
        _buildCardSnapshot(
          metric: metric,
          areaId: areaId,
          today: today,
          comparison: comparison,
          businessPeriods: businessPeriods,
          now: now,
          cachedChartPoints: cachedChartPoints?[(areaId, metric)],
        ),
    ]),
  );
}

InsightCardSnapshot _buildCardSnapshot({
  required DashboardMetric metric,
  required int areaId,
  required ObservationSeries today,
  required ObservationSeries comparison,
  required List<BusinessPeriod> businessPeriods,
  required DateTime now,
  required List<DashboardChartPoint>? cachedChartPoints,
}) {
  final periods = [
    for (final period in businessPeriods)
      _buildPeriod(period: period, areaId: areaId, metric: metric, today: today, comparison: comparison, now: now),
  ];
  return InsightCardSnapshot(
    metric: metric,
    periods: List.unmodifiable(periods),
    chartPoints: cachedChartPoints ?? _buildChartPoints(metric, areaId, today, comparison, now.hour),
  );
}

DashboardPeriodData _buildPeriod({
  required BusinessPeriod period,
  required int areaId,
  required DashboardMetric metric,
  required ObservationSeries today,
  required ObservationSeries comparison,
  required DateTime now,
}) {
  final periodState = insightPeriodState(period, now);
  final status = periodState.status;
  final endMinute = periodState.endMinute;
  if (status == BusinessPeriodStatus.notStarted || endMinute <= period.startMinute) {
    return DashboardPeriodData(period: period, status: status, primary: null, comparisonValue: null);
  }

  final expectedSeconds = (endMinute - period.startMinute) * 60;
  final primary = calculateInsightMetricFromObservationsInRange(
    series: today,
    startMinute: period.startMinute,
    endMinute: endMinute,
    areaId: areaId,
    metric: metric,
    expectedSeconds: expectedSeconds,
  );
  final comparisonValue = calculateInsightMetricFromObservationsInRange(
    series: comparison,
    startMinute: period.startMinute,
    endMinute: endMinute,
    areaId: areaId,
    metric: metric,
    expectedSeconds: expectedSeconds,
  )?.amount;
  return DashboardPeriodData(period: period, status: status, primary: primary, comparisonValue: comparisonValue);
}

List<DashboardChartPoint> _buildChartPoints(
  DashboardMetric metric,
  int areaId,
  ObservationSeries today,
  ObservationSeries comparison,
  int completedHourCount,
) {
  final points = <DashboardChartPoint>[];
  for (var hour = 0; hour < 24; hour++) {
    final todayValue = hour < completedHourCount
        ? calculateInsightHourlyChartValue(series: today, areaId: areaId, metric: metric, hour: hour)
        : null;
    final comparisonValue = calculateInsightHourlyChartValue(
      series: comparison,
      areaId: areaId,
      metric: metric,
      hour: hour,
    );
    points.add(
      DashboardChartPoint(
        minuteOfDay: hour * 60,
        todayValue: todayValue?.amount,
        comparisonValue: comparisonValue?.amount,
        todayCoveredSeconds: todayValue?.coveredSeconds ?? 0,
        comparisonCoveredSeconds: comparisonValue?.coveredSeconds ?? 0,
        todayEstimated: todayValue?.estimated ?? false,
        comparisonEstimated: comparisonValue?.estimated ?? false,
      ),
    );
  }
  return List.unmodifiable(points);
}

class InsightDashboardSnapshot {
  const InsightDashboardSnapshot(this.areas);

  final List<InsightAreaSnapshot> areas;
}

class InsightAreaSnapshot {
  const InsightAreaSnapshot({required this.areaId, required this.name, required this.isGlobal, required this.cards});

  final int areaId;
  final String? name;
  final bool isGlobal;
  final List<InsightCardSnapshot> cards;
}

class InsightCardSnapshot {
  const InsightCardSnapshot({required this.metric, required this.periods, required this.chartPoints});

  final DashboardMetric metric;
  final List<DashboardPeriodData> periods;
  final List<DashboardChartPoint> chartPoints;
}

({BusinessPeriodStatus status, int endMinute}) insightPeriodState(BusinessPeriod period, DateTime now) {
  final status = period.statusAt(now);
  final currentSlotEnd = (now.hour * 60 + now.minute) ~/ 5 * 5;
  final endMinute = switch (status) {
    BusinessPeriodStatus.notStarted => period.startMinute,
    BusinessPeriodStatus.inProgress => period.endMinute < currentSlotEnd ? period.endMinute : currentSlotEnd,
    BusinessPeriodStatus.completed => period.endMinute,
  };
  return (status: status, endMinute: endMinute);
}
