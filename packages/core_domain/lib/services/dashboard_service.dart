import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/business_period.dart';

part 'dashboard_service.freezed.dart';
part 'dashboard_service.g.dart';

enum DashboardMetric {
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

enum DashboardMetricValueUnit { count, countPerHour, objects, seconds, minutes }

class DashboardMetricValue {
  const DashboardMetricValue({
    required this.value,
    required this.unit,
    this.estimated = false,
    this.coveredSeconds = 0,
  });

  final double value;
  final DashboardMetricValueUnit unit;
  final bool estimated;
  final int coveredSeconds;
}

class DashboardPeriodData {
  const DashboardPeriodData({
    required this.period,
    required this.status,
    required this.primary,
    required this.comparisonValue,
  });

  final BusinessPeriod period;
  final BusinessPeriodStatus status;
  final DashboardMetricValue? primary;
  final double? comparisonValue;
}

class DashboardChartPoint {
  const DashboardChartPoint({
    required this.minuteOfDay,
    this.todayValue,
    this.comparisonValue,
    this.todayCoveredSeconds = 0,
    this.comparisonCoveredSeconds = 0,
    this.todayEstimated = false,
    this.comparisonEstimated = false,
  });

  final int minuteOfDay;
  final double? todayValue;
  final double? comparisonValue;
  final int todayCoveredSeconds;
  final int comparisonCoveredSeconds;
  final bool todayEstimated;
  final bool comparisonEstimated;
}

class DashboardAreaData {
  const DashboardAreaData({required this.areaId, required this.name, required this.isGlobal, required this.cards});

  final int areaId;
  final String? name;
  final bool isGlobal;
  final List<DashboardCardData> cards;

  DashboardCardData card(DashboardMetric metric) => cards.firstWhere((card) => card.metric == metric);
}

class DashboardCardData {
  const DashboardCardData({
    required this.metric,
    required this.primary,
    required this.comparisonValue,
    required this.periods,
    required this.chartPoints,
  });

  final DashboardMetric metric;
  final DashboardMetricValue? primary;
  final double? comparisonValue;
  final List<DashboardPeriodData> periods;
  final List<DashboardChartPoint> chartPoints;
}

@freezed
class DashboardState with _$DashboardState {
  const DashboardState({required this.areas});

  final List<DashboardAreaData> areas;
}

// generate
abstract class DashboardService {}

@riverpod
DashboardService dashboardService(Ref ref) {
  throw UnimplementedError('dashboardServiceProvider must be overridden');
}

/// State
@riverpod
DashboardState dashboardState(Ref ref) => throw UnimplementedError('dashboardStateProvider must be overridden');
