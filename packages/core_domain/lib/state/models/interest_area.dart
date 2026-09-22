import 'package:flutter/widgets.dart';
// Model: InterestArea
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

part 'interest_area.freezed.dart';
part 'interest_area.g.dart';

@freezed
abstract class InterestArea with _$InterestArea {
  const InterestArea._();

  const factory InterestArea({
    required int id,
    @Default('') String name,
    @Default(0x00000000) int savedColor,
    @Default([]) List<PointData> points,
    @Default(true) bool enabled,
  }) = _InterestArea;

  factory InterestArea.fromJson(Map<String, dynamic> json) => _$InterestAreaFromJson(json);

  static int _nextId = 1;

  static int get nextId => _nextId++;

  static void resetNextId() {
    _nextId = 1;
  }

  Color get color => Color(savedColor);

  Rect get bounds {
    if (points.isEmpty) {
      return Rect.zero;
    }
    var minX = points.first.dx;
    var maxX = points.first.dx;
    var minY = points.first.dy;
    var maxY = points.first.dy;
    for (final point in points.skip(1)) {
      minX = point.dx < minX ? point.dx : minX;
      maxX = point.dx > maxX ? point.dx : maxX;
      minY = point.dy < minY ? point.dy : minY;
      maxY = point.dy > maxY ? point.dy : maxY;
    }
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  bool contains(PointData point) {
    if (points.length < 3) return false;
    var inside = false;
    for (int i = 0, j = points.length - 1; i < points.length; j = i++) {
      final pi = points[i];
      final pj = points[j];
      final intersects =
          ((pi.dy > point.dy) != (pj.dy > point.dy)) &&
          (point.dx < (pj.dx - pi.dx) * (point.dy - pi.dy) / (pj.dy - pi.dy + 0.0) + pi.dx);
      if (intersects) inside = !inside;
    }
    return inside;
  }
}
