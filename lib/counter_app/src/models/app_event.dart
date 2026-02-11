import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

@freezed
sealed class AppEvent with _$AppEvent {
  const factory AppEvent.appStarted() = AppStarted;
  const factory AppEvent.hardwareCheckInitiated() = HardwareCheckInitiated;
  const factory AppEvent.cameraUnavailable() = CameraUnavailable;
  const factory AppEvent.backendCheckFailed() = BackendCheckFailed;
  const factory AppEvent.onboardingCompleted() = OnboardingCompleted;
  const factory AppEvent.appBackgrounded() = AppBackgrounded;
  const factory AppEvent.appForegrounded() = AppForegrounded;
  const factory AppEvent.appRebootRequested() = AppRebootRequested;
}
