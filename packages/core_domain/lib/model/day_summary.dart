import 'package:core_domain/model/observation_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../aggregation/observation_rollup.dart';
import 'observation.dart';
import 'observation_granularity.dart';

part 'day_summary.freezed.dart';
part 'day_summary.g.dart';

@freezed
sealed class DaySummary with _$DaySummary {
  const DaySummary._();

  const factory DaySummary({
    /// for example: year=2026, month=1, day=12
    required int year,
    required int month,
    required int day,

    /// 5-minute observations, max 288 per day (see [ObservationSeries.maxLength]).
    /// Fewer entries if data is missing.
    @ObservationSeriesConverter() required ObservationSeries fiveMinuteObservations,

    /// Actual traffic totals for each hour.
    ///
    /// Aggregated from available 5-minute observations.
    /// Counts are never adjusted for missing coverage.
    ///
    /// Maximum 24 entries under the current business-time
    required List<Observation> hourlyTotals,

    /// Actual traffic total for the day.
    ///
    /// Aggregated from hourly totals.
    /// Counts are never adjusted for missing coverage.
    required Observation dailyTotal,
  }) = _DaySummary;

  factory DaySummary.fromJson(Map<String, dynamic> json) => _$DaySummaryFromJson(json);

  /// Aggregates available observations from the trailing 60-minute window.
  ///
  /// The result is labeled with the current date and hour. Returns null when
  /// the window contains no observations.
  Observation? get pastHourObservation {
    final now = DateTime.now();
    return pastHourObservationAt(now.hour, now.minute);
  }

  /// Aggregates available observations from the trailing 60-minute window,
  /// limited to this business day.
  ///
  /// [hour] and [minute] represent the end of the requested window
  /// in business-local time.
  ///
  /// The window ends at the latest completed 5-minute boundary.
  ///
  /// Examples:
  /// - At 00:06, includes 00:00–00:05 (5 minutes).
  /// - At 00:36, includes 00:00–00:35 (35 minutes).
  /// - At 11:37, includes 10:35–11:35 (60 minutes).
  ///
  /// Observations from the previous business day are never included.
  ///
  /// Missing observations are not estimated or filled.
  /// Returns null when no observations are available.
  Observation? pastHourObservationAt(int hour, int minute) {
    assert(hour >= 0 && hour < 24);
    assert(minute >= 0 && minute < 60);

    final windowEnd = hour * 60 + (minute ~/ 5 * 5);
    final windowStart = (windowEnd - 60).clamp(0, 1440);

    final sources = fiveMinuteObservations
        .where((observation) {
          final observationMinute = observation.hour * 60 + observation.minute;

          return observationMinute >= windowStart && observationMinute < windowEnd;
        })
        .map((observation) {
          final observationMinute = observation.hour * 60 + observation.minute;

          return observation.copyWith(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: observationMinute - windowStart,
          );
        })
        .toList();

    if (sources.isEmpty) return null;

    return const ObservationRollup().aggregate(sources, granularity: ObservationGranularity.hour);
  }

  String get businessDate =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  String toString() {
    return 'DaySummary('
        'businessDate: $businessDate, '
        'fiveMinuteObservations: ${fiveMinuteObservations.length}, '
        'hourlyTotals: ${hourlyTotals.length}, '
        'dailyTotal: $dailyTotal'
        ')';
  }
}
