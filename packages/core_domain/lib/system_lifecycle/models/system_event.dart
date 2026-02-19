import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_event.freezed.dart';

/// Events that trigger transitions in the [SystemLifecycle] state machine.
@freezed
sealed class SystemEvent with _$SystemEvent {
  /// Triggers the start of hardware validation.
  const factory SystemEvent.hardwareCheckInitiated() = HardwareCheckInitiated;

  /// Signals that all hardware checks passed successfully.
  const factory SystemEvent.hardwareCheckPassed() = HardwareCheckPassed;

  /// Signals that the primary camera is missing, but a live stream is available.
  const factory SystemEvent.cameraMissingLiveStreamAvailable() = CameraMissingLiveStreamAvailable;

  /// Signals that neither the camera nor the live stream is available.
  const factory SystemEvent.cameraAndLiveStreamUnavailable() = CameraAndLiveStreamUnavailable;
}
