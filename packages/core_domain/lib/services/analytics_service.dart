import 'package:core_domain/core_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_service.g.dart';

abstract class AnalyticsService {
  AnalyticsState get state;

  Future<void> add(Observation observation);
}

@riverpod
AnalyticsService analyticsService(Ref ref) {
  throw UnimplementedError('analyticsServiceProvider must be overridden');
}
