import 'dart:async';

import 'package:core_domain/model/insight_dashboard.dart';
import 'package:core_domain/model/observation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_service.g.dart';

abstract class InsightService {
  /// Selects the historical reference for the next dashboard refresh.
  ///
  /// This does not load or publish dashboard data by itself. Call [refresh]
  /// after changing the comparison period.
  void setComparisonPeriod(TrafficComparisonPeriod period);

  /// Updates the live observation used by the recent-hour dashboard total.
  void onObservationChanged();

  /// Called when a 5-minute observation window is completed.
  void onFiveMinuteObservationCompleted(Observation observation);

  /// Loads and publishes the dashboard data for the currently selected period.
  ///
  /// Call this after [setComparisonPeriod] and when new observations are
  /// available.
  Future<void> refresh();

  /// Returns the average estimate for the last hour based on the provided query.
  /// if data is not enough , it will return an estimated value.
  //Future<InsightValue<Activity>?> getLastHourAverage();
}

enum InsightStatus { measured, estimated, insufficient }

class InsightValue<T> {
  const InsightValue({required this.status, this.value});

  final InsightStatus status;
  final T? value;
}

@riverpod
InsightService insightService(Ref ref) {
  throw UnimplementedError('observationServiceProvider must be overridden');
}

/// State
@riverpod
InsightDashboard insightDashboard(Ref ref) => throw UnimplementedError('insightDashboardProvider must be overridden');
