import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation.dart';

part 'month_file.freezed.dart';
part 'month_file.g.dart';

@freezed
sealed class MonthFile with _$MonthFile {
  const MonthFile._();

  const factory MonthFile({
    /// for example: year=2026, month=1
    required int year,
    required int month,

    /// Daily observations for this month, up to 31 entries.
    /// Used to compare individual days and calculate daily averages.
    required List<Observation> dailyObservations,

    /// Hourly observations for this month, up to 744 entries (31 × 24).
    /// Summarized from the 5-minute observations.
    /// Missing hours may result in fewer entries.
    required List<Observation> hourlyObservations,

    /// Monthly observation, summarized from the hourly observations.
    /// Represents the aggregated metrics for the entire month.
    required Observation monthlyObservation,
  }) = _MonthFile;

  factory MonthFile.fromJson(Map<String, dynamic> json) => _$MonthFileFromJson(json);

  String get businessDate =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}';

  @override
  String toString() {
    return 'MonthFile('
        'businessDate: $businessDate, '
        'dailyObservations: ${dailyObservations.length}, '
        'hourlyObservations: ${hourlyObservations.length}, '
        'monthlyObservation: $monthlyObservation'
        ')';
  }
}
