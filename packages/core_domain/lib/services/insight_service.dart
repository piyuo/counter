import 'dart:async';

import 'package:core_domain/model/insight_dashboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_service.g.dart';

abstract class InsightService {
  /// Selects the historical reference used by the next dashboard refresh.
  void setComparisonPeriod(TrafficComparisonPeriod period);

  /// Refreshes the insight data immediately. this will trigger when new observations are available or loaded.
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
