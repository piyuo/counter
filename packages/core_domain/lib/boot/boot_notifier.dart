import 'package:core_domain/app_flow/models/app_flow_event.dart';
import 'package:core_domain/app_flow/providers/app_flow_notifier.dart';
import 'package:core_domain/state/models/backend.dart';
import 'package:core_domain/state/models/frontend.dart';
import 'package:core_domain/state/providers/app_notifier.dart';
import 'package:core_domain/system_lifecycle/models/system_event.dart';
import 'package:core_domain/system_lifecycle/providers/system_lifecycle_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'hardware_capability_service.dart';

part 'boot_notifier.g.dart';

abstract class BootController {}

enum BootStatus { booting, ready }

@riverpod
class BootNotifier extends _$BootNotifier implements BootController {
  @override
  Future<BootStatus> build() async {
    // AppBoot is auto-dispose and started from lifecycle via ref.read(appBootProvider).
    // Because build() awaits async work, control can yield and this provider may be
    // disposed before boot side-effects finish if there are no active listeners.
    // Keep it alive only for the duration of this boot run.
    final keepAliveLink = ref.keepAlive();
    try {
      final lifecycleController = ref.read(systemLifecycleProvider.notifier);
      final appState = await ref.read(appProvider.future);
      final hardwareService = ref.read(hardwareCapabilityServiceProvider);
      // Transition to CheckingHardware
      lifecycleController.dispatch(const SystemEvent.hardwareCheckInitiated());
      // try to sleep for 20 seconds
      bool hasValidCams = false;
      if (appState.frontend is! EmptyFrontend) {
        hasValidCams = await hardwareService.isFrontendValid(appState.frontend);
      }

      if (!hasValidCams) {
        final hasCams = await hardwareService.hasCamFrontend();
        if (!hasCams) {
          lifecycleController.dispatch(const SystemEvent.cameraMissingLiveStreamAvailable());
          return BootStatus.ready;
        }
      }
      lifecycleController.dispatch(const SystemEvent.hardwareCheckPassed());
      if (!hasValidCams) {
        // No valid saved frontend, but cameras are present — persist default at index 0.
        final defaultFrontend = await hardwareService.getDefaultFrontend();
        await ref.read(appProvider.notifier).setFrontend(defaultFrontend);
      }

      // hardware check passed, now run app flow check to determine if we can skip straight to ready
      final appFlowController = ref.read(appFlowProvider.notifier);
      appFlowController.dispatch(const AppFlowEvent.startRequested());

      if (appState.backend is EmptyBackend) {
        // If backend is empty, we know onboarding is needed, so skip directly to ready to avoid showing the app flow waiting screen.
        appFlowController.dispatch(const AppFlowEvent.onboardingNeeded());
        return BootStatus.ready;
      }

      //await hardwareService.initializeVisionSystem(ref);
      appFlowController.dispatch(const AppFlowEvent.onboardingCompleted());
      return BootStatus.ready;
    } finally {
      // Release the temporary keep-alive so AppBoot can be disposed after startup.
      keepAliveLink.close();
    }
  }
}
