import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_flow.freezed.dart';

/// Represents the current phase of the application business flow.
@freezed
sealed class AppFlow with _$AppFlow {
  /// The app is waiting for user interaction to begin.
  const factory AppFlow.waitingForStart() = WaitingForStart;

  /// The app is validating backend connectivity and session state.
  const factory AppFlow.checkingBackend() = CheckingBackend;

  /// The app requires the user to complete the onboarding wizard.
  const factory AppFlow.onboardingRequired() = OnboardingRequired;

  /// Using invitation flow for onboarding, user needs to complete the onboarding wizard.
  const factory AppFlow.onboardingByInvitation() = OnboardingByInvitation;

  /// The main session loop is active and processing data.
  const factory AppFlow.sessionRunning() = SessionRunning;
}

extension AppFlowExtension on AppFlow {
  bool get isOnboarding => this is OnboardingRequired || this is OnboardingByInvitation;
}
