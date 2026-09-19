// interest_area_viewer_overlay.dart

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'area_painting.dart';
import 'area_viewport.dart';
import 'interest_area_notifier.dart';
import 'window_count.dart';

class InterestAreaViewerOverlay extends ConsumerWidget {
  const InterestAreaViewerOverlay({required this.viewport, required this.countState, super.key});

  final AreaViewport viewport;
  final WindowCountState? countState;

  /// Space between the name pill and the occupancy block below it.
  static const double _blockGap = 4.0;

  static final _shadows = [
    Shadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 6, offset: const Offset(0, 2)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areaState = ref.watch(interestAreaProvider);
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
        for (final area in areaState.areas)
          if (_showsLabel(area)) _buildOccupancyBlock(context, area),
      ],
    );
  }

  static bool _showsLabel(core_domain.InterestArea area) => area.enabled && area.points.isNotEmpty;

  /// The occupancy block sits directly below the name pill, which the painter draws
  /// with the same AreaLabelLayout the editor uses, so both modes share one position.
  Widget _buildOccupancyBlock(BuildContext context, core_domain.InterestArea area) {
    final pill = AreaLabelLayout.backgroundRect(viewport, area, Directionality.of(context));
    final occupancy = countState?.areas[area.id]?.currentOccupancy ?? -1;

    final anchored = Positioned(
      left: pill.center.dx,
      top: pill.bottom + _blockGap,
      child: FractionalTranslation(
        translation: const Offset(-0.5, 0), // horizontally centered under the pill
        child: _buildOccupancyContent(context, area, occupancy),
      ),
    );

    if (!viewport.isRotated) {
      return Positioned.fill(
        child: IgnorePointer(child: Stack(children: [anchored])),
      );
    }

    // Rotate about the pill's center so pill and block turn together, as one unit.
    return Positioned.fill(
      child: IgnorePointer(
        child: Transform.rotate(
          angle: viewport.labelRotationRadians,
          alignment: Alignment.topLeft,
          origin: pill.center,
          child: Stack(children: [anchored]),
        ),
      ),
    );
  }

  Widget _buildOccupancyContent(BuildContext context, core_domain.InterestArea area, int occupancy) {
    final captionStyle = TextStyle(
      shadows: _shadows,
      color: Colors.white,
      fontSize: 14,
      decoration: TextDecoration.none,
    );
    final countStyle = TextStyle(
      color: area.color.withValues(alpha: 0.95),
      fontSize: 24,
      fontWeight: FontWeight.w800,
      fontFeatures: const [FontFeature.tabularFigures()],
      decoration: TextDecoration.none,
      shadows: _shadows,
    );

    Widget line(String text, TextStyle style) =>
        Text(text, style: style, softWrap: false, maxLines: 1, overflow: TextOverflow.ellipsis);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        line(context.l.occupancy, captionStyle),
        const SizedBox(height: 2),
        line(occupancy == -1 ? '-' : occupancy.toString(), countStyle),
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
