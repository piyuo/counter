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

    /// 5-minute observations, max 288 per day. a typical day to represent the year
    /// average from fiveMinuteObservations in month summary
    /// useful to compare any day with this year average.
    required List<Observation> fiveMinuteObservations,

    /// Day observations aggregated from the MonthSummary's daily observations.
    /// there is one observation a day, 365 in a non-leap year.
    /// useful for analyzing trends day by day.
    required List<Observation> dailyObservations,

    /// Month observations aggregated from the MonthSummary's monthly observations.
    /// there is 1 observation a month, 12 in a year.
    /// useful for analyzing trends month by month.
    required List<Observation> monthlyObservations,

    /// Yearly observation aggregated from the monthly observations.
    required Observation yearlyObservation,
  }) = _YearSummary;

  factory YearSummary.fromJson(Map<String, dynamic> json) => _$YearSummaryFromJson(json);

  String get businessDate => '$year';

  @override
  String toString() {
    return 'YearSummary('
        'businessDate: $businessDate, '
        'fiveMinuteObservations: ${fiveMinuteObservations.length}, '
        'dailyObservations: ${dailyObservations.length}, '
        'monthlyObservations: ${monthlyObservations.length}, '
        'yearlyObservation: $yearlyObservation'
        ')';
  }
}
