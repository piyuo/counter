// TOC:
//  - ResetNotifier: Orchestrates app state reset and redirects to onboarding.
//
// Clears all persisted app state via [appStateRepositoryProvider] and then
// dispatches [AppFlowEvent.onboardingNeeded] so the app transitions back to
// the onboarding flow.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_notifier.g.dart';

@riverpod
class ResetNotifier extends _$ResetNotifier {
  @override
  void build() {}

  Future<void> reset() async {
    final visionController = ref.read(vision.activeVisionControllerProvider);
    if (visionController != null) {
      await visionController.shutdown();
    }

    // reset state and go back to onboarding
    await ref.read(core_domain.appStateRepositoryProvider).reset();
    ref.read(core_domain.appFlowProvider.notifier).dispatch(const core_domain.AppFlowEvent.onboardingNeeded());
  }
}
