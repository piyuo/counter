import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import 'dashboard_chip.dart';
import 'hourly_metric_summary.dart';

class PrimaryMetricDetail extends ConsumerWidget {
  const PrimaryMetricDetail({required this.areaId, required this.metric, super.key});

  final int areaId;
  final core_domain.DashboardMetric metric;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(core_domain.dashboardStateProvider);
    final card = ref.read(core_domain.dashboardServiceProvider).findCard(areaId, metric);
    final primaryMeasure = card?.primary;
    if (primaryMeasure == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final wholeNumberFormat = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 0;
    final isHourlyRate = core_domain.isHourlyRate(primaryMeasure.unit);
    final unit = formatDashboardMeasurementUnit(context, primaryMeasure);

    final observedCount = primaryMeasure.amount * primaryMeasure.coveredSeconds / 3600;
    final countText = wholeNumberFormat.format(observedCount);
    final secondsText = wholeNumberFormat.format(primaryMeasure.coveredSeconds);
    final secondsPerHourText = wholeNumberFormat.format(3600);
    final rateText = wholeNumberFormat.format(primaryMeasure.amount);
    final coverageFormat = NumberFormat.percentPattern(locale)..maximumFractionDigits = 0;
    final coverageText = coverageFormat.format((primaryMeasure.coveredSeconds / 3600).clamp(0.0, 1.0));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  isHourlyRate ? context.l.insight_hourly_rate : context.l.insight_last_60_minutes,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              if (primaryMeasure.estimated) DashboardChip.yellow(label: context.l.insight_estimated),
            ],
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: formatDashboardMeasurement(context, primaryMeasure),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                if (unit.isNotEmpty)
                  TextSpan(
                    text: ' $unit',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (isHourlyRate) ...[
            const Divider(height: 24),
            DashboardBreakdownRow(label: context.l.observation_screen_observed_count, value: countText),
            const SizedBox(height: 8),
            DashboardBreakdownRow(label: context.l.payloads_screen_coverage, value: coverageText),
            const SizedBox(height: 8),
            DashboardBreakdownRow(
              label: context.l.observation_screen_observed_time,
              value: formatCompactDuration(context.l, primaryMeasure.coveredSeconds, fixedWidth: true),
            ),
            const SizedBox(height: 12),
            Text(
              '$countText ÷ $secondsText × $secondsPerHourText = $rateText ${context.l.insight_tracks_per_hour}',
              style: theme.textTheme.bodyMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
            ),
            const SizedBox(height: 4),
            Text(
              context.l.observation_screen_rate_calculation,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
