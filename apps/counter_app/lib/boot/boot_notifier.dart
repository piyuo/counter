// Boot procedure for the counter app.
// Responsible for orchestrating the initial hardware and app-flow checks to
// determine the first screen to show on app launch.
//
// This provider is auto-disposed after boot completes since its state is not
// needed after startup. It is started explicitly from AppShell.initState()
// so that boot — not the lifecycle state machine — owns the startup sequence.
//
// Architecture:
//   AppShell.initState()
//     └─ ref.read(bootProvider)           ← explicit entry point
//          └─ BootNotifier dispatches → systemLifecycleProvider

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'boot_notifier.g.dart';

abstract class BootController {}

enum BootStatus { booting, booted }

@riverpod
class BootNotifier extends _$BootNotifier implements BootController {
  @override
  Future<BootStatus> build() async {
    // BootNotifier is auto-dispose and started from AppShell via ref.read(bootProvider).
    // Because build() awaits async work, control can yield and this provider may be
    // disposed before boot side-effects finish if there are no active listeners.
    // Keep it alive only for the duration of this boot run.
    final keepAliveLink = ref.keepAlive();
    try {
      final lifecycleController = ref.read(core_domain.systemLifecycleProvider.notifier);
      final appState = await ref.read(core_domain.appProvider.future);
      final hardwareService = ref.read(core_domain.hardwareCapabilityServiceProvider);
      // hardware checking, must have camera to proceed.
      lifecycleController.dispatch(const core_domain.SystemEvent.hardwareCheckInitiated());
      final hasCams = await hardwareService.hasCameraVideoSource();
      if (!hasCams) {
        lifecycleController.dispatch(const core_domain.SystemEvent.cameraMissing());
        return BootStatus.booted;
      }
      lifecycleController.dispatch(const core_domain.SystemEvent.hardwareCheckPassed());

      // now run app flow check
      final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
      // video source check: if saved video source is invalid (e.g. camera index out of range), reset to default (index 0) so user can proceed to set up a valid source.
      appFlowController.dispatch(const core_domain.AppFlowEvent.videoSourceCheck());
      core_domain.VideoSource? defaultVideoSource;
      if (appState.videoSource.hasMadeDecision) {
        // video source was set, check if it still available (e.g. camera index out of range)
        final hasValidCams = await hardwareService.isVideoSourceValid(appState.videoSource);
        if (hasValidCams) {
          defaultVideoSource = appState.videoSource;
        }
      }
      defaultVideoSource ??= await hardwareService.getDefaultVideoSource();
      if (defaultVideoSource == null) {
        lifecycleController.dispatch(const core_domain.SystemEvent.cameraMissing());
        return BootStatus.booted;
      }
      await ref.read(core_domain.appProvider.notifier).setVideoSource(defaultVideoSource);

      // data server check
      appFlowController.dispatch(const core_domain.AppFlowEvent.dataServerCheck());
      if (!appState.isOnboardingComplete) {
        // todo: remove this debug code , that will set 123456 to invitationCodeProvider
        //if (kDebugMode) {
        //  ref.read(invitationCodeProvider.notifier).setCode('223456789X');
        //}

        // data server not configured, need onboarding to set up data server.
        // Scenario 1: invitation code present — start onboarding with invitation flow.
        // Scenario 2: no code — standard onboarding.
        //final hasInvitation = ref.read(core_domain.invitationCodeProvider) != null;
        final hasInvitation = false;
        appFlowController.dispatch(
          hasInvitation
              ? const core_domain.AppFlowEvent.invitationClicked()
              : const core_domain.AppFlowEvent.onboardingNeeded(),
        );
        return BootStatus.booted;
      }

      // app flow check passed, can start session.
      appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      return BootStatus.booted;
    } catch (error, stack) {
      // Boot errors are swallowed silently because bootProvider is started via
      // ref.read() (fire-and-forget) with no listeners observing the AsyncError
      // state. Forward explicitly so the global error handler sees them.
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'BootNotifier',
          context: ErrorDescription('during app boot'),
        ),
      );
      rethrow;
    } finally {
      // Release the temporary keep-alive so BootNotifier can be disposed after startup.
      keepAliveLink.close();
    }
  }
}
