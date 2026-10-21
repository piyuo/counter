import 'package:core_domain/core_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_service.g.dart';

abstract class InsightService {
  InsightState get state;

  /// Returns the average estimate for the last hour based on the provided query.
  /// if data is not enough , it will return an estimated value.
  //Future<InsightValue<AreaMetrics>?> getLastHourAverage();

  /// from fiveMinuteObservations
  /// from time to time  in a DailySummary
  /// from whole day in a DailySummary
  ///
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
