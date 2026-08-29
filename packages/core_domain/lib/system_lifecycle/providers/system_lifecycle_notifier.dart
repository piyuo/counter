import 'package:core_domain/system_lifecycle/models/system_event.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_lifecycle_notifier.g.dart';

/// Abstract controller interface for dispatching system events.
///
/// Implemented by [SystemLifecycleNotifier] to handle event-based state management.
abstract class SystemLifecycleController {
  /// Dispatches a system event to trigger state transitions.
  void dispatch(SystemEvent event);
}

/// Riverpod notifier managing the system lifecycle state machine.
///
/// Tracks application state transitions from booting through hardware validation
/// to either ready or device-not-supported states. Uses pattern matching for
/// state reduction and logs all transitions for debugging purposes.
///
/// This notifier is kept alive across the app lifetime (keepAlive: true).
@Riverpod(keepAlive: true)
class SystemLifecycleNotifier extends _$SystemLifecycleNotifier implements SystemLifecycleController {
  /// Initializes the notifier with the initial [SystemLifecycle.booting] state.
  @override
  SystemLifecycle build() {
    return SystemLifecycle.booting();
  }

  /// Dispatches a [SystemEvent] to transition the lifecycle state.
  ///
  /// Applies the state reducer to compute the next state. If no state change occurs,
  /// returns early to avoid unnecessary updates. Logs the transition for debugging.
  @override
  void dispatch(SystemEvent event) {
    final next = _reduce(state, event);
    if (next == state) return;
    final previous = state;
    state = next;
    appkit.logInfo('[SystemLifecycle] ${_shortLc(previous)} → ${_shortLc(next)} (${_shortEvent(event)})');
  }

  /// Extracts the human-readable lifecycle state name from its toString() representation.
  ///
  /// Converts `SystemLifecycle.booting()` to just `booting` for cleaner logs.
  String _shortLc(SystemLifecycle lc) {
    final s = lc.toString();
    final dot = s.indexOf('.');
    final paren = s.indexOf('(');
    return s.substring(dot + 1, paren);
  }

  /// Extracts the human-readable event name by removing empty parentheses.
  ///
  /// Converts `SystemEvent.hardwareCheckInitiated()` to `SystemEvent.hardwareCheckInitiated`.
  String _shortEvent(SystemEvent ev) => ev.toString().replaceAll('()', '');

  /// State reducer implementing the lifecycle state machine.
  ///
  /// Defines valid state transitions:
  /// - Booting → CheckingHardware (on hardwareCheckInitiated event)
  /// - Any state → SystemDeviceNotSupported (on deviceNotSupported event)
  /// - CheckingHardware → SystemReady (on hardwareCheckPassed event)
  /// - All other transitions return the current state unchanged
  SystemLifecycle _reduce(SystemLifecycle current, SystemEvent event) {
    return switch ((current, event)) {
      (Booting(), const SystemEvent.hardwareCheckInitiated()) => const CheckingHardware(),
      (_, const SystemEvent.deviceNotSupported()) => const SystemDeviceNotSupported(),
      (CheckingHardware(), const SystemEvent.hardwareCheckPassed()) => const SystemReady(),
      _ => current,
    };
  }
}
