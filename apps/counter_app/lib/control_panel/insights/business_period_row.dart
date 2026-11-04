// Contents: BusinessPeriodRow and private business-period formatting helpers.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import 'insight_comparison_indicator.dart';
import 'insight_primary_metric.dart';

class BusinessPeriodRow extends StatelessWidget {
  const BusinessPeriodRow({super.key, required this.periodData, required this.metric, required this.comparisonLabel});

  final core_domain.InsightPeriodData periodData;
  final core_domain.InsightMetric metric;
  final String comparisonLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final period = periodData.period;
    final timeRange = '${_formatMinute(context, period.startMinute)} - ${_formatMinute(context, period.endMinute)}';
    final value = periodData.primary;
    final isUpcoming = periodData.status == core_domain.BusinessPeriodStatus.notStarted;
    final title = _periodLabel(context, period.id, period.name);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    if (value != null && value.estimated)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: InsightMetricChip.yellow(label: context.l.insight_estimated),
                      ),
                  ],
                ),
                Text(timeRange, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                if (periodData.status == core_domain.BusinessPeriodStatus.inProgress)
                  Text(
                    context.l.insight_period_in_progress,
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                InsightComparisonIndicator(
                  current: value?.value,
                  baseline: periodData.comparisonValue,
                  comparisonLabel: comparisonLabel,
                  showText: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatPeriodMetric(BuildContext context, core_domain.InsightMetric metric, double value) {
  final locale = Localizations.localeOf(context).toString();
  final rate = NumberFormat(value >= 10 ? '#,##0' : '0.#', locale).format(value);
  return switch (metric) {
    core_domain.InsightMetric.passBy ||
    core_domain.InsightMetric.stagnant ||
    core_domain.InsightMetric.entry ||
    core_domain.InsightMetric.exit ||
    core_domain.InsightMetric.appear ||
    core_domain.InsightMetric.disappear => '$rate ${context.l.insight_tracks_per_hour}',
    core_domain.InsightMetric.occupancyMean =>
      '${_formatNumber(context, value)} ${context.l.insight_objects_unit} ${context.l.insight_average_short}',
    core_domain.InsightMetric.occupancyPeak => '${_formatNumber(context, value)} ${context.l.insight_objects_unit}',
    core_domain.InsightMetric.dwellTimeMean =>
      '${formatCompactDuration(context.l, value.round())} ${context.l.insight_average_short}',
    core_domain.InsightMetric.dwellTimeMax => formatCompactDuration(context.l, value.round()),
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
