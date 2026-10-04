// interest_area_editor_overlay.dart
// ============================================================================
// Table of Contents
// ============================================================================
// 1. InterestAreaEditorOverlay widget (gestures + drag state only)
// 2. Editor painter
// ============================================================================

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

import 'area_occupancy_overlay.dart';
import 'area_painting.dart';
import 'area_viewport.dart';
import 'inline_label_editor.dart';

enum _DragMode { none, area, point }

class InterestAreaEditorOverlay extends ConsumerStatefulWidget {
  const InterestAreaEditorOverlay({required this.viewport, super.key});

  final AreaViewport viewport;

  @override
  ConsumerState<InterestAreaEditorOverlay> createState() => _InterestAreaEditorOverlayState();
}

class _InterestAreaEditorOverlayState extends ConsumerState<InterestAreaEditorOverlay> {
  // Larger hit radius on mobile to account for finger size.
  static const double _desktopSelectionHitRadius = 24.0;
  static const double _mobileSelectionHitRadius = 40.0;
  static const double _labelEditorMinWidth = 90.0;

  _DragMode _dragMode = _DragMode.none;
  core_domain.PointData? _lastVisionPoint;
  int? _editingLabelAreaId;

  AreaViewport get _viewport => widget.viewport;
  bool get _isMobile => UniversalPlatform.isIOS || UniversalPlatform.isAndroid;
  double get _hitRadius => _isMobile ? _mobileSelectionHitRadius : _desktopSelectionHitRadius;

  // --------------------------------------------------------------------------
  // Label editing
  // --------------------------------------------------------------------------

  void _startLabelEdit(core_domain.InterestArea area) {
    setState(() => _editingLabelAreaId = area.id);
  }

  void _onLabelCommitted(int areaId, String text) {
    ref.read(core_runtime.interestAreaProvider.notifier).updateAreaName(areaId, text);
    if (mounted && _editingLabelAreaId == areaId) {
      setState(() => _editingLabelAreaId = null);
    }
  }

  /// Dropping focus makes the InlineLabelEditor commit itself.
  void _commitLabelEditIfAny() {
    if (_editingLabelAreaId != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Widget? _buildLabelEditor(List<core_domain.InterestArea> areas) {
    final editingId = _editingLabelAreaId;
    if (editingId == null) return null;
    final area = areas.where((a) => a.id == editingId).firstOrNull;
    if (area == null || area.points.isEmpty) return null;

    final rect = AreaLabelLayout.backgroundRect(_viewport, area, Directionality.of(context));
    final width = rect.width < _labelEditorMinWidth ? _labelEditorMinWidth : rect.width;
    final left = rect.left - (width - rect.width) / 2;

    return Positioned(
      left: left,
      top: rect.top,
      width: width,
      height: rect.height,
      child: InlineLabelEditor(
        // Keyed so switching to a different area gets a fresh editor.
        key: ValueKey(editingId),
        color: area.color,
        initialText: area.name,
        onCommit: (text) => _onLabelCommitted(editingId, text),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Gestures
  // --------------------------------------------------------------------------

  void _onTapDown(TapDownDetails details) {
    // A tap anywhere else commits the in-progress label edit.
    if (_editingLabelAreaId != null) {
      _commitLabelEditIfAny();
      return;
    }

    final notifier = ref.read(core_runtime.interestAreaProvider.notifier);
    final areas = ref.read(core_runtime.interestAreaProvider).areas;
    final position = details.localPosition;

    final vertexHit = findVertexHit(_viewport, position, areas, _hitRadius);
    if (vertexHit != null) {
      notifier.selectPoint(vertexHit.areaId, vertexHit.pointIndex);
      return;
    }

    final labelHit = findLabelHit(_viewport, position, areas, Directionality.of(context));
    if (labelHit != null) {
      notifier.selectArea(labelHit.id);
      _startLabelEdit(labelHit);
      return;
    }

    final tapVision = _viewport.toVision(core_domain.PointData.fromOffset(position));
    final areaId = findAreaHit(tapVision, areas);
    if (areaId != null) {
      notifier.selectArea(areaId);
    } else {
      notifier.clearSelection();
    }
  }

  void _onPanStart(DragStartDetails details) {
    _commitLabelEditIfAny();

    final notifier = ref.read(core_runtime.interestAreaProvider.notifier);
    final areas = ref.read(core_runtime.interestAreaProvider).areas;
    final position = details.localPosition;

    final startVision = _viewport.toVision(core_domain.PointData.fromOffset(position));
    _lastVisionPoint = startVision;

    final vertexHit = findVertexHit(_viewport, position, areas, _hitRadius);
    if (vertexHit != null) {
      notifier.selectPoint(vertexHit.areaId, vertexHit.pointIndex);
      _dragMode = _DragMode.point;
      return;
    }

    final areaId = findAreaHit(startVision, areas);
    if (areaId != null) {
      notifier.selectArea(areaId);
      _dragMode = _DragMode.area;
      return;
    }

    _dragMode = _DragMode.none;
  }

  void _onPanUpdate(DragUpdateDetails details, Size bounds) {
    // Stop the drag if the pointer leaves the screen, so areas can't be dragged off-screen.
    final p = details.localPosition;
    if (p.dx < 0 || p.dx > bounds.width || p.dy < 0 || p.dy > bounds.height) {
      _resetDrag();
      return;
    }

    final last = _lastVisionPoint;
    if (last == null) return;

    final currentVision = _viewport.toVision(core_domain.PointData.fromOffset(p));
    final delta = currentVision - last;
    _lastVisionPoint = currentVision;

    final notifier = ref.read(core_runtime.interestAreaProvider.notifier);
    switch (_dragMode) {
      case _DragMode.point:
        notifier.moveSelectedPoint(delta);
      case _DragMode.area:
        notifier.moveSelectedArea(delta);
      case _DragMode.none:
        break;
    }
  }

  void _resetDrag() {
    _dragMode = _DragMode.none;
    _lastVisionPoint = null;
  }

  // --------------------------------------------------------------------------
  // Build
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Whether the editor is shown is decided by the parent (from the notifier's isEditing).
    final areaState = ref.watch(core_runtime.interestAreaProvider);
    final observationState = ref.watch(core_runtime.observationProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _onTapDown,
          onPanStart: _onPanStart,
          onPanUpdate: (details) => _onPanUpdate(details, constraints.biggest),
          onPanEnd: (_) => _resetDrag(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: _viewport.displaySize,
                painter: _InterestAreaEditorPainter(
                  viewport: _viewport,
                  areas: areaState.areas,
                  selectedAreaId: areaState.selectedAreaId,
                  selectedPointIndex: areaState.selectedPointIndex,
                  isMobile: _isMobile,
                  textDirection: Directionality.of(context),
                  editingLabelAreaId: _editingLabelAreaId,
                ),
              ),
              AreaOccupancyOverlay(viewport: _viewport, areas: areaState.areas, observationState: observationState),
              if (_buildLabelEditor(areaState.areas) case final labelEditor?) labelEditor,
            ],
          ),
        );
      },
    );
  }
}

class _InterestAreaEditorPainter extends CustomPainter {
  const _InterestAreaEditorPainter({
    required this.viewport,
    required this.areas,
    required this.selectedAreaId,
    required this.selectedPointIndex,
    required this.isMobile,
    required this.textDirection,
    this.editingLabelAreaId,
  });

  final AreaViewport viewport;
  final List<core_domain.InterestArea> areas;
  final int? selectedAreaId;
  final int? selectedPointIndex;
  final bool isMobile;
  final TextDirection textDirection;
  final int? editingLabelAreaId;

  @override
  void paint(Canvas canvas, Size size) {
    for (final area in areas) {
      final isSelected = area.id == selectedAreaId;
      _drawArea(canvas, area, isSelected: isSelected);
      // Skip the label while it's inline-edited; the TextField overlay shows it instead.
      if (area.enabled && area.points.isNotEmpty && area.id != editingLabelAreaId) {
        AreaLabelLayout.paint(canvas, viewport, area, textDirection);
      }
      if (isSelected) {
        _drawHandles(canvas, area);
      }
    }
  }

  void _drawArea(Canvas canvas, core_domain.InterestArea area, {required bool isSelected}) {
    paintAreaPath(
      canvas,
      viewport.polygonPath(area.points),
      strokeColor: area.color.withValues(alpha: area.enabled ? 0.7 : 0.3),
      fillAlpha: 0.12,
      strokeWidth: isSelected ? 3.0 : 2.0,
    );
  }

  void _drawHandles(Canvas canvas, core_domain.InterestArea area) {
    final unselectedRadius = isMobile ? 10.0 : 8.0;
    final selectedRadius = isMobile ? 15.0 : 12.0;
    for (var i = 0; i < area.points.length; i++) {
      final point = viewport.toScreen(area.points[i]);
      final isSelectedPoint = selectedPointIndex == i;
      canvas.drawCircle(
        point.offset,
        isSelectedPoint ? selectedRadius : unselectedRadius,
        Paint()
          ..color = isSelectedPoint ? Colors.yellow : area.color
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _InterestAreaEditorPainter oldDelegate) {
    return oldDelegate.areas != areas ||
        oldDelegate.viewport != viewport ||
        oldDelegate.selectedAreaId != selectedAreaId ||
        oldDelegate.selectedPointIndex != selectedPointIndex ||
        oldDelegate.isMobile != isMobile ||
        oldDelegate.textDirection != textDirection ||
        oldDelegate.editingLabelAreaId != editingLabelAreaId;
  }
}
