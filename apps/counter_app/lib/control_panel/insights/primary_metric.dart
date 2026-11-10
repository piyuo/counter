import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import 'dashboard_chip.dart';
import 'insight_comparison_indicator.dart';
import 'insight_comparison_period_dropdown.dart';
import 'insight_utils.dart';

class PrimaryMetric extends StatelessWidget {
  const PrimaryMetric({
    super.key,
    required this.data,
    required this.comparisonPeriod,
    required this.onComparisonChanged,
    required this.observationStatus,
  });

  final core_domain.DashboardCardData data;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final ValueChanged<core_domain.TrafficComparisonPeriod> onComparisonChanged;
  final core_domain.ObservationStatus observationStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metricColor = insightObservationStatusColor(context, observationStatus);
    final value = data.primary;
    final number = value == null ? '—' : formatInsightPrimaryNumber(context, value.value, value.unit);
    final unit = value == null ? '' : _primaryUnit(context, value.unit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ObservationStatusChip(status: observationStatus),
            const SizedBox(width: 6),
            if (value != null && value.estimated) DashboardChip.yellow(label: context.l.insight_early_estimate),
            Expanded(
              child: Text.rich(
                textAlign: TextAlign.end,
                TextSpan(
                  children: [
                    TextSpan(
                      text: number,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: metricColor,
                        fontWeight: FontWeight.w700,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    if (unit.isNotEmpty)
                      TextSpan(
                        text: ' $unit',
                        style: theme.textTheme.titleSmall?.copyWith(color: metricColor, fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: InsightComparisonPeriodDropdown(value: comparisonPeriod, onChanged: onComparisonChanged),
            ),
            const SizedBox(width: 6),
            InsightComparisonIndicator(
              current: value?.value,
              baseline: data.comparisonValue,
              comparisonLabel: insightComparisonPeriodLabel(context, comparisonPeriod),
            ),
          ],
        ),
      ],
    );
  }
}

class _ObservationStatusChip extends StatelessWidget {
  const _ObservationStatusChip({required this.status});

  final core_domain.ObservationStatus status;

  @override
  Widget build(BuildContext context) {
    final statusColor = insightObservationStatusColor(context, status);
    final (label, description) = switch (status) {
      core_domain.ObservationStatus.live => (
        context.l.observation_status_live,
        context.l.observation_status_live_description,
      ),
      core_domain.ObservationStatus.interrupted => (
        context.l.observation_status_interrupted,
        context.l.observation_status_interrupted_description,
      ),
      core_domain.ObservationStatus.stopped => (
        context.l.observation_status_stopped,
        context.l.observation_status_stopped_description,
      ),
    };

    return Tooltip(
      message: description,
      child: DashboardChip(
        label: label,
        textColor: statusColor.withValues(alpha: 0.9),
        backgroundColor: statusColor.withValues(alpha: 0.18),
      ),
    );
  }
}

String formatInsightPrimaryNumber(BuildContext context, double value, core_domain.DashboardMetricValueUnit unit) {
  final locale = Localizations.localeOf(context).toString();
  return switch (unit) {
    core_domain.DashboardMetricValueUnit.seconds => formatCompactDuration(context.l, value.round()),
    core_domain.DashboardMetricValueUnit.minutes => formatCompactDuration(context.l, (value * 60).round()),
    core_domain.DashboardMetricValueUnit.objects => NumberFormat('0.#', locale).format(value),
    core_domain.DashboardMetricValueUnit.count || core_domain.DashboardMetricValueUnit.countPerHour => NumberFormat(
      value >= 10 ? '#,##0' : '0.#',
      locale,
    ).format(value),
  };
}

String _primaryUnit(BuildContext context, core_domain.DashboardMetricValueUnit unit) => switch (unit) {
  core_domain.DashboardMetricValueUnit.objects => context.l.insight_objects_unit,
  core_domain.DashboardMetricValueUnit.countPerHour => context.l.insight_tracks_per_hour,
  core_domain.DashboardMetricValueUnit.count ||
  core_domain.DashboardMetricValueUnit.seconds ||
  core_domain.DashboardMetricValueUnit.minutes => '',
};

Color insightObservationStatusColor(BuildContext context, core_domain.ObservationStatus status) => switch (status) {
  core_domain.ObservationStatus.live => Colors.green,
  core_domain.ObservationStatus.interrupted => Colors.amber.shade900,
  core_domain.ObservationStatus.stopped => Theme.of(context).colorScheme.error,
};
