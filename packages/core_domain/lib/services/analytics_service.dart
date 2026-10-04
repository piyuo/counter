import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_service.g.dart';

abstract class AnalyticsService {}

@riverpod
AnalyticsService analyticsService(Ref ref) {
  throw UnimplementedError('analyticsServiceProvider must be overridden');
}
