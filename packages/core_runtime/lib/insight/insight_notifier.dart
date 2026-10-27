import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_notifier.g.dart';

@Riverpod(keepAlive: true)
class InsightNotifier extends _$InsightNotifier implements core_domain.InsightService {
  InsightNotifier({DateTime Function()? nowProvider}) : _nowProvider = nowProvider ?? DateTime.now;

  final DateTime Function() _nowProvider;

  /// current comparison period
  core_domain.TrafficComparisonPeriod _comparisonPeriod = core_domain.TrafficComparisonPeriod.yesterday;
  String? _currentBusinessDate;
  Object? _cachedComparisonSummary;

  @override
  core_domain.InsightDashboard build() {
    ref.onDispose(_observationsController.close);
    return const core_domain.InsightDashboard(
      businessDate: '',
      comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
    );
  }

  final StreamController<core_domain.InsightDashboard> _observationsController = StreamController.broadcast();

  @override
  Stream<core_domain.InsightDashboard> get snapshots => _observationsController.stream;

  core_domain.TrafficComparisonPeriod get comparisonPeriod => _comparisonPeriod;

  void setComparisonPeriod(core_domain.TrafficComparisonPeriod period) {
    if (_comparisonPeriod == period) {
      return;
    }
    _comparisonPeriod = period;
    _cachedComparisonSummary = null;
  }

  @override
  Future<void> refresh() async {
    final now = _nowProvider();
    final period = _comparisonPeriod;
    final businessDate = _formatBusinessDate(now);
    if (_currentBusinessDate != businessDate) {
      _currentBusinessDate = businessDate;
      _cachedComparisonSummary = null;
    }

    final analytics = ref.read(core_domain.analyticsServiceProvider);
    final todaySummary = await analytics.getDaySummary(now.year, now.month, now.day);

    ObservationSeries? comparisonSeries;
    core_domain.Observation? comparisonTypicalDay;
    core_domain.Observation? comparisonPastHourObservation;

    switch (period) {
      case core_domain.TrafficComparisonPeriod.yesterday:
      case core_domain.TrafficComparisonPeriod.sameDayLastWeek:
        final daysAgo = period == core_domain.TrafficComparisonPeriod.yesterday ? 1 : 7;
        final comparisonDate = DateTime(now.year, now.month, now.day - daysAgo);
        final summary = await _getCachedComparisonSummary(
          businessDate,
          period,
          () => analytics.getDaySummary(comparisonDate.year, comparisonDate.month, comparisonDate.day),
        );
        comparisonSeries = summary?.fiveMinuteObservations;
        comparisonTypicalDay = summary?.dailyTotal;
        comparisonPastHourObservation = summary?.pastHourObservationAt(now.hour, now.minute);
      case core_domain.TrafficComparisonPeriod.monthlyAverage:
        final summary = await _getCachedComparisonSummary(
          businessDate,
          period,
          () => analytics.getMonthSummary(now.year, now.month),
        );
        if (summary != null) {
          final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
          comparisonSeries = isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
          comparisonTypicalDay = summary.monthlyTotal;
          comparisonPastHourObservation = _pastHourObservation(comparisonSeries, now);
        }
      case core_domain.TrafficComparisonPeriod.yearlyAverage:
        final summary = await _getCachedComparisonSummary(
          businessDate,
          period,
          () => analytics.getYearSummary(now.year),
        );
        if (summary != null) {
          final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
          comparisonSeries = isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
          comparisonTypicalDay = summary.yearlyTotal;
          comparisonPastHourObservation = _pastHourObservation(comparisonSeries, now);
        }
    }

    final dashboard = core_domain.InsightDashboard(
      businessDate: _formatBusinessDate(now),
      comparisonPeriod: period,
      todaySeries: todaySummary?.fiveMinuteObservations,
      pastHourObservation: todaySummary?.pastHourObservationAt(now.hour, now.minute),
      comparisonSeries: comparisonSeries,
      comparisonPastHourObservation: comparisonPastHourObservation,
      comparisonTypicalDay: comparisonTypicalDay,
    );
    state = dashboard;
    _observationsController.add(dashboard);
  }

  Future<T?> _getCachedComparisonSummary<T extends Object>(
    String businessDate,
    core_domain.TrafficComparisonPeriod period,
    Future<T?> Function() load,
  ) async {
    if (_cachedComparisonSummary != null && _currentBusinessDate == businessDate) {
      return _cachedComparisonSummary as T?;
    }

    final summary = await load();
    if (_currentBusinessDate == businessDate) {
      _cachedComparisonSummary = summary;
    }
    return summary;
  }

  core_domain.Observation? _pastHourObservation(ObservationSeries? series, DateTime endTime) {
    if (series == null || series.isEmpty) return null;

    final windowEnd = DateTime(endTime.year, endTime.month, endTime.day, endTime.hour, endTime.minute ~/ 5 * 5);
    final windowStart = windowEnd.subtract(const Duration(hours: 1));
    final sources = series
        .where((observation) {
          final observationTime = DateTime(
            windowEnd.year,
            windowEnd.month,
            windowEnd.day,
            observation.hour,
            observation.minute,
          );
          return !observationTime.isBefore(windowStart) && observationTime.isBefore(windowEnd);
        })
        .map((observation) {
          final observationTime = DateTime(
            windowEnd.year,
            windowEnd.month,
            windowEnd.day,
            observation.hour,
            observation.minute,
          );
          final minuteInWindow = observationTime.difference(windowStart).inMinutes;
          return observation.copyWith(
            year: windowEnd.year,
            month: windowEnd.month,
            day: windowEnd.day,
            hour: windowEnd.hour,
            minute: minuteInWindow ~/ 5 * 5,
          );
        })
        .toList();

    if (sources.isEmpty) return null;
    return const core_domain.ObservationRollup().aggregate(
      sources,
      granularity: core_domain.ObservationGranularity.hour,
    );
  }

  String _formatBusinessDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
