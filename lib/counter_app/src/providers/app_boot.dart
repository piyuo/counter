import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/hardware_capability_service.dart';
import '../models/app_event.dart';
import '../models/backend.dart';
import '../models/frontend.dart';
import 'app_lifecycle_notifier.dart';
import 'app_notifier.dart';

part 'app_boot.g.dart';

enum BootStatus { booting, ready }

@riverpod
class AppBoot extends _$AppBoot {
  @override
  Future<BootStatus> build() async {
    // AppBoot is auto-dispose and started from lifecycle via ref.read(appBootProvider).
    // Because build() awaits async work, control can yield and this provider may be
    // disposed before boot side-effects finish if there are no active listeners.
    // Keep it alive only for the duration of this boot run.
    final keepAliveLink = ref.keepAlive();
    try {
      final appLifecycleController = ref.read(appLifecycleProvider.notifier);
      final appState = await ref.read(appProvider.future);
      final hardwareService = ref.read(hardwareCapabilityServiceProvider);
      // Transition to CheckingHardware
      appLifecycleController.dispatch(const AppEvent.hardwareCheckInitiated());

      bool hasValidCams = false;
      if (appState.frontend is! EmptyFrontend) {
        hasValidCams = await hardwareService.isFrontendValid(appState.frontend);
      }

      if (!hasValidCams) {
        final hasCams = await hardwareService.hasCamFrontend();
        if (!hasCams) {
          appLifecycleController.dispatch(const AppEvent.cameraUnavailable());
          return BootStatus.ready;
        }
      }

      if (appState.backend is EmptyBackend) {
        appLifecycleController.dispatch(const AppEvent.backendCheckFailed());
        return BootStatus.ready;
      }

      appLifecycleController.dispatch(const AppEvent.appStarted());
      return BootStatus.ready;
    } finally {
      // Release the temporary keep-alive so AppBoot can be disposed after startup.
      keepAliveLink.close();
    }
  }
}
