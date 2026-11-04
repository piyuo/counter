import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/animated_swipe_pager.dart';
import 'business_period_row.dart';
import 'insight_chart.dart';
import 'insight_primary_metric.dart';

class AreaInsightSection extends StatefulWidget {
  const AreaInsightSection({
    required this.areaData,
    required this.comparisonPeriod,
    required this.observationStatus,
    super.key,
  });

  final core_domain.InsightAreaData areaData;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final core_domain.ObservationStatus observationStatus;

  @override
  State<AreaInsightSection> createState() => _AreaInsightSectionState();
}

class _AreaInsightSectionState extends State<AreaInsightSection> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final areaName = widget.areaData.isGlobal
        ? context.l.insight_area_global
        : (widget.areaData.name?.trim().isNotEmpty ?? false)
        ? widget.areaData.name!.trim()
        : '${context.l.main_screen_interest_areas} ${widget.areaData.name}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Row(
              children: [
                Icon(
                  widget.areaData.isGlobal ? Icons.public : Icons.crop_square,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    areaName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                _PageIndicator(currentPage: _selectedPage, count: widget.areaData.cards.length),
              ],
            ),
          ),
          AnimatedSwipePager(
            itemCount: widget.areaData.cards.length,
            onPageChanged: (page) => setState(() => _selectedPage = page),
            itemBuilder: (context, index) => _InsightMetricCard(
              data: widget.areaData.cards[index],
              comparisonPeriod: widget.comparisonPeriod,
              observationStatus: widget.observationStatus,
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightMetricCard extends StatelessWidget {
  const _InsightMetricCard({required this.data, required this.comparisonPeriod, required this.observationStatus});

  final core_domain.InsightCardData data;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;
  final core_domain.ObservationStatus observationStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _metricLabel(context, data.metric);
    final comparisonLabel = _comparisonLabel(context, comparisonPeriod);
    final scale = MediaQuery.textScalerOf(context).scale(1);
    final chartHeight = 150 + (scale - 1).clamp(0, 1.5) * 38;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            Text(
              _primaryCaption(context, data.metric),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            PrimaryMetric(data: data, comparisonLabel: comparisonLabel, observationStatus: observationStatus),
            const SizedBox(height: 10),
            Divider(height: 1, color: theme.dividerColor.withValues(alpha: 0.45)),
            const SizedBox(height: 6),
            for (final period in data.periods)
              BusinessPeriodRow(periodData: period, metric: data.metric, comparisonLabel: comparisonLabel),
            const SizedBox(height: 8),
            InsightChart(
              data: data,
              metricLabel: title,
              comparisonLabel: comparisonLabel,
              height: chartHeight.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.currentPage, required this.count});

  final int currentPage;
  final int count;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.swipe, size: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
      const SizedBox(width: 4),
      Text('${currentPage + 1}/$count', style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}

String _metricLabel(BuildContext context, core_domain.InsightMetric metric) => switch (metric) {
  core_domain.InsightMetric.passBy => context.l.insight_pass_by,
  core_domain.InsightMetric.stagnant => context.l.insight_stagnant,
  core_domain.InsightMetric.entry => context.l.insight_entry,
  core_domain.InsightMetric.exit => context.l.insight_exit,
  core_domain.InsightMetric.appear => context.l.insight_appear,
  core_domain.InsightMetric.disappear => context.l.insight_disappear,
  core_domain.InsightMetric.occupancyMean => context.l.average_occupancy,
  core_domain.InsightMetric.occupancyPeak => context.l.maximum_occupancy,
  core_domain.InsightMetric.dwellTimeMean => context.l.insight_average_completed_visit,
  core_domain.InsightMetric.dwellTimeMax => context.l.insight_longest_completed_visit,
};

String _primaryCaption(BuildContext context, core_domain.InsightMetric metric) => switch (metric) {
  core_domain.InsightMetric.occupancyMean ||
  core_domain.InsightMetric.occupancyPeak ||
  core_domain.InsightMetric.dwellTimeMean ||
  core_domain.InsightMetric.dwellTimeMax => context.l.insight_last_60_minutes,
  _ => '${context.l.insight_last_60_minutes} · ${context.l.insight_hourly_rate}',
};

String _comparisonLabel(BuildContext context, core_domain.TrafficComparisonPeriod period) => switch (period) {
  core_domain.TrafficComparisonPeriod.yesterday => context.l.insight_comparison_yesterday,
  core_domain.TrafficComparisonPeriod.sameDayLastWeek => context.l.insight_comparison_last_week,
  core_domain.TrafficComparisonPeriod.monthlyAverage => context.l.insight_comparison_monthly,
  core_domain.TrafficComparisonPeriod.yearlyAverage => context.l.insight_comparison_yearly,
};
