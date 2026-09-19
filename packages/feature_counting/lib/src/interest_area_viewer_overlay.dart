import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/src/l10n/l10n.dart';
import 'package:flutter_vision/src/window_count/window_count.dart' as window_count;

import 'interest_area.dart';
import 'interest_area_notifier.dart';
import 'interest_area_utils.dart';

class InterestAreaViewerOverlay extends ConsumerWidget {
  const InterestAreaViewerOverlay({
    required this.rotationDegrees,
    required this.countState,
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
  final window_count.WindowCountState? countState;

  final bool isIPadLandscape;

  /// Display width (overrides previewConstraints when rotating)
  final double displayWidth;

  /// Display height (overrides previewConstraints when rotating)
  final double displayHeight;

  /// Display scale (overrides previewConstraints when rotating)
  final double displayScale;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areaState = ref.watch(interestAreaProvider);
    if (areaState.activeAreas.isEmpty) {
      return const SizedBox.shrink();
    }

    TextStyle buildCountStyle(Color areaColor) {
      return TextStyle(
        color: areaColor.withValues(alpha: 0.95),
        fontSize: 24,
        fontWeight: FontWeight.w800,
        fontFeatures: const [FontFeature.tabularFigures()],
        decoration: TextDecoration.none,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      );
    }

    Widget buildAreaCountLabel(InterestArea area) {
      final rect = visionPolygonToScreenBounds(
        area.points,
        videoWidth: videoWidth,
        videoHeight: videoHeight,
        isIPadLandscape: isIPadLandscape,
        displayWidth: displayWidth,
        displayHeight: displayHeight,
        displayScale: displayScale,
      );
      final countStyle = buildCountStyle(area.color);

      final currentOccupancy = countState?.areas[area.id]?.currentOccupancy ?? -1;
      Widget buildLabelContent() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              area.name,
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              context.l.occupancy,
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              currentOccupancy == -1 ? "-" : currentOccupancy.toString(),
              style: countStyle,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      }

      final label = Positioned(
        left: rect.left,
        top: rect.top,
        width: rect.width,
        height: rect.height,
        child: Center(
          child: SizedBox(
            width: rect.width,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: buildLabelContent(),
            ),
          ),
        ),
      );

      if (rotationDegrees <= 0) {
        return label;
      }

      return Positioned(
        left: rect.left,
        top: rect.top,
        width: rect.width,
        height: rect.height,
        child: Transform.rotate(
          angle: -rotationDegrees * (3.141592653589793 / 180),
          child: Center(
            child: SizedBox(
              width: rect.width,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: buildLabelContent(),
              ),
            ),
          ),
        ),
      );
    }

    Widget overlay = Stack(
      children: [
        IgnorePointer(
          child: CustomPaint(
            size: Size(
              displayWidth,
              displayHeight,
            ),
            painter: _InterestAreaViewerPainter(
              videoWidth: videoWidth,
              videoHeight: videoHeight,
              areas: areaState.activeAreas,
              isIPadLandscape: isIPadLandscape,
              displayWidth: displayWidth,
              displayHeight: displayHeight,
              displayScale: displayScale,
            ),
          ),
        ),
        ...areaState.activeAreas.where((area) => area.enabled).map(buildAreaCountLabel),
      ],
    );

    return overlay;
  }
}

class _InterestAreaViewerPainter extends CustomPainter {
  const _InterestAreaViewerPainter({
    required this.areas,
    required this.videoWidth,
    required this.videoHeight,
    required this.isIPadLandscape,
    required this.displayWidth,
    required this.displayHeight,
    required this.displayScale,
  });

  final double videoWidth;
  final double videoHeight;
  final List<InterestArea> areas;
  final bool isIPadLandscape;
  final double displayWidth;
  final double displayHeight;
  final double displayScale;

  @override
  void paint(Canvas canvas, Size size) {
    for (final area in areas) {
      if (!area.enabled) continue;

      final color = area.color.withValues(alpha: 0.7);
      final path = visionPolygonToPath(
        area.points,
        videoWidth: videoWidth,
        videoHeight: videoHeight,
        isIPadLandscape: isIPadLandscape,
        displayWidth: displayWidth,
        displayHeight: displayHeight,
        displayScale: displayScale,
      );
      _drawPath(canvas, path, color);
    }
  }

  void _drawPath(Canvas canvas, Path path, Color color) {
    // Fill with semi-transparent color
    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Solid border
    final strokePaint = Paint()
      ..color = color.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _InterestAreaViewerPainter oldDelegate) {
    return oldDelegate.areas != areas ||
        oldDelegate.videoWidth != videoWidth ||
        oldDelegate.videoHeight != videoHeight ||
        oldDelegate.displayWidth != displayWidth ||
        oldDelegate.displayHeight != displayHeight ||
        oldDelegate.displayScale != displayScale;
  }
}
