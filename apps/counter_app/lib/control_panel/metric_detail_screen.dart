import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart' as observation_model;
import 'package:core_domain/services/dashboard_metric_calculator.dart' as metric_calculator;
import 'package:counter_app/control_panel/insights/dashboard_formatter.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'insights/observation_tile.dart';
import 'insights/primary_metric_detail.dart';
import 'utils/dashboard_utils.dart';

class MetricDetailScreen extends ConsumerStatefulWidget {
  const MetricDetailScreen({required this.areaId, required this.metric, super.key});

  final int areaId;
  final core_domain.DashboardMetric metric;

  @override
  ConsumerState<MetricDetailScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends ConsumerState<MetricDetailScreen> {
  core_domain.TrafficPeriod _period = core_domain.TrafficPeriod.liveToday;
  DateTime _customDate = DateUtils.dateOnly(DateTime.now());
  final Map<int, bool> _expandedHours = {};
  late Future<observation_model.ObservationSeries?> _observationsFuture;

  @override
  void initState() {
    super.initState();
    _observationsFuture = _loadObservations(_period, _customDate);
  }

  Future<observation_model.ObservationSeries?> _loadObservations(
    core_domain.TrafficPeriod period,
    DateTime customDate,
  ) {
    final insight = ref.read(core_domain.insightServiceProvider);
    final now = DateTime.now();
    switch (period) {
      case core_domain.TrafficPeriod.liveToday:
        return insight.getObservationsFromLiveToday();
      case core_domain.TrafficPeriod.yesterday:
        return insight.getObservationsFromYesterday();
      case core_domain.TrafficPeriod.sameDayLastWeek:
        return insight.getObservationsFromSameDayLastWeek();
      case core_domain.TrafficPeriod.customDay:
        final date = DateUtils.dateOnly(customDate);
        if (date == DateUtils.dateOnly(now)) {
          return insight.getObservationsFromLiveToday();
        }
        return insight.getObservationsByDate(date);
      case core_domain.TrafficPeriod.lastMonthAverage:
        return insight.getObservationsFromLastMonth();
      case core_domain.TrafficPeriod.lastYearAverage:
        return insight.getObservationsFromLastYear();
      case core_domain.TrafficPeriod.today:
        throw UnimplementedError();
    }
  }

  Future<void> _selectPeriod(core_domain.TrafficPeriod? period) async {
    if (period == null) return;
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
      _period = period;
      _customDate = customDate;
      _expandedHours.clear();
      _observationsFuture = _loadObservations(period, customDate);
    });
  }

  String _periodLabel(BuildContext context, core_domain.TrafficPeriod period, DateFormat dateFormat) {
    if (period == core_domain.TrafficPeriod.customDay) {
      return dateFormat.format(_customDate);
    }
    return formatTrafficPeriodLabel(context, period);
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) return const SizedBox.shrink();

    ref.listen(core_domain.insightStateProvider, (previous, next) {
      if (_period != core_domain.TrafficPeriod.liveToday) return;
      if (previous?.businessDate == next.businessDate &&
          previous?.todaySeries == next.todaySeries &&
          previous?.recentHourTotal == next.recentHourTotal) {
        return;
      }
      setState(() {
        _observationsFuture = _loadObservations(_period, _customDate);
      });
    });

    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);
    final timeFormat = DateFormat.Hm(locale);
    final metricLabel = formatMetricLabel(context, widget.metric);

    return feature_pip.PipScaffold(
      title: metricLabel,
      builder: (scrollController) => FutureBuilder<observation_model.ObservationSeries?>(
        key: ValueKey((_period, _customDate)),
        future: _observationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(child: GlassProgressIndicator.circular(strokeWidth: 2.5, color: Colors.white));
          }
          if (snapshot.hasError) {
            return Center(child: Text(context.l.insight_error));
          }
          final observations = snapshot.data;
          if (observations == null || observations.isEmpty) {
            return Center(child: Text(context.l.insight_comparison_unavailable));
          }

          final byHour = <int, List<core_domain.Observation>>{};
          for (final observation in observations) {
            byHour.putIfAbsent(observation.hour, () => []).add(observation);
          }
          final sortedHours = byHour.keys.toList()..sort();
          final total = getDashboardMetricAggregateValue(observations.items, widget.areaId, widget.metric);
          final hourlySummaries = {
            for (final hour in sortedHours)
              hour: (
                subtotal: getDashboardMetricAggregateValue(byHour[hour]!, widget.areaId, widget.metric),
                coveredSeconds: getDashboardCoveredSeconds(byHour[hour]!),
                measurement: metric_calculator.calculateInsightMetricFromObservationsInRange(
                  series: observations,
                  startMinute: hour * 60,
                  endMinute: (hour + 1) * 60,
                  areaId: widget.areaId,
                  metric: widget.metric,
                  expectedSeconds: 3600,
                ),
              ),
          };

          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimaryMetricDetail(areaId: widget.areaId, metric: widget.metric),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: DropdownButtonFormField<core_domain.TrafficPeriod>(
                    initialValue: _period,
                    isExpanded: true,
                    items: [
                      for (final period in core_domain.TrafficPeriod.values)
                        DropdownMenuItem(
                          value: period,
                          child: Text(
                            period == core_domain.TrafficPeriod.customDay
                                ? (_period == period
                                      ? _periodLabel(context, period, dateFormat)
                                      : MaterialLocalizations.of(context).datePickerHelpText)
                                : _periodLabel(context, period, dateFormat),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: _selectPeriod,
                  ),
                ),
                for (final hour in sortedHours)
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
                    detectionType: appState.detectionType,
                  ),
                feature_pip.PipPanel(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l.observation_screen_total,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          formatDashboardMetricValueUnit(context, widget.metric, total, appState.detectionType),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
