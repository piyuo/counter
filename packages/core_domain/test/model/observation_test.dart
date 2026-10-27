// TOC
// 1. Observation derived date/time getters

import 'package:core_domain/model/activity.dart';
import 'package:core_domain/model/activity_payload.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_granularity.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation({
  required int year,
  ObservationGranularity granularity = ObservationGranularity.minutes5,
  int month = 1,
  int day = 1,
  int hour = 0,
  int minute = 0,
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
    coveredSeconds: 0,
    areas: const [],
    frameCount: 0,
  );
}

const _baseAreaMetrics = Activity(
  areaId: 1,
  areaName: 'a',
  occupancySampleCount: 0,
  occupancySum: 0,
  occupancySumSquares: 0,
  occupancyMax: 0,
  occupancyLast: 0,
  dwellSampleCount: 0,
  dwellSumSeconds: 0,
  dwellMaxSeconds: 0,
);

void main() {
  group('Observation derived metrics', () {
    test('identifies weekends from the business-local date and payload', () {
      final friday = _observation(year: 2026, month: 8, day: 28);
      final saturday = _observation(year: 2026, month: 8, day: 29);
      final sunday = _observation(year: 2026, month: 8, day: 30);

      expect(friday.isWeekend, isFalse);
      expect(saturday.isWeekend, isTrue);
      expect(sunday.isWeekend, isTrue);
      expect(saturday.toPayload().isWeekend, isTrue);
      expect(sunday.toPayload().isWeekend, isTrue);
    });

    test('derives expected seconds from granularity and calendar date', () {
      expect(_observation(year: 2024, granularity: ObservationGranularity.minutes5).expectedSeconds, 300);
      expect(_observation(year: 2024, granularity: ObservationGranularity.hour).expectedSeconds, 3600);
      expect(_observation(year: 2024, granularity: ObservationGranularity.day).expectedSeconds, 86400);
      expect(_observation(year: 2024, month: 2, granularity: ObservationGranularity.month).expectedSeconds, 29 * 86400);
      expect(_observation(year: 2024, granularity: ObservationGranularity.year).expectedSeconds, 366 * 86400);
    });

    test('derives confidence and coverage from sums and counts without serializing them', () {
      const observation = Observation(
        granularity: ObservationGranularity.minutes5,
        year: 2026,
        month: 1,
        day: 1,
        hour: 10,
        minute: 0,
        confidenceSum: 2.25375,
        confidenceSampleCount: 3,
        coveredSeconds: 225,
        areas: [],
        frameCount: 12,
      );

      expect(observation.confidenceSum, 2.25375);
      expect(observation.confidenceRatio, closeTo(0.75125, 1e-12));
      expect(observation.coverageRatio, 0.75);
      expect(observation.id, 202601011000);
      expect(observation.businessDate, '2026-01-01');

      final json = observation.toJson();
      expect(json.containsKey('confidenceRatio'), isFalse);
      expect(json.containsKey('coverageRatio'), isFalse);
    });

    test('derives occupancy and dwell averages from stored totals', () {
      const metrics = Activity(
        areaId: 1,
        areaName: 'Area 1',
        occupancySampleCount: 2,
        occupancySum: 5,
        occupancySumSquares: 13,
        occupancyMax: 4,
        occupancyLast: 4,
        dwellSumSeconds: 7,
        dwellSampleCount: 2,
        dwellMaxSeconds: 4,
      );

      expect(metrics.occupancyMean, 2.5);
      expect(metrics.occupancyLast, 4);
      expect(metrics.dwellMeanSeconds, 3.5);
      expect(metrics.dwellHistogram, [0, 0, 0, 0, 0, 0, 0, 0]);
      expect(metrics.presenceSampleCount, 0);
      expect(metrics.presenceSumSeconds, 0);
      expect(metrics.presenceMeanSeconds, 0);
    });

    test('converts area metrics to a payload with derived means', () {
      const metrics = Activity(
        areaId: 2,
        areaName: 'Lobby',
        passBy: 1,
        stagnant: 2,
        entry: 3,
        exit: 4,
        appear: 5,
        disappear: 6,
        occupancySampleCount: 2,
        occupancySum: 5,
        occupancySumSquares: 13,
        occupancyMax: 4,
        occupancyLast: 3,
        dwellSampleCount: 2,
        dwellSumSeconds: 7,
        dwellMaxSeconds: 5,
        presenceSampleCount: 2,
        presenceSumSeconds: 9,
      );

      final payload = metrics.toPayload();

      expect(payload.areaId, 2);
      expect(payload.areaName, 'Lobby');
      expect(payload.passBy, 1);
      expect(payload.stagnant, 2);
      expect(payload.entry, 3);
      expect(payload.exit, 4);
      expect(payload.appear, 5);
      expect(payload.disappear, 6);
      expect(payload.occupancyMean, 2.5);
      expect(payload.occupancyVariance, 0.25);
      expect(payload.dwellMeanSeconds, 3.5);
      expect(payload.presenceMeanSeconds, 4.5);
    });

    test('converts observations to payloads with converted area metrics', () {
      const observation = Observation(
        granularity: ObservationGranularity.hour,
        year: 2026,
        month: 8,
        day: 26,
        hour: 11,
        minute: -1,
        confidenceSum: 1.5,
        confidenceSampleCount: 2,
        coveredSeconds: 1800,
        areas: [Activity(areaId: 0, areaName: 'Global', occupancySampleCount: 1, occupancySum: 3)],
        frameCount: 10,
      );

      final payload = observation.toPayload();

      expect(payload.granularity, 'hour');
      expect(payload.businessDate, '2026-08-26');
      expect(payload.confidenceRatio, 0.75);
      expect(payload.expectedSeconds, 3600);
      expect(payload.coverageRatio, 0.5);
      expect(payload.areas.single, isA<ActivityPayload>());
      expect(payload.areas.single.occupancyMean, 3);
      expect(payload.frameCount, 10);
    });

    test('reads sums and counts from JSON and derives convenience metrics', () {
      final observation = Observation.fromJson({
        'granularity': 'minutes5',
        'year': 2026,
        'month': 1,
        'day': 1,
        'hour': 10,
        'minute': 0,
        'confidenceSum': 2.25625,
        'confidenceSampleCount': 3,
        'coveredSeconds': 225,
        'expectedSeconds': 300,
        'areas': [
          {
            'areaId': 1,
            'areaName': 'Area 1',
            'stagnant': 2,
            'occupancySampleCount': 2,
            'occupancySum': 5,
            'occupancySumSquares': 13,
            'occupancyMax': 3,
            'occupancyLast': 4,
            'dwellSumSeconds': 7,
            'dwellSampleCount': 2,
            'dwellMaxSeconds': 4.5,
          },
        ],
        'frameCount': 12,
      });

      final metrics = observation.areas.single;
      expect(observation.year, 2026);
      expect(observation.month, 1);
      expect(observation.day, 1);
      expect(observation.hour, 10);
      expect(observation.minute, 0);
      expect(observation.confidenceSum, 2.25625);
      expect(observation.confidenceRatio, closeTo(0.752083333333, 1e-12));
      expect(observation.coverageRatio, 0.75);
      expect(metrics.stagnant, 2);
      expect(metrics.occupancySumSquares, 13);
      expect(metrics.occupancyMean, 2.5);
      expect(metrics.dwellMeanSeconds, 3.5);
      expect(metrics.dwellMaxSeconds, 4);
    });

    test('default dwell histogram length matches the bucket count', () {
      expect(_baseAreaMetrics.dwellHistogram.length, kDwellBucketCount);
    });

    test('JSON round trip keeps dwell and presence fields', () {
      final metrics = _baseAreaMetrics.copyWith(
        dwellHistogram: [1, 2, 3, 4, 5, 6, 7, 8],
        presenceSampleCount: 2,
        presenceSumSeconds: 90,
      );
      expect(Activity.fromJson(metrics.toJson()), metrics);
    });

    test('keeps event counts and derives occupancy, dwell, and presence means', () {
      const metrics = Activity(
        areaId: 1,
        areaName: 'Area 1',
        passBy: 3,
        stagnant: 5,
        entry: 7,
        exit: 9,
        appear: 11,
        disappear: 13,
        occupancySampleCount: 2,
        occupancySum: 5,
        occupancySumSquares: 13,
        dwellSampleCount: 2,
        dwellSumSeconds: 7,
        presenceSampleCount: 2,
        presenceSumSeconds: 9,
        dwellHistogram: [0, 1, 2, 3, 4, 5, 6, 7],
      );

      expect(metrics.passBy, 3);
      expect(metrics.stagnant, 5);
      expect(metrics.entry, 7);
      expect(metrics.exit, 9);
      expect(metrics.appear, 11);
      expect(metrics.disappear, 13);
      expect(metrics.occupancyMean, 2.5);
      expect(metrics.dwellMeanSeconds, 3.5);
      expect(metrics.presenceMeanSeconds, 4.5);

      final json = metrics.toJson();
      for (final derivedField in ['occupancyMean', 'dwellMeanSeconds', 'presenceMeanSeconds']) {
        expect(json, isNot(contains(derivedField)));
      }
      expect(json['passBy'], 3);
      expect(json['dwellHistogram'], [0, 1, 2, 3, 4, 5, 6, 7]);
      expect((json['dwellHistogram'] as List).every((value) => value is int), isTrue);
    });

    test('JSON round trip preserves the latest occupancy sample', () {
      final metrics = _baseAreaMetrics.copyWith(occupancyLast: 4);

      expect(metrics.occupancyLast, 4);
      expect(Activity.fromJson(metrics.toJson()).occupancyLast, 4);
    });

    test('legacy nullable occupancy snapshot defaults to zero', () {
      final legacyJson = _baseAreaMetrics.toJson()..['occupancyLast'] = null;

      expect(Activity.fromJson(legacyJson).occupancyLast, 0);
      expect(Activity.fromJson(legacyJson).occupancySampleCount, 0);
    });

    test('presence sum serializes as integer seconds', () {
      final metrics = _baseAreaMetrics.copyWith(presenceSumSeconds: 1);
      final json = metrics.toJson();

      expect(json['presenceSumSeconds'], 1);
      expect(json['presenceSumSeconds'], isA<int>());
      expect(Activity.fromJson(json).presenceSumSeconds, 1);
    });

    test('legacy JSON defaults absent presence and histogram fields', () {
      final legacyJson = _baseAreaMetrics.toJson()
        ..remove('presenceTrackCount')
        ..remove('presenceSumSeconds')
        ..remove('presenceMeanSeconds')
        ..remove('dwellHistogram');
      final legacy = Activity.fromJson(legacyJson);
      expect(legacy.presenceSampleCount, 0);
      expect(legacy.presenceSumSeconds, 0);
      expect(legacy.presenceMeanSeconds, 0);
      expect(legacy.dwellHistogram, [0, 0, 0, 0, 0, 0, 0, 0]);
    });
  });
  group('Observation.id', () {
    test('pads short date and time components', () {
      final observation = _observation(year: 2026, month: 1, day: 2, hour: 3, minute: 5);

      expect(observation.id, 202601020305);
    });

    test('encodes components set to -1 as zeroes at each aggregation level', () {
      expect(_observation(year: 2026, month: 6, day: 24, hour: 23, minute: -1).id, 202606242300);
      expect(_observation(year: 2026, month: 6, day: 24, hour: -1, minute: -1).id, 202606240000);
      expect(_observation(year: 2026, month: 6, day: -1, hour: -1, minute: -1).id, 202606000000);
      expect(_observation(year: 2026, month: -1, day: -1, hour: -1, minute: -1).id, 202600000000);
    });
  });

  group('Observation date/time keys', () {
    test('builds date, time, and date-hour keys with padded components', () {
      final observation = _observation(year: 2026, month: 6, day: 4, hour: 13, minute: 5);

      expect(observation.dateKey, 20260604);
      expect(observation.timeKey, 1305);
      expect(observation.dateHourKey, 2026060413);
    });

    test('serializes granularity and defaults missing values to minutes5', () {
      final observation = _observation(year: 2026);
      final json = observation.toJson();

      expect(observation.granularity, ObservationGranularity.minutes5);
      expect(json['granularity'], 'minutes5');
      expect(Observation.fromJson({...json}..remove('granularity')).granularity, ObservationGranularity.minutes5);
    });

    test('encodes unavailable components as zeroes', () {
      final day = _observation(
        year: 2026,
        granularity: ObservationGranularity.day,
        month: 6,
        day: 4,
        hour: -1,
        minute: -1,
      );
      final year = _observation(
        year: 2026,
        granularity: ObservationGranularity.year,
        month: -1,
        day: -1,
        hour: -1,
        minute: -1,
      );

      expect(day.dateKey, 20260604);
      expect(day.timeKey, 0);
      expect(day.dateHourKey, 2026060400);
      expect(year.dateKey, 20260000);
      expect(year.dateHourKey, 2026000000);
    });
  });

  test('AreaMetrics serializes its event count as stagnant', () {
    const metrics = Activity(
      areaId: 0,
      areaName: 'Global',
      stagnant: 3,
      occupancySampleCount: 0,
      occupancySum: 0,
      occupancySumSquares: 0,
      occupancyMax: 0,
      occupancyLast: 0,
      dwellSumSeconds: 0,
      dwellSampleCount: 0,
      dwellMaxSeconds: 0,
    );
    final json = metrics.toJson();

    expect(metrics.stagnant, 3);
    expect(json['stagnant'], 3);
    expect(json.containsKey('stagnantSampleCount'), isFalse);
    expect(json.containsKey('stagnantSum'), isFalse);
    expect(json.containsKey('dwell'), isFalse);
    expect(Activity.fromJson(json).stagnant, 3);
  });

  test('dateTime represents the observation local date and time', () {
    final observation = _observation(year: 2026, month: 6, day: 24, hour: 23, minute: 5);

    expect(observation.dateTime, DateTime(2026, 6, 24, 23, 5));
  });

  test('businessDate zero-pads month and day', () {
    final observation = _observation(year: 2026, month: 1, day: 3);

    expect(observation.businessDate, '2026-01-03');
  });

  test('businessDateTime formats each observation granularity', () {
    final observations = [
      (_observation(year: 2026, month: 1, day: 3, hour: 4, minute: 5), '2026-01-03 04:05'),
      (
        _observation(year: 2026, month: 1, day: 3, hour: 4, minute: -1, granularity: ObservationGranularity.hour),
        '2026-01-03 04:00',
      ),
      (
        _observation(year: 2026, month: 1, day: 3, hour: -1, minute: -1, granularity: ObservationGranularity.day),
        '2026-01-03 00:00',
      ),
      (
        _observation(year: 2026, month: 1, day: -1, hour: -1, minute: -1, granularity: ObservationGranularity.month),
        '2026-01',
      ),
      (
        _observation(year: 2026, month: -1, day: -1, hour: -1, minute: -1, granularity: ObservationGranularity.year),
        '2026',
      ),
    ];

    for (final (observation, expected) in observations) {
      expect(observation.businessDateTime, expected);
    }
  });
}
