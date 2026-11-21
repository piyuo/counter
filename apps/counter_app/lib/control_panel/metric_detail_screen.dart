import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/insight/observation_series_helpers.dart';
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'insights/breakdown_row.dart';
import 'insights/equation.dart';
import 'insights/metric_detail_period_dropdown.dart';
import 'insights/observation_tile.dart';
import 'utils/dashboard_utils.dart';
import 'utils/format_compact_duration.dart';

class MetricDetailScreen extends ConsumerStatefulWidget {
  const MetricDetailScreen({required this.areaId, required this.metric, super.key});

  final int areaId;
  final core_domain.DashboardMetric metric;

  @override
  ConsumerState<MetricDetailScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends ConsumerState<MetricDetailScreen> {
  core_domain.TrafficPeriod _trafficPeriod = core_domain.TrafficPeriod.today;
  DateTime _customDate = DateUtils.dateOnly(DateTime.now());
  final Map<int, bool> _expandedHours = {};
  final Map<String, bool> _expandedBusinessPeriods = {};
  late Future<core_domain.ObservationSeries?> _observationsFuture;
  (core_domain.TrafficPeriod, DateTime)? _loadedKey;

  @override
  void initState() {
    super.initState();
    _observationsFuture = _loadObservations(_trafficPeriod, _customDate);
  }

  Future<core_domain.ObservationSeries?> _loadObservations(
    core_domain.TrafficPeriod period,
    DateTime customDate,
  ) async {
    final insight = ref.read(core_domain.insightServiceProvider);
    core_domain.ObservationSeries? observations;
    switch (period) {
      case core_domain.TrafficPeriod.liveToday:
      case core_domain.TrafficPeriod.today:
        // don't include real-time observations here
        observations = await insight.getObservationsFromToday();
        break;
      case core_domain.TrafficPeriod.yesterday:
        observations = await insight.getObservationsFromYesterday();
        break;
      case core_domain.TrafficPeriod.sameDayLastWeek:
        observations = await insight.getObservationsFromSameDayLastWeek();
        break;
      case core_domain.TrafficPeriod.customDay:
        final date = DateUtils.dateOnly(customDate);
        observations = await insight.getObservationsByDate(date);
        break;
      case core_domain.TrafficPeriod.lastMonthAverage:
        observations = await insight.getObservationsFromLastMonth();
        break;
      case core_domain.TrafficPeriod.lastYearAverage:
        observations = await insight.getObservationsFromLastYear();
        break;
    }
    if (observations == null) {
      return null;
    }
    return fillSeriesHours(observations, now: DateTime.now());
  }

  Future<void> _selectPeriod(core_domain.TrafficPeriod period) async {
    var customDate = _customDate;
    if (period == core_domain.TrafficPeriod.customDay) {
      final today = DateUtils.dateOnly(DateTime.now());
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: customDate.isAfter(today) ? today : customDate,
        firstDate: DateTime(2000),
        lastDate: today,
      );
      if (selectedDate == null || !mounted) return;
      customDate = DateUtils.dateOnly(selectedDate);
    }
    setState(() {
      _trafficPeriod = period;
      _customDate = customDate;
      _expandedHours.clear();
      _expandedBusinessPeriods.clear();
      _observationsFuture = _loadObservations(period, customDate);
    });
  }

  List<ObservationTile> buildObservationTiles(
    core_domain.ObservationSeries? observations,
    core_domain.DetectionType detectionType,
    DateFormat timeFormat,
  ) {
    if (observations == null || observations.isEmpty) return [];

    final byHour = <int, List<core_domain.Observation>>{};
    for (final observation in observations) {
      byHour.putIfAbsent(observation.hour, () => []).add(observation);
    }
    final sortedHours = byHour.keys.toList()..sort();
    final hourlySummaries = {
      for (final hour in sortedHours)
        hour: (
          subtotal: getDashboardMetricAggregateValue(byHour[hour]!, widget.areaId, widget.metric),
          coveredSeconds: getDashboardCoveredSeconds(byHour[hour]!),
          measurement: core_domain.calculateInsightMetricFromObservationsInRange(
            series: observations,
            startMinute: hour * 60,
            endMinute: (hour + 1) * 60,
            areaId: widget.areaId,
            metric: widget.metric,
            expectedSeconds: 3600,
          ),
        ),
    };
    final result = <ObservationTile>[];
    for (final hour in sortedHours) {
      result.add(
        ObservationTile(
          initiallyExpanded: hour == sortedHours.last,
          isExpanded: _expandedHours[hour],
          onExpansionChanged: (expanded) {
            setState(() => _expandedHours[hour] = expanded);
          },
          observations: byHour[hour]!,
          expectedSeconds: 3600, // observations only hour data
          areaId: widget.areaId,
          metric: widget.metric,
          measurement: hourlySummaries[hour]!.measurement,
          timeFormat: timeFormat,
          detectionType: detectionType,
        ),
      );
    }

    return result;
  }

  List<ObservationTile> buildBusinessPeriodTiles(
    core_domain.ObservationSeries? observations,
    List<core_domain.BusinessPeriod> businessPeriods,
    core_domain.DetectionType detectionType,
    DateFormat timeFormat,
  ) {
    if (observations == null || observations.isEmpty) return [];

    final groups = groupDashboardObservationsByBusinessPeriod(observations, businessPeriods);
    final now = DateTime.now();
    final isCurrentDateSelection =
        _trafficPeriod == core_domain.TrafficPeriod.today ||
        (_trafficPeriod == core_domain.TrafficPeriod.customDay && DateUtils.isSameDay(_customDate, now));

    return [
      for (var index = 0; index < groups.length; index++)
        _buildBusinessPeriodTile(
          groups[index],
          observations,
          detectionType,
          timeFormat,
          isCurrentDateSelection && groups[index].period.statusAt(now) == core_domain.BusinessPeriodStatus.inProgress,
        ),
    ];
  }

  ObservationTile _buildBusinessPeriodTile(
    DashboardBusinessPeriodGroup group,
    core_domain.ObservationSeries series,
    core_domain.DetectionType detectionType,
    DateFormat timeFormat,
    bool isInProgress,
  ) {
    final period = group.period;
    final expectedSeconds = (period.endMinute - period.startMinute) * 60;
    return ObservationTile(
      isExpanded: _expandedBusinessPeriods[period.id],
      onExpansionChanged: (expanded) => setState(() => _expandedBusinessPeriods[period.id] = expanded),
      observations: group.observations,
      expectedSeconds: expectedSeconds,
      areaId: widget.areaId,
      metric: widget.metric,
      measurement: core_domain.calculateInsightMetricFromObservationsInRange(
        series: series,
        startMinute: period.startMinute,
        endMinute: period.endMinute,
        areaId: widget.areaId,
        metric: widget.metric,
        expectedSeconds: expectedSeconds,
      ),
      timeFormat: timeFormat,
      detectionType: detectionType,
      showInProgressLabel: isInProgress,
      titleBuilder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_businessPeriodLabel(context, period)),
          Text(
            _businessPeriodTimeRange(period, timeFormat),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  String _businessPeriodLabel(BuildContext context, core_domain.BusinessPeriod period) => switch (period.id) {
    'breakfast' => context.l.insight_period_breakfast,
    'lunch' => context.l.insight_period_lunch,
    'dinner' => context.l.insight_period_dinner,
    _ => period.name,
  };

  String _businessPeriodTimeRange(core_domain.BusinessPeriod period, DateFormat timeFormat) {
    String formatMinute(int minute) {
      if (minute == 1440) return '24:00';
      return timeFormat.format(DateTime(2000, 1, 1, minute ~/ 60, minute % 60));
    }

    return '${formatMinute(period.startMinute)} – ${formatMinute(period.endMinute)}';
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) return const SizedBox.shrink();

    ref.listen(core_domain.insightStateProvider, (previous, next) {
      if (_trafficPeriod != core_domain.TrafficPeriod.today) return;
      if (previous?.businessDate == next.businessDate && previous?.todaySeries == next.todaySeries) {
        return;
      }
      setState(() {
        _observationsFuture = _loadObservations(_trafficPeriod, _customDate);
      });
    });

    final locale = Localizations.localeOf(context).toString();
    final timeFormat = DateFormat.Hm(locale);
    final metricLabel = formatMetricLabel(context, widget.metric);

    return feature_pip.PipScaffold(
      title: metricLabel,
      builder: (scrollController) => FutureBuilder<core_domain.ObservationSeries?>(
        key: ValueKey((_trafficPeriod, _customDate)),
        future: _observationsFuture,
        builder: (context, snapshot) {
          final loadKey = (_trafficPeriod, _customDate);
          if (snapshot.connectionState == ConnectionState.done) {
            _loadedKey = loadKey;
          }
          // Null results are valid, so `hasData` can't tell a refresh from the first load.
          if (snapshot.connectionState == ConnectionState.waiting && _loadedKey != loadKey) {
            return const Center(child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white));
          }
          if (snapshot.hasError) {
            return Center(child: Text(context.l.insight_error));
          }
          final observations = snapshot.data;

          final items = observations?.items ?? const <core_domain.Observation>[];
          final total = getDashboardMetricAggregateValue(items, widget.areaId, widget.metric) ?? 0;
          final totalCoveredSeconds = getDashboardCoveredSeconds(items);
          final businessPeriodTiles = buildBusinessPeriodTiles(
            observations,
            appState.businessPeriods,
            appState.detectionType,
            timeFormat,
          );

          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // explain realtime recent hour observation
                _PrimaryMetricDetail(areaId: widget.areaId, metric: widget.metric),
                // select the period for the observations
                MetricDetailPeriodDropdown(value: _trafficPeriod, customDate: _customDate, onChanged: _selectPeriod),
                ...businessPeriodTiles,
                if (businessPeriodTiles.isNotEmpty)
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Divider(height: 1)),
                ...buildObservationTiles(observations, appState.detectionType, timeFormat),
                if (observations != null && observations.isNotEmpty)
                  feature_pip.PipPanel(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        BreakdownRow(
                          label: context.l.observation_screen_total,
                          value: formatDashboardMetricValue(context, widget.metric, total),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        BreakdownRow(
                          label: context.l.observation_screen_observed_time,
                          value: formatCompactSeconds(context, totalCoveredSeconds),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ],
                    ),
                  ),
                if (observations != null && observations.isNotEmpty)
                  Equation(
                    amount: total,
                    coveredSeconds: totalCoveredSeconds,
                    metric: widget.metric,
                    detectionType: appState.detectionType,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PrimaryMetricDetail extends ConsumerStatefulWidget {
  const _PrimaryMetricDetail({required this.areaId, required this.metric});

  final int areaId;
  final core_domain.DashboardMetric metric;

  @override
  ConsumerState<_PrimaryMetricDetail> createState() => _PrimaryMetricDetailState();
}

class _PrimaryMetricDetailState extends ConsumerState<_PrimaryMetricDetail> {
  bool _isRecentHourExpanded = true;

  @override
  Widget build(BuildContext context) {
    ref.watch(core_domain.dashboardStateProvider);
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    final detectionType = appState?.detectionType;
    final card = ref.read(core_domain.dashboardServiceProvider).findCard(widget.areaId, widget.metric);
    final primaryMeasure = card?.primary;
    if (primaryMeasure == null || card == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final recentHourObservations = card.recentHourObservations;
    final metricHelp = formatMetricHelp(context, primaryMeasure.metric);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(metricHelp, style: theme.textTheme.bodySmall),
        ),
        if (recentHourObservations != null && recentHourObservations.isNotEmpty)
          ObservationTile(
            initiallyExpanded: true,
            isExpanded: _isRecentHourExpanded,
            onExpansionChanged: (expanded) => setState(() => _isRecentHourExpanded = expanded),
            observations: recentHourObservations.items,
            expectedSeconds: 3600, // observations only content recent hour
            areaId: widget.areaId,
            metric: widget.metric,
            measurement: primaryMeasure,
            timeFormat: DateFormat.Hm(Localizations.localeOf(context).toString()),
            detectionType: detectionType,
            minTileHeight: 32,
            titleBuilder: (_) => const SizedBox.shrink(),
            trailingBuilder: (timeText) => Text(
              timeText,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
      ],
    );
  }
}
