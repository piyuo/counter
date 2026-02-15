import 'package:core_domain/boot/providers/boot_notifier.dart';
import 'package:core_domain/lifecycle/models/lifecycle.dart';
import 'package:core_domain/state/models/app_event.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lifecycle_notifier.g.dart';

abstract class LifecycleController {
  void dispatch(AppEvent event);
}

@Riverpod(keepAlive: true)
/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
class LifecycleNotifier extends _$LifecycleNotifier implements LifecycleController {
  @override
  Lifecycle build() {
    ref.read(bootProvider);
    return Lifecycle.booting();
  }

  @override
  void dispatch(AppEvent event) {
    final next = _reduce(state, event);
    if (next == state) return;
    final previous = state;
    state = next;
    appkit.logInfo('[CounterApp] $previous → $next ($event)');
  }

  Lifecycle _reduce(Lifecycle current, AppEvent event) {
    return switch ((current, event)) {
      (_, AppRebootRequested()) => const Lifecycle.rebooting(),
      (Booting(), HardwareCheckInitiated()) => const Lifecycle.checkingHardware(),
      (CheckingHardware(), CameraUnavailable()) => const Lifecycle.noCamera(),
      (CheckingHardware(), BackendCheckFailed()) => const Lifecycle.needsOnboarding(),
      (CheckingHardware(), AppStarted()) => const Lifecycle.ready(),
      (NeedsOnboarding(), OnboardingCompleted()) => const Lifecycle.ready(),
      (Ready(), AppBackgrounded()) => const Lifecycle.background(),
      (Background(), AppForegrounded()) => const Lifecycle.ready(),
      _ => current,
    };
  }
}
