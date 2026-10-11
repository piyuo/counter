import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation.dart';

part 'day_file.freezed.dart';
part 'day_file.g.dart';

@freezed
sealed class DayFile with _$DayFile {
  const DayFile._();

  const factory DayFile({
    /// for example: year=2026, month=1, day=12
    required int year,
    required int month,
    required int day,

    /// 5-minute observations, max 288 per day. if observations are missing, the list may contain fewer entries.
    required List<Observation> fiveMinuteObservations,

    /// Hourly observations, max 24 per day. summarized from the 5-minute observations. missing hours may result in fewer entries.
    required List<Observation> hourlyObservations,

    /// Daily observation, summarized from the hourly observations.
    /// for example: pass-by: 225 // all day
    required Observation dailyObservation,

    /// Five-minute observation: expected duration is normally 300 seconds.
    /// Hourly observation: expected duration is normally 3,600 seconds.
    /// Daily observation: expected duration is normally 86,400 seconds for a full calendar day.
  }) = _DayFile;

  factory DayFile.fromJson(Map<String, dynamic> json) => _$DayFileFromJson(json);

  String get businessDate =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  String toString() {
    return 'DayFile('
        'businessDate: $businessDate, '
        'fiveMinuteObservations: ${fiveMinuteObservations.length}, '
        'hourlyObservations: ${hourlyObservations.length}, '
        'dailyObservation: $dailyObservation'
        ')';
  }
}
