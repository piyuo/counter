import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_notifier.g.dart';

class InsightState {
  InsightState();
}

@riverpod
class InsightNotifier extends _$InsightNotifier implements core_domain.InsightService {
  @override
  InsightState build() {
    return InsightState();
  }
}
