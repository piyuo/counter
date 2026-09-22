// ============================================================================
// Table of Contents
// ============================================================================
// 1. InterestAreaEditorOverlay widget
// 2. Editor painter
// ============================================================================

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

import 'interest_area_notifier.dart';
import 'interest_area_utils.dart';

class InterestAreaEditorOverlay extends ConsumerStatefulWidget {
  const InterestAreaEditorOverlay({
    required this.rotationDegrees,
    required this.isIPadLandscape,
    required this.displayWidth,
    required this.displayHeight,
    required this.displayScale,
    required this.videoWidth,
    required this.videoHeight,
    super.key,
  });

  final double videoWidth;
  final double videoHeight;

  final double rotationDegrees;

  final bool isIPadLandscape;

  /// Display width (overrides previewConstraints when rotating)
  final double displayWidth;

  /// Display height (overrides previewConstraints when rotating)
  final double displayHeight;

  /// Display scale (overrides previewConstraints when rotating)
  final double displayScale;

  @override
  ConsumerState<InterestAreaEditorOverlay> createState() => _InterestAreaEditorOverlayState();
}

class _InterestAreaEditorOverlayState extends ConsumerState<InterestAreaEditorOverlay> {
  // Larger hit radius for mobile devices to account for finger touch size
  static const double _desktopSelectionHitRadius = 24.0;
  static const double _mobileSelectionHitRadius = 40.0;
  static const double _labelEditorMinWidth = 90.0;

  _DragMode _dragMode = _DragMode.none;
  core_domain.PointData? _lastVisionPoint;

  int? _editingLabelAreaId;
  TextEditingController? _labelEditController;
  FocusNode? _labelFocusNode;

  double get _selectionHitRadius {
    return (UniversalPlatform.isIOS || UniversalPlatform.isAndroid)
        ? _mobileSelectionHitRadius
        : _desktopSelectionHitRadius;
  }

  @override
  void dispose() {
    _labelFocusNode?.removeListener(_onLabelFocusChange);
    _labelFocusNode?.dispose();
    _labelEditController?.dispose();
    super.dispose();
  }

  void _startLabelEdit(core_domain.InterestArea area) {
    final oldController = _labelEditController;
    final oldFocusNode = _labelFocusNode;

    _labelEditController = TextEditingController(text: area.name);
    _labelFocusNode = FocusNode()..addListener(_onLabelFocusChange);
    setState(() {
      _editingLabelAreaId = area.id;
    });

    // Deferred: disposing a FocusNode from within its own listener callback trips a "notifyListeners in
    // progress" assertion, so old resources are torn down after this tap's call stack unwinds.
    Future.microtask(() {
      oldFocusNode?.removeListener(_onLabelFocusChange);
      oldFocusNode?.dispose();
      oldController?.dispose();
    });
  }

  void _onLabelFocusChange() {
    // Tapping outside the field drops its focus; treat that as a save-and-close, like a spreadsheet cell.
    if (_labelFocusNode != null && !_labelFocusNode!.hasFocus) {
      _commitLabelEdit();
    }
  }

  void _commitLabelEdit() {
    final areaId = _editingLabelAreaId;
    final controller = _labelEditController;
    final focusNode = _labelFocusNode;
    if (areaId == null || controller == null) return;

    ref.read(interestAreaProvider.notifier).updateAreaName(areaId, controller.text.trim());

    _labelFocusNode = null;
    _labelEditController = null;
    setState(() {
      _editingLabelAreaId = null;
    });

    // Deferred: this may run from the FocusNode's own notifyListeners callback (losing focus), so
    // dispose after the current call stack unwinds instead of synchronously.
    Future.microtask(() {
      focusNode?.removeListener(_onLabelFocusChange);
      focusNode?.dispose();
      controller.dispose();
    });
  }

  core_domain.InterestArea? _findLabelHit(Offset localPosition, List<core_domain.InterestArea> areas) {
    final textDirection = Directionality.of(context);
    for (final area in areas) {
      if (!area.enabled || area.points.isEmpty || area.name.isEmpty) continue;
      final rect = _labelBackgroundRect(
        area: area,
        videoWidth: widget.videoWidth,
        videoHeight: widget.videoHeight,
        isIPadLandscape: widget.isIPadLandscape,
        displayWidth: widget.displayWidth,
        displayHeight: widget.displayHeight,
        displayScale: widget.displayScale,
        textDirection: textDirection,
      );
      if (rect.contains(localPosition)) {
        return area;
      }
    }
    return null;
  }

  Widget? _buildLabelEditor(List<core_domain.InterestArea> editingAreas) {
    final editingId = _editingLabelAreaId;
    if (editingId == null) return null;
    final area = editingAreas.firstWhere(
      (a) => a.id == editingId,
      orElse: () => core_domain.InterestArea(id: editingId, name: '', points: const []),
    );
    if (area.points.isEmpty) return null;

    final rect = _labelBackgroundRect(
      area: area,
      videoWidth: widget.videoWidth,
      videoHeight: widget.videoHeight,
      isIPadLandscape: widget.isIPadLandscape,
      displayWidth: widget.displayWidth,
      displayHeight: widget.displayHeight,
      displayScale: widget.displayScale,
      textDirection: Directionality.of(context),
    );
    final width = rect.width < _labelEditorMinWidth ? _labelEditorMinWidth : rect.width;
    final left = rect.left - (width - rect.width) / 2;

    return Positioned(
      left: left,
      top: rect.top,
      width: width,
      height: rect.height,
      child: Container(
        decoration: BoxDecoration(color: area.color.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(6)),
        alignment: Alignment.center,
        // TextField requires a Material ancestor; this overlay sits outside the app's Scaffold/Material tree.
        child: Material(
          type: MaterialType.transparency,
          child: TextField(
            controller: _labelEditController,
            focusNode: _labelFocusNode,
            autofocus: true,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _commitLabelEdit(),
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final areaState = ref.watch(interestAreaProvider);
    if (!areaState.isEditing) {
      return const SizedBox.shrink();
    }

    final notifier = ref.read(interestAreaProvider.notifier);

    Widget editor = LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            // A tap anywhere else commits the in-progress label edit, like clicking off a spreadsheet cell.
            if (_editingLabelAreaId != null) {
              _commitLabelEdit();
              return;
            }

            _lastVisionPoint = screenToVision(
              core_domain.PointData.fromOffset(details.localPosition),
              isIPadLandscape: widget.isIPadLandscape,
              videoWidth: widget.videoWidth,
              videoHeight: widget.videoHeight,
              displayWidth: widget.displayWidth,
              displayHeight: widget.displayHeight,
              displayScale: widget.displayScale,
            );
            final hitPoint = _findVertexHit(
              core_domain.PointData.fromOffset(details.localPosition),
              areaState.editingAreas,
              videoWidth: widget.videoWidth,
              videoHeight: widget.videoHeight,
              _selectionHitRadius,
              isIPadLandscape: widget.isIPadLandscape,
              displayWidth: widget.displayWidth,
              displayHeight: widget.displayHeight,
              displayScale: widget.displayScale,
            );

            if (hitPoint != null) {
              notifier.selectPoint(hitPoint.areaId, hitPoint.pointIndex);
              return;
            }

            final labelHitArea = _findLabelHit(details.localPosition, areaState.editingAreas);
            if (labelHitArea != null) {
              notifier.selectArea(labelHitArea.id);
              _startLabelEdit(labelHitArea);
              return;
            }

            final hitAreaId = _findAreaHit(_lastVisionPoint!, areaState.editingAreas);
            if (hitAreaId != null) {
              notifier.selectArea(hitAreaId);
            } else {
              notifier.clearSelection();
            }
          },
          onPanStart: (details) {
            if (_editingLabelAreaId != null) {
              _commitLabelEdit();
            }

            final startVision = screenToVision(
              core_domain.PointData.fromOffset(details.localPosition),
              videoWidth: widget.videoWidth,
              videoHeight: widget.videoHeight,
              isIPadLandscape: widget.isIPadLandscape,
              displayWidth: widget.displayWidth,
              displayHeight: widget.displayHeight,
              displayScale: widget.displayScale,
            );
            _lastVisionPoint = startVision;

            final hitPoint = _findVertexHit(
              core_domain.PointData.fromOffset(details.localPosition),
              areaState.editingAreas,
              videoWidth: widget.videoWidth,
              videoHeight: widget.videoHeight,
              _selectionHitRadius,
              isIPadLandscape: widget.isIPadLandscape,
              displayWidth: widget.displayWidth,
              displayHeight: widget.displayHeight,
              displayScale: widget.displayScale,
            );
            if (hitPoint != null) {
              notifier.selectPoint(hitPoint.areaId, hitPoint.pointIndex);
              _dragMode = _DragMode.point;
              return;
            }

            final hitAreaId = _findAreaHit(startVision, areaState.editingAreas);
            if (hitAreaId != null) {
              notifier.selectArea(hitAreaId);
              _dragMode = _DragMode.area;
              return;
            }

            _dragMode = _DragMode.none;
          },
          onPanUpdate: (details) {
            // Check if the drag point is within screen bounds to prevent moving areas off-screen
            if (details.localPosition.dx < 0 ||
                details.localPosition.dx > screenWidth ||
                details.localPosition.dy < 0 ||
                details.localPosition.dy > screenHeight) {
              // Drag point is off-screen, stop the drag
              _dragMode = _DragMode.none;
              _lastVisionPoint = null;
              return;
            }

            if (_lastVisionPoint == null) return;
            final currentVision = screenToVision(
              core_domain.PointData.fromOffset(details.localPosition),
              videoWidth: widget.videoWidth,
              videoHeight: widget.videoHeight,
              isIPadLandscape: widget.isIPadLandscape,
              displayWidth: widget.displayWidth,
              displayHeight: widget.displayHeight,
              displayScale: widget.displayScale,
            );
            final delta = currentVision - _lastVisionPoint!;
            _lastVisionPoint = currentVision;

            switch (_dragMode) {
              case _DragMode.point:
                notifier.moveSelectedPoint(delta);
                break;
              case _DragMode.area:
                notifier.moveSelectedArea(delta);
                break;
              case _DragMode.none:
                break;
            }
          },
          onPanEnd: (_) {
            _dragMode = _DragMode.none;
            _lastVisionPoint = null;
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(widget.displayWidth, widget.displayHeight),
                painter: _InterestAreaEditorPainter(
                  context: context,
                  videoWidth: widget.videoWidth,
                  videoHeight: widget.videoHeight,
                  areas: areaState.editingAreas,
                  rotationDegrees: widget.rotationDegrees,
                  selectedAreaId: areaState.selectedAreaId,
                  selectedPointIndex: areaState.selectedPointIndex,
                  isMobile: UniversalPlatform.isIOS || UniversalPlatform.isAndroid,
                  isIPadLandscape: widget.isIPadLandscape,
                  displayWidth: widget.displayWidth,
                  displayHeight: widget.displayHeight,
                  displayScale: widget.displayScale,
                  editingLabelAreaId: _editingLabelAreaId,
                ),
              ),
              if (_buildLabelEditor(areaState.editingAreas) case final labelEditor?) labelEditor,
            ],
          ),
        );
      },
    );

    return editor;
  }
}

class _InterestAreaEditorPainter extends CustomPainter {
  const _InterestAreaEditorPainter({
    required this.context,
    required this.areas,
    required this.rotationDegrees,
    required this.selectedAreaId,
    required this.selectedPointIndex,
    required this.isMobile,
    required this.isIPadLandscape,
    required this.displayWidth,
    required this.displayHeight,
    required this.displayScale,
    required this.videoWidth,
    required this.videoHeight,
    this.editingLabelAreaId,
  });

  final BuildContext context;
  final List<core_domain.InterestArea> areas;
  final double rotationDegrees;
  final int? selectedAreaId;
  final int? selectedPointIndex;
  final bool isMobile;
  final double videoWidth;
  final double videoHeight;
  final bool isIPadLandscape;
  final double displayWidth;
  final double displayHeight;
  final double displayScale;
  final int? editingLabelAreaId;
  static TextPainter? _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    if (_textPainter == null) {
      final textDirection = Directionality.of(context);
      _textPainter ??= TextPainter(textDirection: textDirection);
    }

    for (final area in areas) {
      final isSelected = area.id == selectedAreaId;
      _drawArea(canvas, area, isSelected: isSelected);
      // Skip painting the label text while it's being inline-edited; the TextField overlay shows it instead.
      if (area.id != editingLabelAreaId) {
        _drawAreaLabel(canvas, _textPainter!, area);
      }
      if (isSelected) {
        _drawSelection(canvas, area);
      }
    }
  }

  void _drawArea(Canvas canvas, core_domain.InterestArea area, {required bool isSelected}) {
    final color = area.color.withValues(alpha: area.enabled ? 0.7 : 0.3);
    final path = visionPolygonToPath(
      area.points,
      videoWidth: videoWidth,
      videoHeight: videoHeight,
      isIPadLandscape: isIPadLandscape,
      displayWidth: displayWidth,
      displayHeight: displayHeight,
      displayScale: displayScale,
    );
    _drawPath(canvas, path, color, isSelected: isSelected);
  }

  void _drawPath(Canvas canvas, Path path, Color color, {required bool isSelected}) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 3.0 : 2.0;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawSelection(Canvas canvas, core_domain.InterestArea area) {
    for (var i = 0; i < area.points.length; i++) {
      final point = visionToScreen(
        area.points[i],
        videoWidth: videoWidth,
        videoHeight: videoHeight,
        isIPadLandscape: isIPadLandscape,
        displayWidth: displayWidth,
        displayHeight: displayHeight,
        displayScale: displayScale,
      );
      final isSelectedPoint = selectedPointIndex != null && selectedPointIndex == i;
      // Larger points on mobile for better visibility, but smaller than before
      final unselectedRadius = isMobile ? 10.0 : 8.0;
      final selectedRadius = isMobile ? 15.0 : 12.0;
      canvas.drawCircle(
        point.offset,
        isSelectedPoint ? selectedRadius : unselectedRadius,
        Paint()
          ..color = isSelectedPoint ? Colors.yellow : area.color
          ..style = PaintingStyle.fill,
      );
    }
  }

  void _drawAreaLabel(Canvas canvas, TextPainter textPainter, core_domain.InterestArea area) {
    if (!area.enabled || area.points.isEmpty) return;

    final bounds = visionPolygonToScreenBounds(
      area.points,
      videoWidth: videoWidth,
      videoHeight: videoHeight,
      isIPadLandscape: isIPadLandscape,
      displayWidth: displayWidth,
      displayHeight: displayHeight,
      displayScale: displayScale,
    );
    final center = bounds.center;
    textPainter.text = TextSpan(
      text: area.name,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        shadows: [Shadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 4, offset: const Offset(0, 2))],
      ),
    );
    textPainter.layout();

    final labelLeft = center.dx - (textPainter.width / 2);
    final labelTop = center.dy - (textPainter.height / 2);
    final paddingHorizontal = 15;
    final paddingVertical = 7;
    final backgroundRect = Rect.fromLTWH(
      labelLeft - paddingHorizontal,
      labelTop - paddingVertical,
      textPainter.width + paddingHorizontal * 2,
      textPainter.height + paddingVertical * 2,
    );

    if (rotationDegrees <= 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(backgroundRect, const Radius.circular(6)),
        Paint()..color = area.color.withValues(alpha: 0.6),
      );

      textPainter.paint(canvas, Offset(labelLeft, labelTop));
      return;
    }

    final radians = -rotationDegrees * (3.141592653589793 / 180);
    final labelCenter = Offset(labelLeft + (textPainter.width / 2), labelTop + (textPainter.height / 2));
    canvas.save();
    canvas.translate(labelCenter.dx, labelCenter.dy);
    canvas.rotate(radians);
    canvas.translate(-labelCenter.dx, -labelCenter.dy);
    canvas.drawRRect(
      RRect.fromRectAndRadius(backgroundRect, const Radius.circular(6)),
      Paint()..color = area.color.withValues(alpha: 0.6),
    );
    textPainter.paint(canvas, Offset(labelLeft, labelTop));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _InterestAreaEditorPainter oldDelegate) {
    return oldDelegate.areas != areas ||
        oldDelegate.videoWidth != videoWidth ||
        oldDelegate.videoHeight != videoHeight ||
        oldDelegate.selectedAreaId != selectedAreaId ||
        oldDelegate.selectedPointIndex != selectedPointIndex ||
        oldDelegate.isMobile != isMobile ||
        oldDelegate.displayWidth != displayWidth ||
        oldDelegate.displayHeight != displayHeight ||
        oldDelegate.displayScale != displayScale ||
        oldDelegate.editingLabelAreaId != editingLabelAreaId;
  }
}

/// Screen-space background rect of an area's label, shared by painting and label tap/edit hit-testing.
Rect _labelBackgroundRect({
  required core_domain.InterestArea area,
  required double videoWidth,
  required double videoHeight,
  required bool isIPadLandscape,
  required double displayWidth,
  required double displayHeight,
  required double displayScale,
  required TextDirection textDirection,
}) {
  final bounds = visionPolygonToScreenBounds(
    area.points,
    videoWidth: videoWidth,
    videoHeight: videoHeight,
    isIPadLandscape: isIPadLandscape,
    displayWidth: displayWidth,
    displayHeight: displayHeight,
    displayScale: displayScale,
  );
  final center = bounds.center;
  final textPainter = TextPainter(
    text: TextSpan(
      text: area.name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    textDirection: textDirection,
  )..layout();

  const paddingHorizontal = 15.0;
  const paddingVertical = 7.0;
  final labelLeft = center.dx - (textPainter.width / 2);
  final labelTop = center.dy - (textPainter.height / 2);
  return Rect.fromLTWH(
    labelLeft - paddingHorizontal,
    labelTop - paddingVertical,
    textPainter.width + paddingHorizontal * 2,
    textPainter.height + paddingVertical * 2,
  );
}

class _PointHit {
  const _PointHit({required this.areaId, required this.pointIndex});

  final int areaId;
  final int pointIndex;
}

enum _DragMode { none, area, point }

_PointHit? _findVertexHit(
  core_domain.PointData tapPosition,
  List<core_domain.InterestArea> areas,
  double radius, {
  required double videoWidth,
  required double videoHeight,
  required bool isIPadLandscape,
  required double displayWidth,
  required double displayHeight,
  required double displayScale,
}) {
  for (final area in areas) {
    for (var i = 0; i < area.points.length; i++) {
      final screenPoint = visionToScreen(
        area.points[i],
        videoWidth: videoWidth,
        videoHeight: videoHeight,
        isIPadLandscape: isIPadLandscape,
        displayWidth: displayWidth,
        displayHeight: displayHeight,
        displayScale: displayScale,
      );
      if ((screenPoint - tapPosition).distance <= radius) {
        return _PointHit(areaId: area.id, pointIndex: i);
      }
    }
  }
  return null;
}

int? _findAreaHit(core_domain.PointData tapVision, List<core_domain.InterestArea> areas) {
  for (final area in areas) {
    if (area.contains(tapVision)) {
      return area.id;
    }
  }
  return null;
}
