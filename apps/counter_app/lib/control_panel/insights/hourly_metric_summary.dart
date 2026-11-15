import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';

class HourlyMetricSummary extends StatelessWidget {
  const HourlyMetricSummary({
    required this.metric,
    required this.subtotal,
    required this.coveredSeconds,
    required this.hourlyRate,
    super.key,
  });

  final core_domain.DashboardMetric metric;
  final double? subtotal;
  final int coveredSeconds;
  final double? hourlyRate;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final numberFormat = NumberFormat.decimalPattern(locale)..maximumFractionDigits = 0;
    final subtotalText = formatDashboardMetricValue(context, metric, subtotal);
    final secondsText = numberFormat.format(coveredSeconds);
    final secondsPerHourText = numberFormat.format(3600);

    return Padding(
      padding: const EdgeInsets.fromLTRB(72, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 12),
          DashboardBreakdownRow(label: context.l.observation_screen_subtotal, value: subtotalText),
          const SizedBox(height: 8),
          DashboardBreakdownRow(
            label: context.l.observation_screen_observed_time,
            value: formatCompactDuration(context.l, coveredSeconds),
          ),
          if (hourlyRate != null) ...[
            const SizedBox(height: 4),
            Text(
              '$subtotalText ÷ $secondsText × $secondsPerHourText = ${numberFormat.format(hourlyRate)} ${context.l.insight_per_hour}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
            ),
            const SizedBox(height: 4),
            Text(
              context.l.observation_screen_rate_calculation,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class DashboardBreakdownRow extends StatelessWidget {
  const DashboardBreakdownRow({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
      const SizedBox(width: 12),
      Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    ],
  );
}
