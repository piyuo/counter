// InsightMetricCalculator tests

import 'package:core_domain/aggregation/insight_data_type.dart';
import 'package:core_domain/aggregation/insight_metric_calculator.dart';
import 'package:core_domain/model/activity.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation(int hour, int minute, {required Activity activity, int coveredSeconds = 300}) => Observation(
  year: 2026,
  month: 10,
  day: 29,
  hour: hour,
  minute: minute,
  coveredSeconds: coveredSeconds,
  areas: [activity],
  frameCount: 1,
);

Activity _activity(
  int areaId, {
  double passBy = 0,
  int occupancySum = 0,
  int occupancySampleCount = 0,
  int occupancyMax = 0,
  int dwellSumSeconds = 0,
  int dwellSampleCount = 0,
  int dwellMaxSeconds = 0,
}) => Activity(
  areaId: areaId,
  areaName: 'Area $areaId',
  passBy: passBy,
  occupancySum: occupancySum,
  occupancySampleCount: occupancySampleCount,
  occupancyMax: occupancyMax,
  dwellSumSeconds: dwellSumSeconds,
  dwellSampleCount: dwellSampleCount,
  dwellMaxSeconds: dwellMaxSeconds,
);

void main() {
  group('fromAggregate', () {
    test('normalizes event counts and reports incomplete coverage', () {
      final fullCoverage = calculateInsightMetricFromAggregate(
        _observation(10, 0, activity: _activity(7, passBy: 84), coveredSeconds: 3600),
        7,
        InsightMetric.passBy,
        expectedSeconds: 3600,
      );
      final partialCoverage = calculateInsightMetricFromAggregate(
        _observation(10, 0, activity: _activity(7, passBy: 42), coveredSeconds: 1800),
        7,
        InsightMetric.passBy,
        expectedSeconds: 3600,
      );

      expect(fullCoverage?.value, 84);
      expect(fullCoverage?.unit, InsightMetricValueUnit.countPerHour);
      expect(fullCoverage?.estimated, isFalse);
      expect(partialCoverage?.value, 84);
      expect(partialCoverage?.unit, InsightMetricValueUnit.countPerHour);
      expect(partialCoverage?.estimated, isTrue);
      expect(partialCoverage?.coveredSeconds, 1800);
    });

    test('keeps missing area and zero coverage unavailable', () {
      final observation = _observation(10, 0, activity: _activity(8, passBy: 12), coveredSeconds: 0);

      expect(calculateInsightMetricFromAggregate(observation, 7, InsightMetric.passBy, expectedSeconds: 3600), isNull);
      expect(calculateInsightMetricFromAggregate(observation, 8, InsightMetric.passBy, expectedSeconds: 3600), isNull);
      expect(calculateInsightMetricFromAggregate(null, 7, InsightMetric.passBy, expectedSeconds: 3600), isNull);
    });
  });

  group('fromObservationsInRange', () {
    test('includes the start and excludes the end while filtering area coverage', () {
      final series = ObservationSeries.fromObservations([
        _observation(9, 0, activity: _activity(7, passBy: 2)),
        _observation(9, 55, activity: _activity(7, passBy: 3)),
        _observation(10, 0, activity: _activity(7, passBy: 90)),
        _observation(9, 5, activity: _activity(8, passBy: 50)),
      ]);

      final value = calculateInsightMetricFromObservationsInRange(
        series: series,
        startMinute: 540,
        endMinute: 600,
        areaId: 7,
        metric: InsightMetric.passBy,
        expectedSeconds: 3600,
      );

      expect(value?.value, 30);
      expect(value?.coveredSeconds, 600);
      expect(value?.estimated, isTrue);
    });

    test('uses weighted means and maxima without rate scaling', () {
      final series = ObservationSeries.fromObservations([
        _observation(
          9,
          0,
          activity: _activity(
            7,
            occupancySum: 6,
            occupancySampleCount: 2,
            occupancyMax: 4,
            dwellSumSeconds: 600,
            dwellSampleCount: 2,
            dwellMaxSeconds: 500,
          ),
        ),
        _observation(
          9,
          5,
          activity: _activity(
            7,
            occupancySum: 9,
            occupancySampleCount: 3,
            occupancyMax: 7,
            dwellSumSeconds: 180,
            dwellSampleCount: 1,
            dwellMaxSeconds: 180,
          ),
        ),
      ]);

      InsightMetricValue? value(InsightMetric metric) => calculateInsightMetricFromObservationsInRange(
        series: series,
        startMinute: 540,
        endMinute: 600,
        areaId: 7,
        metric: metric,
        expectedSeconds: 3600,
      );

      expect(value(InsightMetric.occupancyMean)?.value, 3);
      expect(value(InsightMetric.occupancyMean)?.unit, InsightMetricValueUnit.objects);
      expect(value(InsightMetric.occupancyPeak)?.value, 7);
      expect(value(InsightMetric.dwellTimeMean)?.value, 260);
      expect(value(InsightMetric.dwellTimeMean)?.unit, InsightMetricValueUnit.seconds);
      expect(value(InsightMetric.dwellTimeMax)?.value, 500);
      expect(value(InsightMetric.dwellTimeMax)?.unit, InsightMetricValueUnit.seconds);
    });
  });

  test('marks hourly chart dwell values in minutes', () {
    final series = ObservationSeries.fromObservations([
      _observation(9, 0, activity: _activity(7, dwellSumSeconds: 600, dwellSampleCount: 2, dwellMaxSeconds: 300)),
    ]);

    final mean = calculateInsightHourlyChartValue(
      series: series,
      areaId: 7,
      metric: InsightMetric.dwellTimeMean,
      hour: 9,
    );
    final maximum = calculateInsightHourlyChartValue(
      series: series,
      areaId: 7,
      metric: InsightMetric.dwellTimeMax,
      hour: 9,
    );

    expect(mean?.value, 5);
    expect(mean?.unit, InsightMetricValueUnit.minutes);
    expect(maximum?.value, 5);
    expect(maximum?.unit, InsightMetricValueUnit.minutes);
  });
}
