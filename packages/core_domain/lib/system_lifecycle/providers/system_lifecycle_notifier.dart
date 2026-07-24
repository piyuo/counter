import 'package:core_domain/system_lifecycle/models/system_event.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_lifecycle_notifier.g.dart';

abstract class SystemLifecycleController {
  void dispatch(SystemEvent event);
}

@Riverpod(keepAlive: true)
class SystemLifecycleNotifier extends _$SystemLifecycleNotifier implements SystemLifecycleController {
  @override
  SystemLifecycle build() {
    return SystemLifecycle.booting();
  }

  @override
  void dispatch(SystemEvent event) {
    final next = _reduce(state, event);
    if (next == state) return;
    final previous = state;
    state = next;
    appkit.logInfo('[SystemLifecycle] ${_shortLc(previous)} → ${_shortLc(next)} (${_shortEvent(event)})');
  }

  String _shortLc(SystemLifecycle lc) {
    final s = lc.toString();
    final dot = s.indexOf('.');
    final paren = s.indexOf('(');
    return s.substring(dot + 1, paren);
  }

  String _shortEvent(SystemEvent ev) => ev.toString().replaceAll('()', '');

  SystemLifecycle _reduce(SystemLifecycle current, SystemEvent event) {
    return switch ((current, event)) {
      (Booting(), const SystemEvent.hardwareCheckInitiated()) => const CheckingHardware(),
      (CheckingHardware(), const SystemEvent.deviceNotSupported()) => const SystemDeviceNotSupported(),
      (CheckingHardware(), const SystemEvent.hardwareCheckPassed()) => const SystemReady(),
      _ => current,
    };
  }
}
