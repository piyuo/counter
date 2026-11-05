// Contents: BusinessPeriodRow and private business-period formatting helpers.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/insight_comparison_indicator.dart';
import 'package:counter_app/control_panel/insights/insight_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import 'insight_comparison_period_dropdown.dart';
import 'insight_metric_chip.dart';

class BusinessPeriodRow extends StatelessWidget {
  const BusinessPeriodRow({
    super.key,
    required this.periodData,
    required this.metric,
    required this.comparisonPeriod,
    required this.onComparisonChanged,
  });

  final core_domain.InsightPeriodData periodData;
  final core_domain.InsightMetric metric;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final ValueChanged<core_domain.TrafficComparisonPeriod> onComparisonChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final period = periodData.period;
    final timeRange = '${_formatMinute(context, period.startMinute)} - ${_formatMinute(context, period.endMinute)}';
    final value = periodData.primary;
    final isUpcoming = periodData.status == core_domain.BusinessPeriodStatus.notStarted;
    final title = _periodLabel(context, period.id, period.name);
    final comparisonValue = periodData.comparisonValue;
    final hasComparison = periodData.comparisonValue != null;
    final comparisonLabel = insightComparisonPeriodLabel(context, comparisonPeriod);

    Widget comparison;
    if (!hasComparison) {
      // no comparison available
      comparison = Expanded(
        child: Text('-', textAlign: TextAlign.end, style: theme.textTheme.bodySmall),
      );
    } else if (value == null) {
      final comparisonParts = _formatPeriodMetricParts(context, metric, comparisonValue!);
      final fontColor = Colors.grey;
      comparison = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(comparisonLabel, style: TextStyle(color: fontColor, fontSize: 12)),
          const SizedBox(width: 6),
          Flexible(
            child: Text.rich(
              textAlign: TextAlign.end,
              TextSpan(
                children: [
                  TextSpan(
                    text: comparisonParts.number,
                    style: TextStyle(
                      fontSize: 12,
                      color: fontColor,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  if (comparisonParts.unit.isNotEmpty)
                    TextSpan(
                      text: ' ${comparisonParts.unit}',
                      style: TextStyle(color: fontColor, fontSize: 12),
                    ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      // can be compared
      comparison = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: InsightComparisonPeriodDropdown(
              value: comparisonPeriod,
              onChanged: onComparisonChanged,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 6),
          InsightComparisonIndicator(
            current: value.value,
            baseline: periodData.comparisonValue,
            comparisonLabel: comparisonLabel,
          ),
        ],
      );
    }
    comparison = Expanded(
      child: Text(
        '-',
        textAlign: TextAlign.end,
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row 1: title + chips (left), metric value (right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    if (periodData.status == core_domain.BusinessPeriodStatus.inProgress)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: InsightMetricChip.blue(label: context.l.insight_period_in_progress),
                      ),
                    if (value != null && value.estimated)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: InsightMetricChip.yellow(label: context.l.insight_estimated),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isUpcoming || value == null ? '—' : _formatPeriodMetric(context, metric, value.value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          // Row 2: time range (left), comparison (right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                timeRange,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),

              const SizedBox(width: 8),
              Flexible(child: comparison),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatPeriodMetric(BuildContext context, core_domain.InsightMetric metric, double value) {
  final parts = _formatPeriodMetricParts(context, metric, value);
  return parts.unit.isEmpty ? parts.number : '${parts.number} ${parts.unit}';
}

({String number, String unit}) _formatPeriodMetricParts(
  BuildContext context,
  core_domain.InsightMetric metric,
  double value,
) {
  final locale = Localizations.localeOf(context).toString();
  return switch (metric) {
    core_domain.InsightMetric.passBy ||
    core_domain.InsightMetric.stagnant ||
    core_domain.InsightMetric.entry ||
    core_domain.InsightMetric.exit ||
    core_domain.InsightMetric.appear ||
    core_domain.InsightMetric.disappear => (
      number: NumberFormat(value >= 10 ? '#,##0' : '0.#', locale).format(value),
      unit: context.l.insight_tracks_per_hour,
    ),
    core_domain.InsightMetric.occupancyMean => (
      number: _formatNumber(context, value),
      unit: '${context.l.insight_objects_unit} ${context.l.insight_average_short}',
    ),
    core_domain.InsightMetric.occupancyPeak => (
      number: _formatNumber(context, value),
      unit: context.l.insight_objects_unit,
    ),
    core_domain.InsightMetric.dwellTimeMean => (
      number: formatCompactDuration(context.l, value.round()),
      unit: context.l.insight_average_short,
    ),
    core_domain.InsightMetric.dwellTimeMax => (number: formatCompactDuration(context.l, value.round()), unit: ''),
  };
}

String _periodLabel(BuildContext context, String id, String fallback) => switch (id) {
  'breakfast' => context.l.insight_period_breakfast,
  'lunch' => context.l.insight_period_lunch,
  'dinner' => context.l.insight_period_dinner,
  _ => fallback,
};

String _formatNumber(BuildContext context, double value) =>
    NumberFormat('0.#', Localizations.localeOf(context).toString()).format(value);

String _formatMinute(BuildContext context, int minute) {
  if (minute == 1440) return '24:00';
  final time = TimeOfDay(hour: minute ~/ 60, minute: minute % 60);
  return MaterialLocalizations.of(context).formatTimeOfDay(time, alwaysUse24HourFormat: true);
}
