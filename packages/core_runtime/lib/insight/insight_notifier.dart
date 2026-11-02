import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../observation/observation_notifier.dart' as live_observation;

part 'insight_notifier.g.dart';

@Riverpod(keepAlive: true)
class InsightNotifier extends _$InsightNotifier implements core_domain.InsightService {
  InsightNotifier({DateTime Function()? nowProvider}) : _nowProvider = nowProvider ?? DateTime.now;

  final DateTime Function() _nowProvider;

  /// current comparison period
  core_domain.TrafficComparisonPeriod _comparisonPeriod = core_domain.TrafficComparisonPeriod.yesterday;
  String? _currentBusinessDate;
  Object? _cachedComparisonSummary;
  core_domain.TrafficComparisonPeriod? _cachedComparisonPeriod;
  int _refreshGeneration = 0;
  ObservationSeries? _todaySeries;

  @override
  core_domain.InsightDashboard build() {
    return const core_domain.InsightDashboard(
      businessDate: '',
      comparisonPeriod: core_domain.TrafficComparisonPeriod.yesterday,
    );
  }

  core_domain.TrafficComparisonPeriod get comparisonPeriod => _comparisonPeriod;

  @override
  void onObservationChanged() {
    _updateRecentHourTotal();
  }

  @override
  void onFiveMinuteObservationCompleted(core_domain.Observation observation) {
    unawaited(refresh());
  }

  @override
  void setComparisonPeriod(core_domain.TrafficComparisonPeriod period) {
    if (_comparisonPeriod == period) {
      return;
    }
    _comparisonPeriod = period;
    _cachedComparisonSummary = null;
    _cachedComparisonPeriod = null;
  }

  @override
  Future<void> refresh() async {
    final refreshGeneration = ++_refreshGeneration;
    final now = _nowProvider();
    final period = _comparisonPeriod;
    final businessDate = _formatBusinessDate(now);
    if (_currentBusinessDate != businessDate) {
      _currentBusinessDate = businessDate;
      _cachedComparisonSummary = null;
      _cachedComparisonPeriod = null;
      _todaySeries = null;
    }

    final analytics = ref.read(core_domain.analyticsServiceProvider);
    final todaySummary = await analytics.getDaySummary(now.year, now.month, now.day);
    if (!_isCurrentRefresh(refreshGeneration, period, businessDate)) return;

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
          refreshGeneration,
          () => analytics.getDaySummary(comparisonDate.year, comparisonDate.month, comparisonDate.day),
        );
        comparisonSeries = summary?.fiveMinuteObservations;
        if (comparisonSeries != null) {
          comparisonPastHourObservation = core_domain.getRecentHourTotalAt(now.hour, now.minute, comparisonSeries);
        }
        comparisonTypicalDay = summary?.dailyTotal;
      case core_domain.TrafficComparisonPeriod.monthlyAverage:
        final summary = await _getCachedComparisonSummary(
          businessDate,
          period,
          refreshGeneration,
          () => analytics.getMonthSummary(now.year, now.month),
        );
        if (summary != null) {
          final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
          comparisonSeries = isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
          comparisonTypicalDay = summary.monthlyTotal;
          comparisonPastHourObservation = core_domain.getRecentHourTotalAt(now.hour, now.minute, comparisonSeries);
        }
      case core_domain.TrafficComparisonPeriod.yearlyAverage:
        final summary = await _getCachedComparisonSummary(
          businessDate,
          period,
          refreshGeneration,
          () => analytics.getYearSummary(now.year),
        );
        if (summary != null) {
          final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
          comparisonSeries = isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
          comparisonTypicalDay = summary.yearlyTotal;
          comparisonPastHourObservation = core_domain.getRecentHourTotalAt(now.hour, now.minute, comparisonSeries);
        }
    }

    if (!_isCurrentRefresh(refreshGeneration, period, businessDate)) return;

    _todaySeries = todaySummary?.fiveMinuteObservations;
    final dashboard = core_domain.InsightDashboard(
      businessDate: _formatBusinessDate(now),
      comparisonPeriod: period,
      todaySeries: todaySummary?.fiveMinuteObservations,
      recentHourObservation: recentHourTotal(),
      comparisonSeries: comparisonSeries,
      comparisonRecentHourObservation: comparisonPastHourObservation,
      comparisonTypicalDay: comparisonTypicalDay,
    );
    state = dashboard;
  }

  /// Aggregates today's completed observations with the current live 5-minute
  /// observation when it belongs to the active business-time slot.
  core_domain.Observation? recentHourTotal() {
    final now = _nowProvider();
    final live = ref.read(live_observation.observationProvider).liveObservation;
    if (live == null) return null;

    final currentSlotMinute = (now.minute ~/ 5) * 5;

    final observationsBySlot = <int, core_domain.Observation>{
      for (final observation in _todaySeries ?? ObservationSeries.empty) _slotKey(observation): observation,
    };

    final isCurrentLiveObservation =
        live.granularity == core_domain.ObservationGranularity.minutes5 &&
        live.year == now.year &&
        live.month == now.month &&
        live.day == now.day &&
        live.hour == now.hour &&
        live.minute == currentSlotMinute;

    if (isCurrentLiveObservation) {
      observationsBySlot[_slotKey(live)] = live;
    }

    return core_domain.getRecentHourTotalAt(
      now.hour,
      now.minute,
      ObservationSeries.fromObservations(observationsBySlot.values),
    );
  }

  int _slotKey(core_domain.Observation observation) => observation.hour * 60 + observation.minute;

  void _updateRecentHourTotal() {
    final dashboard = state;
    if (dashboard.businessDate.isEmpty || dashboard.businessDate != _currentBusinessDate) return;

    state = core_domain.InsightDashboard(
      businessDate: dashboard.businessDate,
      comparisonPeriod: dashboard.comparisonPeriod,
      recentHourObservation: recentHourTotal(),
      comparisonRecentHourObservation: dashboard.comparisonRecentHourObservation,
      todaySeries: dashboard.todaySeries,
      comparisonSeries: dashboard.comparisonSeries,
      comparisonTypicalDay: dashboard.comparisonTypicalDay,
    );
  }

  Future<T?> _getCachedComparisonSummary<T extends Object>(
    String businessDate,
    core_domain.TrafficComparisonPeriod period,
    int refreshGeneration,
    Future<T?> Function() load,
  ) async {
    if (_cachedComparisonSummary != null && _currentBusinessDate == businessDate && _cachedComparisonPeriod == period) {
      return _cachedComparisonSummary as T?;
    }

    final summary = await load();
    if (_isCurrentRefresh(refreshGeneration, period, businessDate)) {
      _cachedComparisonSummary = summary;
      _cachedComparisonPeriod = period;
    }
    return summary;
  }

  bool _isCurrentRefresh(int generation, core_domain.TrafficComparisonPeriod period, String businessDate) =>
      generation == _refreshGeneration &&
      _comparisonPeriod == period &&
      _currentBusinessDate == businessDate &&
      _formatBusinessDate(_nowProvider()) == businessDate;

  String _formatBusinessDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
