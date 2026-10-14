import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation.dart';

part 'month_summary.freezed.dart';
part 'month_summary.g.dart';

@freezed
sealed class MonthSummary with _$MonthSummary {
  const MonthSummary._();

  const factory MonthSummary({
    /// for example: year=2026, month=1
    required int year,
    required int month,

    /// 5-minute observations, max 288 per day. a typical day to represent the month
    /// average from fiveMinuteObservations in day summary
    /// useful to compare any day with this month average.
    required List<Observation> fiveMinuteObservations,

    /// Hourly observations aggregated from the DaySummary's hourly observations.
    /// there are 24 observation a day, multiplied by the number of days in the month.
    /// useful for analyzing monthly trends in hourly observations.
    required List<Observation> hourlyObservations,

    /// Day observations aggregated from the DaySummary's daily observations.
    /// there is one observation a day, multiplied by the number of days in the month.
    /// useful for analyzing monthly trends day by day.
    required List<Observation> dailyObservations,

    /// Monthly observation aggregated from the daily observations.
    required Observation monthlyObservation,
  }) = _MonthSummary;

  factory MonthSummary.fromJson(Map<String, dynamic> json) => _$MonthSummaryFromJson(json);

  String get businessDate =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}';

  @override
  String toString() {
    return 'MonthSummary('
        'businessDate: $businessDate, '
        'fiveMinuteObservations: ${fiveMinuteObservations.length}, '
        'hourlyObservations: ${hourlyObservations.length}, '
        'dailyObservations: ${dailyObservations.length}, '
        'monthlyObservation: $monthlyObservation'
        ')';
  }
}
