import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';

/// Returns the observations whose 5-minute slot starts in the half-open
/// range [from, to), in minutes of the day.
///
/// [fromHour]:[fromMinute] is inclusive and [toHour]:[toMinute] is
/// exclusive, matching how a 5-minute observation covers
/// [start, start + 5 min). Examples:
///
/// - 13:00 -> 14:00 returns the 12 slots 13:00 ... 13:55
/// - 00:00 -> 24:00 returns the whole day
///
/// Minutes must be multiples of 5 because observations align to wall-clock
/// 5-minute intervals. [toHour] may be 24 (with [toMinute] 0) to mean the end
/// of the day. The range cannot cross midnight.
///
/// Missing observations are not estimated or filled, and source observations
/// keep their original timestamps.
ObservationSeries sliceRange(ObservationSeries series, int fromHour, int fromMinute, int toHour, int toMinute) {
  if (fromHour < 0 || fromHour >= 24) {
    throw RangeError.range(fromHour, 0, 23, 'fromHour');
  }
  _validateFiveMinuteBoundary(fromMinute, 'fromMinute');
  if (toHour < 0 || toHour > 24) {
    throw RangeError.range(toHour, 0, 24, 'toHour');
  }
  _validateFiveMinuteBoundary(toMinute, 'toMinute');
  if (toHour == 24 && toMinute != 0) {
    throw ArgumentError.value(toMinute, 'toMinute', 'must be 0 when toHour is 24');
  }

  final start = fromHour * 60 + fromMinute;
  final end = toHour * 60 + toMinute;
  if (start > end) {
    throw ArgumentError('from must not be after to');
  }

  return ObservationSeries.fromObservations(
    series.where((observation) => observation.slotKey >= start && observation.slotKey < end),
  );
}

/// Selects observations in the recent-hour window, including the current
/// 5-minute slot if it exists in [series].
///
/// Intended for analytics that may include an ongoing observation. The window
/// is limited to the current business day and never crosses midnight.
ObservationSeries sliceRecentHour(ObservationSeries series, int hour, int minute) {
  if (hour < 0 || hour >= 24) {
    throw RangeError.range(hour, 0, 23, 'hour');
  }
  if (minute < 0 || minute >= 60) {
    throw RangeError.range(minute, 0, 59, 'minute');
  }

  final windowEnd = hour * 60 + (minute ~/ 5 + 1) * 5;
  final windowStart = (windowEnd - 60).clamp(0, 1440);

  return sliceRange(series, windowStart ~/ 60, windowStart % 60, windowEnd ~/ 60, windowEnd % 60);
}

/// Walks the 5-minute slots in [startSlot, endSlot) (minutes since midnight)
/// and returns the observation from [series] for each slot, or an
/// [core_domain.Observation.missing] placeholder stamped with [date]'s
/// year/month/day when the slot has none.
ObservationSeries fillSlots(ObservationSeries series, DateTime date, int startSlot, int endSlot) {
  _validateSlotBoundary(startSlot, 'startSlot');
  _validateSlotBoundary(endSlot, 'endSlot');
  if (startSlot > endSlot) {
    throw ArgumentError('startSlot must not be after endSlot');
  }

  final observationsBySlot = _observationsBySlot(series, date);
  return ObservationSeries.fromObservations(_fillSlotObservations(observationsBySlot, date, startSlot, endSlot));
}

/// Returns one observation for every completed 5-minute slot of [now]'s day,
/// from 00:00 up to but not including the current slot, in time order. Slots
/// with no observation are filled with [core_domain.Observation.missing].
///
/// Observations in [series] at or later than [now]'s slot are dropped, so a
/// whole-day series is safe to pass in.
///
/// Examples:
/// - 13:00 -> 00:00 ... 12:55 (156 observations)
/// - 13:07 -> 00:00 ... 13:00 (157 observations)
/// - 23:58 -> 00:00 ... 23:50 (287 observations)
///
/// [series] should contain observations from a single day, because slots
/// are matched by time of day only.
ObservationSeries fillToday(ObservationSeries series, DateTime now) {
  final endSlot = _currentSlotStart(now);
  return fillSlots(series, now, 0, endSlot);
}

/// Returns the completed five-minute observations in [hour] on [now]'s day,
/// in time order. Slots with no observation are filled with
/// [core_domain.Observation.missing]. If [hour] is omitted, [now]'s hour is
/// used.
///
/// A past hour contains all 12 slots. The current hour ends before [now]'s
/// current slot, and future hours are empty.
///
/// [series] should contain observations from a single day, because slots
/// are matched by time of day only.
ObservationSeries fillHour(ObservationSeries series, DateTime now, {int? hour}) {
  final targetHour = hour ?? now.hour;
  if (targetHour < 0 || targetHour >= 24) {
    throw RangeError.range(targetHour, 0, 23, 'hour');
  }

  final startSlot = targetHour * 60;
  final endSlot = targetHour < now.hour
      ? startSlot + 60
      : targetHour == now.hour
      ? _currentSlotStart(now)
      : startSlot;
  final filled = fillSlots(series, now, startSlot, endSlot);
  return filled;
}

/// Fills the completed slots of each past or current hour that has at least
/// one observation in [series]. Hours with no observations are left out.
///
/// The current and future slots are not returned, even if they exist in
/// [series].
ObservationSeries fillSeriesHours(ObservationSeries series, DateTime now) {
  final hours = series.map((observation) => observation.hour).toSet().where((hour) => hour <= now.hour).toList()
    ..sort();
  return ObservationSeries.fromObservations([for (final hour in hours) ...fillHour(series, now, hour: hour)]);
}

int _currentSlotStart(DateTime now) => now.hour * 60 + (now.minute ~/ 5) * 5;

void _validateFiveMinuteBoundary(int minute, String name) {
  if (minute < 0 || minute > 55) {
    throw RangeError.range(minute, 0, 55, name);
  }
  if (minute % 5 != 0) {
    throw ArgumentError.value(minute, name, 'must be a multiple of 5');
  }
}

/// Returns up to 12 observations from the current business day: completed
/// slots ending before [now]'s current 5-minute slot, plus that slot if it
/// exists in [series]. Missing completed slots are filled; the current and
/// future slots are never filled.
ObservationSeries fillRecentHour(ObservationSeries series, DateTime now) {
  final windowEnd = _currentSlotStart(now);
  final observationsBySlot = _observationsBySlot(series, now);
  var windowStart = windowEnd > 60 ? windowEnd - 60 : 0;
  final currentObservation = observationsBySlot[windowEnd];
  if (currentObservation != null && windowEnd - windowStart > 55) {
    windowStart += 5;
  }

  final observations = _fillSlotObservations(observationsBySlot, now, windowStart, windowEnd);
  if (currentObservation != null) {
    observations.add(currentObservation);
  }
  return ObservationSeries.fromObservations(observations);
}

Map<int, core_domain.Observation> _observationsBySlot(ObservationSeries series, DateTime date) {
  final observationsBySlot = <int, core_domain.Observation>{};
  for (final observation in series) {
    if (observation.year != date.year || observation.month != date.month || observation.day != date.day) {
      throw ArgumentError.value(
        '${observation.year}-${observation.month}-${observation.day}',
        'series',
        'Observation date must match requested business date ${date.year}-${date.month}-${date.day}',
      );
    }
    observationsBySlot.putIfAbsent(observation.slotKey, () => observation);
  }
  return observationsBySlot;
}

List<core_domain.Observation> _fillSlotObservations(
  Map<int, core_domain.Observation> observationsBySlot,
  DateTime date,
  int startSlot,
  int endSlot,
) => [
  for (var slot = startSlot; slot < endSlot; slot += 5)
    observationsBySlot[slot] ??
        core_domain.Observation.missing(
          year: date.year,
          month: date.month,
          day: date.day,
          hour: slot ~/ 60,
          minute: slot % 60,
        ),
];

void _validateSlotBoundary(int slot, String name) {
  if (slot < 0 || slot > 1440) {
    throw RangeError.range(slot, 0, 1440, name);
  }
  if (slot % 5 != 0) {
    throw ArgumentError.value(slot, name, 'must be a multiple of 5');
  }
}
