import 'package:flutter/material.dart';

class InsightMetricChip extends StatelessWidget {
  const InsightMetricChip({super.key, required this.label, this.textColor, this.backgroundColor});

  factory InsightMetricChip.yellow({required String label}) => InsightMetricChip(
    label: label,
    textColor: Colors.yellow.shade900.withValues(alpha: 0.9),
    backgroundColor: Colors.yellow.withValues(alpha: 0.18),
  );

  factory InsightMetricChip.blue({required String label}) => InsightMetricChip(
    label: label,
    textColor: Colors.blue.shade100.withValues(alpha: 0.9),
    backgroundColor: Colors.blue.withValues(alpha: 0.3),
  );

  final String label;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const StadiumBorder(),
      side: BorderSide.none,
      backgroundColor: backgroundColor,
      labelStyle: theme.textTheme.labelSmall?.copyWith(fontSize: 10, color: textColor),
      label: Text(label),
    );
  }
}
