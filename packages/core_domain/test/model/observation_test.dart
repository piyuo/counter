// TOC
// 1. Observation derived date/time getters

import 'package:core_domain/model/observation.dart';
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
    confidenceRatioSum: 0,
    confidenceSampleCount: 0,
    confidenceRatio: 0,
    coveredSeconds: 0,
    expectedSeconds: 0,
    coverageRatio: 0,
    areas: const [],
    frameCount: 0,
  );
}

void main() {
  group('Observation derived metrics', () {
    test('stores confidence and coverage derived from sums and counts', () {
      const observation = Observation(
        granularity: ObservationGranularity.minutes5,
        year: 2026,
        month: 1,
        day: 1,
        hour: 10,
        minute: 0,
        confidenceRatioSum: 2.25375,
        confidenceSampleCount: 3,
        confidenceRatio: 0.75125,
        coveredSeconds: 225,
        expectedSeconds: 300,
        coverageRatio: 0.75,
        areas: [],
        frameCount: 12,
      );

      expect(observation.confidenceRatioSum, 2.25375);
      expect(observation.confidenceRatio, 0.75125);
      expect(observation.coverageRatio, 0.75);
      expect(observation.id, 202601011000);
      expect(observation.businessDate, '2026-01-01');
    });

    test('derives occupancy and dwell averages from stored totals', () {
      const metrics = AreaMetrics(
        areaId: 1,
        areaName: 'Area 1',
        passBy: 0,
        stagnant: 0,
        entry: 0,
        exit: 0,
        appear: 0,
        disappear: 0,
        occupancySampleCount: 2,
        occupancySampleSum: 5,
        occupancyAvg: 2.5,
        occupancyMax: 4,
        occupancyLast: 4,
        dwellSumSeconds: 7,
        dwellSampleCount: 2,
        dwellAvgSeconds: 3.5,
        dwellMaxSeconds: 4,
      );

      expect(metrics.occupancyAvg, 2.5);
      expect(metrics.occupancyLast, 4);
      expect(metrics.dwellAvgSeconds, 3.5);
    });

    test('toString includes every stored observation and area field', () {
      const area = AreaMetrics(
        areaId: 2,
        areaName: 'Lobby',
        passBy: 3,
        stagnant: 4,
        entry: 5,
        exit: 6,
        appear: 7,
        disappear: 8,
        occupancySampleCount: 9,
        occupancySampleSum: 10,
        occupancyAvg: 1.2345,
        occupancyMax: 11,
        occupancyLast: 12,
        dwellSumSeconds: 13,
        dwellSampleCount: 14,
        dwellAvgSeconds: 2.3456,
        dwellMaxSeconds: 15,
      );
      const observation = Observation(
        granularity: ObservationGranularity.minutes5,
        year: 2026,
        month: 1,
        day: 2,
        hour: 3,
        minute: 4,
        confidenceRatioSum: 0.123456,
        confidenceSampleCount: 16,
        confidenceRatio: 0.234567,
        coveredSeconds: 17,
        expectedSeconds: 18,
        coverageRatio: 0.345678,
        areas: [area],
        frameCount: 19,
      );

      final observationString = observation.toString();
      for (final field in [
        'granularity: minutes5',
        'year: 2026',
        'month: 1',
        'day: 2',
        'hour: 3',
        'minute: 4',
        'frameCount: 19',
        'confidenceRatioSum: 0.12',
        'confidenceSampleCount: 16',
        'confidenceRatio: 0.23',
        'expectedSeconds: 18',
        'coveredSeconds: 17',
        'coverageRatio: 0.35',
      ]) {
        expect(observationString, contains(field));
      }
      expect(observationString, contains('areas: [$area]'));

      final areaString = area.toString();
      for (final field in [
        'areaId: 2',
        'areaName: Lobby',
        'passBy: 3',
        'stagnant: 4',
        'entry: 5',
        'exit: 6',
        'appear: 7',
        'disappear: 8',
        'occupancySampleCount: 9',
        'occupancySampleSum: 10',
        'occupancyAvg: 1.23',
        'occupancyMax: 11',
        'occupancyLast: 12',
        'dwellSumSeconds: 13',
        'dwellSampleCount: 14',
        'dwellAvgSeconds: 2.35',
        'dwellMaxSeconds: 15',
      ]) {
        expect(areaString, contains(field));
      }
    });

    test('reads component-based JSON and preserves convenience metrics', () {
      final observation = Observation.fromJson({
        'granularity': 'minutes5',
        'year': 2026,
        'month': 1,
        'day': 1,
        'hour': 10,
        'minute': 0,
        'confidenceRatioSum': 2.25625,
        'confidenceSampleCount': 3,
        'confidenceRatio': 0.752083333333,
        'coveredSeconds': 225,
        'expectedSeconds': 300,
        'coverageRatio': 0.75,
        'areas': [
          {
            'areaId': 1,
            'areaName': 'Area 1',
            'passBy': 0,
            'stagnant': 2,
            'entry': 0,
            'exit': 0,
            'appear': 0,
            'disappear': 0,
            'occupancySampleCount': 2,
            'occupancySampleSum': 5,
            'occupancyAvg': 2.5,
            'occupancyMax': 3,
            'occupancyLast': 4,
            'dwellSumSeconds': 7,
            'dwellSampleCount': 2,
            'dwellAvgSeconds': 3.5,
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
      expect(observation.confidenceRatioSum, 2.25625);
      expect(observation.confidenceRatio, 0.752083333333);
      expect(observation.coverageRatio, 0.75);
      expect(metrics.stagnant, 2);
      expect(metrics.occupancyAvg, 2.5);
      expect(metrics.dwellAvgSeconds, 3.5);
      expect(metrics.dwellMaxSeconds, 4);
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
    const metrics = AreaMetrics(
      areaId: 0,
      areaName: 'Global',
      passBy: 0,
      stagnant: 3,
      entry: 0,
      exit: 0,
      appear: 0,
      disappear: 0,
      occupancySampleCount: 0,
      occupancySampleSum: 0,
      occupancyAvg: 0,
      occupancyMax: 0,
      occupancyLast: 0,
      dwellSumSeconds: 0,
      dwellSampleCount: 0,
      dwellAvgSeconds: 0,
      dwellMaxSeconds: 0,
    );
    final json = metrics.toJson();

    expect(metrics.stagnant, 3);
    expect(json['stagnant'], 3);
    expect(json.containsKey('dwell'), isFalse);
    expect(AreaMetrics.fromJson(json).stagnant, 3);
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
