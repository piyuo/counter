import 'package:core_domain/lifecycle/providers/lifecycle_notifier.dart';
import 'package:core_domain/state/models/app_event.dart';
import 'package:core_domain/state/models/backend.dart';
import 'package:core_domain/state/models/frontend.dart';
import 'package:core_domain/state/providers/app_notifier.dart';
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
      final lifecycleController = ref.read(lifecycleProvider.notifier);
      final appState = await ref.read(appProvider.future);
      final hardwareService = ref.read(hardwareCapabilityServiceProvider);
      // Transition to CheckingHardware
      lifecycleController.dispatch(const AppEvent.hardwareCheckInitiated());

      bool hasValidCams = false;
      if (appState.frontend is! EmptyFrontend) {
        hasValidCams = await hardwareService.isFrontendValid(appState.frontend);
      }

      if (!hasValidCams) {
        final hasCams = await hardwareService.hasCamFrontend();
        if (!hasCams) {
          lifecycleController.dispatch(const AppEvent.cameraUnavailable());
          return BootStatus.ready;
        }
      }

      if (appState.backend is EmptyBackend) {
        lifecycleController.dispatch(const AppEvent.backendCheckFailed());
        return BootStatus.ready;
      }

      lifecycleController.dispatch(const AppEvent.appStarted());
      return BootStatus.ready;
    } finally {
      // Release the temporary keep-alive so AppBoot can be disposed after startup.
      keepAliveLink.close();
    }
  }
}
