// Insight chart widget.
//
// Contents:
// - InsightChart
// - Legend item

import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

class InsightChart extends StatelessWidget {
  const InsightChart({
    super.key,
    required this.data,
    required this.metricLabel,
    required this.comparisonLabel,
    required this.height,
  });

  final core_domain.InsightCardData data;
  final String metricLabel;
  final String comparisonLabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todayColor = theme.colorScheme.primary;
    final comparisonColor = theme.colorScheme.tertiary;
    final hasToday = data.chartPoints.any((point) => point.todayValue != null);
    final hasComparison = data.chartPoints.any((point) => point.comparisonValue != null);
    final maxValue = data.chartPoints
        .expand((point) => [point.todayValue, point.comparisonValue])
        .whereType<double>()
        .fold<double>(0, math.max);
    final maxY = maxValue <= 0 ? 1.0 : maxValue * 1.15;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: hasToday || hasComparison
              ? LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 1435,
                    minY: 0,
                    maxY: maxY,
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) =>
                          FlLine(color: theme.dividerColor.withValues(alpha: 0.22), strokeWidth: 1),
                    ),
                    borderData: FlBorderData(show: false),
                    lineTouchData: const LineTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text(_chartUnit(context, data.metric), style: theme.textTheme.labelSmall),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 34,
                          getTitlesWidget: (value, meta) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              NumberFormat('0.#', Localizations.localeOf(context).toString()).format(value),
                              style: theme.textTheme.labelSmall,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 360,
                          reservedSize: 24,
                          getTitlesWidget: (value, meta) {
                            final minute = value.round();
                            if (minute % 360 != 0 || minute >= 1440) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(_formatChartMinute(context, minute), style: theme.textTheme.labelSmall),
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      if (hasToday) _line(data.chartPoints, (point) => point.todayValue, todayColor),
                      if (hasComparison) _line(data.chartPoints, (point) => point.comparisonValue, comparisonColor),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
        const SizedBox(height: 2),
        Wrap(
          spacing: 14,
          runSpacing: 4,
          children: [
            if (hasToday) _LegendItem(color: todayColor, label: context.l.insight_today_chart(metricLabel)),
            if (hasComparison) _LegendItem(color: comparisonColor, label: comparisonLabel),
          ],
        ),
      ],
    );
  }

  LineChartBarData _line(
    List<core_domain.InsightChartPoint> points,
    double? Function(core_domain.InsightChartPoint point) readValue,
    Color color,
  ) => LineChartBarData(
    spots: [
      for (final point in points)
        readValue(point) == null ? FlSpot.nullSpot : FlSpot(point.minuteOfDay.toDouble(), readValue(point)!),
    ],
    color: color,
    barWidth: 2,
    isCurved: false,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
  );
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
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 5),
      Text(label, style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}

String _chartUnit(BuildContext context, core_domain.InsightMetric metric) => switch (metric) {
  core_domain.InsightMetric.occupancy => context.l.insight_chart_occupancy_unit,
  core_domain.InsightMetric.dwellTime => context.l.insight_chart_dwell_unit,
  _ => context.l.insight_chart_event_unit,
};

String _formatChartMinute(BuildContext context, int minute) {
  if (minute == 1440) return '24:00';
  final time = TimeOfDay(hour: minute ~/ 60, minute: minute % 60);
  return MaterialLocalizations.of(context).formatTimeOfDay(time, alwaysUse24HourFormat: true);
}
