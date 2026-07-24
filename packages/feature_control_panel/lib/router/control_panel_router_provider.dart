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
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'control_panel_route_data.dart';
import 'control_panel_route_rules_provider.dart';

final controlPanelRouterProvider = Provider.family<GoRouter, String?>((ref, initialLocation) {
  // Create a notifier to trigger router refreshes for state-driven routing.
  final notifier = ValueNotifier(0);

  // Pending previous states — set by state-change listeners, cleared after
  // each redirect so only the triggering call sees them (not later route navs).
  core_domain.AppFlow? pendingPreviousFlow;
  core_domain.SystemLifecycle? pendingPreviousLifecycle;

  // Tracks the last committed path so redirect can report previousPath.
  String lastCommittedPath = initialLocation ?? '/';

  // State-driven: lifecycle and flow changes trigger GoRouter's redirect.
  ref.listen(core_domain.systemLifecycleProvider, (prev, _) {
    pendingPreviousLifecycle = prev;
    notifier.value++;
  });
  ref.listen(core_domain.appFlowProvider, (prev, _) {
    pendingPreviousFlow = prev;
    notifier.value++;
  });

  final router = GoRouter(
    initialLocation: initialLocation ?? '/',
    refreshListenable: notifier,
    routes: [...$appRoutes, ...feature_onboarding.$appRoutes],
    redirect: (context, state) {
      // Use read inside redirect to avoid recreating the router on every rebuild.
      final engine = ref.read(controlPanelRouteDecisionEngineProvider);
      // Capture and clear pending previous states so transition detection
      final previousLifecycle = pendingPreviousLifecycle;
      final previousFlow = pendingPreviousFlow;
      pendingPreviousFlow = null;
      pendingPreviousLifecycle = null;

      final routeContext = core_domain.RouteContext(
        lifecycle: ref.read(core_domain.systemLifecycleProvider),
        previousLifecycle: previousLifecycle,
        flow: ref.read(core_domain.appFlowProvider),
        previousFlow: previousFlow,
        path: state.uri.path,
        previousPath: lastCommittedPath,
      );

      return engine.decide(routeContext)?.target;
    },
  );

  void onRouteChanged() {
    final path = router.state.uri.path;
    lastCommittedPath = path;
    final pipController = ref.read(feature_pip.pipProvider.notifier);
    pipController.onRouteChanged(path);

    // Lock the sliding panel open while on any onboarding route (root + sub-routes).
    // Release the lock as soon as the user leaves the onboarding subtree.
    final isOnboarding =
        path == core_domain.OnboardingRoutes.onboarding ||
        path.startsWith('${core_domain.OnboardingRoutes.onboarding}/');
    pipController.setIsLockedOpen(isOnboarding);
  }

  router.routerDelegate.addListener(onRouteChanged);

  // Event-driven: one-shot navigation actions go directly to router.push() or
  // router.go(), bypassing the redirect cycle — no consume(), no stale state.
  // Each NavigationEvent carries its own path; return null to ignore the event.
  final subscription = ref.read(core_domain.navigationEventBusProvider).stream.listen((action) {
    final path = action.event.path;
    if (path == null) return;
    final extra = action.event.extra;
    switch (action) {
      case core_domain.PushAction():
        router.push(path, extra: extra);
      case core_domain.GoAction():
        router.go(path, extra: extra);
    }
  });

  ref.onDispose(() {
    notifier.dispose();
    router.routerDelegate.removeListener(onRouteChanged);
    subscription.cancel();
    router.dispose();
  });
  return router;
});
