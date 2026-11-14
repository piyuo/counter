import 'package:flutter/material.dart';

class DashboardChip extends StatelessWidget {
  const DashboardChip({super.key, required this.label, this.textColor, this.backgroundColor, this.tooltip});

  factory DashboardChip.yellow({required String label}) => DashboardChip(
    label: label,
    textColor: Colors.yellow.shade900.withValues(alpha: 0.9),
    backgroundColor: Colors.yellow.withValues(alpha: 0.18),
  );

  factory DashboardChip.blue({required String label}) => DashboardChip(
    label: label,
    textColor: Colors.blue.shade100.withValues(alpha: 0.9),
    backgroundColor: Colors.blue.withValues(alpha: 0.3),
  );

  final String label;
  final String? tooltip;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip ?? '',
      child: Chip(
        visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        side: BorderSide.none,
        backgroundColor: backgroundColor,
        labelStyle: theme.textTheme.labelSmall?.copyWith(fontSize: 10, color: textColor),
        label: Text(label),
      ),
    );
  }
}
