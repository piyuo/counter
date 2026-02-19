import 'package:core_domain/boot/boot_notifier.dart';
import 'package:core_domain/system_lifecycle/models/system_event.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_lifecycle_notifier.g.dart';

abstract class SystemLifecycleController {
  void dispatch(SystemEvent event);
}

@Riverpod(keepAlive: true)
/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
class SystemLifecycleNotifier extends _$SystemLifecycleNotifier implements SystemLifecycleController {
  @override
  SystemLifecycle build() {
    ref.read(bootProvider);
    return SystemLifecycle.booting();
  }

  @override
  void dispatch(SystemEvent event) {
    final next = _reduce(state, event);
    if (next == state) return;
    final previous = state;
    state = next;
    appkit.logInfo('[SystemLifecycle] $previous → $next ($event)');
  }

  SystemLifecycle _reduce(SystemLifecycle current, SystemEvent event) {
    return switch ((current, event)) {
      (Booting(), const SystemEvent.hardwareCheckInitiated()) => const CheckingHardware(),
      (CheckingHardware(), const SystemEvent.cameraMissingLiveStreamAvailable()) => const LiveStreamOnly(),
      (CheckingHardware(), const SystemEvent.cameraAndLiveStreamUnavailable()) => const SystemError('no-camera'),
      (CheckingHardware(), const SystemEvent.hardwareCheckPassed()) => const SystemReady(),
      _ => current,
    };
  }
}
