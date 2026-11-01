// TOC
// 1. Recent-hour aggregation tests

import 'package:core_domain/aggregation/recent_hour_total.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_granularity.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation(int hour, int minute, {int frameCount = 1}) => Observation(
  granularity: ObservationGranularity.minutes5,
  year: 2026,
  month: 1,
  day: 1,
  hour: hour,
  minute: minute,
  frameCount: frameCount,
  areas: const [],
);

void main() {
  group('getRecentHourTotalAt', () {
    test('rounds up to the current five-minute boundary and clamps to the day', () {
      final series = ObservationSeries.fromObservations([
        _observation(0, 0, frameCount: 2),
        _observation(0, 5, frameCount: 4),
        _observation(0, 10, frameCount: 7),
      ]);

      final result = getRecentHourTotalAt(0, 6, series);

      expect(result?.frameCount, 6); // 00:00 (2 frames) + 00:05 (4 frames)
      expect(result?.coveredSeconds, 0);
    });

    test('advances to the next slot when the time is exactly on a boundary', () {
      final start = DateTime(2026, 1, 1, 10, 35);
      final series = ObservationSeries.fromObservations([
        for (var index = 0; index < 13; index++)
          _observation(
            start.add(Duration(minutes: index * 5)).hour,
            start.add(Duration(minutes: index * 5)).minute,
            frameCount: 1 << index,
          ),
      ]);

      final result = getRecentHourTotalAt(11, 35, series);

      expect(result?.frameCount, 8190);
    });

    test('does not wrap around midnight into observations from the same day', () {
      final series = ObservationSeries.fromObservations([
        for (var index = 0; index < 12; index++) _observation(23, index * 5),
        _observation(0, 0),
        _observation(0, 5),
      ]);

      final result = getRecentHourTotalAt(0, 6, series);

      expect(result?.frameCount, 2);
      expect(result?.granularity, ObservationGranularity.hour);
      expect(result?.hour, 0);
    });
  });
}
