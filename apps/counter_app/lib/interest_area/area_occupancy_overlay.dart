// ============================================================================
// Table of Contents
// ============================================================================
// 1. AreaOccupancyOverlay — shared occupancy labels
// ============================================================================

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'area_painting.dart';
import 'area_viewport.dart';

class AreaOccupancyOverlay extends StatelessWidget {
  const AreaOccupancyOverlay({required this.viewport, required this.areas, required this.observationState, super.key});

  final AreaViewport viewport;
  final List<core_domain.InterestArea> areas;
  final core_domain.ObservationState? observationState;

  static const double _blockGap = 4.0;

  static final _shadows = [
    Shadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 6, offset: const Offset(0, 2)),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final area in areas)
          if (area.enabled && area.points.isNotEmpty) _buildOccupancyBlock(context, area),
      ],
    );
  }

  Widget _buildOccupancyBlock(BuildContext context, core_domain.InterestArea area) {
    final pill = AreaLabelLayout.backgroundRect(viewport, area, Directionality.of(context));
    final occupancy = observationState?.areas[area.id]?.currentOccupancy ?? -1;

    final anchored = Positioned(
      left: pill.center.dx,
      top: pill.bottom + _blockGap,
      child: FractionalTranslation(
        translation: const Offset(-0.5, 0),
        child: _buildOccupancyContent(context, area, occupancy),
      ),
    );

    if (!viewport.isRotated) {
      return Positioned.fill(
        child: IgnorePointer(child: Stack(children: [anchored])),
      );
    }

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
