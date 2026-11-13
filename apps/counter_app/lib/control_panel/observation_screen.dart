import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart' as observation_model;
import 'package:core_domain/services/dashboard_metric_calculator.dart'
    as metric_calculator;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/widgets/feedback/glass_progress_indicator.dart';
import 'package:shared_l10n/shared_l10n.dart';

import 'insights/hourly_metric_summary.dart';
import 'insights/live_primary_panel.dart';
import 'utils/dashboard_utils.dart';

enum _ObservationPeriod {
  today,
  yesterday,
  lastWeek,
  monthlyAverage,
  yearlyAverage,
  custom,
}

class ObservationScreen extends ConsumerStatefulWidget {
  const ObservationScreen({
    required this.areaId,
    required this.metric,
    super.key,
  });

  final int areaId;
  final core_domain.DashboardMetric metric;

  @override
  ConsumerState<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends ConsumerState<ObservationScreen> {
  _ObservationPeriod _period = _ObservationPeriod.today;
  DateTime _customDate = DateUtils.dateOnly(DateTime.now());
  final Map<int, bool> _expandedHours = {};
  late Future<observation_model.ObservationSeries?> _observationsFuture;

  @override
  void initState() {
    super.initState();
    _observationsFuture = _loadObservations(_period, _customDate);
  }

  Future<observation_model.ObservationSeries?> _loadObservations(
    _ObservationPeriod period,
    DateTime customDate,
  ) {
    final analytics = ref.read(core_domain.analyticsServiceProvider);
    final now = DateTime.now();
    switch (period) {
      case _ObservationPeriod.today:
        return _loadDay(analytics, now);
      case _ObservationPeriod.yesterday:
        return _loadDay(analytics, DateTime(now.year, now.month, now.day - 1));
      case _ObservationPeriod.lastWeek:
        return _loadDay(analytics, DateTime(now.year, now.month, now.day - 7));
      case _ObservationPeriod.custom:
        return _loadDay(analytics, customDate);
      case _ObservationPeriod.monthlyAverage:
        return analytics.getMonthSummary(now.year, now.month).then((summary) {
          if (summary == null) return null;
          final isWeekend =
              now.weekday == DateTime.saturday ||
              now.weekday == DateTime.sunday;
          return isWeekend
              ? summary.weekendFiveMinuteObservation
              : summary.weekdayFiveMinuteObservation;
        });
      case _ObservationPeriod.yearlyAverage:
        return analytics.getYearSummary(now.year).then((summary) {
          if (summary == null) return null;
          final isWeekend =
              now.weekday == DateTime.saturday ||
              now.weekday == DateTime.sunday;
          return isWeekend
              ? summary.weekendFiveMinuteObservation
              : summary.weekdayFiveMinuteObservation;
        });
    }
  }

  Future<observation_model.ObservationSeries?> _loadDay(
    core_domain.AnalyticsService analytics,
    DateTime date,
  ) async {
    final summary = await analytics.getDaySummary(
      date.year,
      date.month,
      date.day,
    );
    return summary?.fiveMinuteObservations;
  }

  Future<void> _selectPeriod(_ObservationPeriod? period) async {
    if (period == null) return;
    var customDate = _customDate;
    if (period == _ObservationPeriod.custom) {
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

  String _periodLabel(
    BuildContext context,
    _ObservationPeriod period,
    DateFormat dateFormat,
  ) => switch (period) {
    _ObservationPeriod.today => context.l.insight_today,
    _ObservationPeriod.yesterday => context.l.insight_comparison_yesterday,
    _ObservationPeriod.lastWeek => context.l.insight_comparison_last_week,
    _ObservationPeriod.monthlyAverage => context.l.insight_comparison_monthly,
    _ObservationPeriod.yearlyAverage => context.l.insight_comparison_yearly,
    _ObservationPeriod.custom => dateFormat.format(_customDate),
  };

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) return const SizedBox.shrink();

    ref.listen(core_domain.analyticsStateProvider, (previous, next) {
      if (_period != _ObservationPeriod.today) return;
      if (previous?.lastUpdatedUtc == next.lastUpdatedUtc) return;
      setState(() {
        _observationsFuture = _loadObservations(_period, _customDate);
      });
    });

    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMMMd(locale);
    final timeFormat = DateFormat.Hm(locale);
    final numberFormat = NumberFormat.decimalPattern(locale)
      ..maximumFractionDigits = 0;
    final metricLabel = dashboardMetricLabel(context, widget.metric);

    return feature_pip.PipScaffold(
      title: metricLabel,
      builder: (scrollController) =>
          FutureBuilder<observation_model.ObservationSeries?>(
            key: ValueKey((_period, _customDate)),
            future: _observationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData) {
                return const Center(
                  child: GlassProgressIndicator.circular(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text(context.l.insight_error));
              }
              final observations = snapshot.data;
              if (observations == null || observations.isEmpty) {
                return Center(
                  child: Text(context.l.insight_comparison_unavailable),
                );
              }

              final byHour = <int, List<core_domain.Observation>>{};
              for (final observation in observations) {
                byHour.putIfAbsent(observation.hour, () => []).add(observation);
              }
              final sortedHours = byHour.keys.toList()..sort();
              final total = getDashboardMetricAggregateValue(
                observations.items,
                widget.areaId,
                widget.metric,
              );
              final hourlySummaries = {
                for (final hour in sortedHours)
                  hour: (
                    subtotal: getDashboardMetricAggregateValue(
                      byHour[hour]!,
                      widget.areaId,
                      widget.metric,
                    ),
                    coveredSeconds: getDashboardCoveredSeconds(
                      byHour[hour]!,
                      widget.areaId,
                    ),
                    measurement: metric_calculator
                        .calculateInsightMetricFromObservationsInRange(
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
                padding: const EdgeInsets.symmetric(
                  vertical: feature_pip.kScrollContentAppbarPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: DropdownButtonFormField<_ObservationPeriod>(
                        initialValue: _period,
                        isExpanded: true,
                        items: [
                          for (final period in _ObservationPeriod.values)
                            DropdownMenuItem(
                              value: period,
                              child: Text(
                                period == _ObservationPeriod.custom
                                    ? (_period == period
                                          ? _periodLabel(
                                              context,
                                              period,
                                              dateFormat,
                                            )
                                          : MaterialLocalizations.of(
                                              context,
                                            ).datePickerHelpText)
                                    : _periodLabel(context, period, dateFormat),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: _selectPeriod,
                      ),
                    ),
                    if (_period == _ObservationPeriod.today)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                        child: LivePrimaryPanel(
                          areaId: widget.areaId,
                          metric: widget.metric,
                        ),
                      ),
                    for (final hour in sortedHours)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: ExpansionTile(
                          initiallyExpanded: hour == sortedHours.last,
                          onExpansionChanged: (expanded) {
                            setState(() => _expandedHours[hour] = expanded);
                          },
                          dense: true,
                          minTileHeight: 10,
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          leading: Icon(
                            (_expandedHours[hour] ?? hour == sortedHours.last)
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                          title: Text(
                            timeFormat.format(DateTime(2000, 1, 1, hour)),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                          trailing: Text(
                            _formatHourlyMeasurement(
                              context,
                              hourlySummaries[hour]!.measurement,
                              hourlySummaries[hour]!.subtotal,
                              widget.metric,
                              numberFormat,
                            ),
                          ),
                          children: [
                            for (final observation in byHour[hour]!)
                              Padding(
                                padding: EdgeInsets.fromLTRB(72, 0, 16, 4),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${timeFormat.format(observation.dateTime)} - ${timeFormat.format(observation.dateTime.add(const Duration(minutes: 5)))}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontFeatures: const [
                                                FontFeature.tabularFigures(),
                                              ],
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      formatDashboardMetricValue(
                                        getDashboardMetricValue(
                                          observation,
                                          widget.areaId,
                                          widget.metric,
                                        ),
                                        widget.metric,
                                        numberFormat,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            HourlyMetricSummary(
                              metric: widget.metric,
                              subtotal: hourlySummaries[hour]!.subtotal,
                              coveredSeconds:
                                  hourlySummaries[hour]!.coveredSeconds,
                              hourlyRate: _hourlyRate(
                                hourlySummaries[hour]!.measurement,
                              ),
                            ),
                          ],
                        ),
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
                              formatDashboardMetricValue(
                                total,
                                widget.metric,
                                numberFormat,
                              ),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
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

double? _hourlyRate(core_domain.DashboardMeasurement? measurement) =>
    measurement?.unit == core_domain.DashboardMeasurementUnit.countPerHour
    ? measurement!.amount
    : null;

String _formatHourlyMeasurement(
  BuildContext context,
  core_domain.DashboardMeasurement? measurement,
  double? subtotal,
  core_domain.DashboardMetric metric,
  NumberFormat numberFormat,
) {
  if (!dashboardMetricUsesHourlyRate(metric)) {
    return formatDashboardMetricValue(subtotal, metric, numberFormat);
  }
  if (measurement?.unit != core_domain.DashboardMeasurementUnit.countPerHour) {
    return '—';
  }
  final rate = numberFormat.format(measurement!.amount);
  return '$rate ${context.l.insight_tracks_per_hour}';
}
