import 'dart:math';

import 'package:counter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vision/vision.dart' as vision;

import 'project_provider.dart';
import 'zone_color_table.dart';

double _pointDetectRadius = UniversalPlatform.isAndroid || UniversalPlatform.isIOS ? 48.0 : 18.0;

/// This class provides support for the [ZoneEditor].
class ZoneEditorController with ChangeNotifier {
  List<vision.VideoZone> zones = [];
  bool isChanged = false;
  vision.VideoZone? selectedZone;
  Offset? dragStartPosition;
  bool isDraggingPolygon = false;
  bool isDraggingPoint = false;

  int _mediaWidth = 500;
  int _mediaHeight = 500;

  int get mediaWidth => _mediaWidth;
  int get mediaHeight => _mediaHeight;
  bool get isEmpty => zones.isEmpty;

  /// called when zone is changed
  VoidCallback? onZoneChanged;

  void setMediaSize(int width, int height) {
    _mediaWidth = width;
    _mediaHeight = height;
    notifyListeners();
  }

  void selectPolygon(Offset modelPoint) {
    // First try to select a point
    for (var polygon in zones) {
      for (var i = 0; i < polygon.points.length; i++) {
        final d = (polygon.points[i] - modelPoint).distance;
        if (d < _pointDetectRadius) {
          selectedZone = polygon;
          selectedZone!.selectedPointIndex = i;
          isDraggingPolygon = false;
          isDraggingPoint = true;
          moveZoneToFront(polygon);
          return;
        }
      }
    }

    // Then try to select a polygon
    for (var polygon in zones) {
      if (_isPointInsidePolygon(modelPoint, polygon.points)) {
        selectedZone = polygon;
        dragStartPosition = modelPoint;
        isDraggingPolygon = true;
        isDraggingPoint = false;
        moveZoneToFront(polygon);
        return;
      }
    }

    // Clear dragging state if nothing was selected
    if (selectedZone != null) {
      dragStartPosition = null;
      isDraggingPolygon = false;
      isDraggingPoint = false;
      notifyListeners();
    }
  }

  void updatePointPosition(Offset modelPoint) {
    if (selectedZone == null) return;

    if (isDraggingPoint && !isDraggingPolygon) {
      selectedZone!.points[selectedZone!.selectedPointIndex] = modelPoint;
      notifyListeners();
    } else if (isDraggingPolygon && dragStartPosition != null) {
      final dx = modelPoint.dx - dragStartPosition!.dx;
      final dy = modelPoint.dy - dragStartPosition!.dy;
      for (var i = 0; i < selectedZone!.points.length; i++) {
        selectedZone!.points[i] = Offset(
          selectedZone!.points[i].dx + dx,
          selectedZone!.points[i].dy + dy,
        );
      }
      dragStartPosition = modelPoint;
      notifyListeners();
    }
    onZoneChanged?.call();
  }

  // End the dragging operation
  void endDragging() {
    isDraggingPolygon = false;
    isDraggingPoint = false;
    dragStartPosition = null;
    notifyListeners();
    isChanged = true;
    onZoneChanged?.call();
  }

  // Check if a point is inside a polygon
  bool _isPointInsidePolygon(Offset point, List<Offset> points) {
    int intersections = 0;
    for (int i = 0; i < points.length; i++) {
      Offset p1 = points[i];
      Offset p2 = points[(i + 1) % points.length];
      if ((p1.dy > point.dy) != (p2.dy > point.dy)) {
        double slope = (p2.dx - p1.dx) / (p2.dy - p1.dy);
        double x = p1.dx + slope * (point.dy - p1.dy);
        if (x > point.dx) {
          intersections++;
        }
      }
    }
    return (intersections % 2) == 1;
  }

  // This method brings the specified polygon to the front of the list.
  // This is typically used to ensure that the selected polygon is drawn last and therefore appears on top of the others.
  void moveZoneToFront(vision.VideoZone videoZone) {
    // Remove the polygon from the list
    zones.remove(videoZone);
    // Add the polygon back to the end of the list
    zones.insert(0, videoZone);
    // Notify listeners that a change has occurred
    notifyListeners();
    isChanged = true;
    onZoneChanged?.call();
  }

  /// Sets the selected zone.
  void setSelectedZone(vision.VideoZone zone) {
    selectedZone = zone;
    moveZoneToFront(zone);
    notifyListeners();
  }

  /// Moves the selected polygon to the bottom of the stack.
  void moveZoneToBottom() {
    if (selectedZone != null) {
      zones.remove(selectedZone);
      zones.add(selectedZone!);
      notifyListeners();
      isChanged = true;
      onZoneChanged?.call();
    }
  }

  // This method creates a new point on the selected polygon.
  // The new point is placed at the midpoint of the longest side of the polygon.
  void addPoint() {
    // If no polygon is selected, do nothing
    if (selectedZone == null) return;

    // Initialize the maximum distance and index
    double maxDistance = -1;
    int maxIndex = -1;

    // Iterate over each point in the polygon
    for (int i = 0; i < selectedZone!.points.length; i++) {
      // Get the current point and the next point
      Offset p1 = selectedZone!.points[i];
      Offset p2 = selectedZone!.points[(i + 1) % selectedZone!.points.length];
      // Calculate the distance between the two points
      double distance = (p1 - p2).distance;

      // If this distance is the largest so far, update the maximum distance and index
      if (distance > maxDistance) {
        maxDistance = distance;
        maxIndex = i;
      }
    }

    // If a maximum index was found, create a new point
    if (maxIndex != -1) {
      // Get the two points that form the longest side
      Offset p1 = selectedZone!.points[maxIndex];
      Offset p2 = selectedZone!.points[(maxIndex + 1) % selectedZone!.points.length];
      // Calculate the midpoint of the longest side
      Offset newPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

      // Insert the new point into the list of points
      selectedZone!.points.insert(maxIndex + 1, newPoint);
      // Set the new point as the selected point
      selectedZone!.selectedPointIndex = maxIndex + 1;
      // Notify listeners that a change has occurred
      notifyListeners();
      isChanged = true;
      onZoneChanged?.call();
    }
  }

  // This method removes the selected point from the selected polygon.
  // It does nothing if the selected polygon has only three points (since a polygon must have at least three points).
  void removePoint() {
    if (selectedZone != null) {
      if (selectedZone!.points.length > 3) {
        selectedZone!.points.removeAt(selectedZone!.selectedPointIndex);
        selectedZone!.selectedPointIndex = 0;
        notifyListeners();
        isChanged = true;
        onZoneChanged?.call();
      }
    }
  }

  // This method adds a new polygon to the list of polygons.
  // The points of the new polygon are scaled according to the current scale factors.
  vision.VideoZone addZone(BuildContext context) {
    // Define the size of the image
    final double mediaWidth = _mediaWidth.toDouble();
    final double mediaHeight = _mediaHeight.toDouble();

    // Define the radius of the hexagon, ensuring it occupies about 1/4 of the image
    final double maxRadius = min(mediaWidth, mediaHeight) / 2;
    final double radius = maxRadius;

    // Define the center of the hexagon to be in the middle of the image
    final double centerX = mediaWidth / 2;
    final double centerY = mediaHeight / 2;

    // Generate the vertices of the hexagon
    List<Offset> points = [];
    for (int i = 0; i < 6; i++) {
      double angle = (pi / 3) * i; // One vertex every 60 degrees
      double x = centerX + (radius * cos(angle));
      double y = centerY + (radius * sin(angle));
      points.add(Offset(x, y));
    }
    // Adjust the coordinates of the points according to the scaling factor
    List<Offset> scaledPoints = points.map((p) => Offset(p.dx, p.dy)).toList();
    final projectProvider = ProjectProvider.of(context);
    final nextZoneId = projectProvider.getNextZoneId();
    final polygon = vision.VideoZone(
      tallyAnnotations: vision.defaultTallyAnnotation(context),
      zoneId: nextZoneId,
      name: '${context.l.default_zone_name} $nextZoneId',
      points: scaledPoints,
      color: getNextZoneColor(),
    );
    selectedZone = polygon;
    zones.insert(0, polygon);
    notifyListeners();
    isChanged = true;
    onZoneChanged?.call();
    return polygon;
  }

  // This method removes the selected zone from the list of zone.
  // It does nothing if there is only one polygon in the list.
  // After the selected polygon is removed, the first polygon in the list becomes the new selected polygon.
  void removeSelectedZone() {
    if (selectedZone != null) {
      removeZone(selectedZone!);
    }
  }

  /// Returns true if the zone can be removed.
  bool isZoneAllowRemove() {
    return zones.length > 1;
  }

  /// Removes the specified zone from the list of zones.
  void removeZone(vision.VideoZone zone) {
    zones.remove(zone);
    if (zones.isNotEmpty) {
      selectedZone = zones[0];
    } else {
      selectedZone = null;
    }
    notifyListeners();
    isChanged = true;
    onZoneChanged?.call();
  }

  List<vision.VideoZone> getProjectZones() {
    return zones;
  }

  /// Updates the list of polygons in the zoning editor.
  void setZones(List<vision.VideoZone> value) {
    zones.clear();
    zones.addAll(value);
    selectedZone = null;
    if (zones.isNotEmpty) {
      selectedZone = zones[0];
    }
    notifyListeners();
  }

  // This method resets the state of the controller.
  // It clears the list of polygons and sets the selected polygon to null.
  // After the state has been reset, it notifies any listeners that the state has changed.
  void reset() {
    zones.clear();
    selectedZone = null;
    notifyListeners();
    isChanged = true;
    onZoneChanged?.call();
  }
}
