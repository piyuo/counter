import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_flow.freezed.dart';

/// Represents the current phase of the application business flow.
@freezed
sealed class AppFlow with _$AppFlow {
  /// The app is waiting for user interaction to begin.
  const factory AppFlow.waitingForStart() = WaitingForStart;

  /// The app is validating data server is set up.
  const factory AppFlow.checkingDataServer() = CheckingDataServer;

  /// The app requires the user to complete the onboarding wizard. from the beginning of the onboarding flow
  const factory AppFlow.onboardingBegin() = OnboardingBegin;

  /// The app requires the user to complete the onboarding wizard. but user already have an invitation code
  const factory AppFlow.onboardingByInvitation() = OnboardingByInvitation;

  /// onboarding passed, session is running
  const factory AppFlow.sessionRunning() = SessionRunning;
}

extension AppFlowExtension on AppFlow {
  bool get isOnboarding => this is OnboardingBegin || this is OnboardingByInvitation;
}
