import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_notifier.g.dart';

class AnalyticsState {
  AnalyticsState();
}

@riverpod
class AnalyticsNotifier extends _$AnalyticsNotifier implements core_domain.AnalyticsService {
  @override
  AnalyticsState build() {
    return AnalyticsState();
  }
}
