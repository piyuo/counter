import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_flow_event.freezed.dart';

/// Events that drive user flow and application phases.
@freezed
sealed class AppFlowEvent with _$AppFlowEvent {
  const factory AppFlowEvent.dataServerCheck() = DataServerCheck;

  /// User onboarding is needed.
  const factory AppFlowEvent.onboardingNeeded() = OnboardingNeeded;

  /// User clicked onboarding invitation link, needs to complete onboarding with invitation flow.
  /// but this event only worked  when app is checking backend or onboarding. after that this event will be ignored, and user need to restart app to trigger this event again.
  const factory AppFlowEvent.invitationClicked() = InvitationClicked;

  /// app is ready, can start session
  const factory AppFlowEvent.startSession() = StartSession;
}
