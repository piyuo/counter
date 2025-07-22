import 'package:flutter_vision/flutter_vision.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'time_of_day_meta.dart';

part 'filter_meta.freezed.dart';
part 'filter_meta.g.dart'; // JSON support

@freezed
class FilterMeta with _$FilterMeta {
  @JsonSerializable(explicitToJson: true)
  const factory FilterMeta({
    required FilterType filterType,
    required TimeOfDayMeta start,
    required TimeOfDayMeta end,
  }) = _FilterMeta;

  factory FilterMeta.fromJson(Map<String, Object?> json) => _$FilterMetaFromJson(json);
}
