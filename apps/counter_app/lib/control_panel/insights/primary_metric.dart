import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'dashboard_chip.dart';
import 'dashboard_formatter.dart';
import 'insight_comparison_indicator.dart';
import 'insight_comparison_period_dropdown.dart';

class PrimaryMetric extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricColor = formatObservationStatusColor(context, observationStatus);
    final primaryMeasure = data.primary;
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    final detectionType = appState?.detectionType;
    final unit = formatDashboardMeasurementUnit(context, primaryMeasure, detectionType);
    final statusColor = formatObservationStatusColor(context, observationStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashboardChip(
              label: formatObservationStatusLabel(context, observationStatus),
              tooltip: formatObservationStatusTooltip(context, observationStatus),
              textColor: statusColor.withValues(alpha: 0.9),
              backgroundColor: statusColor.withValues(alpha: 0.18),
            ),
            const SizedBox(width: 6),
            if (primaryMeasure != null && primaryMeasure.estimated)
              DashboardChip.yellow(label: context.l.insight_early_estimate),
            Expanded(
              child: Text.rich(
                textAlign: TextAlign.end,
                TextSpan(
                  children: [
                    TextSpan(
                      text: formatDashboardMeasurement(context, primaryMeasure),
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
              current: primaryMeasure?.amount,
              baseline: data.comparisonValue,
              comparisonLabel: formatTrafficComparisonPeriodLabel(context, comparisonPeriod),
            ),
          ],
        ),
      ],
    );
  }
}
