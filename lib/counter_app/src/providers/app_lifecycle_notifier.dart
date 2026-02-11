import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_event.dart';
import '../models/app_lifecycle.dart';
import 'app_boot.dart';

part 'app_lifecycle_notifier.g.dart';

abstract class AppLifecycleController {
  void dispatch(AppEvent event);
}

@Riverpod(keepAlive: true)
/// Architecture note:
/// - AppLifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
class AppLifecycleNotifier extends _$AppLifecycleNotifier implements AppLifecycleController {
  @override
  AppLifecycle build() {
    ref.read(appBootProvider);
    return AppLifecycle.booting();
  }

  @override
  void dispatch(AppEvent event) {
    final next = _reduce(state, event);
    if (next == state) return;
    final previous = state;
    state = next;
    appkit.logInfo('[CounterApp] $previous → $next ($event)');
  }

  AppLifecycle _reduce(AppLifecycle current, AppEvent event) {
    return switch ((current, event)) {
      (_, AppRebootRequested()) => const AppLifecycle.rebooting(),
      (Booting(), HardwareCheckInitiated()) => const AppLifecycle.checkingHardware(),
      (CheckingHardware(), CameraUnavailable()) => const AppLifecycle.noCamera(),
      (CheckingHardware(), BackendCheckFailed()) => const AppLifecycle.needsOnboarding(),
      (CheckingHardware(), AppStarted()) => const AppLifecycle.ready(),
      (NeedsOnboarding(), OnboardingCompleted()) => const AppLifecycle.ready(),
      (Ready(), AppBackgrounded()) => const AppLifecycle.background(),
      (Background(), AppForegrounded()) => const AppLifecycle.ready(),
      _ => current,
    };
  }
}
