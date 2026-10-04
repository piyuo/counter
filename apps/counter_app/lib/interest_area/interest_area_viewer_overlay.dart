// interest_area_viewer_overlay.dart

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'area_occupancy_overlay.dart';
import 'area_painting.dart';
import 'area_viewport.dart';

class InterestAreaViewerOverlay extends ConsumerWidget {
  const InterestAreaViewerOverlay({required this.viewport, required this.observationState, super.key});

  final AreaViewport viewport;
  final core_domain.ObservationState? observationState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areaState = ref.watch(core_runtime.interestAreaProvider);
    if (areaState.areas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        IgnorePointer(
          child: CustomPaint(
            size: viewport.displaySize,
            painter: _InterestAreaViewerPainter(
              viewport: viewport,
              areas: areaState.areas,
              textDirection: Directionality.of(context),
            ),
          ),
        ),
        AreaOccupancyOverlay(viewport: viewport, areas: areaState.areas, observationState: observationState),
      ],
    );
  }
}

class _InterestAreaViewerPainter extends CustomPainter {
  const _InterestAreaViewerPainter({required this.viewport, required this.areas, required this.textDirection});

  final AreaViewport viewport;
  final List<core_domain.InterestArea> areas;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    for (final area in areas) {
      if (!area.enabled) continue;
      paintAreaPath(
        canvas,
        viewport.polygonPath(area.points),
        strokeColor: area.color.withValues(alpha: 0.9),
        fillAlpha: 0.25,
        strokeWidth: 3.0,
        roundJoins: true,
      );
      // Same pill, same position as the editor.
      if (area.points.isNotEmpty) {
        AreaLabelLayout.paint(canvas, viewport, area, textDirection);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _InterestAreaViewerPainter oldDelegate) {
    return oldDelegate.areas != areas || oldDelegate.viewport != viewport || oldDelegate.textDirection != textDirection;
  }
}
