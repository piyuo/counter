import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

class InsightComparisonIndicator extends StatelessWidget {
  const InsightComparisonIndicator({
    super.key,
    required this.current,
    required this.baseline,
    required this.comparisonLabel,
    required this.showText,
  });

  final double? current;
  final double? baseline;
  final String comparisonLabel;
  final bool showText;

  static const double _iconSize = 14;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neutralText = theme.colorScheme.onSurfaceVariant;
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).toString();

    IconData? icon;
    var percent = '—';
    var pillColor = theme.colorScheme.surfaceContainerHighest;
    var pillForeground = neutralText;

    final currentValue = current;
    final baselineValue = baseline;
    if (currentValue != null && baselineValue != null && baselineValue > 0) {
      final difference = (currentValue - baselineValue) / baselineValue;
      if (difference > 0.005) {
        icon = Icons.trending_up;
        pillColor = isDark ? Colors.green.shade700 : Colors.green.shade800;
        pillForeground = Colors.white;
      } else if (difference < -0.005) {
        icon = Icons.trending_down;
        pillColor = isDark ? Colors.deepOrange.shade700 : Colors.deepOrange.shade800;
        pillForeground = Colors.white;
      } else {
        icon = Icons.trending_flat;
      }
      percent = _formatDifference(difference, locale);
    }

    final percentStyle = theme.textTheme.labelMedium?.copyWith(
      color: pillForeground,
      fontWeight: FontWeight.w700,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    // Widest realistic text, used only to reserve a stable width.
    final widest = '+${NumberFormat('0%', locale).format(9.999)}';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: pillColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon == null
                  ? const SizedBox(width: _iconSize, height: _iconSize)
                  : Icon(icon, size: _iconSize, color: pillForeground),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  ExcludeSemantics(
                    child: Opacity(opacity: 0, child: Text(widest, maxLines: 1, style: percentStyle)),
                  ),
                  Text(percent, maxLines: 1, style: percentStyle),
                ],
              ),
            ],
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              context.l.insight_comparison_period(comparisonLabel),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(color: neutralText),
            ),
          ),
        ],
      ],
    );
  }

  /// 10% and above: whole percent. Below 10%: one fixed decimal.
  /// Always signed, and tiny values collapse to 0 so "-0.0%" never appears.
  static String _formatDifference(double difference, String locale) {
    final rounded = difference.abs() < 0.0005 ? 0.0 : difference;
    final pattern = rounded.abs() >= 0.1 ? '0%' : '0.0%';
    final text = NumberFormat(pattern, locale).format(rounded);
    return rounded > 0 ? '+$text' : text;
  }
}
