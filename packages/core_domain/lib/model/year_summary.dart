import 'package:core_domain/model/observation_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation.dart';

part 'year_summary.freezed.dart';
part 'year_summary.g.dart';

@freezed
sealed class YearSummary with _$YearSummary {
  const YearSummary._();

  const factory YearSummary({
    /// for example: year=2026
    required int year,

    /// Typical weekday 5-minute profile for this year, averaged across the
    /// available weekday profiles from each month. Missing slots are omitted.
    @ObservationSeriesConverter() required ObservationSeries weekdayFiveMinuteObservation,

    /// Typical weekend 5-minute profile for this year, averaged across the
    /// available weekend profiles from each month. Missing slots are omitted.
    @ObservationSeriesConverter() required ObservationSeries weekendFiveMinuteObservation,

    /// Day observations aggregated from the MonthSummary's daily observations.
    /// there is one observation a day, 365 in a non-leap year.
    /// useful for analyzing trends day by day.
    required List<Observation> dailyTotals,

    /// Month observations aggregated from the MonthSummary's monthly observations.
    /// there is 1 observation a month, 12 in a year.
    /// useful for analyzing trends month by month.
    required List<Observation> monthlyTotals,

    /// Yearly observation aggregated from the monthly observations.
    required Observation yearlyTotal,
  }) = _YearSummary;

  factory YearSummary.fromJson(Map<String, dynamic> json) => _$YearSummaryFromJson(json);

  String get businessDate => '$year';

  @override
  String toString() {
    return 'YearSummary('
        'businessDate: $businessDate, '
        'weekdayFiveMinuteObservation: ${weekdayFiveMinuteObservation.length}, '
        'weekendFiveMinuteObservation: ${weekendFiveMinuteObservation.length}, '
        'dailyTotals: ${dailyTotals.length}, '
        'monthlyTotals: ${monthlyTotals.length}, '
        'yearlyTotal: $yearlyTotal'
        ')';
  }
}
