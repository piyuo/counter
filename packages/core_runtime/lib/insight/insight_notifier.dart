import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/model/observation_series.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../observation/observation_notifier.dart' as live_observation;
import 'observation_series_helpers.dart';
import 'single_entry_future_cache.dart';

part 'insight_notifier.g.dart';

@Riverpod(keepAlive: true)
class InsightNotifier extends _$InsightNotifier implements core_domain.InsightService {
  InsightNotifier({DateTime Function()? nowProvider}) : _nowProvider = nowProvider ?? DateTime.now;

  final DateTime Function() _nowProvider;
  int _refreshGeneration = 0;
  int _liveUpdateGeneration = 0;
  ObservationSeries? _todaySeries;

  /// current comparison period
  core_domain.TrafficPeriod _comparisonPeriod = core_domain.TrafficPeriod.yesterday;
  String? _currentBusinessDate;

  /// Summary caches (one entry each, see [SingleEntryFutureCache]).
  ///
  /// Day, month and year summaries are immutable history: a finished period
  /// never changes, and the current unfinished month/year is never summarized
  /// on the fly. Keys are therefore just the period, and entries are not
  /// invalidated on business-date rollover; a new period simply replaces the
  /// entry. Used by both refresh() and the getObservationsFrom*() methods.
  final SingleEntryFutureCache<core_domain.DaySummary> _daySummaryCache = SingleEntryFutureCache();
  final SingleEntryFutureCache<core_domain.MonthSummary> _monthSummaryCache = SingleEntryFutureCache();
  final SingleEntryFutureCache<core_domain.YearSummary> _yearSummaryCache = SingleEntryFutureCache();

  /// Summaries for a period can be incomplete until its final uploads land, so
  /// all summary caches are dropped once a day, [_cacheResetOffset] after
  /// midnight. Between resets, cached history is reused.
  static const _cacheResetOffset = Duration(minutes: 15);
  DateTime? _cacheEpoch;

  core_domain.TrafficPeriod get comparisonPeriod => _comparisonPeriod;

  /// invalidates the summary caches one time per day, to avoid if payload comes late and we have a stale cache.
  void _resetCachesIfNewEpoch() {
    final shifted = _nowProvider().subtract(_cacheResetOffset);
    final epoch = DateTime(shifted.year, shifted.month, shifted.day);
    if (epoch == _cacheEpoch) return;
    if (_cacheEpoch != null) {
      _daySummaryCache.clear();
      _monthSummaryCache.clear();
      _yearSummaryCache.clear();
    }
    _cacheEpoch = epoch;
  }

  @override
  core_domain.InsightState build() {
    return core_domain.InsightState.empty(businessDate: _formatBusinessDate(_nowProvider()));
  }

  @override
  Future<void> onObservationChanged() async {
    final generation = ++_liveUpdateGeneration;
    final now = _nowProvider();
    final businessDate = _formatBusinessDate(now);

    if (businessDate != _currentBusinessDate) {
      await refresh();
    }

    if (generation != _liveUpdateGeneration) return;
    if (state.businessDate != businessDate) return;

    final recentHourObservations = _recentHourSeries(_nowProvider());
    final recentHourTotal = _totalOf(recentHourObservations);
    final filledRecentHour = fillRecentHour(recentHourObservations, now);
    state = state.copyWith(recentHourTotal: recentHourTotal, recentHourObservations: filledRecentHour);
  }

  @override
  Future<void> onFiveMinuteObservationCompleted(_) async {
    await refresh();
  }

  @override
  Future<void> setComparisonPeriod(core_domain.TrafficPeriod period) async {
    _comparisonPeriod = period;
    await refresh();
  }

  @override
  Future<void> refresh() async {
    final refreshGeneration = ++_refreshGeneration;
    final now = _nowProvider();
    final period = _comparisonPeriod;
    final businessDate = _formatBusinessDate(now);
    if (_currentBusinessDate != businessDate) {
      _currentBusinessDate = businessDate;
      _todaySeries = null;
    }

    final analytics = ref.read(core_domain.analyticsServiceProvider);
    final todaySummary = await analytics.getDaySummary(now.year, now.month, now.day);
    if (!_isCurrentRefresh(refreshGeneration, period, businessDate)) return;

    ObservationSeries? comparisonSeries;
    core_domain.Observation? comparisonTotal;
    ObservationSeries? comparisonRecentHourObservations;
    core_domain.Observation? comparisonRecentHourTotal;

    switch (period) {
      case core_domain.TrafficPeriod.yesterday:
      case core_domain.TrafficPeriod.sameDayLastWeek:
        final daysAgo = period == core_domain.TrafficPeriod.yesterday ? 1 : 7;
        final comparisonDate = DateTime(now.year, now.month, now.day - daysAgo);
        final summary = await getCachedDaySummary(comparisonDate);
        if (summary != null) {
          comparisonSeries = summary.fiveMinuteObservations;
          comparisonRecentHourObservations = sliceRecentHour(comparisonSeries, now.hour, now.minute);
          comparisonRecentHourTotal = _totalOf(comparisonRecentHourObservations);
          comparisonTotal = summary.dailyTotal;
        }
        break;
      case core_domain.TrafficPeriod.lastMonthAverage:
        final previousMonth = DateTime(now.year, now.month - 1);
        final summary = await getCachedMonthSummary(previousMonth);
        if (summary != null) {
          final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
          comparisonSeries = isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
          comparisonTotal = summary.monthlyTotal;
          comparisonRecentHourObservations = sliceRecentHour(comparisonSeries, now.hour, now.minute);
          comparisonRecentHourTotal = _totalOf(comparisonRecentHourObservations);
        }
        break;
      case core_domain.TrafficPeriod.lastYearAverage:
        final previousYear = DateTime(now.year - 1);
        final summary = await getCachedYearSummary(previousYear);
        if (summary != null) {
          final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
          comparisonSeries = isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
          comparisonTotal = summary.yearlyTotal;
          comparisonRecentHourObservations = sliceRecentHour(comparisonSeries, now.hour, now.minute);
          comparisonRecentHourTotal = _totalOf(comparisonRecentHourObservations);
        }
        break;
      case core_domain.TrafficPeriod.liveToday:
      case core_domain.TrafficPeriod.today:
      case core_domain.TrafficPeriod.customDay:

        /// these don't have meaning in refresh , it only use for search and filter
        throw UnsupportedError('TrafficPeriod $period is not supported in refresh.');
    }

    if (!_isCurrentRefresh(refreshGeneration, period, businessDate)) return;
    _todaySeries = todaySummary?.fiveMinuteObservations;
    final recentHourObservations = _recentHourSeries(_nowProvider());
    final recentHourTotal = _totalOf(recentHourObservations);
    if (!_isCurrentRefresh(refreshGeneration, period, businessDate)) return;
    final dashboard = core_domain.InsightState(
      businessDate: _formatBusinessDate(now),
      comparisonPeriod: period,
      todaySeries: _todaySeries,
      recentHourTotal: recentHourTotal,
      recentHourObservations: recentHourObservations,
      comparisonRecentHourTotal: comparisonRecentHourTotal,
      comparisonSeries: comparisonSeries,
      comparisonTotal: comparisonTotal,
    );
    state = dashboard;
  }

  Future<core_domain.DaySummary?> getCachedDaySummary(DateTime date) async {
    _resetCachesIfNewEpoch();
    final analytics = ref.read(core_domain.analyticsServiceProvider);
    return await _daySummaryCache.get(
      '${date.year}-${date.month}-${date.day}',
      () => analytics.getDaySummary(date.year, date.month, date.day),
    );
  }

  Future<core_domain.MonthSummary?> getCachedMonthSummary(DateTime date) async {
    _resetCachesIfNewEpoch();
    final analytics = ref.read(core_domain.analyticsServiceProvider);
    return await _monthSummaryCache.get(
      '${date.year}-${date.month}',
      () => analytics.getMonthSummary(date.year, date.month),
    );
  }

  Future<core_domain.YearSummary?> getCachedYearSummary(DateTime date) async {
    _resetCachesIfNewEpoch();
    final analytics = ref.read(core_domain.analyticsServiceProvider);
    return await _yearSummaryCache.get('${date.year}', () => analytics.getYearSummary(date.year));
  }

  bool _isCurrentRefresh(int generation, core_domain.TrafficPeriod period, String businessDate) =>
      generation == _refreshGeneration &&
      _comparisonPeriod == period &&
      _currentBusinessDate == businessDate &&
      _formatBusinessDate(_nowProvider()) == businessDate;

  String _formatBusinessDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  // ---------------------------------------------------------------------------
  // Recent-hour helpers
  //
  // Pipeline: _savedToday -> _overlayLive -> _sliceRecentHour -> _totalOf
  // Each step does one thing, and the window is defined in exactly one place.
  // ---------------------------------------------------------------------------

  /// Today's saved observations, or null if the cached series belongs to
  /// another business date.
  ObservationSeries? _savedToday(DateTime now) =>
      _currentBusinessDate == _formatBusinessDate(now) ? _todaySeries : null;

  /// Saved observations with the live observation replacing the saved one for
  /// the same slot. Returns an empty series when both are null.
  ObservationSeries _overlayLive(ObservationSeries? saved, core_domain.Observation? live) {
    final observationsBySlot = <int, core_domain.Observation>{
      for (final observation in saved ?? ObservationSeries.empty) observation.slotKey: observation,
    };
    if (live != null) {
      observationsBySlot[live.slotKey] = live;
    }
    return ObservationSeries.fromObservations(observationsBySlot.values);
  }

  /// Aggregates a series into a single observation, or null if it is empty.
  core_domain.Observation? _totalOf(ObservationSeries series) =>
      series.isEmpty ? null : core_domain.aggregateRecentHourObservations(series.toList());

  /// Today's saved observations with the live slot overlaid, limited to the
  /// recent-hour window ending after the current 5-minute slot.
  ObservationSeries _recentHourSeries(DateTime now) {
    final merged = _overlayLive(_savedToday(now), _getCurrentLiveObservation(now));
    final sliced = sliceRecentHour(merged, now.hour, now.minute);
    return sliced;
  }

  /// Returns saved observations in today's recent-hour window with the live
  /// observation replacing the saved one for the same slot when available.
  @override
  ObservationSeries getObservationsFromRecentHour() => _recentHourSeries(_nowProvider());

  /// Aggregates the current day's saved observations and, when available, the
  /// live observation for the active 5-minute slot, over the recent-hour window.
  ///
  /// The window stops at midnight and never includes observations from the
  /// previous day. If no valid live observation is available, saved
  /// observations from the current day are still used.
  core_domain.Observation? recentHourTotal() => _totalOf(_recentHourSeries(_nowProvider()));

  /// Aggregates an arbitrary series (e.g. a comparison series) over the
  /// recent-hour window for the given time of day. No live overlay is applied.
  core_domain.Observation? getRecentHourTotalAt(int hour, int minute, ObservationSeries series) =>
      _totalOf(sliceRecentHour(series, hour, minute));

  // ---------------------------------------------------------------------------
  // Observation queries
  // ---------------------------------------------------------------------------

  /// Returns today's saved observations with the current live slot overlaid.
  @override
  Future<ObservationSeries?> getObservationsFromLiveToday() async {
    final now = _nowProvider();
    final today = await ref.read(core_domain.analyticsServiceProvider).getDaySummary(now.year, now.month, now.day);

    if (_formatBusinessDate(_nowProvider()) != _formatBusinessDate(now)) {
      return null;
    }

    final live = _getCurrentLiveObservation(now);
    if (today == null && live == null) return null;

    final overlaid = _overlayLive(today?.fiveMinuteObservations, live);
    return overlaid;
  }

  /// Returns today's saved observations without adding the live observation.
  @override
  Future<ObservationSeries?> getObservationsFromToday() async {
    final now = _nowProvider();
    final summary = await ref.read(core_domain.analyticsServiceProvider).getDaySummary(now.year, now.month, now.day);
    return summary?.fiveMinuteObservations;
  }

  /// Returns observations from the previous business date.
  @override
  Future<ObservationSeries?> getObservationsFromYesterday() async {
    final now = _nowProvider();
    final yesterday = now.copyWith(day: now.day - 1);
    final summary = await getCachedDaySummary(yesterday);
    if (summary == null) return null;
    return summary.fiveMinuteObservations;
  }

  /// Returns observations from the same business date one week ago.
  @override
  Future<ObservationSeries?> getObservationsFromSameDayLastWeek() async {
    final now = _nowProvider();
    final sameDayLastWeek = now.copyWith(day: now.day - 7);
    final summary = await getCachedDaySummary(sameDayLastWeek);
    if (summary == null) return null;
    return summary.fiveMinuteObservations;
  }

  /// Returns the last completed month's historical average profile for
  /// today's weekday/weekend type.
  ///
  /// The current, incomplete month is not summarized on the fly.
  @override
  Future<ObservationSeries?> getObservationsFromLastMonth() async {
    final now = _nowProvider();
    final previousMonth = DateTime(now.year, now.month - 1);
    final summary = await getCachedMonthSummary(previousMonth);
    if (summary == null) return null;
    final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
    return isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
  }

  /// Returns the last completed year's historical average profile for
  /// today's weekday/weekend type.
  ///
  /// The current, incomplete year is not summarized on the fly.
  @override
  Future<ObservationSeries?> getObservationsFromLastYear() async {
    final now = _nowProvider();
    final previousYear = DateTime(now.year - 1);
    final summary = await getCachedYearSummary(previousYear);
    if (summary == null) return null;
    final isWeekend = now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
    return isWeekend ? summary.weekendFiveMinuteObservation : summary.weekdayFiveMinuteObservation;
  }

  @override
  Future<ObservationSeries?> getObservationsByDate(DateTime date) async {
    final today = _nowProvider();
    assert(
      DateTime(date.year, date.month, date.day).isBefore(DateTime(today.year, today.month, today.day)),
      'date must be before today; use getObservationsFromLiveToday() for today.',
    );
    final summary = await ref.read(core_domain.analyticsServiceProvider).getDaySummary(date.year, date.month, date.day);
    return summary?.fiveMinuteObservations;
  }

  // ---------------------------------------------------------------------------
  // Live observation
  // ---------------------------------------------------------------------------

  core_domain.Observation? _getCurrentLiveObservation(DateTime now) {
    final live = ref.read(live_observation.observationProvider).liveObservation;
    return _isCurrentLiveObservation(live, now) ? live : null;
  }

  bool _isCurrentLiveObservation(core_domain.Observation live, DateTime now) {
    final currentSlotMinute = (now.minute ~/ 5) * 5;
    return live.granularity == core_domain.ObservationGranularity.minutes5 &&
        live.year == now.year &&
        live.month == now.month &&
        live.day == now.day &&
        live.hour == now.hour &&
        live.minute == currentSlotMinute;
  }
}
