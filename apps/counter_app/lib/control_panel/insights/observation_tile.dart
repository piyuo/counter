import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/dashboard_utils.dart';
import '../utils/format_compact_duration.dart';
import 'breakdown_row.dart';
import 'equation.dart';

typedef ObservationHeaderBuilder = Widget Function(String value);

const _timeColumnWidth = 112.0;
const _observedColumnWidth = 58.0;
const _columnSpacing = 8.0;

class ObservationTile extends StatelessWidget {
  const ObservationTile({
    this.initiallyExpanded = false,
    required this.isExpanded,
    required this.observations,
    required this.expectedSeconds,
    required this.areaId,
    required this.metric,
    required this.measurement,
    required this.timeFormat,
    super.key,
    this.onExpansionChanged,
    this.detectionType,
    this.titleBuilder,
    this.trailingBuilder,
    this.minTileHeight = 16,
    this.showInProgressLabel,
  });

  final bool initiallyExpanded;
  final bool? isExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final List<core_domain.Observation> observations;
  final int expectedSeconds;
  final int areaId;
  final core_domain.DashboardMetric metric;
  final core_domain.DashboardMeasurement? measurement;
  final DateFormat timeFormat;
  final core_domain.DetectionType? detectionType;
  final ObservationHeaderBuilder? titleBuilder;
  final ObservationHeaderBuilder? trailingBuilder;
  final double minTileHeight;
  final bool? showInProgressLabel;

  @override
  Widget build(BuildContext context) {
    double observedSum = core_domain.getMetricSum(areaId, metric, observations);
    int coveredSeconds = core_domain.getCoveredSeconds(observations);
    final hourStart = DateTime(2000, 1, 1, observations.first.hour);
    final timeText = '${timeFormat.format(hourStart)} – ${timeFormat.format(hourStart.add(const Duration(hours: 1)))}';
    String trailingText = formatDashboardMetricHourlyTotal(context, metric, observedSum, coveredSeconds, detectionType);
    final subtotalText = formatDashboardMetricValue(context, metric, observedSum);
    final columnHeadingStyle = Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600);

    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      dense: true,
      minTileHeight: minTileHeight,
      tilePadding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      leading: Icon((isExpanded ?? initiallyExpanded) ? Icons.expand_less : Icons.expand_more),
      title: titleBuilder != null
          ? titleBuilder!('')
          : Wrap(
              children: [
                Text(
                  timeText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
      trailing: trailingBuilder != null ? trailingBuilder!(trailingText) : Text(trailingText),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(52, 0, 16, 0),
          child: Row(
            children: [
              SizedBox(
                width: _timeColumnWidth,
                child: Text(context.l.observation_screen_time, style: columnHeadingStyle),
              ),
              const SizedBox(width: _columnSpacing),
              SizedBox(
                width: _observedColumnWidth,
                child: Text(
                  context.l.observation_screen_observed,
                  textAlign: TextAlign.right,
                  style: columnHeadingStyle,
                ),
              ),
              const SizedBox(width: _columnSpacing),
              Expanded(
                child: Text(context.l.observation_screen_count, textAlign: TextAlign.right, style: columnHeadingStyle),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        for (final observation in observations)
          Padding(
            padding: const EdgeInsets.fromLTRB(52, 0, 16, 0),
            child: Row(
              children: [
                SizedBox(
                  width: _timeColumnWidth,
                  child: Text(
                    '${timeFormat.format(observation.dateTime)} - ${timeFormat.format(observation.dateTime.add(const Duration(minutes: 5)))}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                ),
                const SizedBox(width: _columnSpacing),
                SizedBox(
                  width: _observedColumnWidth,
                  child: observation.isMissing
                      ? null
                      : Text(
                          formatCompactSeconds(context, observation.coveredSeconds),
                          textAlign: TextAlign.right,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                        ),
                ),
                const SizedBox(width: _columnSpacing),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.right,
                    formatDashboardMetricValue(context, metric, getDashboardMetricValue(observation, areaId, metric)),
                  ),
                ),
              ],
            ),
          ),
        if (showInProgressLabel ?? observations.length < 12)
          Padding(
            padding: const EdgeInsets.fromLTRB(52, 8, 16, 8),
            child: Text(
              context.l.insight_period_in_progress,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
        const SizedBox(height: 8),
        Padding(padding: const EdgeInsets.fromLTRB(52, 0, 16, 0), child: const Divider(height: 1)),
        const SizedBox(height: 8),
        BreakdownRow(label: context.l.observation_screen_subtotal, value: subtotalText),
        BreakdownRow(
          label: context.l.observation_screen_observed_time,
          value: formatCompactSeconds(context, coveredSeconds),
        ),
        const SizedBox(height: 8),
        // Equation showing the hourly rate calculation
        Equation(amount: observedSum, coveredSeconds: coveredSeconds, metric: metric, detectionType: null),
      ],
    );
  }
}
