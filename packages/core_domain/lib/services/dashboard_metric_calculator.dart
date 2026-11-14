import 'dart:math';

import 'package:core_domain/services/dashboard_service.dart';

import '../model/activity.dart';
import '../model/observation.dart';
import '../model/observation_series.dart';

enum _MetricValueMode { hourlyRate, chart }

const double _coverageTolerance = 0.05;

DashboardMeasurement? calculateInsightMetricFromAggregate(
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
              // Live and period values are estimated hourly rates; charts retain actual counts when coverage is incomplete.
              amount: eventHourlyRate ? eventCount / coveredSeconds * 3600 : eventCount,
              unit: eventHourlyRate ? DashboardMeasurementUnit.countPerHour : DashboardMeasurementUnit.count,
              estimated: _isEstimated(coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds),
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.occupancyMean =>
      occupancySampleCount == 0
          ? null
          : DashboardMeasurement(
              amount: occupancySum / occupancySampleCount,
              unit: DashboardMeasurementUnit.objects,
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.occupancyPeak =>
      occupancyMaximum == null
          ? null
          : DashboardMeasurement(
              amount: occupancyMaximum.toDouble(),
              unit: DashboardMeasurementUnit.objects,
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.dwellTimeMean =>
      dwellSampleCount == 0
          ? null
          : DashboardMeasurement(
              amount: dwellSumSeconds / dwellSampleCount / (dwellInMinutes ? 60 : 1),
              unit: dwellInMinutes ? DashboardMeasurementUnit.minutes : DashboardMeasurementUnit.seconds,
              coveredSeconds: coveredSeconds,
            ),
    DashboardMetric.dwellTimeMax =>
      dwellMaximum == null
          ? null
          : DashboardMeasurement(
              amount: dwellMaximum / (dwellInMinutes ? 60 : 1),
              unit: dwellInMinutes ? DashboardMeasurementUnit.minutes : DashboardMeasurementUnit.seconds,
              coveredSeconds: coveredSeconds,
            ),
  };
}

bool _isEstimated({required int coveredSeconds, required int expectedSeconds}) =>
    coveredSeconds < expectedSeconds * (1 - _coverageTolerance);

double _insightEventValue(Activity activity, DashboardMetric metric) => switch (metric) {
  DashboardMetric.passBy => activity.passBy,
  DashboardMetric.stagnant => activity.stagnant,
  DashboardMetric.entry => activity.entry,
  DashboardMetric.exit => activity.exit,
  DashboardMetric.appear => activity.appear,
  DashboardMetric.disappear => activity.disappear,
  DashboardMetric.occupancyMean ||
  DashboardMetric.occupancyPeak ||
  DashboardMetric.dwellTimeMean ||
  DashboardMetric.dwellTimeMax => 0,
};

Activity? _activity(Observation observation, int areaId) {
  for (final area in observation.areas) {
    if (area.areaId == areaId) return area;
  }
  return null;
}
