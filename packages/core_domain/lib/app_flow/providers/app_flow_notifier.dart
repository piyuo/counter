import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/app_flow/models/app_flow_event.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_flow_notifier.g.dart';

abstract class AppFlowController {
  void dispatch(AppFlowEvent event);
}

@Riverpod(keepAlive: true)
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
    appkit.logInfo('[AppFlow] $previous → $next ($event)');
  }

  AppFlow _reduce(AppFlow current, AppFlowEvent event) {
    return switch ((current, event)) {
      (WaitingForStart(), const AppFlowEvent.startRequested()) => const CheckingBackend(),
      (CheckingBackend(), const AppFlowEvent.onboardingNeeded()) => const OnboardingRequired(),
      (CheckingBackend(), const AppFlowEvent.onboardingCompleted()) => const SessionRunning(),
      _ => current,
    };
  }
}
