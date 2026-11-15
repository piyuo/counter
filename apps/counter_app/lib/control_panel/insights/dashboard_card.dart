import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/business_period_row.dart';
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'insight_chart.dart';
import 'primary_metric.dart';

class DashboardCard extends ConsumerWidget {
  const DashboardCard({
    super.key,
    required this.areaId,
    required this.data,
    required this.comparisonPeriod,
    required this.onComparisonChanged,
    required this.observationStatus,
  });

  final int areaId;
  final core_domain.DashboardCardData data;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final ValueChanged<core_domain.TrafficComparisonPeriod> onComparisonChanged;
  final core_domain.ObservationStatus observationStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final title = formatDashboardMetricLabel(context, data.metric);
    final comparisonLabel = formatTrafficComparisonPeriodLabel(context, comparisonPeriod);
    final scale = MediaQuery.textScalerOf(context).scale(1);
    final chartHeight = 150 + (scale - 1).clamp(0, 1.5) * 38;

    String primaryCaption() {
      if (observationStatus != core_domain.ObservationStatus.started) {
        return context.l.insight_counting_paused_last_recorded;
      }

      if (data.primary != null && data.primary!.estimated) {
        final baseOnMinutes = (data.primary!.coveredSeconds / 60).round();
        return context.l.insight_based_on_minutes.replaceAll('%m', baseOnMinutes.toString());
      }

      return context.l.insight_last_60_minutes;
    }

    return Card(
      color: Colors.black12,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(9, 2, 9, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              subtitle: Text(
                primaryCaption(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
              trailing: Padding(padding: const EdgeInsets.only(right: 8.0), child: Icon(Icons.arrow_forward_ios)),
              onTap: () {
                ref.push(core_domain.OpenObservationDetails(areaId: areaId, metric: data.metric));
              },
            ),
            PrimaryMetric(
              data: data,
              comparisonPeriod: comparisonPeriod,
              onComparisonChanged: onComparisonChanged,
              observationStatus: observationStatus,
            ),
            const SizedBox(height: 6),
            Divider(height: 1, color: theme.dividerColor.withValues(alpha: 0.45)),
            const SizedBox(height: 4),
            for (final period in data.periods)
              BusinessPeriodRow(
                periodData: period,
                metric: data.metric,
                comparisonPeriod: comparisonPeriod,
                onComparisonChanged: onComparisonChanged,
              ),
            const SizedBox(height: 8),
            InsightChart(
              data: data,
              metricLabel: title,
              comparisonLabel: comparisonLabel,
              height: chartHeight.toDouble(),
              showLiveMarker: observationStatus == core_domain.ObservationStatus.started,
            ),
          ],
        ),
      ),
    );
  }
}
