import '../model/business_period.dart';

enum InsightMetric {
  passBy,
  stagnant,
  entry,
  exit,
  appear,
  disappear,
  occupancyMean,
  occupancyPeak,
  dwellTimeMean,
  dwellTimeMax,
}

class InsightMetricValue {
  const InsightMetricValue({required this.value, this.estimated = false, this.coveredSeconds = 0});

  final double value;
  final bool estimated;
  final int coveredSeconds;
}

class InsightPeriodData {
  const InsightPeriodData({
    required this.period,
    required this.status,
    required this.primary,
    required this.comparisonValue,
  });

  final BusinessPeriod period;
  final BusinessPeriodStatus status;
  final InsightMetricValue? primary;
  final double? comparisonValue;
}

class InsightChartPoint {
  const InsightChartPoint({required this.minuteOfDay, this.todayValue, this.comparisonValue});

  final int minuteOfDay;
  final double? todayValue;
  final double? comparisonValue;
}

class InsightCardData {
  const InsightCardData({
    required this.metric,
    required this.primary,
    required this.comparisonValue,
    required this.periods,
    required this.chartPoints,
  });

  final InsightMetric metric;
  final InsightMetricValue? primary;
  final double? comparisonValue;
  final List<InsightPeriodData> periods;
  final List<InsightChartPoint> chartPoints;
}

class InsightAreaData {
  const InsightAreaData({required this.areaId, required this.name, required this.isGlobal, required this.cards});

  final int areaId;
  final String? name;
  final bool isGlobal;
  final List<InsightCardData> cards;

  InsightCardData card(InsightMetric metric) => cards.firstWhere((card) => card.metric == metric);
}
