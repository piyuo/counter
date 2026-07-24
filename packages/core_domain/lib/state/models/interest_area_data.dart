// Model: InterestAreaData
// Description: Domain-level representation of an interest area (mirrors flutter_vision's InterestArea).
//   Used to persist user-defined detection zones without depending on flutter_vision package.
//   Serialised to/from JSON (persisted inside AppState) and converted to InterestArea only
//   at the runtime boundary where the vision engine is configured.
// Fields:
//   - id      : int            — unique identifier (auto-generated if not provided)
//   - name    : String         — user-friendly label
//   - color   : int            — ARGB color value (Color.value from Flutter)
//   - points  : List<PointData> — polygon vertices defining the area boundary
//   - enabled : bool           — whether this area is active for detection

import 'package:freezed_annotation/freezed_annotation.dart';

import 'point_data.dart';

part 'interest_area_data.freezed.dart';
part 'interest_area_data.g.dart';

@freezed
abstract class InterestAreaData with _$InterestAreaData {
  const InterestAreaData._();

  const factory InterestAreaData({
    required int id,
    @Default('') String name,
    @Default(0x00000000) int color,
    @Default([]) List<PointData> points,
    @Default(true) bool enabled,
  }) = _InterestAreaData;

  factory InterestAreaData.fromJson(Map<String, dynamic> json) => _$InterestAreaDataFromJson(json);
}
