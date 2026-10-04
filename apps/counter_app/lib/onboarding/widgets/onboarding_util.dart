import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Goes to the camera test page if the user has not completed it, otherwise goes to the onboarding action page.
Future<void> goToCameraTestOrAction(WidgetRef ref) async {
  final appState = await ref.read(core_domain.appProvider.future);
  if (appState.hasCompletedCameraTest) {
    ref.go(const core_domain.OpenOnboardingCTA());
    return;
  }

  ref.go(const core_domain.OpenOnboardingCameraTest());
}
