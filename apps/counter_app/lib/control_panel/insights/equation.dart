import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/control_panel/utils/format_compact_duration.dart';
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'dashboard_formatter.dart';

class Equation extends StatelessWidget {
  const Equation({
    required this.amount,
    required this.coveredSeconds,
    required this.expectedSeconds,
    required this.metric,
    required this.detectionType,
    super.key,
  });

  final double amount;
  final int coveredSeconds;
  final int expectedSeconds;
  final core_domain.DashboardMetric metric;
  final core_domain.DetectionType? detectionType;

  @override
  Widget build(BuildContext context) {
    final result = amount / coveredSeconds * 3600;
    final coveredSecondsText = formatCompactSeconds(context, coveredSeconds);
    final expectedSecondsText = formatCompactSeconds(context, expectedSeconds);

    final amountText = formatDashboardValue(context, amount);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(
            '$amountText ÷ $coveredSecondsText × $expectedSecondsText = ${formatDashboardMetricValueUnit(context, metric, result, detectionType)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(context.l.observation_screen_rate_calculation, style: TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
