// 1. MetricsDisplay widget
// 2. _ClampedOffset — offset widget clamped within screen bounds
// 3. _MeasureSize — measures child widget size after layout

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';

class WindowProgressDisplay extends StatelessWidget {
  const WindowProgressDisplay({
    required this.windowCount,
    this.offset = Offset.zero,
    this.lightOutMode = false,
    super.key,
  });

  final vision.WindowCountState? windowCount;

  final Offset offset;
  final bool lightOutMode;

  @override
  Widget build(BuildContext context) {
    Widget content;

    final currentWindowCount = windowCount;

    if (currentWindowCount == null) {
      return Center(child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white, size: 54));
    }
    final donePercent = currentWindowCount.donePercent.clamp(0.0, 100.0);
    final inProgressPercent = currentWindowCount.inProgressPercent.clamp(0.0, 100.0);
    final missingPercent = currentWindowCount.missingPercent.clamp(0.0, 100.0);
    final doneSegmentValue = donePercent.round().clamp(0, 100);
    final inProgressSegmentValue = inProgressPercent.round().clamp(0, 100 - doneSegmentValue);
    final missingSegmentValue = 100 - doneSegmentValue - inProgressSegmentValue;
    final progressSegments = [
      Segment(
        value: doneSegmentValue,
        color: Colors.lightBlue,
        label: const Text('Done', style: TextStyle(fontSize: 10)),
        valueLabel: Text('${donePercent.toStringAsFixed(1)}%', style: TextStyle(fontSize: 10)),
      ),
      Segment(
        value: inProgressSegmentValue,
        color: Colors.grey,
        label: const Text('In progress', style: TextStyle(fontSize: 10)),
        valueLabel: Text('${inProgressPercent.toStringAsFixed(1)}%', style: TextStyle(fontSize: 10)),
      ),
      Segment(
        value: missingSegmentValue,
        color: Colors.orange.withValues(alpha: 0.6),
        label: const Text('Missing', style: TextStyle(fontSize: 10)),
        valueLabel: Text('${missingPercent.toStringAsFixed(1)}%', style: TextStyle(fontSize: 10)),
      ),
    ];

    content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(
                      context,
                    ).textTheme.apply(bodyColor: Colors.white70, displayColor: Colors.white70),
                  ),
                  child: PrimerProgressBar(
                    segments: progressSegments,
                    maxTotalValue: 100,
                    barStyle: const SegmentedBarStyle(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4)),
                    legendStyle: const SegmentedBarLegendStyle(
                      spacing: 0,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    final mediaPadding = MediaQuery.paddingOf(context);
    return Center(
      child: _ClampedOffset(
        offset: offset,
        padding: EdgeInsets.only(
          left: mediaPadding.left + 12,
          right: mediaPadding.right + 12,
          top: mediaPadding.top + 12,
          bottom: mediaPadding.bottom + 12,
        ),
        child: content,
      ),
    );
  }
}

// ============================================================================
// 2. _ClampedOffset — offset widget clamped within screen bounds
// ============================================================================

class _ClampedOffset extends StatefulWidget {
  const _ClampedOffset({required this.offset, required this.padding, required this.child});

  final Offset offset;
  final EdgeInsets padding;
  final Widget child;

  @override
  State<_ClampedOffset> createState() => _ClampedOffsetState();
}

class _ClampedOffsetState extends State<_ClampedOffset> {
  Size _childSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 0.0;
        final maxHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : 0.0;

        final usableWidth = math.max(0.0, maxWidth - widget.padding.left - widget.padding.right);
        final usableHeight = math.max(0.0, maxHeight - widget.padding.top - widget.padding.bottom);

        final maxX = math.max(0.0, (usableWidth - _childSize.width) / 2);
        final maxY = math.max(0.0, (usableHeight - _childSize.height) / 2);

        final clampedOffset = Offset(widget.offset.dx.clamp(-maxX, maxX), widget.offset.dy.clamp(-maxY, maxY));

        return Transform.translate(
          offset: clampedOffset,
          child: _MeasureSize(
            onChange: (size) {
              if (!mounted) return;
              if (size != _childSize) setState(() => _childSize = size);
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}

// ============================================================================
// 3. _MeasureSize — measures child widget size after layout
// ============================================================================

class _MeasureSize extends StatefulWidget {
  const _MeasureSize({required this.onChange, required this.child});

  final ValueChanged<Size> onChange;
  final Widget child;

  @override
  State<_MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  @override
  void didUpdateWidget(covariant _MeasureSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  void _notifySize() {
    final context = _key.currentContext;
    if (context == null) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    widget.onChange(box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _key, child: widget.child);
  }
}
