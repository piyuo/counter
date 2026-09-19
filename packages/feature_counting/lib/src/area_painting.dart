// area_painting.dart
//
// Shared by the viewer and editor: path painting, label geometry/painting,
// and pure hit-testing functions (unit-testable without widgets).

import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';

import 'area_viewport.dart';

// ---------------------------------------------------------------------------
// Path painting
// ---------------------------------------------------------------------------

/// Fills and strokes [path]. Callers decide the colors/widths; the drawing
/// itself lives in one place.
void paintAreaPath(
  Canvas canvas,
  Path path, {
  required Color strokeColor,
  required double fillAlpha,
  required double strokeWidth,
  bool roundJoins = false,
}) {
  canvas.drawPath(
    path,
    Paint()
      ..color = strokeColor.withValues(alpha: fillAlpha)
      ..style = PaintingStyle.fill,
  );
  final stroke = Paint()
    ..color = strokeColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth;
  if (roundJoins) {
    stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }
  canvas.drawPath(path, stroke);
}

// ---------------------------------------------------------------------------
// Label geometry (single source of truth for painting AND hit-testing)
// ---------------------------------------------------------------------------

class AreaLabelLayout {
  const AreaLabelLayout._();

  static const double paddingHorizontal = 15.0;
  static const double paddingVertical = 7.0;
  static const double cornerRadius = 6.0;

  static final TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 4, offset: const Offset(0, 2))],
  );

  static TextPainter _measure(String name, TextDirection direction) {
    return TextPainter(text: TextSpan(text: name, style: textStyle), textDirection: direction)..layout();
  }

  /// Screen-space background rect (unrotated) of an area's label.
  static Rect backgroundRect(AreaViewport viewport, core_domain.InterestArea area, TextDirection direction) {
    final painter = _measure(area.name, direction);
    final rect = _rectFor(viewport, area, painter);
    painter.dispose();
    return rect;
  }

  static Rect _rectFor(AreaViewport viewport, core_domain.InterestArea area, TextPainter painter) {
    return Rect.fromCenter(
      center: viewport.polygonBounds(area.points).center,
      width: painter.width + paddingHorizontal * 2,
      height: painter.height + paddingVertical * 2,
    );
  }

  /// Paints the label background + text, counter-rotated about its center.
  static void paint(Canvas canvas, AreaViewport viewport, core_domain.InterestArea area, TextDirection direction) {
    final painter = _measure(area.name, direction);
    final rect = _rectFor(viewport, area, painter);

    canvas.save();
    if (viewport.isRotated) {
      canvas
        ..translate(rect.center.dx, rect.center.dy)
        ..rotate(viewport.labelRotationRadians)
        ..translate(-rect.center.dx, -rect.center.dy);
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(cornerRadius)),
      Paint()..color = area.color.withValues(alpha: 0.6),
    );
    painter.paint(canvas, rect.topLeft + const Offset(paddingHorizontal, paddingVertical));
    canvas.restore();
    painter.dispose();
  }

  /// Hit-test that accounts for the label's counter-rotation.
  static bool hitTest(AreaViewport viewport, Rect rect, Offset position) {
    if (!viewport.isRotated) return rect.contains(position);
    // The label is painted rotated by -a; undo it by rotating the tap by +a.
    final a = -viewport.labelRotationRadians;
    final d = position - rect.center;
    final c = math.cos(a);
    final s = math.sin(a);
    final local = Offset(d.dx * c - d.dy * s, d.dx * s + d.dy * c) + rect.center;
    return rect.contains(local);
  }
}

// ---------------------------------------------------------------------------
// Hit testing (pure)
// ---------------------------------------------------------------------------

class AreaVertexHit {
  const AreaVertexHit({required this.areaId, required this.pointIndex});

  final int areaId;
  final int pointIndex;
}

AreaVertexHit? findVertexHit(
  AreaViewport viewport,
  Offset tap,
  List<core_domain.InterestArea> areas,
  double radius,
) {
  final tapPoint = core_domain.PointData.fromOffset(tap);
  for (final area in areas) {
    for (var i = 0; i < area.points.length; i++) {
      final screenPoint = viewport.toScreen(area.points[i]);
      if ((screenPoint - tapPoint).distance <= radius) {
        return AreaVertexHit(areaId: area.id, pointIndex: i);
      }
    }
  }
  return null;
}

int? findAreaHit(core_domain.PointData tapVision, List<core_domain.InterestArea> areas) {
  for (final area in areas) {
    if (area.contains(tapVision)) return area.id;
  }
  return null;
}

core_domain.InterestArea? findLabelHit(
  AreaViewport viewport,
  Offset tap,
  List<core_domain.InterestArea> areas,
  TextDirection direction,
) {
  for (final area in areas) {
    if (!area.enabled || area.points.isEmpty || area.name.isEmpty) continue;
    final rect = AreaLabelLayout.backgroundRect(viewport, area, direction);
    if (AreaLabelLayout.hitTest(viewport, rect, tap)) return area;
  }
  return null;
}
