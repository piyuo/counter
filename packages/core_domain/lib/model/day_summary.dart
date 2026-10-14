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

    /// 5-minute observations, max 288 per day. Fewer entries if data is missing.
    required List<Observation> fiveMinuteObservations,

    /// Hourly observations aggregated from the 5-minute ones. Max 24 per day.
    required List<Observation> hourlyObservations,

    /// Daily observation aggregated from the hourly ones.
    required Observation dailyObservation,
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
        'hourlyObservations: ${hourlyObservations.length}, '
        'dailyObservation: $dailyObservation'
        ')';
  }
}
