import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_service.g.dart';

abstract class InsightService {}

@riverpod
InsightService insightService(Ref ref) {
  throw UnimplementedError('observationServiceProvider must be overridden');
}
