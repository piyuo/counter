import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_of_day_meta.freezed.dart';
part 'time_of_day_meta.g.dart'; // JSON support

@freezed
class TimeOfDayMeta with _$TimeOfDayMeta {
  const factory TimeOfDayMeta({
    required int hour,
    required int minute,
  }) = _TimeOfDayMeta;

  factory TimeOfDayMeta.fromJson(Map<String, Object?> json) => _$TimeOfDayMetaFromJson(json);
}
