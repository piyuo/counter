import 'dart:math';

import '../model/activity.dart';
import '../model/observation.dart';
import '../model/observation_series.dart';
import 'insight_data_type.dart';

enum _MetricValueMode { hourlyRate, chart }

const double _coverageTolerance = 0.05;

InsightMetricValue? calculateInsightMetricFromAggregate(
  Observation? observation,
  int areaId,
  InsightMetric metric, {
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

InsightMetricValue? calculateInsightMetricFromObservationsInRange({
  required ObservationSeries series,
  required int startMinute,
  required int endMinute,
  required int areaId,
  required InsightMetric metric,
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

InsightMetricValue? calculateInsightHourlyChartValue({
  required ObservationSeries series,
  required int areaId,
  required InsightMetric metric,
  required int hour,
}) => _fromObservations(
  series.where((observation) => observation.hour == hour),
  areaId,
  metric,
  expectedSeconds: 3600,
  mode: _MetricValueMode.chart,
);

InsightMetricValue? _fromObservations(
  Iterable<Observation> observations,
  int areaId,
  InsightMetric metric, {
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

InsightMetricValue? _valueForSingleSample(
  Activity sample,
  InsightMetric metric, {
  required int coveredSeconds,
  required int expectedSeconds,
}) => _valueForSamples([sample], metric, coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds);

InsightMetricValue? _valueForSamples(
  List<Activity> samples,
  InsightMetric metric, {
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

InsightMetricValue? _valueFromTotals(
  InsightMetric metric, {
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
    InsightMetric.passBy ||
    InsightMetric.stagnant ||
    InsightMetric.entry ||
    InsightMetric.exit ||
    InsightMetric.appear ||
    InsightMetric.disappear =>
      coveredSeconds <= 0
          ? null
          : InsightMetricValue(
              // Live and period values are estimated hourly rates; charts retain actual counts when coverage is incomplete.
              value: eventHourlyRate ? eventCount / coveredSeconds * 3600 : eventCount,
              unit: eventHourlyRate ? InsightMetricValueUnit.countPerHour : InsightMetricValueUnit.count,
              estimated: _isEstimated(coveredSeconds: coveredSeconds, expectedSeconds: expectedSeconds),
              coveredSeconds: coveredSeconds,
            ),
    InsightMetric.occupancyMean =>
      occupancySampleCount == 0
          ? null
          : InsightMetricValue(
              value: occupancySum / occupancySampleCount,
              unit: InsightMetricValueUnit.objects,
              coveredSeconds: coveredSeconds,
            ),
    InsightMetric.occupancyPeak =>
      occupancyMaximum == null
          ? null
          : InsightMetricValue(
              value: occupancyMaximum.toDouble(),
              unit: InsightMetricValueUnit.objects,
              coveredSeconds: coveredSeconds,
            ),
    InsightMetric.dwellTimeMean =>
      dwellSampleCount == 0
          ? null
          : InsightMetricValue(
              value: dwellSumSeconds / dwellSampleCount / (dwellInMinutes ? 60 : 1),
              unit: dwellInMinutes ? InsightMetricValueUnit.minutes : InsightMetricValueUnit.seconds,
              coveredSeconds: coveredSeconds,
            ),
    InsightMetric.dwellTimeMax =>
      dwellMaximum == null
          ? null
          : InsightMetricValue(
              value: dwellMaximum / (dwellInMinutes ? 60 : 1),
              unit: dwellInMinutes ? InsightMetricValueUnit.minutes : InsightMetricValueUnit.seconds,
              coveredSeconds: coveredSeconds,
            ),
  };
}

bool _isEstimated({required int coveredSeconds, required int expectedSeconds}) =>
    coveredSeconds < expectedSeconds * (1 - _coverageTolerance);

double _insightEventValue(Activity activity, InsightMetric metric) => switch (metric) {
  InsightMetric.passBy => activity.passBy,
  InsightMetric.stagnant => activity.stagnant,
  InsightMetric.entry => activity.entry,
  InsightMetric.exit => activity.exit,
  InsightMetric.appear => activity.appear,
  InsightMetric.disappear => activity.disappear,
  InsightMetric.occupancyMean ||
  InsightMetric.occupancyPeak ||
  InsightMetric.dwellTimeMean ||
  InsightMetric.dwellTimeMax => 0,
};

Activity? _activity(Observation observation, int areaId) {
  for (final area in observation.areas) {
    if (area.areaId == areaId) return area;
  }
  return null;
}
