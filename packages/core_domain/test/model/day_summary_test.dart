// TOC
// 1. DaySummary observation query tests

import 'package:core_domain/model/day_summary.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_granularity.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:core_domain/model/observation_time_query.dart';
import 'package:flutter_test/flutter_test.dart';

Observation _observation(int hour, int minute) =>
    Observation(year: 2026, month: 1, day: 1, hour: hour, minute: minute, areas: const [], frameCount: 0);

Observation _observationAt(DateTime time, {int frameCount = 1, int coveredSeconds = 300}) => Observation(
  granularity: ObservationGranularity.minutes5,
  year: time.year,
  month: time.month,
  day: time.day,
  hour: time.hour,
  minute: time.minute,
  coveredSeconds: coveredSeconds,
  areas: const [],
  frameCount: frameCount,
);

DaySummary _summary(List<Observation> observations) => DaySummary(
  year: 2026,
  month: 1,
  day: 1,
  fiveMinuteObservations: ObservationSeries.fromObservations(observations),
  hourlyTotals: const [],
  dailyTotal: _observation(-1, -1),
);

void main() {
  group('ObservationSeries.find', () {
    test('includes both endpoints and preserves observation order', () {
      final before = _observation(9, 55);
      final from = _observation(10, 0);
      final within = _observation(10, 5);
      final to = _observation(10, 10);
      final after = _observation(10, 15);
      final summary = _summary([before, from, within, to, after]);

      final result = summary.fiveMinuteObservations.find(
        ObservationTimeQuery(
          from: ObservationTimeFilter(hour: 10, minute: 0),
          to: ObservationTimeFilter(hour: 10, minute: 10),
        ),
      );

      expect(result, [from, within, to]);
    });

    test('matches ranges that cross midnight', () {
      final before = _observation(22, 55);
      final from = _observation(23, 0);
      final midnight = _observation(0, 0);
      final to = _observation(1, 0);
      final after = _observation(1, 5);
      final summary = _summary([before, from, midnight, to, after]);

      final result = summary.fiveMinuteObservations.find(
        ObservationTimeQuery(
          from: ObservationTimeFilter(hour: 23, minute: 0),
          to: ObservationTimeFilter(hour: 1, minute: 0),
        ),
      );

      expect(result, [midnight, to, from]);
    });
  });

  group('DaySummary.fiveMinuteObservations', () {
    test('supports direct iteration in clock order', () {
      final atTen = _observation(10, 5);
      final atNine = _observation(9, 55);
      final summary = _summary([atTen, atNine]);

      final iterated = [for (final observation in summary.fiveMinuteObservations) observation];

      expect(iterated, [atNine, atTen]);
    });
  });
}
