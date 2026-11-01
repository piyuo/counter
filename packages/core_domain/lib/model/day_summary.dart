import 'package:core_domain/model/observation_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation.dart';

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
