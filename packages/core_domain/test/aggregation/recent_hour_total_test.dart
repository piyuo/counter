import 'package:core_domain/aggregation/recent_hour_total.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_granularity.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation(
  int hour,
  int minute, {
  int frameCount = 1,
  int coveredSeconds = 0,
}) => Observation(
  granularity: ObservationGranularity.minutes5,
  year: 2026,
  month: 1,
  day: 1,
  hour: hour,
  minute: minute,
  coveredSeconds: coveredSeconds,
  frameCount: frameCount,
  areas: const [],
);

void main() {
  group('getRecentHourTotalAt', () {
    test(
      'rounds up to the current five-minute boundary and clamps to the day',
      () {
        final series = ObservationSeries.fromObservations([
          _observation(0, 0, frameCount: 2),
          _observation(0, 5, frameCount: 4),
          _observation(0, 10, frameCount: 7),
        ]);

        final result = getRecentHourTotalAt(0, 6, series);

        expect(result?.frameCount, 6); // 00:00 (2 frames) + 00:05 (4 frames)
        expect(result?.coveredSeconds, 0);
      },
    );

    test('includes the current slot when time is exactly on a boundary', () {
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

    test('includes the 12 slots from 13:25 through 14:20 at 14:23', () {
      final series = ObservationSeries.fromObservations([
        _observation(13, 20, frameCount: 100),
        for (var index = 0; index < 12; index++)
          _observation(
            DateTime(2026, 1, 1, 13, 25).add(Duration(minutes: index * 5)).hour,
            DateTime(
              2026,
              1,
              1,
              13,
              25,
            ).add(Duration(minutes: index * 5)).minute,
          ),
        _observation(14, 25, frameCount: 100),
      ]);

      final result = getRecentHourTotalAt(14, 23, series);

      expect(result?.frameCount, 12);
    });

    test('sums full and partial covered seconds', () {
      final series = ObservationSeries.fromObservations([
        _observation(13, 25, coveredSeconds: 300),
        _observation(13, 30, coveredSeconds: 120),
      ]);

      final result = getRecentHourTotalAt(14, 23, series);

      expect(result?.coveredSeconds, 420);
    });

    test('accepts missing slots when the available observations span less than 55 minutes', () {
      final series = ObservationSeries.fromObservations([
        _observation(13, 40, frameCount: 2),
        _observation(13, 50, frameCount: 3),
        _observation(14, 20, frameCount: 5),
      ]);

      final result = getRecentHourTotalAt(14, 23, series);

      expect(result?.frameCount, 10);
    });

    test('uses the latest source slot timestamp', () {
      final series = ObservationSeries.fromObservations([
        _observation(13, 55),
        _observation(14, 0),
        _observation(14, 20),
      ]);

      final result = getRecentHourTotalAt(14, 23, series);

      expect(result?.hour, 14);
      expect(result?.minute, 20);
    });

    test('returns null when no observations are in the window', () {
      final series = ObservationSeries.fromObservations([
        _observation(10, 0),
        _observation(10, 5),
      ]);

      final result = getRecentHourTotalAt(14, 23, series);

      expect(result, isNull);
    });

    test(
      'does not wrap around midnight into observations from the same day',
      () {
        final series = ObservationSeries.fromObservations([
          for (var index = 0; index < 12; index++) _observation(23, index * 5),
          _observation(0, 0),
          _observation(0, 5),
        ]);

        final result = getRecentHourTotalAt(0, 6, series);

        expect(result?.frameCount, 2);
        expect(result?.granularity, ObservationGranularity.hour);
        expect(result?.hour, 0);
      },
    );
  });
}
