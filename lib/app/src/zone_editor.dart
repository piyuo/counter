import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:provider/provider.dart';

import 'zone_editor_controller.dart';

// This class is responsible for rendering the zone objects and allowing the user to interact with it
// The user can select a polygon, drag the points of the polygon, and create new polygons
// ZoneEditor handles the view logic including scaling
class ZoneEditor extends StatefulWidget {
  final ZoneEditorController controller;

  const ZoneEditor({
    required this.controller,
    super.key,
  });

  @override
  State<ZoneEditor> createState() => _ZoneEditorState();
}

class _ZoneEditorState extends State<ZoneEditor> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Scale factors managed by the view
        final scaleFactorX = constraints.maxWidth / widget.controller.mediaWidth;
        final scaleFactorY = constraints.maxHeight / widget.controller.mediaHeight;
        final scaleFactor = scaleFactorX < scaleFactorY ? scaleFactorX : scaleFactorY;

        // Convert screen coordinates to model coordinates
        Offset screenToModel(double width, double height, Offset screenPoint) {
          return Offset(
            screenPoint.dx / scaleFactorX,
            screenPoint.dy / scaleFactorY,
          );
        }

        return Listener(
          onPointerDown: (details) => widget.controller.selectPolygon(
              screenToModel(constraints.maxWidth, constraints.maxHeight, details.localPosition), scaleFactor),
          onPointerMove: (details) => widget.controller
              .updatePointPosition(screenToModel(constraints.maxWidth, constraints.maxHeight, details.localPosition)),
          onPointerUp: (details) => widget.controller.endDragging(),
          child: ChangeNotifierProvider<ZoneEditorController>.value(
            value: widget.controller,
            child: Consumer<ZoneEditorController>(
              builder: (context, controller, child) {
                return CustomPaint(
                  painter: _PolygonPainter(
                    zones: controller.zones,
                    selectedZone: controller.selectedZone,
                    selectedPointColor: CupertinoColors.activeBlue.resolveFrom(context),
                    unselectedPointColor: CupertinoColors.label.resolveFrom(context),
                    borderColor: CupertinoColors.label.resolveFrom(context),
                    shadowColor: CupertinoColors.inactiveGray.resolveFrom(context),
                    scaleFactorX: scaleFactorX,
                    scaleFactorY: scaleFactorY,
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _PolygonPainter extends CustomPainter {
  final List<vision.VideoZone> zones;
  final vision.VideoZone? selectedZone;
  final Color selectedPointColor;
  final Color unselectedPointColor;
  final Color borderColor;
  final Color shadowColor;
  final double scaleFactorX;
  final double scaleFactorY;

  const _PolygonPainter({
    required this.zones,
    required this.selectedZone,
    required this.selectedPointColor,
    required this.unselectedPointColor,
    required this.borderColor,
    required this.shadowColor,
    required this.scaleFactorX,
    required this.scaleFactorY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = zones.length - 1; i >= 0; i--) {
      final polygon = zones[i];
      final paint = Paint()
        ..color = polygon.color.withValues(alpha: (polygon == selectedZone) ? 0.7 : 0.5)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final scaledPoints = polygon.points.map((p) => Offset(p.dx * scaleFactorX, p.dy * scaleFactorY)).toList();

      final path = Path()..addPolygon(scaledPoints, true);

      canvas.drawShadow(path, shadowColor, 5.0, true);
      canvas.drawPath(path, paint);
      canvas.drawPath(path, borderPaint);

      if (polygon == selectedZone) {
        for (var i = 0; i < scaledPoints.length; i++) {
          final pointPaint = Paint()
            ..color = (polygon.selectedPointIndex == i) ? selectedPointColor : unselectedPointColor;
          canvas.drawCircle(scaledPoints[i], 10, pointPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
