import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'insights/hourly_metric_summary.dart';
import 'utils/dashboard_utils.dart';

class ObservationTile extends StatelessWidget {
  const ObservationTile({
    required this.hourLabel,
    required this.initiallyExpanded,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.observations,
    required this.areaId,
    required this.metric,
    required this.subtotal,
    required this.coveredSeconds,
    required this.measurement,
    required this.timeFormat,
    super.key,
  });

  final String hourLabel;
  final bool initiallyExpanded;
  final bool? isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final List<core_domain.Observation> observations;
  final int areaId;
  final core_domain.DashboardMetric metric;
  final double? subtotal;
  final int coveredSeconds;
  final core_domain.DashboardMeasurement? measurement;
  final DateFormat timeFormat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: onExpansionChanged,
        dense: true,
        minTileHeight: 10,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Icon((isExpanded ?? initiallyExpanded) ? Icons.expand_less : Icons.expand_more),
        title: Text(
          hourLabel,
          style: const TextStyle(fontWeight: FontWeight.w700, fontFeatures: [FontFeature.tabularFigures()]),
        ),
        trailing: Text(formatDashboardMetricValue(context, metric, subtotal)),
        children: [
          for (final observation in observations)
            Padding(
              padding: const EdgeInsets.fromLTRB(72, 0, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${timeFormat.format(observation.dateTime)} - ${timeFormat.format(observation.dateTime.add(const Duration(minutes: 5)))}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    formatDashboardMetricValue(context, metric, getDashboardMetricValue(observation, areaId, metric)),
                  ),
                ],
              ),
            ),
          HourlyMetricSummary(
            metric: metric,
            subtotal: subtotal,
            coveredSeconds: coveredSeconds,
            hourlyRate: _hourlyRate(measurement),
          ),
        ],
      ),
    );
  }

  double? _hourlyRate(core_domain.DashboardMeasurement? value) =>
      value?.unit == core_domain.DashboardMeasurementUnit.countPerHour ? value!.amount : null;
}
