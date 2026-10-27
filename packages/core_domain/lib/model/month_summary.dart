import 'package:core_domain/model/observation_series.dart';
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

    /// Typical weekday 5-minute profile for this month. Matching time slots
    /// are averaged across available weekdays. Missing slots are omitted.
    @ObservationSeriesConverter() required ObservationSeries weekdayFiveMinuteObservation,

    /// Typical weekend 5-minute profile for this month. Matching time slots
    /// are averaged across available weekend days. Missing slots are omitted.
    @ObservationSeriesConverter() required ObservationSeries weekendFiveMinuteObservation,

    /// Hourly observations aggregated from the DaySummary's hourly observations.
    /// there are 24 observation a day, multiplied by the number of days in the month.
    /// useful for analyzing monthly trends in hourly observations.
    required List<Observation> hourlyTotals,

    /// Day observations aggregated from the DaySummary's daily observations.
    /// there is one observation a day, multiplied by the number of days in the month.
    /// useful for analyzing monthly trends day by day.
    required List<Observation> dailyTotals,

    /// Monthly observation aggregated from the daily observations.
    required Observation monthlyTotal,
  }) = _MonthSummary;

  factory MonthSummary.fromJson(Map<String, dynamic> json) => _$MonthSummaryFromJson(json);

  String get businessDate =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}';

  @override
  String toString() {
    return 'MonthSummary('
        'businessDate: $businessDate, '
        'weekdayFiveMinuteObservation: ${weekdayFiveMinuteObservation.length}, '
        'weekendFiveMinuteObservation: ${weekendFiveMinuteObservation.length}, '
        'hourlyTotals: ${hourlyTotals.length}, '
        'dailyTotals: ${dailyTotals.length}, '
        'monthlyTotal: $monthlyTotal'
        ')';
  }
}
