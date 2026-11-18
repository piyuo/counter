import 'dart:math';

import 'package:core_domain/services/dashboard_service.dart';

import '../model/activity.dart';
import '../model/observation.dart';
import '../model/observation_series.dart';

enum _MetricValueMode { hourlyRate, chart }

DashboardMeasurement? calculateInsightPrimaryMetric(
  Observation? observation,
  int areaId,
  DashboardMetric metric, {
  required int expectedSeconds,
}) {
  if (observation == null) return null;
  final activity = _activity(observation, areaId);
  if (activity == null) return null;
  return _valueForSingleSample(
    activity,
    metric,
    coveredSeconds: observation.coveredSeconds,
    expectedSeconds: expectedSeconds,
  );
}

DashboardMeasurement? calculateInsightMetricFromObservationsInRange({
  required ObservationSeries series,
  required int startMinute,
  required int endMinute,
  required int areaId,
  required DashboardMetric metric,
  required int expectedSeconds,
}) => _fromObservations(
  series.where((observation) {
    final minute = observation.hour * 60 + observation.minute;
    return minute >= startMinute && minute < endMinute;
  }),
  areaId,
  metric,
  expectedSeconds: expectedSeconds,
);

DashboardMeasurement? calculateInsightHourlyChartValue({
  required ObservationSeries series,
  required int areaId,
  required DashboardMetric metric,
  required int hour,
}) => _fromObservations(
  series.where((observation) => observation.hour == hour),
  areaId,
  metric,
  expectedSeconds: 3600,
  mode: _MetricValueMode.chart,
);

DashboardMeasurement? _fromObservations(
  Iterable<Observation> observations,
  int areaId,
  DashboardMetric metric, {
  required int expectedSeconds,
  _MetricValueMode mode = _MetricValueMode.hourlyRate,
}) {
  final samples = <Activity>[];
  var coveredSeconds = 0;
  for (final observation in observations) {
    final activity = _activity(observation, areaId);
    if (activity == null) continue;
    samples.add(activity);
    coveredSeconds += observation.coveredSeconds;
  }
  if (samples.isEmpty) return null;
  return _valueForSamples(
    samples,
    metric,
    coveredSeconds: coveredSeconds,
    expectedSeconds: expectedSeconds,
    mode: mode,
  );
}

DashboardMeasurement? _valueForSingleSample(
  Activity sample,
  DashboardMetric metric, {
  required int coveredSeconds,
  required int expectedSeconds,
}) => _valueForSamples([sample], metric, coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds);

DashboardMeasurement? _valueForSamples(
  List<Activity> samples,
  DashboardMetric metric, {
  required int coveredSeconds,
  required int expectedSeconds,
  _MetricValueMode mode = _MetricValueMode.hourlyRate,
}) {
  assert(
    samples.isNotEmpty && samples.every((sample) => sample.areaId == samples.first.areaId),
    'samples must all belong to the same area',
  );
  var eventCount = 0.0;
  var occupancySampleCount = 0;
  var occupancySum = 0;
  int? occupancyMaximum;
  var dwellSampleCount = 0;
  var dwellSumSeconds = 0;
  int? dwellMaximum;
  for (final sample in samples) {
    eventCount += _insightEventValue(sample, metric);
    if (sample.occupancySampleCount > 0) {
      occupancySampleCount += sample.occupancySampleCount;
      occupancySum += sample.occupancySum;
      occupancyMaximum = occupancyMaximum == null ? sample.occupancyMax : max(occupancyMaximum, sample.occupancyMax);
    }
    if (sample.dwellSampleCount > 0) {
      dwellSampleCount += sample.dwellSampleCount;
      dwellSumSeconds += sample.dwellSumSeconds;
      dwellMaximum = dwellMaximum == null ? sample.dwellMaxSeconds : max(dwellMaximum, sample.dwellMaxSeconds);
    }
  }
  return _valueFromTotals(
    metric,
    eventCount: eventCount,
    occupancySampleCount: occupancySampleCount,
    occupancySum: occupancySum,
    occupancyMaximum: occupancyMaximum,
    dwellSampleCount: dwellSampleCount,
    dwellSumSeconds: dwellSumSeconds,
    dwellMaximum: dwellMaximum,
    coveredSeconds: coveredSeconds,
    expectedSeconds: expectedSeconds,
    mode: mode,
  );
}

double hourlyRate(double eventCount, int coveredSeconds) =>
    coveredSeconds <= 0 ? 0 : eventCount / coveredSeconds * 3600;

DashboardMeasurement? _valueFromTotals(
  DashboardMetric metric, {
  required double eventCount,
  required int occupancySampleCount,
  required int occupancySum,
  required int? occupancyMaximum,
  required int dwellSampleCount,
  required int dwellSumSeconds,
  required int? dwellMaximum,
  required int coveredSeconds,
  required int expectedSeconds,
  required _MetricValueMode mode,
}) {
  final eventHourlyRate = mode == _MetricValueMode.hourlyRate;
  final dwellInMinutes = mode == _MetricValueMode.chart;
  return switch (metric) {
    DashboardMetric.passBy ||
    DashboardMetric.stagnant ||
    DashboardMetric.entry ||
    DashboardMetric.exit ||
    DashboardMetric.appear ||
    DashboardMetric.disappear =>
      coveredSeconds <= 0
          ? null
          : DashboardMeasurement(
              // Live and period values are normalized to an hourly rate; charts retain actual counts when coverage is incomplete.
              amount: eventHourlyRate ? eventCount / coveredSeconds * 3600 : eventCount,
              metric: metric,
              expectedSeconds: expectedSeconds,
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.occupancyMean =>
      occupancySampleCount == 0
          ? null
          : DashboardMeasurement(
              amount: occupancySum / occupancySampleCount,
              metric: metric,
              expectedSeconds: expectedSeconds,
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.occupancyMax =>
      occupancyMaximum == null
          ? null
          : DashboardMeasurement(
              amount: occupancyMaximum.toDouble(),
              metric: metric,
              coveredSeconds: coveredSeconds,
              expectedSeconds: expectedSeconds,
            ),
    DashboardMetric.dwellTimeMean =>
      dwellSampleCount == 0
          ? null
          : DashboardMeasurement(
              amount: dwellSumSeconds / dwellSampleCount / (dwellInMinutes ? 60 : 1),
              metric: metric,
              expectedSeconds: expectedSeconds,
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.dwellTimeMax =>
      dwellMaximum == null
          ? null
          : DashboardMeasurement(
              amount: dwellMaximum / (dwellInMinutes ? 60 : 1),
              metric: metric,
              expectedSeconds: expectedSeconds,
              coveredSeconds: coveredSeconds,
            ),
  };
}

double _insightEventValue(Activity activity, DashboardMetric metric) => switch (metric) {
  DashboardMetric.passBy => activity.passBy,
  DashboardMetric.stagnant => activity.stagnant,
  DashboardMetric.entry => activity.entry,
  DashboardMetric.exit => activity.exit,
  DashboardMetric.appear => activity.appear,
  DashboardMetric.disappear => activity.disappear,
  DashboardMetric.occupancyMean ||
  DashboardMetric.occupancyMax ||
  DashboardMetric.dwellTimeMean ||
  DashboardMetric.dwellTimeMax => 0,
};

Activity? _activity(Observation observation, int areaId) {
  for (final area in observation.areas) {
    if (area.areaId == areaId) return area;
  }
  return null;
}

/// Value of [metric] for [areaId] in a single observation.
///
/// Returns 0 when the observation has no entry for [areaId]. Dwell values
/// are in seconds.
double getMetricValue(int areaId, DashboardMetric metric, Observation o) {
  final activity = _activity(o, areaId);
  if (activity == null) return 0;

  return switch (metric) {
    DashboardMetric.passBy => activity.passBy,
    DashboardMetric.stagnant => activity.stagnant,
    DashboardMetric.entry => activity.entry,
    DashboardMetric.exit => activity.exit,
    DashboardMetric.appear => activity.appear,
    DashboardMetric.disappear => activity.disappear,
    DashboardMetric.occupancyMean => activity.occupancyMean,
    DashboardMetric.occupancyMax => activity.occupancyMax.toDouble(),
    DashboardMetric.dwellTimeMean => activity.dwellMeanSeconds.toDouble(),
    DashboardMetric.dwellTimeMax => activity.dwellMaxSeconds.toDouble(),
  };
}

/// Plain sum of [getMetricValue] over every observation in [o].
///
/// This is only a meaningful total for event counts (passBy, stagnant, entry,
/// exit, appear, disappear). For occupancy and dwell metrics it sums per-slot
/// means or maxes, which is not a real mean or maximum. Use
/// [calculateInsightMetricFromObservationsInRange] when you need those
/// aggregated correctly.
///
/// Observations without an entry for [areaId] contribute 0.
double getMetricSum(int areaId, DashboardMetric metric, List<Observation> o) =>
    o.fold<double>(0, (sum, observation) => sum + getMetricValue(areaId, metric, observation));

/// Sums observation-level coverage, which is not specific to an area or metric.
int getCoveredSeconds(List<Observation> observations) =>
    observations.fold(0, (total, observation) => total + observation.coveredSeconds);
