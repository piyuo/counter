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

  static const double _iconSize = 15;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neutral = theme.colorScheme.onSurfaceVariant;
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).toString();

    IconData? icon;
    var trendColor = neutral;
    var percent = '—';
    final currentValue = current;
    final baselineValue = baseline;
    if (currentValue != null && baselineValue != null && baselineValue > 0) {
      final difference = (currentValue - baselineValue) / baselineValue;
      if (difference > 0.005) {
        icon = Icons.trending_up;
        trendColor = isDark ? Colors.green.shade300 : Colors.green.shade700;
      } else if (difference < -0.005) {
        icon = Icons.trending_down;
        trendColor = isDark ? Colors.deepOrange.shade300 : Colors.deepOrange.shade700;
      } else {
        icon = Icons.trending_flat;
      }
      percent = _formatDifference(difference, locale);
    }

    final percentStyle = theme.textTheme.bodySmall?.copyWith(
      color: trendColor,
      fontWeight: FontWeight.w600,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    // Widest realistic text, used only to reserve a stable width.
    // Measured with the same style so the slot width matches the real text.
    final widest = '+${NumberFormat('0.0%', locale).format(9.999)}';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showText) ...[
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              context.l.insight_comparison_period(comparisonLabel),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(color: neutral),
            ),
          ),
        ],
        const SizedBox(width: 6),
        icon == null
            ? const SizedBox(width: _iconSize, height: _iconSize)
            : Icon(icon, size: _iconSize, color: trendColor),
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
