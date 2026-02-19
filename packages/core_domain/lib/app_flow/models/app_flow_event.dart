import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_flow_event.freezed.dart';

/// Events that drive user flow and application phases.
@freezed
sealed class AppFlowEvent with _$AppFlowEvent {
  /// Request to begin the session workflow.
  const factory AppFlowEvent.startRequested() = StartRequested;

  /// User onboarding is needed.
  const factory AppFlowEvent.onboardingNeeded() = OnboardingNeeded;

  /// Onboarding was successfully completed.
  const factory AppFlowEvent.onboardingCompleted() = OnboardingCompleted;
}
