import 'package:core_domain/model/observation_series.dart';
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
  occupancyMax,
  dwellTimeMean,
  dwellTimeMax,
}

bool isHourlyRate(DashboardMetric metric) => switch (metric) {
  DashboardMetric.passBy ||
  DashboardMetric.stagnant ||
  DashboardMetric.entry ||
  DashboardMetric.exit ||
  DashboardMetric.appear ||
  DashboardMetric.disappear => true,
  DashboardMetric.occupancyMean ||
  DashboardMetric.occupancyMax ||
  DashboardMetric.dwellTimeMean ||
  DashboardMetric.dwellTimeMax => false,
};

class DashboardMeasurement {
  const DashboardMeasurement({
    required this.amount,
    required this.metric,
    required this.expectedSeconds,
    required this.coveredSeconds,
  });

  final double amount;
  final DashboardMetric metric;
  final int expectedSeconds;
  final int coveredSeconds;
  double get coverage => expectedSeconds == 0 ? 0 : coveredSeconds / expectedSeconds;
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
  final DashboardMeasurement? primary;
  final double? comparisonValue;
}

class DashboardChartPoint {
  const DashboardChartPoint({
    required this.minuteOfDay,
    this.todayValue,
    this.comparisonValue,
    this.todayCoveredSeconds = 0,
    this.comparisonCoveredSeconds = 0,
    this.todayCoverage = 0,
    this.comparisonCoverage = 0,
  });

  final int minuteOfDay;
  final double? todayValue;
  final double? comparisonValue;
  final int todayCoveredSeconds;
  final int comparisonCoveredSeconds;
  final double todayCoverage;
  final double comparisonCoverage;
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
    required this.recentHourObservations,
  });

  final DashboardMetric metric;
  final DashboardMeasurement? primary;

  /// let user double check the recent hour observations.
  final ObservationSeries? recentHourObservations;

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
abstract class DashboardService {
  DashboardCardData? findCard(int areaId, DashboardMetric metric);
}

@riverpod
DashboardService dashboardService(Ref ref) {
  throw UnimplementedError('dashboardServiceProvider must be overridden');
}

/// State
@riverpod
DashboardState dashboardState(Ref ref) => throw UnimplementedError('dashboardStateProvider must be overridden');
