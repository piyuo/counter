import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/app_flow/models/app_flow_event.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_flow_notifier.g.dart';

abstract class AppFlowController {
  void dispatch(AppFlowEvent event);
}

@Riverpod(keepAlive: true) // do not autoDispose , there are services that depend on, e.g. NativeAppLinkService
/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
class AppFlowNotifier extends _$AppFlowNotifier implements AppFlowController {
  @override
  AppFlow build() {
    return AppFlow.waitingForStart();
  }

  @override
  void dispatch(AppFlowEvent event) {
    final next = _reduce(state, event);
    if (next == state) return;
    final previous = state;
    state = next;
    appkit.logInfo('[AppFlow] ${_shortFlow(previous)} → ${_shortFlow(next)} (${_shortEvent(event)})');
  }

  String _shortFlow(AppFlow flow) {
    final s = flow.toString();
    final dot = s.indexOf('.');
    final paren = s.indexOf('(');
    return s.substring(dot + 1, paren);
  }

  String _shortEvent(AppFlowEvent ev) => ev.toString().replaceAll('()', '');

  AppFlow _reduce(AppFlow current, AppFlowEvent event) {
    return switch ((current, event)) {
      (WaitingForStart(), const AppFlowEvent.videoSourceCheck()) => const CheckingVideoSource(),
      (CheckingVideoSource(), const AppFlowEvent.dataServerCheck()) => const CheckingDataServer(),
      (CheckingDataServer(), const AppFlowEvent.onboardingNeeded()) => const OnboardingBegin(),
      // before onboarding, check app to see if it open by invitation
      (CheckingDataServer(), const AppFlowEvent.invitationClicked()) => const OnboardingByInvitation(),
      (CheckingDataServer(), const AppFlowEvent.startSession()) => const SessionRunning(),
      (OnboardingBegin(), const AppFlowEvent.startSession()) => const SessionRunning(),
      (OnboardingBegin(), const AppFlowEvent.invitationClicked()) => const OnboardingByInvitation(),
      (SessionRunning(), const AppFlowEvent.onboardingNeeded()) => const OnboardingBegin(), //  user reset in settings
      _ => current,
    };
  }
}
