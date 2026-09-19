import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'interest_area.dart';
import 'interest_area_state.dart';

part 'interest_area_notifier.g.dart';

abstract interface class InterestAreaController {
  void start(List<InterestArea> activeAreas);
  void stop();
}

@riverpod
class InterestAreaNotifier extends _$InterestAreaNotifier implements InterestAreaController {
  static const int maxEditingAreas = 2;
  final _random = math.Random();

  /// Keep-alive link to prevent the notifier from being disposed while the camera is active.
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  var _keepAliveLink; // KeepAliveLink — not exported from flutter_riverpod barrel

  bool _started = false;

  @override
  InterestAreaState build() {
    ref.onDispose(() {
      stop();
    });

    return const InterestAreaState.initial();
  }

  @override
  void start(List<InterestArea> activeAreas) {
    if (_started) {
      return;
    }
    _started = true;
    reset(areas: activeAreas);
    _keepAliveLink = ref.keepAlive();
  }

  @override
  void stop() {
    if (!_started) {
      return;
    }
    _started = false;

    _keepAliveLink?.close();
    _keepAliveLink = null;
  }

  void startEditing({required int videoWidth, required int videoHeight}) {
    final areas = state.activeAreas.isEmpty
        ? <InterestArea>[_buildDefaultArea(videoWidth, videoHeight)]
        : List<InterestArea>.from(state.activeAreas).take(maxEditingAreas).toList();
    final firstPoints = areas.isNotEmpty ? areas.first.points : const <Offset>[];
    state = state.copyWith(
      isEditing: true,
      editingAreas: areas,
      selectedAreaId: areas.isNotEmpty ? areas.first.id : null,
      selectedPointIndex: firstPoints.isNotEmpty ? 0 : null,
    );
  }

  void finishEditing() {
    final areas = state.editingAreas;
    state = state.copyWith(
      isEditing: false,
      activeAreas: List<InterestArea>.from(areas),
      selectedAreaId: null,
      selectedPointIndex: null,
    );
  }

  void cancelEditing() {
    state = state.copyWith(
      isEditing: false,
      editingAreas: state.activeAreas,
      selectedAreaId: null,
      selectedPointIndex: null,
    );
  }

  void reset({List<InterestArea> areas = const []}) {
    InterestArea.resetNextId();
    state = const InterestAreaState.initial();
    if (areas.isNotEmpty) {
      state = state.copyWith(activeAreas: areas);
    }
  }

  void setActiveAreas(List<InterestArea> areas) {
    state = state.copyWith(activeAreas: List<InterestArea>.from(areas), selectedAreaId: null, selectedPointIndex: null);
  }

  void clearActiveAreas() {
    state = state.copyWith(activeAreas: const [], selectedAreaId: null, selectedPointIndex: null);
  }

  void selectArea(int? areaId) {
    if (areaId == null) {
      state = state.copyWith(selectedAreaId: null, selectedPointIndex: null);
      return;
    }

    final areas = state.isEditing ? state.editingAreas : state.activeAreas;
    final area = areas.firstWhere(
      (area) => area.id == areaId,
      orElse: () => InterestArea(id: areaId, name: '', points: const []),
    );
    final resetSelectedPoint =
        (area.points.isNotEmpty && state.selectedPointIndex == null) ||
        (state.selectedPointIndex != null && state.selectedPointIndex! >= area.points.length);
    state = state.copyWith(
      selectedAreaId: areaId,
      selectedPointIndex: resetSelectedPoint ? 0 : state.selectedPointIndex,
    );
  }

  void selectPoint(int areaId, int pointIndex) {
    state = state.copyWith(selectedAreaId: areaId, selectedPointIndex: pointIndex);
  }

  void clearSelection() {
    state = state.copyWith(selectedAreaId: null, selectedPointIndex: null);
  }

  void addEditingArea(InterestArea area) {
    if (state.editingAreas.length >= maxEditingAreas) {
      return;
    }
    final color = area.color == const Color(0x00000000) ? _nextAreaColorForIndex(area.id) : area.color;
    final normalized = area.copyWith(color: color, points: _randomizeAreaPoints(area.points));
    state = state.copyWith(editingAreas: [...state.editingAreas, normalized], selectedPointIndex: null);
  }

  void removeSelectedArea() {
    final selectedId = state.selectedAreaId;
    if (selectedId == null) return;
    if (state.isEditing) {
      removeEditingArea(selectedId);
    }
    clearSelection();
  }

  bool addPointToArea() {
    if (!state.isEditing) return false;

    final selectedId = state.selectedAreaId;
    if (selectedId == null) return false;

    final index = state.editingAreas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return false;

    final area = state.editingAreas[index];
    final autoPoint = _midpointOfLongestEdge(area.points);
    final insertion = _insertPointOnNearestEdge(area.points, autoPoint);
    final updated = area.copyWith(points: insertion.points);
    _replaceEditingArea(updated);
    selectPoint(updated.id, insertion.insertedIndex);
    return true;
  }

  void removeSelectedPoint() {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    final selectedPoint = state.selectedPointIndex;
    if (selectedId == null || selectedPoint == null) return;

    final index = state.editingAreas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;
    final area = state.editingAreas[index];
    final points = List<Offset>.from(area.points);
    if (selectedPoint < 0 || selectedPoint >= points.length) return;
    points.removeAt(selectedPoint);

    if (points.length < 3) {
      removeEditingArea(area.id);
      clearSelection();
      return;
    }

    final updated = area.copyWith(points: points);
    _replaceEditingArea(updated);
    final nextIndex = selectedPoint >= points.length ? points.length - 1 : selectedPoint;
    selectPoint(updated.id, nextIndex);
  }

  void moveSelectedArea(Offset delta) {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    if (selectedId == null) return;
    final index = state.editingAreas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;

    final area = state.editingAreas[index];
    final moved = area.points.map((point) => point + delta).toList(growable: false);
    final updated = area.copyWith(points: moved);
    _replaceEditingArea(updated);
  }

  void moveSelectedPoint(Offset delta) {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    final pointIndex = state.selectedPointIndex;
    if (selectedId == null || pointIndex == null) return;
    final index = state.editingAreas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;
    final area = state.editingAreas[index];
    if (pointIndex < 0 || pointIndex >= area.points.length) return;
    final points = List<Offset>.from(area.points);
    points[pointIndex] = points[pointIndex] + delta;
    final updated = area.copyWith(points: points);
    _replaceEditingArea(updated);
  }

  void updateSelectedAreaName(String newName) {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    if (selectedId == null) return;
    final index = state.editingAreas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;
    final area = state.editingAreas[index];
    final updated = area.copyWith(name: newName);
    _replaceEditingArea(updated);
  }

  void removeEditingArea(int areaId) {
    if (!state.isEditing) return;
    state = state.copyWith(editingAreas: state.editingAreas.where((area) => area.id != areaId).toList());
  }

  void _replaceEditingArea(InterestArea updated) {
    final updatedAreas = state.editingAreas
        .map((area) => area.id == updated.id ? updated : area)
        .toList(growable: false);
    state = state.copyWith(editingAreas: updatedAreas);
  }

  InterestArea _buildDefaultArea(int videoWidth, int videoHeight) {
    final size = math.min(videoWidth, videoHeight) * 0.3;
    final center = Offset(videoWidth / 2, videoHeight / 2);
    final rect = Rect.fromCenter(center: center, width: size, height: size);
    final points = <Offset>[
      _screenToVisionPoint(rect.topLeft, videoWidth, videoHeight),
      _screenToVisionPoint(rect.topRight, videoWidth, videoHeight),
      _screenToVisionPoint(rect.bottomRight, videoWidth, videoHeight),
      _screenToVisionPoint(rect.bottomLeft, videoWidth, videoHeight),
    ];

    int id = InterestArea.nextId;
    final context = appkit.navigatorKey.currentContext;
    String areaName = '';
    if (context != null) {
      //areaName = '${context.l.area_short} $id';
      areaName = 'Area $id'; // todo: replace with localized name if context is available
    } else {
      areaName = 'Area $id';
    }

    return InterestArea(id: id, name: areaName, color: _nextAreaColorForIndex(id), points: points, enabled: true);
  }

  void newArea(int videoWidth, int videoHeight) {
    if (!state.isEditing) return;

    final size = math.min(videoWidth, videoHeight) * 0.3;
    final id = InterestArea.nextId;
    final offsetDelta = 30.0 + (id % 10);
    final rect = Rect.fromCenter(
      center: Offset(videoWidth / 2 + offsetDelta, videoHeight / 2 + offsetDelta),
      width: size,
      height: size,
    );
    final points = <Offset>[
      _screenToVisionPoint(rect.topLeft, videoWidth, videoHeight),
      _screenToVisionPoint(rect.topRight, videoWidth, videoHeight),
      _screenToVisionPoint(rect.bottomRight, videoWidth, videoHeight),
      _screenToVisionPoint(rect.bottomLeft, videoWidth, videoHeight),
    ];
    final context = appkit.navigatorKey.currentContext;
    String areaName = '';
    if (context != null) {
      //areaName = '${context.l.area_short} $id';
      areaName = 'Area $id'; // todo: replace with localized name if context is available
    } else {
      areaName = 'Area $id';
    }
    final area = InterestArea(id: id, name: areaName, color: _nextAreaColorForIndex(id), points: points, enabled: true);

    addEditingArea(area);
    selectArea(area.id);
  }

  List<Offset> _randomizeAreaPoints(List<Offset> points) {
    final dx = (_random.nextDouble() * 2 - 1) * 180;
    final dy = (_random.nextDouble() * 2 - 1) * 140;
    final offset = Offset(dx, dy);

    return points.map((point) => point + offset).toList(growable: false);
  }

  _InsertionResult _insertPointOnNearestEdge(List<Offset> points, Offset point) {
    if (points.length < 2) {
      final newPoints = [...points, point];
      return _InsertionResult(points: newPoints, insertedIndex: newPoints.length - 1);
    }

    var minDistance = double.infinity;
    var insertAfter = 0;

    for (var i = 0; i < points.length; i++) {
      final start = points[i];
      final end = points[(i + 1) % points.length];
      final distance = _distanceToSegment(point, start, end);
      if (distance < minDistance) {
        minDistance = distance;
        insertAfter = i;
      }
    }

    final newPoints = [...points];
    final insertIndex = insertAfter + 1;
    newPoints.insert(insertIndex, point);
    return _InsertionResult(points: newPoints, insertedIndex: insertIndex);
  }

  double _distanceToSegment(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final ap = p - a;
    final abLen2 = ab.dx * ab.dx + ab.dy * ab.dy;
    if (abLen2 == 0) return (p - a).distance;
    final t = ((ap.dx * ab.dx) + (ap.dy * ab.dy)) / abLen2;
    final clampedT = t < 0 ? 0 : (t > 1 ? 1 : t);
    final projection = Offset(a.dx + ab.dx * clampedT, a.dy + ab.dy * clampedT);
    return (p - projection).distance;
  }

  Offset _midpointOfLongestEdge(List<Offset> points) {
    assert(points.length >= 2, 'At least two points are required to find the longest edge.');
    var maxDistance = -1.0;
    Offset? midpoint;
    for (var i = 0; i < points.length; i++) {
      final start = points[i];
      final end = points[(i + 1) % points.length];
      final distance = (end - start).distance;
      if (distance > maxDistance) {
        maxDistance = distance;
        midpoint = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      }
    }
    return midpoint!;
  }

  Offset _screenToVisionPoint(Offset screenPoint, int videoWidth, int videoHeight) {
    return Offset((videoWidth / 2) - screenPoint.dx, (videoHeight / 2) - screenPoint.dy);
  }

  Color _nextAreaColorForIndex(int index) {
    const palette = [Colors.purple, Colors.orange, Colors.pink, Colors.blue, Colors.green, Colors.teal, Colors.indigo];
    return palette[index % palette.length];
  }
}

class _InsertionResult {
  const _InsertionResult({required this.points, required this.insertedIndex});

  final List<Offset> points;
  final int insertedIndex;
}
