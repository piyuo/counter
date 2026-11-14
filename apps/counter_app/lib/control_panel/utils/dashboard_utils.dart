import 'package:core_domain/core_domain.dart' as core_domain;

bool dashboardMetricUsesHourlyRate(core_domain.DashboardMetric metric) => switch (metric) {
  core_domain.DashboardMetric.passBy ||
  core_domain.DashboardMetric.stagnant ||
  core_domain.DashboardMetric.entry ||
  core_domain.DashboardMetric.exit ||
  core_domain.DashboardMetric.appear ||
  core_domain.DashboardMetric.disappear => true,
  _ => false,
};

double? getDashboardMetricValue(core_domain.Observation observation, int areaId, core_domain.DashboardMetric metric) {
  final activity = observation.areas.where((area) => area.areaId == areaId).firstOrNull;
  if (activity == null) return null;
  return switch (metric) {
    core_domain.DashboardMetric.passBy => activity.passBy,
    core_domain.DashboardMetric.stagnant => activity.stagnant,
    core_domain.DashboardMetric.entry => activity.entry,
    core_domain.DashboardMetric.exit => activity.exit,
    core_domain.DashboardMetric.appear => activity.appear,
    core_domain.DashboardMetric.disappear => activity.disappear,
    core_domain.DashboardMetric.occupancyMean =>
      activity.occupancySampleCount == 0 ? null : activity.occupancySum / activity.occupancySampleCount,
    core_domain.DashboardMetric.occupancyPeak =>
      activity.occupancySampleCount == 0 ? null : activity.occupancyMax.toDouble(),
    core_domain.DashboardMetric.dwellTimeMean =>
      activity.dwellSampleCount == 0 ? null : activity.dwellSumSeconds / activity.dwellSampleCount / 60,
    core_domain.DashboardMetric.dwellTimeMax => activity.dwellSampleCount == 0 ? null : activity.dwellMaxSeconds / 60,
  };
}

double? getDashboardMetricAggregateValue(
  Iterable<core_domain.Observation> observations,
  int areaId,
  core_domain.DashboardMetric metric,
) {
  final activities = [
    for (final observation in observations)
      for (final activity in observation.areas)
        if (activity.areaId == areaId) activity,
  ];
  if (activities.isEmpty) return null;
  return switch (metric) {
    core_domain.DashboardMetric.passBy => activities.fold<double>(0.0, (total, activity) => total + activity.passBy),
    core_domain.DashboardMetric.stagnant => activities.fold<double>(
      0.0,
      (total, activity) => total + activity.stagnant,
    ),
    core_domain.DashboardMetric.entry => activities.fold<double>(0.0, (total, activity) => total + activity.entry),
    core_domain.DashboardMetric.exit => activities.fold<double>(0.0, (total, activity) => total + activity.exit),
    core_domain.DashboardMetric.appear => activities.fold<double>(0.0, (total, activity) => total + activity.appear),
    core_domain.DashboardMetric.disappear => activities.fold<double>(
      0.0,
      (total, activity) => total + activity.disappear,
    ),
    core_domain.DashboardMetric.occupancyMean => _mean(
      activities.fold(0, (total, activity) => total + activity.occupancySum),
      activities.fold(0, (total, activity) => total + activity.occupancySampleCount),
    ),
    core_domain.DashboardMetric.occupancyPeak =>
      activities
          .where((activity) => activity.occupancySampleCount > 0)
          .map((activity) => activity.occupancyMax.toDouble())
          .fold<double?>(null, (maximum, value) => maximum == null || value > maximum ? value : maximum),
    core_domain.DashboardMetric.dwellTimeMean => _meanDwellMinutes(activities),
    core_domain.DashboardMetric.dwellTimeMax =>
      activities
          .where((activity) => activity.dwellSampleCount > 0)
          .map((activity) => activity.dwellMaxSeconds.toDouble() / 60)
          .fold<double?>(null, (maximum, value) => maximum == null || value > maximum ? value : maximum),
  };
}

int getDashboardCoveredSeconds(Iterable<core_domain.Observation> observations, int areaId) => observations
    .where((observation) => observation.areas.any((area) => area.areaId == areaId))
    .fold(0, (total, observation) => total + observation.coveredSeconds);

double? _mean(num sum, int count) => count == 0 ? null : sum / count;

double? _meanDwellMinutes(List<core_domain.Activity> activities) {
  final meanSeconds = _mean(
    activities.fold(0, (total, activity) => total + activity.dwellSumSeconds),
    activities.fold(0, (total, activity) => total + activity.dwellSampleCount),
  );
  return meanSeconds == null ? null : meanSeconds / 60;
}
