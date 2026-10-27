// TOC
// 1. ObservationSeries construction

import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_granularity.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:core_domain/model/observation_time_query.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation({required int hour, required int minute, required int frameCount}) {
  return Observation(
    granularity: ObservationGranularity.minutes5,
    year: 2026,
    month: 1,
    day: 1,
    hour: hour,
    minute: minute,
    areas: const [],
    frameCount: frameCount,
  );
}

void main() {
  group('ObservationSeries construction', () {
    test('sorts by clock time and keeps the first observation in a duplicate slot', () {
      final firstAtTen = _observation(hour: 10, minute: 5, frameCount: 1);
      final duplicateAtTen = _observation(hour: 10, minute: 5, frameCount: 2);
      final atNine = _observation(hour: 9, minute: 55, frameCount: 3);

      final series = ObservationSeries.fromObservations([firstAtTen, atNine, duplicateAtTen]);

      expect(series.items, [atNine, firstAtTen]);
      expect(series.at(10, 5)?.frameCount, 1);
    });

    test('supports direct iteration in clock order', () {
      final atTen = _observation(hour: 10, minute: 5, frameCount: 1);
      final atNine = _observation(hour: 9, minute: 55, frameCount: 2);
      final series = ObservationSeries.fromObservations([atTen, atNine]);

      final iterated = [for (final observation in series) observation];

      expect(iterated, [atNine, atTen]);
    });
  });

  group('ObservationSeries.find', () {
    test('includes both endpoints of a time range', () {
      final before = _observation(hour: 9, minute: 55, frameCount: 1);
      final from = _observation(hour: 10, minute: 0, frameCount: 2);
      final within = _observation(hour: 10, minute: 5, frameCount: 3);
      final to = _observation(hour: 10, minute: 10, frameCount: 4);
      final after = _observation(hour: 10, minute: 15, frameCount: 5);
      final series = ObservationSeries.fromObservations([before, from, within, to, after]);

      final result = series.find(
        ObservationTimeQuery(
          from: ObservationTimeFilter(hour: 10, minute: 0),
          to: ObservationTimeFilter(hour: 10, minute: 10),
        ),
      );

      expect(result, [from, within, to]);
    });

    test('wraps across midnight and returns results in clock order', () {
      final before = _observation(hour: 22, minute: 55, frameCount: 1);
      final from = _observation(hour: 23, minute: 0, frameCount: 2);
      final midnight = _observation(hour: 0, minute: 0, frameCount: 3);
      final to = _observation(hour: 1, minute: 0, frameCount: 4);
      final after = _observation(hour: 1, minute: 5, frameCount: 5);
      final series = ObservationSeries.fromObservations([before, from, midnight, to, after]);

      final result = series.find(
        ObservationTimeQuery(
          from: ObservationTimeFilter(hour: 23, minute: 0),
          to: ObservationTimeFilter(hour: 1, minute: 0),
        ),
      );

      expect(result, [midnight, to, from]);
    });
  });
}
