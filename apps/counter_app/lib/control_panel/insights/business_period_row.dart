// Contents: BusinessPeriodRow and private business-period formatting helpers.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/insight_comparison_indicator.dart';
import 'package:counter_app/control_panel/insights/insight_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import 'dashboard_chip.dart';
import 'insight_comparison_period_dropdown.dart';

class BusinessPeriodRow extends StatelessWidget {
  const BusinessPeriodRow({
    super.key,
    required this.periodData,
    required this.metric,
    required this.comparisonPeriod,
    required this.onComparisonChanged,
  });

  final core_domain.DashboardPeriodData periodData;
  final core_domain.DashboardMetric metric;
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

    List<Widget> buildComparison() {
      if (value == null) {
        final comparisonParts = _formatPeriodMetricParts(context, metric, comparisonValue!);
        final fontColor = Colors.grey;
        return [
          const Spacer(),
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
        ];
      }
      //has value
      return [
        Flexible(
          child: InsightComparisonPeriodDropdown(value: comparisonPeriod, onChanged: onComparisonChanged, fontSize: 12),
        ),
        const SizedBox(width: 6),
        InsightComparisonIndicator(
          current: value.amount,
          baseline: periodData.comparisonValue,
          comparisonLabel: comparisonLabel,
        ),
      ];
    }

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
                        child: DashboardChip.blue(label: context.l.insight_period_in_progress),
                      ),
                    if (value != null && value.estimated)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: DashboardChip.yellow(label: context.l.insight_estimated),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isUpcoming || value == null ? '—' : _formatPeriodMetricValue(context, metric, value),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  timeRange,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),

              if (!hasComparison) Text('-', textAlign: TextAlign.end, style: theme.textTheme.bodySmall),
              if (hasComparison) ...buildComparison(),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatPeriodMetricValue(
  BuildContext context,
  core_domain.DashboardMetric metric,
  core_domain.DashboardMeasurement value,
) {
  final normalizedValue = switch (value.unit) {
    core_domain.DashboardMeasurementUnit.seconds => value.amount,
    core_domain.DashboardMeasurementUnit.minutes => value.amount * 60,
    _ => value.amount,
  };
  final parts = _formatPeriodMetricParts(context, metric, normalizedValue);
  return parts.unit.isEmpty ? parts.number : '${parts.number} ${parts.unit}';
}

({String number, String unit}) _formatPeriodMetricParts(
  BuildContext context,
  core_domain.DashboardMetric metric,
  double value,
) {
  final locale = Localizations.localeOf(context).toString();
  return switch (metric) {
    core_domain.DashboardMetric.passBy ||
    core_domain.DashboardMetric.stagnant ||
    core_domain.DashboardMetric.entry ||
    core_domain.DashboardMetric.exit ||
    core_domain.DashboardMetric.appear ||
    core_domain.DashboardMetric.disappear => (
      number: NumberFormat(value >= 10 ? '#,##0' : '0.#', locale).format(value),
      unit: context.l.insight_tracks_per_hour,
    ),
    core_domain.DashboardMetric.occupancyMean => (
      number: _formatNumber(context, value),
      unit: '${context.l.insight_objects_unit} ${context.l.insight_average_short}',
    ),
    core_domain.DashboardMetric.occupancyPeak => (
      number: _formatNumber(context, value),
      unit: context.l.insight_objects_unit,
    ),
    core_domain.DashboardMetric.dwellTimeMean => (
      number: formatCompactDuration(context.l, value.round()),
      unit: context.l.insight_average_short,
    ),
    core_domain.DashboardMetric.dwellTimeMax => (number: formatCompactDuration(context.l, value.round()), unit: ''),
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
