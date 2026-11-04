import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import 'insight_comparison_indicator.dart';

class PrimaryMetric extends StatelessWidget {
  const PrimaryMetric({super.key, required this.data, required this.comparisonLabel, required this.observationStatus});

  final core_domain.InsightCardData data;
  final String comparisonLabel;
  final core_domain.ObservationStatus observationStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metricColor = insightObservationStatusColor(context, observationStatus);
    final value = data.primary;
    final number = value == null ? '—' : _formatPrimaryNumber(context, data.metric, value.value);
    final unit = value == null ? '' : _primaryUnit(context, data.metric);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ObservationStatusChip(status: observationStatus),
            const SizedBox(width: 6),
            if (observationStatus == core_domain.ObservationStatus.live && value != null && value.estimated)
              InsightMetricChip.yellow(label: context.l.insight_early_estimate),
            if (observationStatus != core_domain.ObservationStatus.live)
              InsightMetricChip.yellow(label: context.l.insight_counting_paused),
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
        Align(
          alignment: Alignment.centerRight,
          child: InsightComparisonIndicator(
            current: value?.value,
            baseline: data.comparisonValue,
            comparisonLabel: comparisonLabel,
            showText: true,
          ),
        ),
      ],
    );
  }
}

class InsightMetricChip extends StatelessWidget {
  const InsightMetricChip({super.key, required this.label, this.textColor, this.backgroundColor});

  factory InsightMetricChip.yellow({required String label}) => InsightMetricChip(
    label: label,
    textColor: Colors.yellow.shade900.withValues(alpha: 0.9),
    backgroundColor: Colors.yellow.withValues(alpha: 0.18),
  );

  final String label;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      side: BorderSide.none,
      backgroundColor: backgroundColor,
      labelStyle: theme.textTheme.labelSmall?.copyWith(color: textColor),
      label: Text(label),
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
      child: InsightMetricChip(
        label: label,
        textColor: statusColor.withValues(alpha: 0.9),
        backgroundColor: statusColor.withValues(alpha: 0.18),
      ),
    );
  }
}

String _formatPrimaryNumber(BuildContext context, core_domain.InsightMetric metric, double value) {
  final locale = Localizations.localeOf(context).toString();
  return switch (metric) {
    core_domain.InsightMetric.dwellTimeMean ||
    core_domain.InsightMetric.dwellTimeMax => formatCompactDuration(context.l, value.round()),
    core_domain.InsightMetric.occupancyMean ||
    core_domain.InsightMetric.occupancyPeak => NumberFormat('0.#', locale).format(value),
    _ => NumberFormat(value >= 10 ? '#,##0' : '0.#', locale).format(value),
  };
}

String _primaryUnit(BuildContext context, core_domain.InsightMetric metric) => switch (metric) {
  core_domain.InsightMetric.occupancyMean || core_domain.InsightMetric.occupancyPeak => context.l.insight_objects_unit,
  core_domain.InsightMetric.dwellTimeMean || core_domain.InsightMetric.dwellTimeMax => '',
  _ => context.l.insight_tracks_per_hour,
};

Color insightObservationStatusColor(BuildContext context, core_domain.ObservationStatus status) => switch (status) {
  core_domain.ObservationStatus.live => Colors.green,
  core_domain.ObservationStatus.interrupted => Colors.amber.shade900,
  core_domain.ObservationStatus.stopped => Theme.of(context).colorScheme.error,
};
