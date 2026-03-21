import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_event.freezed.dart';

/// Events that trigger transitions in the [SystemLifecycle] state machine.
@freezed
sealed class SystemEvent with _$SystemEvent {
  /// Triggers the start of hardware validation.
  const factory SystemEvent.hardwareCheckInitiated() = HardwareCheckInitiated;

  /// Signals that all hardware checks passed successfully.
  const factory SystemEvent.hardwareCheckPassed() = HardwareCheckPassed;

  /// camera is missing
  const factory SystemEvent.cameraMissing() = CameraMissing;
}
