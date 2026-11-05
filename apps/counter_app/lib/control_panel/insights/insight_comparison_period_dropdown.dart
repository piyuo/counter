import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'insight_utils.dart';

class InsightComparisonPeriodDropdown extends StatelessWidget {
  const InsightComparisonPeriodDropdown({super.key, required this.value, required this.onChanged, this.fontSize});

  final core_domain.TrafficComparisonPeriod value;
  final ValueChanged<core_domain.TrafficComparisonPeriod> onChanged;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton<core_domain.TrafficComparisonPeriod>(
        value: value,
        isDense: true,
        isExpanded: true,
        alignment: AlignmentDirectional.centerEnd,
        borderRadius: BorderRadius.circular(8),
        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontSize: fontSize),
        onChanged: (period) {
          if (period != null) onChanged(period);
        },
        items: [
          for (final period in core_domain.TrafficComparisonPeriod.values)
            DropdownMenuItem(
              value: period,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                context.l.insight_comparison_period(insightComparisonPeriodLabel(context, period)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
        ],
      ),
    );
  }
}
