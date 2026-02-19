// TOC:
//  - routerProvider: GoRouter instance wired with state-driven and event-driven routing
//
// Architecture note:
//  - State-driven routing: lifecycle + flow changes increment a ValueNotifier that
//    triggers GoRouter's redirect callback → RouteDecisionEngine decides the path.
//  - Event-driven routing: one-shot NavigationEvents (e.g. OpenSettings) are
//    consumed from the navigationEventBus stream and call router.go() directly,
//    bypassing the redirect cycle so no consume() / stale state handling is needed.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/feature_onboarding.dart' as feature_onboarding;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'control_panel_route_map.dart';
import 'route_rules_provider.dart';

final routerProvider = Provider.family<GoRouter, String?>((ref, initialLocation) {
  // Create a notifier to trigger router refreshes for state-driven routing.
  final notifier = ValueNotifier(0);

  // State-driven: lifecycle and flow changes trigger GoRouter's redirect.
  ref.listen(core_domain.systemLifecycleProvider, (_, _) => notifier.value++);
  ref.listen(core_domain.appFlowProvider, (_, _) => notifier.value++);

  ref.onDispose(notifier.dispose);

  final router = GoRouter(
    initialLocation: initialLocation ?? '/',
    refreshListenable: notifier,
    routes: [...controlPanelRouteMap(), ...feature_onboarding.onBoardingRouteMap()],
    redirect: (context, state) {
      // Use read inside redirect to avoid recreating the router on every rebuild.
      final engine = ref.read(routeDecisionEngineProvider);

      final routeContext = core_domain.RouteContext(
        lifecycle: ref.read(core_domain.systemLifecycleProvider),
        flow: ref.read(core_domain.appFlowProvider),
        currentPath: state.uri.path,
      );

      return engine.decide(routeContext)?.target;
    },
  );

  // Event-driven: one-shot navigation events go directly to router.go(),
  // bypassing the redirect cycle — no consume(), no stale state.
  final subscription = ref.read(core_domain.navigationEventBusProvider).stream.listen((event) {
    switch (event) {
      case core_domain.OpenSettings():
        router.go(core_domain.ControlPanelRoutes.settings);
      case core_domain.OpenAbout():
        router.go(core_domain.ControlPanelRoutes.about);
      case core_domain.OpenOnboarding():
        router.go(core_domain.OnboardingRoutes.onboarding);
      case core_domain.OpenOnboardingInvitation(token: final token):
        router.go(core_domain.OnboardingRoutes.onboardingInvitationPath(token: token));
    }
  });

  ref.onDispose(() {
    subscription.cancel();
    router.dispose();
  });
  return router;
});
