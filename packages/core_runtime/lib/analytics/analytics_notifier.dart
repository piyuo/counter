import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_notifier.g.dart';

@Riverpod(keepAlive: true)
class AnalyticsNotifier extends _$AnalyticsNotifier implements core_domain.AnalyticsService {
  StreamSubscription<core_domain.Observation>? _subscription;

  @override
  core_domain.AnalyticsState build() {
    final observationService = ref.read(core_domain.observationServiceProvider);

    _subscription = observationService.snapshots.listen(_onObservation);

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return const core_domain.AnalyticsState();
  }

  void _onObservation(core_domain.Observation observation) {
    final observations = [...state.observations, observation];
    state = state.copyWith(observations: observations);
  }

  @override
  Future<void> add(core_domain.Observation observation) async {
    // TODO: implement add
  }
}
