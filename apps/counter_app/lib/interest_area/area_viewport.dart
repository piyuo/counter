// area_viewport.dart
//
// One value object for the vision-space <-> screen-space mapping that every
// interest-area widget, painter, and hit-test needs.

import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'interest_area_utils.dart';

@immutable
class AreaViewport {
  const AreaViewport({
    required this.videoWidth,
    required this.videoHeight,
    required this.isIPadLandscape,
    required this.displayWidth,
    required this.displayHeight,
    required this.displayScale,
    this.rotationDegrees = 0,
  });

  final double videoWidth;
  final double videoHeight;
  final bool isIPadLandscape;

  /// Display width (overrides previewConstraints when rotating)
  final double displayWidth;

  /// Display height (overrides previewConstraints when rotating)
  final double displayHeight;

  /// Display scale (overrides previewConstraints when rotating)
  final double displayScale;

  /// Device rotation; labels counter-rotate by this so they stay upright.
  final double rotationDegrees;

  Size get displaySize => Size(displayWidth, displayHeight);

  bool get isRotated => rotationDegrees > 0;

  /// Angle (radians) applied to labels to counter the device rotation.
  double get labelRotationRadians => -rotationDegrees * (math.pi / 180);

  core_domain.PointData toScreen(core_domain.PointData vision) => visionToScreen(
    vision,
    videoWidth: videoWidth,
    videoHeight: videoHeight,
    isIPadLandscape: isIPadLandscape,
    displayWidth: displayWidth,
    displayHeight: displayHeight,
    displayScale: displayScale,
  );

  core_domain.PointData toVision(core_domain.PointData screen) => screenToVision(
    screen,
    videoWidth: videoWidth,
    videoHeight: videoHeight,
    isIPadLandscape: isIPadLandscape,
    displayWidth: displayWidth,
    displayHeight: displayHeight,
    displayScale: displayScale,
  );

  Path polygonPath(List<core_domain.PointData> points) => visionPolygonToPath(
    points,
    videoWidth: videoWidth,
    videoHeight: videoHeight,
    isIPadLandscape: isIPadLandscape,
    displayWidth: displayWidth,
    displayHeight: displayHeight,
    displayScale: displayScale,
  );

  Rect polygonBounds(List<core_domain.PointData> points) => visionPolygonToScreenBounds(
    points,
    videoWidth: videoWidth,
    videoHeight: videoHeight,
    isIPadLandscape: isIPadLandscape,
    displayWidth: displayWidth,
    displayHeight: displayHeight,
    displayScale: displayScale,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaViewport &&
          other.videoWidth == videoWidth &&
          other.videoHeight == videoHeight &&
          other.isIPadLandscape == isIPadLandscape &&
          other.displayWidth == displayWidth &&
          other.displayHeight == displayHeight &&
          other.displayScale == displayScale &&
          other.rotationDegrees == rotationDegrees;

  @override
  int get hashCode => Object.hash(
    videoWidth,
    videoHeight,
    isIPadLandscape,
    displayWidth,
    displayHeight,
    displayScale,
    rotationDegrees,
  );
}
