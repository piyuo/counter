import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:core_runtime/insight/observation_series_helpers.dart';
import 'package:flutter_test/flutter_test.dart';

core_domain.Observation _observation(DateTime date, int hour, int minute) =>
    core_domain.Observation(
      year: date.year,
      month: date.month,
      day: date.day,
      hour: hour,
      minute: minute,
      areas: const [],
      frameCount: 1,
      coveredSeconds: 300,
    );

ObservationSeries _series(DateTime date, List<(int, int)> times) =>
    ObservationSeries.fromObservations([
      for (final (hour, minute) in times) _observation(date, hour, minute),
    ]);

List<int> _slotKeys(ObservationSeries series) =>
    series.map((observation) => observation.slotKey).toList();

void main() {
  final date = DateTime(2026, 10, 26);

  test('sliceRange uses an inclusive start and exclusive end', () {
    final series = _series(date, [(12, 55), (13, 0), (13, 55), (14, 0)]);

    final result = sliceRange(series, 13, 0, 14, 0);

    expect(_slotKeys(result), [13 * 60, 13 * 60 + 55]);
  });

  test('sliceRange includes the final slot when the range ends at 24:00', () {
    final series = _series(date, [(0, 0), (12, 0), (23, 55)]);

    final result = sliceRange(series, 0, 0, 24, 0);

    expect(_slotKeys(result), [0, 12 * 60, 23 * 60 + 55]);
  });

  test('sliceRange rejects 24:xx end times', () {
    expect(
      () => sliceRange(ObservationSeries.empty, 0, 0, 24, 5),
      throwsArgumentError,
    );
  });

  test('sliceRecentHour uses inclusive and exclusive slot boundaries', () {
    final series = _series(date, [(12, 0), (12, 5), (13, 0), (13, 5)]);

    final result = sliceRecentHour(series, 13, 4);

    expect(_slotKeys(result), [12 * 60 + 5, 13 * 60]);
  });

  test('sliceRecentHour rejects invalid times', () {
    expect(
      () => sliceRecentHour(ObservationSeries.empty, 24, 0),
      throwsRangeError,
    );
    expect(
      () => sliceRecentHour(ObservationSeries.empty, 13, 60),
      throwsRangeError,
    );
  });

  test('fillSlots inserts date-stamped missing placeholders', () {
    final series = _series(date, [(11, 0)]);

    final result = fillSlots(series, date, 11 * 60, 11 * 60 + 15);

    expect(_slotKeys(result), [11 * 60, 11 * 60 + 5, 11 * 60 + 10]);
    expect(result.at(11, 0)?.isMissing, isFalse);
    expect(result.at(11, 5)?.isMissing, isTrue);
    expect(result.at(11, 5)?.year, date.year);
    expect(result.at(11, 5)?.month, date.month);
    expect(result.at(11, 5)?.day, date.day);
  });

  test('fillSlots preserves existing observations and their metrics', () {
    final observation = core_domain.Observation(
      year: date.year,
      month: date.month,
      day: date.day,
      hour: 11,
      minute: 5,
      areas: const [],
      frameCount: 17,
      coveredSeconds: 120,
    );
    final series = ObservationSeries.fromObservations([observation]);

    final result = fillSlots(series, date, 11 * 60 + 5, 11 * 60 + 15);

    expect(result.at(11, 5), same(observation));
    expect(result.at(11, 5)?.frameCount, 17);
    expect(result.at(11, 5)?.coveredSeconds, 120);
    expect(result.at(11, 10)?.isMissing, isTrue);
  });

  test('fillSlots fills an empty series in chronological order', () {
    final result = fillSlots(ObservationSeries.empty, date, 10, 25);

    expect(_slotKeys(result), [10, 15, 20]);
    expect(result.every((observation) => observation.isMissing), isTrue);
  });

  test(
    'fillSlots accepts 24:00 as an exclusive end without creating hour 24',
    () {
      final result = fillSlots(
        ObservationSeries.empty,
        date,
        23 * 60 + 55,
        1440,
      );

      expect(_slotKeys(result), [23 * 60 + 55]);
      expect(result.single.hour, 23);
      expect(result.single.minute, 55);
    },
  );

  test('fillSlots rejects invalid ranges', () {
    expect(
      () => fillSlots(ObservationSeries.empty, date, -5, 0),
      throwsRangeError,
    );
    expect(
      () => fillSlots(ObservationSeries.empty, date, 0, 1445),
      throwsRangeError,
    );
    expect(
      () => fillSlots(ObservationSeries.empty, date, 1, 5),
      throwsArgumentError,
    );
    expect(
      () => fillSlots(ObservationSeries.empty, date, 10, 5),
      throwsArgumentError,
    );
  });

  test('fillSlots rejects observations from another business date', () {
    final yesterday = DateTime(2026, 10, 25);
    final series = _series(yesterday, [(13, 5)]);

    expect(
      () => fillSlots(series, date, 13 * 60, 13 * 60 + 10),
      throwsArgumentError,
    );
  });

  test(
    'fillToday fills completed slots but excludes the current and future slots',
    () {
      final series = _series(date, [(0, 0), (0, 10), (0, 15), (0, 20)]);

      final result = fillToday(series, DateTime(2026, 10, 26, 0, 17));

      expect(_slotKeys(result), [0, 5, 10]);
      expect(result.at(0, 5)?.isMissing, isTrue);
      expect(result.at(0, 15), isNull);
    },
  );

  test('fillToday contains only completed slots at the end of the day', () {
    final result = fillToday(
      ObservationSeries.empty,
      DateTime(2026, 10, 26, 23, 59),
    );

    expect(result, hasLength(287));
    expect(_slotKeys(result).last, 23 * 60 + 50);
  });

  test('fillHour excludes the current and future slots', () {
    final series = _series(date, [(13, 15), (13, 50), (13, 55), (14, 0)]);

    final result = fillHour(series, DateTime(2026, 10, 26, 13, 50));

    expect(result, hasLength(10));
    expect(_slotKeys(result), [
      for (var minute = 0; minute < 50; minute += 5) 13 * 60 + minute,
    ]);
    expect(result.at(13, 15)?.isMissing, isFalse);
    expect(result.at(13, 50), isNull);
    expect(result.at(14, 0), isNull);
  });

  test('fillHour fills all 12 slots for a past hour', () {
    final series = _series(date, [(9, 5)]);

    final result = fillHour(series, DateTime(2026, 10, 26, 20), hour: 9);

    expect(result, hasLength(12));
    expect(_slotKeys(result), [
      for (var minute = 0; minute < 60; minute += 5) 9 * 60 + minute,
    ]);
    expect(result.at(9, 5)?.isMissing, isFalse);
    expect(result.at(9, 55)?.isMissing, isTrue);
  });

  test('fillSeriesHours fills all 12 slots in each past hour present in the series', () {
    final series = _series(date, [(9, 5), (13, 0), (20, 0), (20, 5), (21, 0)]);

    final result = fillSeriesHours(series, DateTime(2026, 10, 26, 20));

    expect(result, hasLength(24));
    expect(_slotKeys(result).take(12), [
      for (var minute = 0; minute < 60; minute += 5) 9 * 60 + minute,
    ]);
    expect(_slotKeys(result).skip(12), [
      for (var minute = 0; minute < 60; minute += 5) 13 * 60 + minute,
    ]);
    expect(result.at(9, 0)?.isMissing, isTrue);
    expect(result.at(13, 0)?.isMissing, isFalse);
    expect(result.at(13, 55)?.isMissing, isTrue);
    expect(result.at(20, 0), isNull);
    expect(result.at(20, 5), isNull);
    expect(result.at(21, 0), isNull);
  });

  test(
    'fillRecentHour retains the current slot without filling future slots',
    () {
      final series = _series(date, [(12, 5), (13, 0), (13, 5), (13, 10)]);

      final result = fillRecentHour(series, DateTime(2026, 10, 26, 13, 7));

      expect(result, hasLength(12));
      expect(_slotKeys(result).first, 12 * 60 + 10);
      expect(_slotKeys(result).last, 13 * 60 + 5);
      expect(result.at(13, 5), same(series.at(13, 5)));
      expect(result.at(13, 10), isNull);
    },
  );

  test('fillRecentHour retains the current slot at a slot boundary', () {
    final series = _series(date, [(13, 0), (13, 5)]);

    final result = fillRecentHour(series, DateTime(2026, 10, 26, 13, 5));

    expect(result.at(13, 0)?.isMissing, isFalse);
    expect(result.at(13, 5), same(series.at(13, 5)));
  });

  test('fillRecentHour retains the current slot at midnight', () {
    final series = _series(date, [(0, 0), (0, 5)]);

    final result = fillRecentHour(series, DateTime(2026, 10, 26, 0, 0));

    expect(result, hasLength(1));
    expect(result.at(0, 0), same(series.at(0, 0)));
    expect(result.at(0, 5), isNull);
  });

  test('fillRecentHour at 13:59 includes the last 12 completed slots', () {
    final result = fillRecentHour(
      ObservationSeries.empty,
      DateTime(2026, 10, 26, 13, 59),
    );

    expect(result, hasLength(12));
    expect(_slotKeys(result).first, 12 * 60 + 55);
    expect(_slotKeys(result).last, 13 * 60 + 50);
  });
}
