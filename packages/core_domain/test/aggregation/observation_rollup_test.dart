// TOC
// 1. ObservationRollup actual-period tests
// 2. ObservationRollup typical-profile tests

import 'package:core_domain/core_domain.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation({
  required ObservationGranularity granularity,
  required int year,
  required int month,
  required int day,
  required int hour,
  required int minute,
  List<AreaMetrics> areas = const [],
}) {
  return Observation(
    granularity: granularity,
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    confidenceSum: 0,
    confidenceSampleCount: 0,
    coveredSeconds: granularity == ObservationGranularity.minutes5 ? 300 : 0,
    areas: areas,
    frameCount: 1,
  );
}

AreaMetrics _metrics({
  int areaId = 1,
  double passBy = 0,
  double stagnant = 0,
  double entry = 0,
  double exit = 0,
  double appear = 0,
  double disappear = 0,
  int occupancySampleCount = 0,
  int occupancySampleSum = 0,
  int occupancySampleSumSquares = 0,
  int occupancyMax = 0,
  int occupancyLast = 0,
  int dwellSampleCount = 0,
  int dwellSumSeconds = 0,
  int dwellMaxSeconds = 0,
  List<int> dwellHistogram = const [0, 0, 0, 0, 0, 0, 0, 0],
}) {
  return AreaMetrics(
    areaId: areaId,
    areaName: 'Area $areaId',
    passBy: passBy,
    stagnant: stagnant,
    entry: entry,
    exit: exit,
    appear: appear,
    disappear: disappear,
    occupancySampleCount: occupancySampleCount,
    occupancySum: occupancySampleSum,
    occupancySumSquares: occupancySampleSumSquares,
    occupancyMax: occupancyMax,
    occupancyLast: occupancyLast,
    dwellSampleCount: dwellSampleCount,
    dwellSumSeconds: dwellSumSeconds,
    dwellMaxSeconds: dwellMaxSeconds,
    dwellHistogram: dwellHistogram,
  );
}

Observation _minute({required int minute, required AreaMetrics metrics, int day = 1, int month = 1}) {
  return _observation(
    granularity: ObservationGranularity.minutes5,
    year: 2026,
    month: month,
    day: day,
    hour: 10,
    minute: minute,
    areas: [metrics],
  );
}

Observation _partialMinute({required int minute, required int coveredSeconds, int day = 1}) {
  return Observation(
    granularity: ObservationGranularity.minutes5,
    year: 2026,
    month: 1,
    day: day,
    hour: 10,
    minute: minute,
    confidenceSum: 0,
    confidenceSampleCount: 0,
    coveredSeconds: coveredSeconds,
    areas: const [],
    frameCount: 1,
  );
}

void main() {
  const rollup = ObservationRollup();

  group('ObservationRollup actual-period aggregation', () {
    test('keeps the latest valid occupancy snapshot', () {
      final combined = rollup.aggregate([
        _minute(minute: 0, metrics: _metrics(passBy: 1, occupancySampleCount: 1, occupancyLast: 4)),
        _minute(minute: 5, metrics: _metrics(passBy: 2, occupancySampleCount: 1, occupancyLast: 8)),
      ], granularity: ObservationGranularity.hour);

      expect(combined.areas.single.occupancyLast, 8);
      expect(combined.areas.single.passBy, 3);
    });

    test('adds event counts across source observations', () {
      final combined = rollup.aggregate([
        _minute(minute: 0, metrics: _metrics(passBy: 2, stagnant: 3, entry: 4, exit: 5, appear: 6, disappear: 7)),
        _minute(minute: 5, metrics: _metrics(passBy: 8, stagnant: 9, entry: 10, exit: 11, appear: 12, disappear: 13)),
      ], granularity: ObservationGranularity.hour);

      final metrics = combined.areas.single;
      expect((metrics.passBy, metrics.stagnant, metrics.entry), (10, 12, 14));
      expect((metrics.exit, metrics.appear, metrics.disappear), (16, 18, 20));
    });

    test('does not let a later observation without samples erase a valid snapshot', () {
      final combined = rollup.aggregate([
        _minute(minute: 0, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 4)),
        _minute(minute: 5, metrics: _metrics()),
      ], granularity: ObservationGranularity.hour);

      expect(combined.areas.single.occupancyLast, 4);
    });

    test('preserves a valid zero as the latest occupancy snapshot', () {
      final combined = rollup.aggregate([
        _minute(minute: 0, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 4)),
        _minute(minute: 5, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 0)),
      ], granularity: ObservationGranularity.hour);

      expect(combined.areas.single.occupancyLast, 0);
    });

    test('ignores occupancy maxima from observations with no samples', () {
      final combined = rollup.aggregate([
        _minute(minute: 0, metrics: _metrics(occupancySampleCount: 1, occupancyMax: 4, occupancyLast: 4)),
        _minute(minute: 5, metrics: _metrics(occupancyMax: 99)),
      ], granularity: ObservationGranularity.hour);

      expect(combined.areas.single.occupancyMax, 4);
    });

    test('defaults last occupancy to zero when no samples exist', () {
      final combined = rollup.aggregate([
        _minute(minute: 0, metrics: _metrics()),
        _minute(minute: 5, metrics: _metrics()),
      ], granularity: ObservationGranularity.hour);

      expect(combined.areas.single.occupancyLast, 0);
      expect(combined.areas.single.occupancySampleCount, 0);
    });

    test('rejects duplicate sources for each supported target granularity', () {
      final minute = _minute(minute: 0, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 0));
      final day = _observation(
        granularity: ObservationGranularity.day,
        year: 2026,
        month: 1,
        day: 1,
        hour: -1,
        minute: -1,
      );
      final month = _observation(
        granularity: ObservationGranularity.month,
        year: 2026,
        month: 1,
        day: -1,
        hour: -1,
        minute: -1,
      );

      expect(() => rollup.aggregate([minute, minute], granularity: ObservationGranularity.hour), throwsArgumentError);
      expect(() => rollup.aggregate([minute, minute], granularity: ObservationGranularity.day), throwsArgumentError);
      expect(() => rollup.aggregate([day, day], granularity: ObservationGranularity.month), throwsArgumentError);
      expect(() => rollup.aggregate([month, month], granularity: ObservationGranularity.year), throwsArgumentError);
    });

    test('rejects an actual aggregate whose dwell histogram disagrees with its count', () {
      final observation = _minute(
        minute: 0,
        metrics: _metrics(dwellSampleCount: 2, dwellHistogram: const [1, 0, 0, 0, 0, 0, 0, 0]),
      );

      expect(() => rollup.aggregate([observation], granularity: ObservationGranularity.hour), throwsArgumentError);
    });
  });

  group('ObservationRollup typical-day profiles', () {
    test('uses occupancy maximum and leaves the last snapshot unavailable', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [
          _minute(
            minute: 0,
            metrics: _metrics(
              occupancySampleCount: 2,
              occupancySampleSum: 6,
              occupancySampleSumSquares: 20,
              occupancyMax: 8,
              occupancyLast: 4,
            ),
          ),
        ],
        [
          _minute(
            minute: 0,
            day: 2,
            metrics: _metrics(
              occupancySampleCount: 2,
              occupancySampleSum: 10,
              occupancySampleSumSquares: 52,
              occupancyMax: 12,
              occupancyLast: 8,
            ),
          ),
        ],
      ]);

      expect(profile.single.areas.single.occupancyMax, 12);
      expect(profile.single.areas.single.occupancyLast, 0);
      expect(profile.single.areas.single.occupancySampleCount, 2);
      expect(profile.single.areas.single.occupancySum, 8);
      expect(profile.single.areas.single.occupancyMean, 4);
    });

    test('can average an existing profile without rejecting its unavailable snapshot', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [_minute(minute: 0, metrics: _metrics(occupancySampleCount: 2, occupancySampleSum: 4, occupancyLast: 3))],
      ]);

      final averagedAgain = rollup.averageFiveMinuteProfiles([profile]);

      expect(averagedAgain.single.areas.single.occupancyLast, 0);
      expect(averagedAgain.single.areas.single.occupancyMean, 2);
    });

    test('derives typical occupancy mean from averaged sufficient statistics', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [
          _minute(
            minute: 0,
            metrics: _metrics(
              occupancySampleCount: 2,
              occupancySampleSum: 2,
              occupancySampleSumSquares: 2,
              occupancyMax: 1,
              occupancyLast: 1,
            ),
          ),
        ],
        [
          _minute(
            minute: 0,
            day: 2,
            metrics: _metrics(
              occupancySampleCount: 8,
              occupancySampleSum: 24,
              occupancySampleSumSquares: 72,
              occupancyMax: 3,
              occupancyLast: 3,
            ),
          ),
        ],
      ]);

      final metrics = profile.single.areas.single;
      expect(metrics.occupancySampleCount, 5);
      expect(metrics.occupancySum, 13);
      expect(metrics.occupancySumSquares, 37);
      expect(metrics.occupancyMean, closeTo(2.6, 1e-12));
      expect(metrics.occupancyMean, isNot(2.0), reason: '2.0 would be the unweighted average of daily means');
    });

    test('averages dwellMaxSeconds as the typical daily maximum', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [
          _minute(
            minute: 0,
            metrics: _metrics(dwellSampleCount: 1, dwellMaxSeconds: 4, dwellHistogram: const [1, 0, 0, 0, 0, 0, 0, 0]),
          ),
        ],
        [
          _minute(
            minute: 0,
            day: 2,
            metrics: _metrics(dwellSampleCount: 1, dwellMaxSeconds: 10, dwellHistogram: const [1, 0, 0, 0, 0, 0, 0, 0]),
          ),
        ],
      ]);

      expect(profile.single.areas.single.dwellMaxSeconds, 7);
    });

    test('uses only present slots, preserves zero, and omits absent slots', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [
          _minute(minute: 0, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 0)),
          _minute(minute: 5, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 4)),
        ],
        [_minute(minute: 0, day: 2, metrics: _metrics(occupancySampleCount: 1, occupancyLast: 0))],
      ]);

      expect(profile.map((observation) => observation.minute), [0, 5]);
      expect(profile.first.areas.single.occupancySampleCount, 1);
      expect(profile.first.areas.single.occupancySum, 0);
      expect(profile.first.areas.single.occupancyMean, 0);
      expect(profile.first.areas.single.occupancyLast, 0);
      expect(profile.last.areas.single.occupancyLast, 0);
    });

    test('averages coverage over valid contributors without filling missing slots', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [_partialMinute(minute: 0, coveredSeconds: 150)],
        [_partialMinute(minute: 0, coveredSeconds: 75, day: 2)],
      ]);

      expect(profile, hasLength(1));
      expect(profile.single.coveredSeconds, 113);
      expect(profile.single.expectedSeconds, 300);
      expect(profile.single.coverageRatio, closeTo(113 / 300, 1e-12));
    });

    test('rounds profile dwell histogram with largest remainders to match count', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [
          _minute(
            minute: 0,
            metrics: _metrics(dwellSampleCount: 1, dwellSumSeconds: 3, dwellHistogram: const [1, 0, 0, 0, 0, 0, 0, 0]),
          ),
        ],
        [
          _minute(
            minute: 0,
            day: 2,
            metrics: _metrics(dwellSampleCount: 2, dwellSumSeconds: 9, dwellHistogram: const [0, 1, 1, 0, 0, 0, 0, 0]),
          ),
        ],
      ]);

      final metrics = profile.single.areas.single;
      expect(metrics.dwellSampleCount, 2);
      expect(metrics.dwellHistogram, [1, 1, 0, 0, 0, 0, 0, 0]);
      expect(metrics.dwellHistogram.reduce((sum, count) => sum + count), metrics.dwellSampleCount.toDouble());
    });

    test('averages event counts across profiles', () {
      final profile = rollup.averageFiveMinuteProfiles([
        [_minute(minute: 0, metrics: _metrics(passBy: 4))],
        [_minute(minute: 0, day: 2, metrics: _metrics(passBy: 8))],
      ]);

      expect(profile.single.areas.single.passBy, 6);
    });

    test('rejects invalid histogram totals and accepts empty zero-sample histograms', () {
      final zeroSampleProfile = rollup.averageFiveMinuteProfiles([
        [_minute(minute: 0, metrics: _metrics())],
      ]);
      expect(zeroSampleProfile.single.areas.single.dwellHistogram, [0, 0, 0, 0, 0, 0, 0, 0]);

      expect(
        () => rollup.averageFiveMinuteProfiles([
          [
            _minute(minute: 0, metrics: _metrics(dwellSampleCount: 1, dwellHistogram: const [0, 0, 0, 0, 0, 0, 0, 0])),
          ],
        ]),
        throwsArgumentError,
      );
    });

    test('rejects duplicate time slots within one profile', () {
      final observation = _minute(minute: 0, metrics: _metrics());

      expect(
        () => rollup.averageFiveMinuteProfiles([
          [observation, observation],
        ]),
        throwsArgumentError,
      );
    });

    test('omits a slot that is absent from every source profile', () {
      expect(rollup.averageFiveMinuteProfiles([[], []]), isEmpty);
    });

    test('rejects an empty dwell histogram', () {
      expect(
        () => rollup.aggregate([
          _minute(minute: 0, metrics: _metrics(dwellHistogram: const [])),
        ], granularity: ObservationGranularity.hour),
        throwsArgumentError,
      );
    });
  });
}
