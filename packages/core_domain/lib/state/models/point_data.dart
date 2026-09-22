// Model: PointData
// Description: Domain-level representation of a 2D point (mirrors Flutter's Offset).
//   Used to persist interest area polygon vertices without depending on Flutter types.
//   Serialised to/from JSON and converted to Offset only at the UI/runtime boundary.

import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_data.freezed.dart';
part 'point_data.g.dart';

@freezed
abstract class PointData with _$PointData {
  const PointData._();

  const factory PointData({@Default(0.0) double dx, @Default(0.0) double dy}) = _PointData;

  factory PointData.fromJson(Map<String, dynamic> json) => _$PointDataFromJson(json);

  /// Creates a [PointData] from a Flutter [Offset].
  factory PointData.fromOffset(Offset offset) => PointData(dx: offset.dx, dy: offset.dy);

  /// Adds two points together element-wise.
  PointData operator +(PointData other) => PointData(dx: dx + other.dx, dy: dy + other.dy);

  /// Subtracts another point from this point element-wise.
  PointData operator -(PointData other) => PointData(dx: dx - other.dx, dy: dy - other.dy);

  /// The magnitude of the offset.
  ///
  /// If you need this value to compare it to another [PointData]'s distance,
  /// consider using [distanceSquared] instead, since it is cheaper to compute.
  double get distance => math.sqrt(dx * dx + dy * dy);

  /// Converts this [PointData] to a Flutter [Offset].
  /// Always stays in sync with the current [dx] and [dy] values.
  Offset get offset => Offset(dx, dy);
}
