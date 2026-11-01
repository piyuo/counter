// TOC
// 1. Recent-hour observation aggregation

import '../model/observation.dart';
import '../model/observation_granularity.dart';
import '../model/observation_series.dart';
import 'observation_rollup.dart';

/// Aggregates available observations from the recent hour window.
///
/// The window ends at the boundary after the current 5-minute slot. The
/// window is limited to the observations on this business day and never wraps
/// around midnight.
/// Missing observations are not estimated or filled.
Observation? getRecentHourTotalAt(int hour, int minute, ObservationSeries series) {
  assert(hour >= 0 && hour < 24);
  assert(minute >= 0 && minute < 60);

  if (series.isEmpty) return null;

  final windowEnd = hour * 60 + (minute ~/ 5 + 1) * 5;
  final windowStart = windowEnd - 60;
  final effectiveWindowStart = windowStart.clamp(0, 1440);
  final first = series.first;
  final sources = <Observation>[];

  for (final observation in series) {
    final observationMinute = observation.hour * 60 + observation.minute;
    if (observationMinute < effectiveWindowStart || observationMinute >= windowEnd) continue;

    sources.add(
      observation.copyWith(
        year: first.year,
        month: first.month,
        day: first.day,
        hour: hour,
        minute: observationMinute - effectiveWindowStart,
      ),
    );
  }

  if (sources.isEmpty) return null;

  return aggregateObservations(sources, granularity: ObservationGranularity.hour);
}
