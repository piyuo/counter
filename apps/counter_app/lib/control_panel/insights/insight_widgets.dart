import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/format_compact_duration.dart';
import '../widgets/animated_swipe_pager.dart';
import 'insight_chart.dart';

class AreaInsightSection extends StatefulWidget {
  const AreaInsightSection({required this.area, required this.comparisonPeriod, super.key});

  final core_domain.InsightAreaData area;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;

  @override
  State<AreaInsightSection> createState() => _AreaInsightSectionState();
}

class _AreaInsightSectionState extends State<AreaInsightSection> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final areaName = widget.area.isGlobal
        ? context.l.insight_area_global
        : (widget.area.name?.trim().isNotEmpty ?? false)
        ? widget.area.name!.trim()
        : '${context.l.main_screen_interest_areas} ${widget.area.name}';
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
                  widget.area.isGlobal ? Icons.public : Icons.crop_square,
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
                _PageIndicator(currentPage: _selectedPage, count: widget.area.cards.length),
              ],
            ),
          ),
          AnimatedSwipePager(
            itemCount: widget.area.cards.length,
            onPageChanged: (page) => setState(() => _selectedPage = page),
            itemBuilder: (context, index) =>
                _InsightMetricCard(data: widget.area.cards[index], comparisonPeriod: widget.comparisonPeriod),
          ),
        ],
      ),
    );
  }
}

class _InsightMetricCard extends StatelessWidget {
  const _InsightMetricCard({required this.data, required this.comparisonPeriod});

  final core_domain.InsightCardData data;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _metricLabel(context, data.metric);
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
            Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            Text(_primaryCaption(context, data.metric), style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            _PrimaryMetric(data: data, comparisonPeriod: comparisonPeriod),
            const SizedBox(height: 10),
            Divider(height: 1, color: theme.dividerColor.withValues(alpha: 0.45)),
            const SizedBox(height: 6),
            for (final period in data.periods)
              _BusinessPeriodRow(periodData: period, metric: data.metric, comparisonPeriod: comparisonPeriod),
            const SizedBox(height: 8),
            InsightChart(
              data: data,
              metricLabel: title,
              comparisonLabel: _comparisonLabel(context, comparisonPeriod),
              height: chartHeight.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryMetric extends StatelessWidget {
  const _PrimaryMetric({required this.data, required this.comparisonPeriod});

  final core_domain.InsightCardData data;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = data.primary;
    final displayValue = value == null ? '—' : _formatMetricValue(context, data.metric, value.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(displayValue, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
            if (value?.estimated ?? false)
              Chip(
                visualDensity: VisualDensity.compact,
                labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(context.l.insight_estimated),
              ),
          ],
        ),
        if (value?.secondaryValue != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              _secondaryMetric(context, data.metric, value!.secondaryValue!),
              style: theme.textTheme.bodyMedium,
            ),
          ),
        const SizedBox(height: 2),
        _ComparisonIndicator(
          current: value?.value,
          baseline: data.comparisonValue,
          comparisonLabel: _comparisonLabel(context, comparisonPeriod),
          showText: true,
        ),
      ],
    );
  }
}

class _BusinessPeriodRow extends StatelessWidget {
  const _BusinessPeriodRow({required this.periodData, required this.metric, required this.comparisonPeriod});

  final core_domain.InsightPeriodData periodData;
  final core_domain.InsightMetric metric;
  final core_domain.TrafficComparisonPeriod comparisonPeriod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final period = periodData.period;
    final timeRange = '${_formatMinute(context, period.startMinute)} - ${_formatMinute(context, period.endMinute)}';
    final value = periodData.primary;
    final isUpcoming = periodData.status == core_domain.BusinessPeriodStatus.notStarted;
    final title = _periodLabel(context, period.id, period.name);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleSmall),
                Text(timeRange, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                if (periodData.status == core_domain.BusinessPeriodStatus.inProgress)
                  Text(
                    context.l.insight_period_in_progress,
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isUpcoming || value == null ? '—' : _formatPeriodMetric(context, metric, value.value),
                  textAlign: TextAlign.end,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (value?.secondaryValue != null)
                  Text(
                    _secondaryMetric(context, metric, value!.secondaryValue!),
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodySmall,
                  ),
                if (value?.estimated ?? false) Text(context.l.insight_estimated, style: theme.textTheme.labelSmall),
                _ComparisonIndicator(
                  current: value?.value,
                  baseline: periodData.comparisonValue,
                  comparisonLabel: _comparisonLabel(context, comparisonPeriod),
                  showText: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonIndicator extends StatelessWidget {
  const _ComparisonIndicator({
    required this.current,
    required this.baseline,
    required this.comparisonLabel,
    required this.showText,
  });

  final double? current;
  final double? baseline;
  final String comparisonLabel;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentValue = current;
    final baselineValue = baseline;
    if (currentValue == null || baselineValue == null || baselineValue <= 0) {
      return Wrap(
        spacing: 6,
        runSpacing: 2,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('-', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          if (showText)
            Text(
              context.l.insight_comparison_period(comparisonLabel),
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
        ],
      );
    }
    final difference = (currentValue - baselineValue) / baselineValue;
    final icon = difference > 0.005
        ? Icons.trending_up
        : difference < -0.005
        ? Icons.trending_down
        : Icons.trending_flat;
    final percent = NumberFormat('0.#%', Localizations.localeOf(context).toString()).format(difference);
    return Wrap(
      spacing: 3,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(icon, size: 15, color: theme.colorScheme.onSurfaceVariant),
        Text(percent, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        if (showText)
          Text(
            context.l.insight_comparison_period(comparisonLabel),
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
      ],
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
  core_domain.InsightMetric.occupancy => context.l.insight_occupancy,
  core_domain.InsightMetric.dwellTime => context.l.insight_dwell_time,
};

String _primaryCaption(BuildContext context, core_domain.InsightMetric metric) => switch (metric) {
  core_domain.InsightMetric.dwellTime =>
    '${context.l.insight_average_completed_visit} - ${context.l.insight_last_60_minutes}',
  _ => '${context.l.insight_last_60_minutes} · ${context.l.insight_hourly_rate}',
};

String _formatMetricValue(BuildContext context, core_domain.InsightMetric metric, double value) {
  final number = _formatNumber(context, value);
  return switch (metric) {
    core_domain.InsightMetric.passBy ||
    core_domain.InsightMetric.stagnant ||
    core_domain.InsightMetric.entry ||
    core_domain.InsightMetric.exit ||
    core_domain.InsightMetric.appear ||
    core_domain.InsightMetric.disappear => '$number ${context.l.insight_tracks_per_hour}',
    core_domain.InsightMetric.occupancy => '$number ${context.l.insight_objects_unit}',
    core_domain.InsightMetric.dwellTime => formatCompactDuration(context.l, value.round()),
  };
}

String _formatPeriodMetric(BuildContext context, core_domain.InsightMetric metric, double value) {
  final number = _formatNumber(context, value);
  return switch (metric) {
    core_domain.InsightMetric.passBy ||
    core_domain.InsightMetric.stagnant ||
    core_domain.InsightMetric.entry ||
    core_domain.InsightMetric.exit ||
    core_domain.InsightMetric.appear ||
    core_domain.InsightMetric.disappear => '$number ${context.l.insight_tracks_per_hour}',
    core_domain.InsightMetric.occupancy =>
      '$number ${context.l.insight_objects_unit} ${context.l.insight_average_short}',
    core_domain.InsightMetric.dwellTime =>
      '${formatCompactDuration(context.l, value.round())} ${context.l.insight_average_short}',
  };
}

String _secondaryMetric(BuildContext context, core_domain.InsightMetric metric, double value) {
  final label = switch (metric) {
    core_domain.InsightMetric.occupancy => context.l.insight_peak,
    core_domain.InsightMetric.dwellTime => context.l.insight_longest_completed_visit,
    _ => '',
  };
  if (label.isEmpty) return '';
  final formatted = metric == core_domain.InsightMetric.dwellTime
      ? formatCompactDuration(context.l, value.round())
      : '${_formatNumber(context, value)} ${context.l.insight_objects_unit}';
  return '$label: $formatted';
}

String _periodLabel(BuildContext context, String id, String fallback) => switch (id) {
  'breakfast' => context.l.insight_period_breakfast,
  'lunch' => context.l.insight_period_lunch,
  'dinner' => context.l.insight_period_dinner,
  _ => fallback,
};

String _comparisonLabel(BuildContext context, core_domain.TrafficComparisonPeriod period) => switch (period) {
  core_domain.TrafficComparisonPeriod.yesterday => context.l.insight_comparison_yesterday,
  core_domain.TrafficComparisonPeriod.sameDayLastWeek => context.l.insight_comparison_last_week,
  core_domain.TrafficComparisonPeriod.monthlyAverage => context.l.insight_comparison_monthly,
  core_domain.TrafficComparisonPeriod.yearlyAverage => context.l.insight_comparison_yearly,
};

String _formatNumber(BuildContext context, double value) =>
    NumberFormat('0.#', Localizations.localeOf(context).toString()).format(value);

String _formatMinute(BuildContext context, int minute) {
  if (minute == 1440) return '24:00';
  final time = TimeOfDay(hour: minute ~/ 60, minute: minute % 60);
  return MaterialLocalizations.of(context).formatTimeOfDay(time, alwaysUse24HourFormat: true);
}
