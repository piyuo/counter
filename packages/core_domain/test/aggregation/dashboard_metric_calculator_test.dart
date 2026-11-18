// InsightMetricCalculator tests

import 'package:core_domain/model/activity.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:core_domain/services/dashboard_metric_calculator.dart';
import 'package:core_domain/services/dashboard_service.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation(
  int hour,
  int minute, {
  required Activity activity,
  int coveredSeconds = 300,
}) => Observation(
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
  group('getMetricValue', () {
    test('returns the selected area metric with dwell time in seconds', () {
      final observation = _observation(
        10,
        0,
        activity: _activity(
          7,
          passBy: 3,
          occupancySum: 9,
          occupancySampleCount: 3,
          occupancyMax: 5,
          dwellSumSeconds: 240,
          dwellSampleCount: 2,
          dwellMaxSeconds: 180,
        ),
      );

      expect(getMetricValue(7, DashboardMetric.passBy, observation), 3);
      expect(getMetricValue(7, DashboardMetric.occupancyMean, observation), 3);
      expect(getMetricValue(7, DashboardMetric.occupancyMax, observation), 5);
      expect(
        getMetricValue(7, DashboardMetric.dwellTimeMean, observation),
        120,
      );
      expect(getMetricValue(7, DashboardMetric.dwellTimeMax, observation), 180);
    });

    test('returns zero when the area or metric samples are unavailable', () {
      final observation = _observation(10, 0, activity: _activity(7));

      expect(getMetricValue(8, DashboardMetric.passBy, observation), 0);
      expect(getMetricValue(7, DashboardMetric.occupancyMean, observation), 0);
      expect(getMetricValue(7, DashboardMetric.dwellTimeMean, observation), 0);
    });
  });
  group('getMetricSum', () {
    final series = ObservationSeries.fromObservations([
      _observation(
        10,
        0,
        activity: _activity(
          7,
          passBy: 2,
          dwellSumSeconds: 120,
          dwellSampleCount: 1,
        ),
      ),
      _observation(10, 5, activity: _activity(8, passBy: 50)),
      _observation(
        10,
        10,
        activity: _activity(
          7,
          passBy: 3,
          dwellSumSeconds: 240,
          dwellSampleCount: 1,
        ),
      ),
    ]);

    test('adds an event metric across observations for the selected area', () {
      // The 10:05 observation only has area 8, so its passBy of 50 is ignored.
      expect(getMetricSum(7, DashboardMetric.passBy, series.items), 5);
    });

    test('plainly sums per-slot values for non-count metrics without aggregating', () {
      // 120s + 240s. This is NOT a weighted mean; it documents the current
      // behavior of a plain sum, not a recommended way to combine dwell means.
      expect(getMetricSum(7, DashboardMetric.dwellTimeMean, series.items), 360);
    });

    test('returns 0 for an area that appears in no observation', () {
      expect(getMetricSum(99, DashboardMetric.passBy, series.items), 0);
    });

    test('returns 0 for an empty series', () {
      expect(
        getMetricSum(7, DashboardMetric.passBy, ObservationSeries.empty.items),
        0,
      );
    });
  });

  group('getCoveredSeconds', () {
    final series = ObservationSeries.fromObservations([
      _observation(10, 0, activity: _activity(7), coveredSeconds: 100),
      _observation(10, 5, activity: _activity(8), coveredSeconds: 300),
      _observation(
        10,
        10,
        activity: _activity(7, passBy: 2),
        coveredSeconds: 50,
      ),
    ]);

    test('sums observation-level coverage regardless of area data', () {
      expect(getCoveredSeconds(series.items), 450);
    });

    test('coverage is observation-level and independent of metric', () {
      expect(getCoveredSeconds(series.items), 450);
    });

    test(
      'includes coverage when observations have no entry for a particular area',
      () {
        final withoutAreaData = ObservationSeries.fromObservations([
          _observation(10, 0, activity: _activity(8), coveredSeconds: 100),
        ]);

        expect(getCoveredSeconds(withoutAreaData.items), 100);
        expect(getCoveredSeconds(ObservationSeries.empty.items), 0);
      },
    );
  });

  group('fromAggregate', () {
    test('normalizes event counts and reports coverage', () {
      final fullCoverage = calculateInsightPrimaryMetric(
        _observation(
          10,
          0,
          activity: _activity(7, passBy: 84),
          coveredSeconds: 3600,
        ),
        7,
        DashboardMetric.passBy,
        expectedSeconds: 3600,
      );
      final partialCoverage = calculateInsightPrimaryMetric(
        _observation(
          10,
          0,
          activity: _activity(7, passBy: 42),
          coveredSeconds: 1800,
        ),
        7,
        DashboardMetric.passBy,
        expectedSeconds: 3600,
      );

      expect(fullCoverage?.amount, 84);
      expect(fullCoverage?.metric, DashboardMetric.passBy);
      expect(fullCoverage?.coverage, 1);
      expect(partialCoverage?.amount, 84);
      expect(partialCoverage?.metric, DashboardMetric.passBy);
      expect(partialCoverage?.coverage, 0.5);
      expect(partialCoverage?.coveredSeconds, 1800);
    });

    test('keeps missing area and zero coverage unavailable', () {
      final observation = _observation(
        10,
        0,
        activity: _activity(8, passBy: 12),
        coveredSeconds: 0,
      );

      expect(
        calculateInsightPrimaryMetric(
          observation,
          7,
          DashboardMetric.passBy,
          expectedSeconds: 3600,
        ),
        isNull,
      );
      expect(
        calculateInsightPrimaryMetric(
          observation,
          8,
          DashboardMetric.passBy,
          expectedSeconds: 3600,
        ),
        isNull,
      );
      expect(
        calculateInsightPrimaryMetric(
          null,
          7,
          DashboardMetric.passBy,
          expectedSeconds: 3600,
        ),
        isNull,
      );
    });
  });

  group('fromObservationsInRange', () {
    test(
      'includes the start and excludes the end while filtering area coverage',
      () {
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
          metric: DashboardMetric.passBy,
          expectedSeconds: 3600,
        );

        expect(value?.amount, 30);
        expect(value?.coveredSeconds, 600);
        expect(value?.coverage, 1 / 6);
      },
    );

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

      DashboardMeasurement? value(DashboardMetric metric) =>
          calculateInsightMetricFromObservationsInRange(
            series: series,
            startMinute: 540,
            endMinute: 600,
            areaId: 7,
            metric: metric,
            expectedSeconds: 3600,
          );

      expect(value(DashboardMetric.occupancyMean)?.amount, 3);
      expect(
        value(DashboardMetric.occupancyMean)?.metric,
        DashboardMetric.occupancyMean,
      );
      expect(value(DashboardMetric.occupancyMax)?.amount, 7);
      expect(value(DashboardMetric.dwellTimeMean)?.amount, 260);
      expect(
        value(DashboardMetric.dwellTimeMean)?.metric,
        DashboardMetric.dwellTimeMean,
      );
      expect(value(DashboardMetric.dwellTimeMax)?.amount, 500);
      expect(
        value(DashboardMetric.dwellTimeMax)?.metric,
        DashboardMetric.dwellTimeMax,
      );
    });
  });

  test('marks hourly chart dwell values in minutes', () {
    final series = ObservationSeries.fromObservations([
      _observation(
        9,
        0,
        activity: _activity(
          7,
          dwellSumSeconds: 600,
          dwellSampleCount: 2,
          dwellMaxSeconds: 300,
        ),
      ),
    ]);

    final mean = calculateInsightHourlyChartValue(
      series: series,
      areaId: 7,
      metric: DashboardMetric.dwellTimeMean,
      hour: 9,
    );
    final maximum = calculateInsightHourlyChartValue(
      series: series,
      areaId: 7,
      metric: DashboardMetric.dwellTimeMax,
      hour: 9,
    );

    expect(mean?.amount, 5);
    expect(mean?.metric, DashboardMetric.dwellTimeMean);
    expect(maximum?.amount, 5);
    expect(maximum?.metric, DashboardMetric.dwellTimeMax);
  });
}
