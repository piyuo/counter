// TOC
// 1. InsightChart
// 2. Hourly bar painter
// 3. Legend item

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/dashboard_utils.dart';
import '../widgets/info_dialog.dart';
import 'primary_metric.dart';

class _ChartColors {
  static const today = Color(0xFF3B82F6);
  static const comparisonColor = Color(0xFFC4B5FD);
  static const comparisonOpacity = 0.9;
  static const liveDark = Color(0xFF4ADE80);
  static const liveLight = Color(0xFF15803D);
  static const todayLabelDark = Color(0xFF93C5FD);
  static const todayLabelLight = Color(0xFF1D4ED8);
  static const comparisonLabelDark = Color(0xFFC4B5FD);
  static const comparisonLabelLight = Color(0xFF6D28D9);

  static Color live(Brightness brightness) => brightness == Brightness.dark ? liveDark : liveLight;

  static Color todayLabel(Brightness brightness) => brightness == Brightness.dark ? todayLabelDark : todayLabelLight;

  static Color comparisonLabel(Brightness brightness) =>
      brightness == Brightness.dark ? comparisonLabelDark : comparisonLabelLight;
}

class InsightChart extends StatefulWidget {
  const InsightChart({
    super.key,
    required this.data,
    required this.metricLabel,
    required this.comparisonLabel,
    required this.height,
    this.currentHour,
    this.showLiveMarker = true,
    @visibleForTesting this.onHourlyBarsPaint,
    @visibleForTesting this.onExtremeLabelsPaint,
    @visibleForTesting this.onLiveMarkerPaint,
  });

  final core_domain.DashboardCardData data;
  final String metricLabel;
  final String comparisonLabel;
  final double height;
  final int? currentHour;
  final bool showLiveMarker;
  final VoidCallback? onHourlyBarsPaint;
  final VoidCallback? onExtremeLabelsPaint;
  final VoidCallback? onLiveMarkerPaint;

  @override
  State<InsightChart> createState() => _InsightChartState();
}

class _InsightChartState extends State<InsightChart> {
  int? _selectedHour;
  List<core_domain.DashboardChartPoint>? _cachedPoints;
  core_domain.DashboardMetric? _cachedMetric;
  List<_BarExtreme> _extremes = const [];
  List<_PositionedExtremeLabel> _positionedExtremeLabels = const [];
  List<_BarExtreme>? _positionedExtremes;
  Size? _positionedSize;
  double? _positionedMaxY;
  String? _positionedLocale;
  ui.TextDirection? _positionedTextDirection;
  TextScaler? _positionedTextScaler;
  TextStyle? _positionedStyle;
  Brightness? _positionedBrightness;
  bool _hasToday = false;
  bool _hasComparison = false;
  double _maxY = 1;

  void _updateChartSnapshot(core_domain.DashboardCardData data) {
    if (identical(_cachedPoints, data.chartPoints) && _cachedMetric == data.metric) return;

    _cachedPoints = data.chartPoints;
    _cachedMetric = data.metric;
    _extremes = _findExtremes(data.chartPoints);
    _hasToday = data.chartPoints.any((point) => point.todayValue != null);
    _hasComparison = data.chartPoints.any((point) => point.comparisonValue != null);
    final maxValue = data.chartPoints
        .where((point) {
          final hour = point.minuteOfDay ~/ 60;
          return hour >= 0 && hour < 24;
        })
        .expand((point) => [point.todayValue, point.comparisonValue])
        .whereType<double>()
        .where((value) => value.isFinite && value >= 0)
        .fold<double>(0, math.max);
    _maxY = _niceChartScale(maxValue <= 0 ? 1 : maxValue * 1.15);
  }

  List<_PositionedExtremeLabel> _extremeLabelsFor({
    required Size size,
    required String locale,
    required ui.TextDirection textDirection,
    required TextScaler textScaler,
    required TextStyle style,
    required Brightness brightness,
  }) {
    if (identical(_positionedExtremes, _extremes) &&
        _positionedSize == size &&
        _positionedMaxY == _maxY &&
        _positionedLocale == locale &&
        _positionedTextDirection == textDirection &&
        _positionedTextScaler == textScaler &&
        _positionedStyle == style &&
        _positionedBrightness == brightness) {
      return _positionedExtremeLabels;
    }

    _positionedExtremes = _extremes;
    _positionedSize = size;
    _positionedMaxY = _maxY;
    _positionedLocale = locale;
    _positionedTextDirection = textDirection;
    _positionedTextScaler = textScaler;
    _positionedStyle = style;
    _positionedBrightness = brightness;
    _positionedExtremeLabels = _layoutExtremeLabels(
      extremes: _extremes,
      size: size,
      maxY: _maxY,
      metric: widget.data.metric,
      locale: locale,
      textDirection: textDirection,
      textScaler: textScaler,
      style: style,
      todayColor: _ChartColors.todayLabel(brightness),
      comparisonColor: _ChartColors.comparisonLabel(brightness),
    );
    return _positionedExtremeLabels;
  }

  _LiveRateMarkerData? _liveMarkerFor(core_domain.DashboardCardData data, int hour) {
    if (!widget.showLiveMarker || !dashboardMetricUsesHourlyRate(data.metric)) {
      return null;
    }
    final primary = data.primary;
    if (primary == null || !primary.amount.isFinite || primary.amount < 0) return null;
    return _LiveRateMarkerData(hour: hour, rate: primary.amount, unit: primary.unit, estimated: primary.estimated);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    _updateChartSnapshot(data);
    final hour = (widget.currentHour ?? DateTime.now().hour).clamp(0, 23);
    final markerData = _liveMarkerFor(data, hour);
    if (markerData != null && markerData.rate >= _maxY) {
      _maxY = _niceChartScale(markerData.rate * 1.15);
    }
    final liveMarkerColor = _ChartColors.live(theme.brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            context.l.insight_chart_hourly_breakdown,
            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: widget.height,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, plotConstraints) {
                        final textDirection = Directionality.of(context);
                        final textScaler = MediaQuery.textScalerOf(context);
                        final labelStyle = theme.textTheme.labelSmall ?? const TextStyle(fontSize: 11);
                        final extremeLabels = _extremeLabelsFor(
                          size: Size(plotConstraints.maxWidth, plotConstraints.maxHeight),
                          locale: locale.toString(),
                          textDirection: textDirection,
                          textScaler: textScaler,
                          style: labelStyle,
                          brightness: theme.brightness,
                        );
                        final liveLabel = markerData == null
                            ? null
                            : formatInsightPrimaryNumber(context, markerData.rate, markerData.unit);
                        return Semantics(
                          label: context.l.insight_chart_hourly_breakdown,
                          value: _selectedHour == null ? null : _hourRange(_selectedHour!, locale.toString()),
                          hint: context.l.insight_chart_hourly_info,
                          child: GestureDetector(
                            key: const ValueKey('insight-hourly-plot'),
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (details) {
                              final position = details.localPosition.dx / plotConstraints.maxWidth;
                              setState(() => _selectedHour = (position * 24).floor().clamp(0, 23));
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                RepaintBoundary(
                                  child: CustomPaint(
                                    key: const ValueKey('insight-hourly-bars'),
                                    painter: _HourlyBarsPainter(
                                      points: data.chartPoints,
                                      maxY: _maxY,
                                      selectedHour: _selectedHour,
                                      dividerColor: theme.dividerColor,
                                      onPaint: widget.onHourlyBarsPaint,
                                    ),
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                                if (markerData != null)
                                  Semantics(
                                    key: const ValueKey('insight-live-rate-marker'),
                                    label: context.l.insight_chart_live_rate,
                                    value: _liveMarkerSemanticsValue(
                                      markerData,
                                      liveLabel!,
                                      locale.toString(),
                                      context.l,
                                    ),
                                    child: IgnorePointer(
                                      child: RepaintBoundary(
                                        child: CustomPaint(
                                          key: const ValueKey('insight-live-rate-paint'),
                                          painter: _LiveRateMarkerPainter(
                                            marker: markerData,
                                            maxY: _maxY,
                                            color: liveMarkerColor,
                                            label: liveLabel,
                                            labelStyle: labelStyle,
                                            textDirection: textDirection,
                                            textScaler: textScaler,
                                            extremeLabels: extremeLabels,
                                            onPaint: widget.onLiveMarkerPaint,
                                          ),
                                          child: const SizedBox.expand(),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_extremes.isNotEmpty)
                                  Semantics(
                                    key: const ValueKey('insight-hourly-extreme-labels'),
                                    label: _extremes
                                        .map((extreme) {
                                          final value = formatDashboardMetricValue(
                                            extreme.value,
                                            data.metric,
                                            NumberFormat('0.##', locale.toString()),
                                            unavailable: '',
                                          );
                                          final period = extreme.isToday
                                              ? context.l.insight_today
                                              : widget.comparisonLabel;
                                          final estimate = extreme.estimated ? ', ${context.l.insight_estimated}' : '';
                                          return '$value, ${_hourRange(extreme.hour, locale.toString())}, $period$estimate';
                                        })
                                        .join('; '),
                                    child: IgnorePointer(
                                      child: RepaintBoundary(
                                        child: CustomPaint(
                                          painter: _HourlyExtremeLabelsPainter(
                                            labels: extremeLabels,
                                            onPaint: widget.onExtremeLabelsPaint,
                                          ),
                                          child: const SizedBox.expand(),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 22,
                    child: Row(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, labelConstraints) {
                              final showEndLabel = labelConstraints.maxWidth >= 192;
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  for (var hour = 0; hour <= 24; hour += 3)
                                    if (hour < 24 || showEndLabel)
                                      Positioned(
                                        left: hour == 0
                                            ? 0
                                            : hour == 24
                                            ? labelConstraints.maxWidth - 24
                                            : labelConstraints.maxWidth * hour / 24 - 12,
                                        top: 1,
                                        width: 24,
                                        child: Align(
                                          alignment: hour == 0
                                              ? Alignment.centerLeft
                                              : hour == 24
                                              ? Alignment.centerRight
                                              : Alignment.center,
                                          child: Text(
                                            hour.toString().padLeft(2, '0'),
                                            style: theme.textTheme.labelSmall,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (_selectedHour != null)
          _HourDetails(
            point: data.chartPoints.firstWhere(
              (point) => point.minuteOfDay == _selectedHour! * 60,
              orElse: () => core_domain.DashboardChartPoint(minuteOfDay: _selectedHour! * 60),
            ),
            hour: _selectedHour!,
            metric: data.metric,
            comparisonLabel: widget.comparisonLabel,
            locale: locale,
          ),
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                runSpacing: 2,
                children: [
                  if (_hasToday) _LegendItem(color: _ChartColors.today, label: context.l.insight_today),
                  if (_hasComparison)
                    _LegendItem(
                      color: _ChartColors.comparisonColor.withValues(alpha: _ChartColors.comparisonOpacity),
                      label: widget.comparisonLabel,
                    ),
                  if (markerData != null)
                    _LiveRateLegendItem(color: liveMarkerColor, label: context.l.insight_chart_live_rate),
                ],
              ),
            ),
            IconButton(
              tooltip: context.l.insight_chart_info_title,
              onPressed: () => _showChartInfo(context),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints.tightFor(width: 24, height: 24),
              iconSize: 16,
              color: theme.colorScheme.onSurfaceVariant,
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
      ],
    );
  }

  void _showChartInfo(BuildContext context) {
    showInfoDialog(
      context: context,
      title: context.l.insight_chart_info_title,
      content: '${context.l.insight_chart_hourly_info}\n\n${context.l.insight_chart_info_units}',
    );
  }
}

class _HourDetails extends StatelessWidget {
  const _HourDetails({
    required this.point,
    required this.hour,
    required this.metric,
    required this.comparisonLabel,
    required this.locale,
  });

  final core_domain.DashboardChartPoint point;
  final int hour;
  final core_domain.DashboardMetric metric;
  final String comparisonLabel;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final localization = context.l;
    final style = Theme.of(context).textTheme.bodySmall;
    final numberFormat = NumberFormat('0.##', locale.toString());
    final todayValue = formatDashboardMetricValue(
      point.todayValue,
      metric,
      numberFormat,
      unavailable: localization.insight_comparison_unavailable,
    );
    final comparisonValue = formatDashboardMetricValue(
      point.comparisonValue,
      metric,
      numberFormat,
      unavailable: localization.insight_comparison_unavailable,
    );
    final difference = point.todayValue != null && point.comparisonValue != null && point.comparisonValue! > 0
        ? _formatDifference(point.todayValue!, point.comparisonValue!, locale.toString())
        : null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_hourRange(hour, locale.toString()), style: Theme.of(context).textTheme.labelMedium),
          Text(localization.insight_today_chart(todayValue), style: style),
          if (point.todayEstimated)
            Text(_coverageLabel(localization, point.todayCoveredSeconds, locale.toString()), style: style),
          Text('$comparisonLabel: $comparisonValue', style: style),
          if (point.comparisonEstimated)
            Text(_coverageLabel(localization, point.comparisonCoveredSeconds, locale.toString()), style: style),
          if (difference != null) Text(difference, style: style),
        ],
      ),
    );
  }
}

class _BarExtreme {
  const _BarExtreme({required this.hour, required this.value, required this.isToday, required this.estimated});

  final int hour;
  final double value;
  final bool isToday;
  final bool estimated;
}

List<_BarExtreme> _findExtremes(List<core_domain.DashboardChartPoint> points) {
  final candidates = <_BarExtreme>[];
  for (final point in points) {
    final hour = point.minuteOfDay ~/ 60;
    if (hour < 0 || hour >= 24) continue;
    for (final candidate in [
      (value: point.todayValue, isToday: true, estimated: point.todayEstimated),
      (value: point.comparisonValue, isToday: false, estimated: point.comparisonEstimated),
    ]) {
      final value = candidate.value;
      if (value == null || !value.isFinite || value < 0) continue;
      candidates.add(_BarExtreme(hour: hour, value: value, isToday: candidate.isToday, estimated: candidate.estimated));
    }
  }
  if (candidates.isEmpty) return const [];

  var highest = candidates.first;
  var lowest = candidates.first;
  for (final candidate in candidates.skip(1)) {
    if (candidate.value > highest.value ||
        candidate.value == highest.value && _compareExtremeTie(candidate, highest) > 0) {
      highest = candidate;
    }
    if (candidate.value < lowest.value ||
        candidate.value == lowest.value && _compareExtremeTie(candidate, lowest) > 0) {
      lowest = candidate;
    }
  }
  if (highest.value == lowest.value) return [highest];
  return [highest, lowest];
}

int _compareExtremeTie(_BarExtreme left, _BarExtreme right) {
  if (left.estimated != right.estimated) return left.estimated ? -1 : 1;
  if (left.isToday != right.isToday) return left.isToday ? 1 : -1;
  if (left.hour != right.hour) return left.hour < right.hour ? 1 : -1;
  return 0;
}

class _HourlyExtremeLabelsPainter extends CustomPainter {
  const _HourlyExtremeLabelsPainter({required this.labels, this.onPaint});

  final List<_PositionedExtremeLabel> labels;
  final VoidCallback? onPaint;

  @override
  void paint(Canvas canvas, Size size) {
    for (final label in labels) {
      label.painter.paint(canvas, label.offset);
    }
    onPaint?.call();
  }

  @override
  bool shouldRepaint(_HourlyExtremeLabelsPainter oldDelegate) => !identical(labels, oldDelegate.labels);
}

class _PositionedExtremeLabel {
  const _PositionedExtremeLabel({required this.painter, required this.offset});

  final TextPainter painter;
  final Offset offset;

  Rect get rect => Rect.fromLTWH(offset.dx, offset.dy, painter.width, painter.height);
}

class _HourlyBarsPainter extends CustomPainter {
  const _HourlyBarsPainter({
    required this.points,
    required this.maxY,
    required this.selectedHour,
    required this.dividerColor,
    this.onPaint,
  });

  final List<core_domain.DashboardChartPoint> points;
  final double maxY;
  final int? selectedHour;
  final Color dividerColor;
  final VoidCallback? onPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final plotHeight = math.max(1.0, size.height - 2);
    final slotWidth = size.width / 24;
    final safeMaxY = maxY <= 0 ? 1.0 : maxY;
    final gridPaint = Paint()
      ..color = dividerColor.withValues(alpha: 0.22)
      ..strokeWidth = 1;

    for (var step = 0; step <= 4; step++) {
      final y = plotHeight - plotHeight * step / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (var hour = 0; hour <= 24; hour += 3) {
      final x = size.width * hour / 24;
      canvas.drawLine(Offset(x, 0), Offset(x, plotHeight), gridPaint);
    }
    if (selectedHour != null) {
      final x = slotWidth * selectedHour!;
      canvas.drawRect(
        Rect.fromLTWH(x, 0, slotWidth, plotHeight),
        Paint()..color = _ChartColors.liveDark.withValues(alpha: 0.06),
      );
    }

    for (final point in points) {
      final hour = point.minuteOfDay ~/ 60;
      if (hour < 0 || hour >= 24) continue;
      final centerX = slotWidth * (hour + 0.5);
      _drawBar(
        canvas,
        centerX: centerX,
        slotWidth: slotWidth,
        plotHeight: plotHeight,
        maxY: safeMaxY,
        value: point.comparisonValue,
        widthFactor: 0.82,
        color: _ChartColors.comparisonColor.withValues(
          alpha: point.comparisonEstimated ? 0.28 : _ChartColors.comparisonOpacity,
        ),
      );
      _drawBar(
        canvas,
        centerX: centerX,
        slotWidth: slotWidth,
        plotHeight: plotHeight,
        maxY: safeMaxY,
        value: point.todayValue,
        widthFactor: 0.52,
        color: _ChartColors.today.withValues(alpha: point.todayEstimated ? 0.58 : 1),
      );
    }
    onPaint?.call();
  }

  void _drawBar(
    Canvas canvas, {
    required double centerX,
    required double slotWidth,
    required double plotHeight,
    required double maxY,
    required double? value,
    required double widthFactor,
    required Color color,
  }) {
    if (value == null || !value.isFinite || value < 0) return;
    final barHeight = value <= 0 ? 2.0 : (value / maxY * plotHeight).clamp(2.0, plotHeight);
    final width = slotWidth * widthFactor;
    final rect = Rect.fromLTWH(centerX - width / 2, plotHeight - barHeight, width, barHeight);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), Paint()..color = color);
  }

  @override
  bool shouldRepaint(_HourlyBarsPainter oldDelegate) =>
      !identical(points, oldDelegate.points) ||
      maxY != oldDelegate.maxY ||
      selectedHour != oldDelegate.selectedHour ||
      dividerColor != oldDelegate.dividerColor;
}

List<_PositionedExtremeLabel> _layoutExtremeLabels({
  required List<_BarExtreme> extremes,
  required Size size,
  required double maxY,
  required core_domain.DashboardMetric metric,
  required String locale,
  required ui.TextDirection textDirection,
  required TextScaler textScaler,
  required TextStyle style,
  required Color todayColor,
  required Color comparisonColor,
}) {
  if (extremes.isEmpty) return const [];

  final plotHeight = math.max(1.0, size.height - 2);
  final slotWidth = size.width / 24;
  final numberFormat = NumberFormat('0.##', locale);
  final labels = <_PositionedExtremeLabel>[];
  for (final extreme in extremes) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: formatDashboardMetricValue(extreme.value, metric, numberFormat, unavailable: ''),
        style: style.copyWith(
          color: extreme.isToday ? todayColor : comparisonColor,
          fontWeight: FontWeight.w600,
          fontFeatures: const [ui.FontFeature.tabularFigures()],
        ),
      ),
      textDirection: textDirection,
      textScaler: textScaler,
      maxLines: 1,
    )..layout(maxWidth: size.width);
    final barHeight = extreme.value <= 0 ? 2.0 : (extreme.value / maxY * plotHeight).clamp(2.0, plotHeight);
    final barTop = plotHeight - barHeight;
    final centerX = slotWidth * (extreme.hour + 0.5);
    final left = (centerX - textPainter.width / 2).clamp(0.0, math.max(0.0, size.width - textPainter.width)).toDouble();
    final top = (barTop - 4 - textPainter.height).clamp(0.0, math.max(0.0, plotHeight - textPainter.height)).toDouble();
    labels.add(_PositionedExtremeLabel(painter: textPainter, offset: Offset(left, top)));
  }

  if (labels.length == 2 && labels[0].rect.overlaps(labels[1].rect)) {
    final first = labels[0].rect;
    final second = labels[1];
    const gap = 2.0;
    final alternatives = [
      Offset(second.offset.dx, first.top - gap - second.painter.height),
      Offset(second.offset.dx, first.bottom + gap),
      Offset(first.left - gap - second.painter.width, second.offset.dy),
      Offset(first.right + gap, second.offset.dy),
    ];
    _PositionedExtremeLabel? replacement;
    for (final offset in alternatives) {
      final rect = Rect.fromLTWH(offset.dx, offset.dy, second.painter.width, second.painter.height);
      if (rect.left >= 0 &&
          rect.right <= size.width &&
          rect.top >= 0 &&
          rect.bottom <= plotHeight &&
          !rect.overlaps(first)) {
        replacement = _PositionedExtremeLabel(painter: second.painter, offset: offset);
        break;
      }
    }
    if (replacement == null) {
      labels.removeLast();
    } else {
      labels[1] = replacement;
    }
  }
  return List.unmodifiable(labels);
}

class _LiveRateMarkerData {
  const _LiveRateMarkerData({required this.hour, required this.rate, required this.unit, required this.estimated});

  final int hour;
  final double rate;
  final core_domain.DashboardMeasurementUnit unit;
  final bool estimated;
}

class _LiveRateMarkerPainter extends CustomPainter {
  const _LiveRateMarkerPainter({
    required this.marker,
    required this.maxY,
    required this.color,
    required this.label,
    required this.labelStyle,
    required this.textDirection,
    required this.textScaler,
    required this.extremeLabels,
    this.onPaint,
  });

  final _LiveRateMarkerData marker;
  final double maxY;
  final Color color;
  final String label;
  final TextStyle labelStyle;
  final ui.TextDirection textDirection;
  final TextScaler textScaler;
  final List<_PositionedExtremeLabel> extremeLabels;
  final VoidCallback? onPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (!marker.rate.isFinite || marker.rate < 0 || !maxY.isFinite || maxY <= 0) return;

    final plotHeight = math.max(1.0, size.height - 2);
    final slotWidth = size.width / 24;
    final left = slotWidth * marker.hour;
    canvas.drawRect(Rect.fromLTWH(left, 0, slotWidth, plotHeight), Paint()..color = color.withValues(alpha: 0.06));

    final centerX = slotWidth * (marker.hour + 0.5);
    final y = (plotHeight * (1 - marker.rate / maxY)).clamp(0.0, plotHeight).toDouble();
    final linePaint = Paint()
      ..color = color.withValues(alpha: marker.estimated ? 0.82 : 1)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final halfWidth = slotWidth * 0.4;
    canvas.drawLine(Offset(centerX - halfWidth, y), Offset(centerX + halfWidth, y), linePaint);

    final labelPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: labelStyle.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontFeatures: const [ui.FontFeature.tabularFigures()],
        ),
      ),
      textDirection: textDirection,
      textScaler: textScaler,
      maxLines: 1,
    )..layout(maxWidth: size.width);
    final above = y - 4 - labelPainter.height;
    final below = y + 4;
    final verticalCandidates = above >= 0 ? [above, below] : [below, above];
    final horizontalOffsets = [0.0, -4.0, 4.0, -8.0, 8.0, -slotWidth / 2, slotWidth / 2];
    Offset? labelOffset;
    for (final top in verticalCandidates) {
      for (final horizontalOffset in horizontalOffsets) {
        final labelLeft = (centerX + horizontalOffset - labelPainter.width / 2)
            .clamp(0.0, math.max(0.0, size.width - labelPainter.width))
            .toDouble();
        final rect = Rect.fromLTWH(labelLeft, top, labelPainter.width, labelPainter.height);
        if (rect.top >= 0 &&
            rect.bottom <= plotHeight &&
            !extremeLabels.any((extreme) => rect.overlaps(extreme.rect))) {
          labelOffset = Offset(labelLeft, top);
          break;
        }
      }
      if (labelOffset != null) break;
    }
    if (labelOffset != null) labelPainter.paint(canvas, labelOffset);
    onPaint?.call();
  }

  @override
  bool shouldRepaint(_LiveRateMarkerPainter oldDelegate) =>
      marker.hour != oldDelegate.marker.hour ||
      marker.rate != oldDelegate.marker.rate ||
      marker.unit != oldDelegate.marker.unit ||
      marker.estimated != oldDelegate.marker.estimated ||
      maxY != oldDelegate.maxY ||
      color != oldDelegate.color ||
      label != oldDelegate.label ||
      labelStyle != oldDelegate.labelStyle ||
      textDirection != oldDelegate.textDirection ||
      textScaler != oldDelegate.textScaler ||
      !identical(extremeLabels, oldDelegate.extremeLabels);
}

class _LiveRateLegendItem extends StatelessWidget {
  const _LiveRateLegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 3,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      ),
      const SizedBox(width: 3),
      Text(label, style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}

String _hourRange(int hour, String locale) {
  final base = DateTime(2026, 1, 1);
  final formatter = DateFormat.jm(locale);
  final start = formatter.format(DateTime(base.year, base.month, base.day, hour));
  final end = formatter.format(DateTime(base.year, base.month, base.day, hour + 1));
  return '$start - $end';
}

String _coverageLabel(Localization localization, int coveredSeconds, String locale) => localization
    .insight_based_on_minutes
    .replaceAll('%m', NumberFormat.decimalPattern(locale).format(coveredSeconds / 60));

String _formatDifference(double todayValue, double comparisonValue, String locale) {
  final difference = (todayValue - comparisonValue) / comparisonValue;
  final formatted = NumberFormat.decimalPercentPattern(locale: locale, decimalDigits: 1).format(difference.abs());
  return difference > 0
      ? '+$formatted'
      : difference < 0
      ? '-$formatted'
      : formatted;
}

double _niceChartScale(double value) {
  if (!value.isFinite || value <= 0) return 1;
  final magnitude = math.pow(10, (math.log(value) / math.ln10).floor()).toDouble();
  return (value / magnitude).ceilToDouble() * magnitude;
}

String _liveMarkerSemanticsValue(_LiveRateMarkerData marker, String rate, String locale, Localization localization) {
  final estimate = marker.estimated ? ', ${localization.insight_estimated}' : '';
  return '${_hourRange(marker.hour, locale)}, $rate ${localization.insight_tracks_per_hour}$estimate';
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 8,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      ),
      const SizedBox(width: 3),
      Text(label, style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}
