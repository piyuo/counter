import 'dart:async';

import 'package:core_domain/model/insight_state.dart';
import 'package:core_domain/model/observation.dart';
import 'package:core_domain/model/observation_series.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_service.g.dart';

abstract class InsightService {
  /// Updates the live observation used by the recent-hour dashboard total.
  Future<void> onObservationChanged();

  /// Called when a 5-minute observation window is completed.
  Future<void> onFiveMinuteObservationCompleted(Observation observation);

  /// Selects the historical reference for the next dashboard refresh.
  ///
  /// This does not load or publish dashboard data by itself. Call [refresh]
  /// after changing the comparison period.
  Future<void> setComparisonPeriod(TrafficPeriod period);

  /// Loads and publishes the dashboard data for the currently selected period.
  Future<void> refresh();

  // Returns saved observations in today's recent-hour window with the live
  /// observation replacing the saved one for the same slot when available.
  ///
  ObservationSeries getObservationsFromRecentHour();

  /// Returns today's saved observations with the current live slot overlaid.
  ///
  Future<ObservationSeries?> getObservationsFromLiveToday();

  /// Returns today's saved observations without adding the live observation.
  Future<ObservationSeries?> getObservationsFromToday();

  /// Returns observations from the previous business date.
  Future<ObservationSeries?> getObservationsFromYesterday();

  /// Returns observations from the same business date one week ago.
  Future<ObservationSeries?> getObservationsFromSameDayLastWeek();

  /// Returns this month's average profile for today's weekday/weekend type.
  Future<ObservationSeries?> getObservationsFromLastMonth();

  /// Returns this year's average profile for today's weekday/weekend type.
  Future<ObservationSeries?> getObservationsFromLastYear();

  /// Returns the saved observations for [date], which must be before today, or
  /// `null` when no day summary is available.
  ///
  /// Use [getObservationsFromLiveToday] for today's observations.
  Future<ObservationSeries?> getObservationsByDate(DateTime date);
}

@riverpod
InsightService insightService(Ref ref) {
  throw UnimplementedError('insightServiceProvider must be overridden');
}

/// State
@riverpod
InsightState insightState(Ref ref) => throw UnimplementedError('insightStateProvider must be overridden');
