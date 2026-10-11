import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insight_notifier.g.dart';

@Riverpod(keepAlive: true)
class InsightNotifier extends _$InsightNotifier implements core_domain.InsightService {
  @override
  core_domain.InsightState build() {
    return const core_domain.InsightState();
  }
}
