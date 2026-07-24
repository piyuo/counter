// Model: PointData
// Description: Domain-level representation of a 2D point (mirrors Flutter's Offset).
//   Used to persist interest area polygon vertices without depending on Flutter types.
//   Serialised to/from JSON and converted to Offset only at the UI/runtime boundary.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_data.freezed.dart';
part 'point_data.g.dart';

@freezed
abstract class PointData with _$PointData {
  const PointData._();

  const factory PointData({@Default(0.0) double dx, @Default(0.0) double dy}) = _PointData;

  factory PointData.fromJson(Map<String, dynamic> json) => _$PointDataFromJson(json);
}
