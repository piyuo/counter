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
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'monitor_route_data.dart';
import 'monitor_route_rules_provider.dart';

final monitorRouterProvider = Provider.family<GoRouter, String?>((ref, initialLocation) {
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
    routes: $appRoutes,
    redirect: (context, state) {
      // Use read inside redirect to avoid recreating the router on every rebuild.
      final engine = ref.read(monitorRouteDecisionEngineProvider);

      // Capture and clear pending previous states so transition detection
      final previousFlow = pendingPreviousFlow;
      final previousLifecycle = pendingPreviousLifecycle;
      pendingPreviousFlow = null;
      pendingPreviousLifecycle = null;

      final routeContext = core_domain.RouteContext(
        lifecycle: ref.read(core_domain.systemLifecycleProvider),
        flow: ref.read(core_domain.appFlowProvider),
        path: state.uri.path,
        previousPath: lastCommittedPath,
        previousFlow: previousFlow,
        previousLifecycle: previousLifecycle,
      );

      return engine.decide(routeContext)?.target;
    },
  );

  void onRouteChanged() {
    lastCommittedPath = router.state.uri.path;
  }

  router.routerDelegate.addListener(onRouteChanged);

  // Event-driven: one-shot navigation events go directly to router.go(),
  // bypassing the redirect cycle — no consume(), no stale state.
  final subscription = ref.read(core_domain.navigationEventBusProvider).stream.listen((action) {
    //appkit.logInfo('[monitor_route] (${action.event.runtimeType}) — not handled');
  });

  ref.onDispose(() {
    notifier.dispose();
    router.routerDelegate.removeListener(onRouteChanged);
    subscription.cancel();
    router.dispose();
  });
  return router;
});
