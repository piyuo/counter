import 'package:flutter/material.dart';

/// Defines how a point interaction qualifies as a hit for an [InterestArea].
/// Removed HitTestMode as per new requirement.

@immutable
class InterestArea {
  InterestArea({
    int? id,
    required this.name,
    this.color = const Color(0x00000000),
    required this.points,
    this.enabled = true,
  }) : id = id ?? nextId;

  static int _nextId = 1;

  static int get nextId => _nextId++;

  static void resetNextId() {
    _nextId = 1;
  }

  final int id;
  final String name;
  final Color color;
  final List<Offset> points;
  final bool enabled;

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

  bool contains(Offset point) {
    if (points.length < 3) return false;
    var inside = false;
    for (int i = 0, j = points.length - 1; i < points.length; j = i++) {
      final pi = points[i];
      final pj = points[j];
      final intersects = ((pi.dy > point.dy) != (pj.dy > point.dy)) &&
          (point.dx < (pj.dx - pi.dx) * (point.dy - pi.dy) / (pj.dy - pi.dy + 0.0) + pi.dx);
      if (intersects) inside = !inside;
    }
    return inside;
  }

  InterestArea copyWith({
    int? id,
    String? name,
    Color? color,
    List<Offset>? points,
    bool? enabled,
  }) {
    return InterestArea(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      points: points ?? this.points,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InterestArea) return false;
    return id == other.id &&
        name == other.name &&
        color == other.color &&
        points.length == other.points.length &&
        List.generate(points.length, (i) => points[i] == other.points[i]).every((e) => e) &&
        enabled == other.enabled;
  }

  @override
  int get hashCode => Object.hash(id, name, color, Object.hashAll(points), enabled);
}
