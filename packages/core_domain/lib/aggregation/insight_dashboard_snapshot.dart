import 'package:core_domain/aggregation/insight_metric_calculator.dart';

import '../model/business_period.dart';
import '../model/insight_dashboard.dart';
import '../model/observation_payload.dart';
import '../model/observation_series.dart';
import '../state/models/interest_area.dart';
import 'insight_data_type.dart';

InsightDashboardSnapshot buildInsightDashboardSnapshot({
  required InsightDashboard dashboard,
  required List<InterestArea> customAreas,
  required List<BusinessPeriod> businessPeriods,
  required DateTime now,
  Map<(int, InsightMetric), List<InsightChartPoint>>? cachedChartPoints,
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
  required Map<(int, InsightMetric), List<InsightChartPoint>>? cachedChartPoints,
}) {
  final metrics = [
    InsightMetric.passBy,
    InsightMetric.stagnant,
    if (!isGlobal) InsightMetric.entry,
    if (!isGlobal) InsightMetric.exit,
    InsightMetric.appear,
    InsightMetric.disappear,
    InsightMetric.occupancyMean,
    InsightMetric.occupancyPeak,
    InsightMetric.dwellTimeMean,
    InsightMetric.dwellTimeMax,
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
  required InsightMetric metric,
  required int areaId,
  required ObservationSeries today,
  required ObservationSeries comparison,
  required List<BusinessPeriod> businessPeriods,
  required DateTime now,
  required List<InsightChartPoint>? cachedChartPoints,
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

InsightPeriodData _buildPeriod({
  required BusinessPeriod period,
  required int areaId,
  required InsightMetric metric,
  required ObservationSeries today,
  required ObservationSeries comparison,
  required DateTime now,
}) {
  final periodState = insightPeriodState(period, now);
  final status = periodState.status;
  final endMinute = periodState.endMinute;
  if (status == BusinessPeriodStatus.notStarted || endMinute <= period.startMinute) {
    return InsightPeriodData(period: period, status: status, primary: null, comparisonValue: null);
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
  )?.value;
  return InsightPeriodData(period: period, status: status, primary: primary, comparisonValue: comparisonValue);
}

List<InsightChartPoint> _buildChartPoints(
  InsightMetric metric,
  int areaId,
  ObservationSeries today,
  ObservationSeries comparison,
  int completedHourCount,
) {
  final points = <InsightChartPoint>[];
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
      InsightChartPoint(
        minuteOfDay: hour * 60,
        todayValue: todayValue?.value,
        comparisonValue: comparisonValue?.value,
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

  final InsightMetric metric;
  final List<InsightPeriodData> periods;
  final List<InsightChartPoint> chartPoints;
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
