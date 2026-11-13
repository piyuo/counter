import '../model/observation.dart';
import '../model/observation_series.dart';
import 'observation_rollup.dart';

/// Aggregates available observations from the recent hour window.
///
/// The window ends at the boundary after the current 5-minute slot.
/// It is limited to the current business day and never crosses midnight.
///
/// Missing observations are not estimated or filled.
/// Source observations retain their original timestamps.
Observation? getRecentHourTotalAt(int hour, int minute, ObservationSeries series) {
  assert(hour >= 0 && hour < 24);
  assert(minute >= 0 && minute < 60);

  if (series.isEmpty) return null;

  final windowEnd = hour * 60 + (minute ~/ 5 + 1) * 5;
  final windowStart = (windowEnd - 60).clamp(0, 1440);

  final sources = series.where((observation) {
    final observationMinute = observation.hour * 60 + observation.minute;

    return observationMinute >= windowStart && observationMinute < windowEnd;
  }).toList();

  if (sources.isEmpty) return null;

  return aggregateRecentHourObservations(sources);
}
