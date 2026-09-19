import 'dart:async';
import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'interest_area_state.dart';

part 'interest_area_notifier.g.dart';

abstract interface class InterestAreaController {
  /// Loads [areas]. After the user edits them, [onPersist] is called (debounced, so
  /// effectively once dragging stops) with the latest list. This replaces the old
  /// "save" step: put your storage/upload code in the callback.
  void start(List<core_domain.InterestArea> areas, {void Function(List<core_domain.InterestArea> areas)? onPersist});
  void stop();
  void reset();
}

@riverpod
class InterestAreaNotifier extends _$InterestAreaNotifier implements InterestAreaController {
  static const int maxEditingAreas = 2;

  /// Edits are applied to `state.areas` instantly; persistence waits this long after the
  /// last change so a drag produces one write, not hundreds.
  static const Duration _persistDebounce = Duration(milliseconds: 400);

  final _random = math.Random();

  /// Keep-alive link to prevent the notifier from being disposed while the camera is active.
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  var _keepAliveLink; // KeepAliveLink — not exported from flutter_riverpod barrel

  bool _started = false;

  Timer? _persistTimer;
  List<core_domain.InterestArea>? _pendingPersist;
  void Function(List<core_domain.InterestArea> areas)? _onPersist;

  @override
  InterestAreaState build() {
    ref.onDispose(() {
      stop();
    });

    return const InterestAreaState.initial();
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void start(List<core_domain.InterestArea> areas, {void Function(List<core_domain.InterestArea> areas)? onPersist}) {
    if (_started) {
      return;
    }
    _started = true;
    _onPersist = onPersist;
    core_domain.InterestArea.resetNextId();
    state = const InterestAreaState.initial();
    state = state.copyWith(areas: areas);
    _keepAliveLink = ref.keepAlive();
  }

  @override
  void stop() {
    if (!_started) {
      return;
    }
    _started = false;

    // Don't lose the last edit if we stop within the debounce window.
    flushPersist();
    _onPersist = null;

    _keepAliveLink?.close();
    _keepAliveLink = null;
  }

  /// Lifecycle reset (not the user-facing "start over", see [resetAreas]).
  @override
  void reset() {
    flushPersist();
    core_domain.InterestArea.resetNextId();
    state = const InterestAreaState.initial();
  }

  // ---------------------------------------------------------------------------
  // Persistence
  // ---------------------------------------------------------------------------

  void _schedulePersist() {
    _pendingPersist = state.areas;
    _persistTimer?.cancel();
    _persistTimer = Timer(_persistDebounce, flushPersist);
  }

  /// Writes any pending change right now. Safe to call at any time (e.g. when the app is
  /// sent to the background).
  void flushPersist() {
    _persistTimer?.cancel();
    _persistTimer = null;
    final pending = _pendingPersist;
    _pendingPersist = null;
    if (pending != null) {
      _onPersist?.call(pending);
    }
  }

  void _persistNow() {
    _schedulePersist();
    flushPersist();
  }

  // ---------------------------------------------------------------------------
  // Editing mode (UI only: shows handles and gestures. There is no draft any more.)
  // ---------------------------------------------------------------------------

  void startEditing({required int videoWidth, required int videoHeight}) {
    final areas = state.areas;
    final firstPoints = areas.isNotEmpty ? areas.first.points : const <core_domain.PointData>[];
    state = state.copyWith(
      isEditing: true,
      selectedAreaId: areas.isNotEmpty ? areas.first.id : null,
      selectedPointIndex: firstPoints.isNotEmpty ? 0 : null,
    );
  }

  /// Leaves editing mode and writes immediately. Returns the current areas so existing
  /// callers keep compiling, but persistence now happens through `onPersist`.
  List<core_domain.InterestArea> finishEditing() {
    state = state.copyWith(isEditing: false, selectedAreaId: null, selectedPointIndex: null);
    flushPersist();
    return state.areas;
  }

  // ---------------------------------------------------------------------------
  // Bulk operations
  // ---------------------------------------------------------------------------

  /// Replaces all areas from an external source (e.g. loading saved config). Does NOT persist.
  void setAreas(List<core_domain.InterestArea> areas) {
    _persistTimer?.cancel();
    _persistTimer = null;
    _pendingPersist = null;
    state = state.copyWith(
      areas: List<core_domain.InterestArea>.from(areas),
      selectedAreaId: null,
      selectedPointIndex: null,
    );
  }

  /// Clears all areas without persisting (programmatic use, same as the old clearActiveAreas).
  void clearAreas() {
    _persistTimer?.cancel();
    _persistTimer = null;
    _pendingPersist = null;
    state = state.copyWith(areas: const [], selectedAreaId: null, selectedPointIndex: null);
  }

  /// User-facing "start over" button: removes every area and persists immediately.
  void resetAreas() {
    state = state.copyWith(areas: const [], selectedAreaId: null, selectedPointIndex: null);
    _persistNow();
  }

  // ---------------------------------------------------------------------------
  // Selection
  // ---------------------------------------------------------------------------

  void selectArea(int? areaId) {
    if (areaId == null) {
      state = state.copyWith(selectedAreaId: null, selectedPointIndex: null);
      return;
    }

    final area = state.areas.firstWhere(
      (area) => area.id == areaId,
      orElse: () => core_domain.InterestArea(id: areaId, name: '', points: const []),
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

  // ---------------------------------------------------------------------------
  // Mutations (every one of these goes live immediately and schedules a persist)
  // ---------------------------------------------------------------------------

  void addArea(core_domain.InterestArea area) {
    if (state.areas.length >= maxEditingAreas) {
      return;
    }
    final color = area.color == const Color(0x00000000) ? _nextAreaColorForIndex(area.id) : area.color;
    final normalized = area.copyWith(savedColor: color.toARGB32(), points: _randomizeAreaPoints(area.points));
    state = state.copyWith(areas: [...state.areas, normalized], selectedPointIndex: null);
    _schedulePersist();
  }

  void removeSelectedArea() {
    final selectedId = state.selectedAreaId;
    if (selectedId == null) return;
    if (state.isEditing) {
      removeArea(selectedId);
    }
    clearSelection();
  }

  bool addPointToArea() {
    if (!state.isEditing) return false;

    final selectedId = state.selectedAreaId;
    if (selectedId == null) return false;

    final index = state.areas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return false;

    final area = state.areas[index];
    final autoPoint = _midpointOfLongestEdge(area.points);
    final insertion = _insertPointOnNearestEdge(area.points, autoPoint);
    final updated = area.copyWith(points: insertion.points);
    _replaceArea(updated);
    selectPoint(updated.id, insertion.insertedIndex);
    return true;
  }

  void removeSelectedPoint() {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    final selectedPoint = state.selectedPointIndex;
    if (selectedId == null || selectedPoint == null) return;

    final index = state.areas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;
    final area = state.areas[index];
    final points = List<core_domain.PointData>.from(area.points);
    if (selectedPoint < 0 || selectedPoint >= points.length) return;
    points.removeAt(selectedPoint);

    if (points.length < 3) {
      removeArea(area.id);
      clearSelection();
      return;
    }

    final updated = area.copyWith(points: points);
    _replaceArea(updated);
    final nextIndex = selectedPoint >= points.length ? points.length - 1 : selectedPoint;
    selectPoint(updated.id, nextIndex);
  }

  void moveSelectedArea(core_domain.PointData delta) {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    if (selectedId == null) return;
    final index = state.areas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;

    final area = state.areas[index];
    final moved = area.points.map((point) => point + delta).toList(growable: false);
    final updated = area.copyWith(points: moved);
    _replaceArea(updated);
  }

  void moveSelectedPoint(core_domain.PointData delta) {
    if (!state.isEditing) return;
    final selectedId = state.selectedAreaId;
    final pointIndex = state.selectedPointIndex;
    if (selectedId == null || pointIndex == null) return;
    final index = state.areas.indexWhere((area) => area.id == selectedId);
    if (index == -1) return;
    final area = state.areas[index];
    if (pointIndex < 0 || pointIndex >= area.points.length) return;
    final points = List<core_domain.PointData>.from(area.points);
    points[pointIndex] = points[pointIndex] + delta;
    final updated = area.copyWith(points: points);
    _replaceArea(updated);
  }

  void updateSelectedAreaName(String newName) {
    final selectedId = state.selectedAreaId;
    if (selectedId == null) return;
    updateAreaName(selectedId, newName);
  }

  /// Updates the name of an area regardless of selection, used by the inline label editor.
  void updateAreaName(int areaId, String newName) {
    if (!state.isEditing) return;
    final index = state.areas.indexWhere((area) => area.id == areaId);
    if (index == -1) return;
    final area = state.areas[index];
    final updated = area.copyWith(name: newName);
    _replaceArea(updated);
  }

  void removeArea(int areaId) {
    if (!state.isEditing) return;
    state = state.copyWith(areas: state.areas.where((area) => area.id != areaId).toList());
    _schedulePersist();
  }

  void _replaceArea(core_domain.InterestArea updated) {
    final updatedAreas = state.areas.map((area) => area.id == updated.id ? updated : area).toList(growable: false);
    state = state.copyWith(areas: updatedAreas);
    _schedulePersist();
  }

  // ---------------------------------------------------------------------------
  // Area creation
  // ---------------------------------------------------------------------------

  core_domain.InterestArea _buildDefaultArea(int videoWidth, int videoHeight) {
    final size = math.min(videoWidth, videoHeight) * 0.3;
    final center = Offset(videoWidth / 2, videoHeight / 2);
    final rect = Rect.fromCenter(center: center, width: size, height: size);
    final points = <core_domain.PointData>[
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.topLeft), videoWidth, videoHeight),
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.topRight), videoWidth, videoHeight),
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.bottomRight), videoWidth, videoHeight),
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.bottomLeft), videoWidth, videoHeight),
    ];

    int id = core_domain.InterestArea.nextId;
    final context = appkit.navigatorKey.currentContext;
    String areaName = '';
    if (context != null) {
      //areaName = '${context.l.area_short} $id';
      areaName = 'Area $id'; // todo: replace with localized name if context is available
    } else {
      areaName = 'Area $id';
    }

    return core_domain.InterestArea(
      id: id,
      name: areaName,
      savedColor: _nextAreaColorForIndex(id).toARGB32(),
      points: points,
      enabled: true,
    );
  }

  void newArea(int videoWidth, int videoHeight) {
    if (!state.isEditing) return;

    final size = math.min(videoWidth, videoHeight) * 0.3;
    final id = core_domain.InterestArea.nextId;
    final offsetDelta = 30.0 + (id % 10);
    final rect = Rect.fromCenter(
      center: Offset(videoWidth / 2 + offsetDelta, videoHeight / 2 + offsetDelta),
      width: size,
      height: size,
    );
    final points = <core_domain.PointData>[
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.topLeft), videoWidth, videoHeight),
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.topRight), videoWidth, videoHeight),
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.bottomRight), videoWidth, videoHeight),
      _screenToVisionPoint(core_domain.PointData.fromOffset(rect.bottomLeft), videoWidth, videoHeight),
    ];
    final context = appkit.navigatorKey.currentContext;
    String areaName = '';
    if (context != null) {
      //areaName = '${context.l.area_short} $id';
      areaName = 'Area $id'; // todo: replace with localized name if context is available
    } else {
      areaName = 'Area $id';
    }
    final area = core_domain.InterestArea(
      id: id,
      name: areaName,
      savedColor: _nextAreaColorForIndex(id).toARGB32(),
      points: points,
      enabled: true,
    );

    addArea(area);
    selectArea(area.id);
  }

  List<core_domain.PointData> _randomizeAreaPoints(List<core_domain.PointData> points) {
    final dx = (_random.nextDouble() * 2 - 1) * 180;
    final dy = (_random.nextDouble() * 2 - 1) * 140;
    final offset = core_domain.PointData(dx: dx, dy: dy);

    return points.map((point) => point + offset).toList(growable: false);
  }

  _InsertionResult _insertPointOnNearestEdge(List<core_domain.PointData> points, core_domain.PointData point) {
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

  double _distanceToSegment(core_domain.PointData p, core_domain.PointData a, core_domain.PointData b) {
    final ab = b - a;
    final ap = p - a;
    final abLen2 = ab.dx * ab.dx + ab.dy * ab.dy;
    if (abLen2 == 0) return (p - a).distance;
    final t = ((ap.dx * ab.dx) + (ap.dy * ab.dy)) / abLen2;
    final clampedT = t < 0 ? 0 : (t > 1 ? 1 : t);
    final projection = core_domain.PointData(dx: a.dx + ab.dx * clampedT, dy: a.dy + ab.dy * clampedT);
    return (p - projection).distance;
  }

  core_domain.PointData _midpointOfLongestEdge(List<core_domain.PointData> points) {
    assert(points.length >= 2, 'At least two points are required to find the longest edge.');
    var maxDistance = -1.0;
    core_domain.PointData? midpoint;
    for (var i = 0; i < points.length; i++) {
      final start = points[i];
      final end = points[(i + 1) % points.length];
      final distance = (end - start).distance;
      if (distance > maxDistance) {
        maxDistance = distance;
        midpoint = core_domain.PointData(dx: (start.dx + end.dx) / 2, dy: (start.dy + end.dy) / 2);
      }
    }
    return midpoint!;
  }

  core_domain.PointData _screenToVisionPoint(core_domain.PointData screenPoint, int videoWidth, int videoHeight) {
    return core_domain.PointData(dx: (videoWidth / 2) - screenPoint.dx, dy: (videoHeight / 2) - screenPoint.dy);
  }

  Color _nextAreaColorForIndex(int index) {
    const palette = [Colors.purple, Colors.orange, Colors.pink, Colors.blue, Colors.green, Colors.teal, Colors.indigo];
    return palette[index % palette.length];
  }
}

class _InsertionResult {
  const _InsertionResult({required this.points, required this.insertedIndex});

  final List<core_domain.PointData> points;
  final int insertedIndex;
}
