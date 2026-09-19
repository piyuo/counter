// ============================================================================
// Table of Contents
// ============================================================================
// 1. Coordinate conversions
// ============================================================================

import 'package:flutter/material.dart';

/// Convert vision coordinates to screen coordinates.
/// When displayWidth/displayHeight/displayScale are provided, uses those instead of previewConstraints.
/// This is needed for landscape rotation where dimensions are swapped.
Offset visionToScreen(
  Offset visionPoint, {
  required bool isIPadLandscape,
  required double videoWidth,
  required double videoHeight,
  required double displayWidth,
  required double displayHeight,
  required double displayScale,
}) {
  // When rotated, dimensions are swapped: videoHeight becomes display width
  final centerX = isIPadLandscape ? videoHeight / 2 : videoWidth / 2;
  final centerY = isIPadLandscape ? videoWidth / 2 : videoHeight / 2;
  final center = Offset(centerX, centerY);

  // Calculate the screen position
  final screenX = (center.dx - visionPoint.dx) * displayScale;
  final screenY = (center.dy - visionPoint.dy) * displayScale;

  // Calculate actual video display dimensions after scaling
  final videoDisplayWidth = centerX * 2 * displayScale;
  final videoDisplayHeight = centerY * 2 * displayScale;

  // Calculate offset to center the video within the canvas
  final offsetX = (displayWidth - videoDisplayWidth) / 2;
  final offsetY = (displayHeight - videoDisplayHeight) / 2;
  return Offset(offsetX + screenX, offsetY + screenY);
}

Offset screenToVision(
  Offset screenPoint, {
  required bool isIPadLandscape,
  required double videoWidth,
  required double videoHeight,
  required double displayWidth,
  required double displayHeight,
  required double displayScale,
}) {
  // When rotated, dimensions are swapped
  final centerX = isIPadLandscape ? videoHeight / 2 : videoWidth / 2;
  final centerY = isIPadLandscape ? videoWidth / 2 : videoHeight / 2;

  final center = Offset(centerX, centerY);

  // Calculate actual video display dimensions after scaling
  final videoDisplayWidth = centerX * 2 * displayScale;
  final videoDisplayHeight = centerY * 2 * displayScale;

  final offsetX = (displayWidth - videoDisplayWidth) / 2;
  final offsetY = (displayHeight - videoDisplayHeight) / 2;

  // Remove the centering offset first
  final adjustedX = screenPoint.dx - offsetX;
  final adjustedY = screenPoint.dy - offsetY;

  return Offset(
    center.dx - (adjustedX / displayScale),
    center.dy - (adjustedY / displayScale),
  );
}

Path visionPolygonToPath(
  List<Offset> points, {
  required bool isIPadLandscape,
  required double videoWidth,
  required double videoHeight,
  required double displayWidth,
  required double displayHeight,
  required double displayScale,
}) {
  final screenPoints = points
      .map((point) => visionToScreen(
            point,
            isIPadLandscape: isIPadLandscape,
            videoWidth: videoWidth,
            videoHeight: videoHeight,
            displayWidth: displayWidth,
            displayHeight: displayHeight,
            displayScale: displayScale,
          ))
      .toList();
  final path = Path();
  if (screenPoints.isEmpty) return path;
  path.moveTo(screenPoints.first.dx, screenPoints.first.dy);
  for (final point in screenPoints.skip(1)) {
    path.lineTo(point.dx, point.dy);
  }
  path.close();
  return path;
}

Rect visionPolygonToScreenBounds(
  List<Offset> points, {
  required bool isIPadLandscape,
  required double videoWidth,
  required double videoHeight,
  required double displayWidth,
  required double displayHeight,
  required double displayScale,
}) {
  if (points.isEmpty) return Rect.zero;
  final screenPoints = points
      .map((point) => visionToScreen(
            point,
            isIPadLandscape: isIPadLandscape,
            videoWidth: videoWidth,
            videoHeight: videoHeight,
            displayWidth: displayWidth,
            displayHeight: displayHeight,
            displayScale: displayScale,
          ))
      .toList();
  var minX = screenPoints.first.dx;
  var maxX = screenPoints.first.dx;
  var minY = screenPoints.first.dy;
  var maxY = screenPoints.first.dy;
  for (final point in screenPoints.skip(1)) {
    minX = point.dx < minX ? point.dx : minX;
    maxX = point.dx > maxX ? point.dx : maxX;
    minY = point.dy < minY ? point.dy : minY;
    maxY = point.dy > maxY ? point.dy : maxY;
  }
  return Rect.fromLTRB(minX, minY, maxX, maxY);
}
