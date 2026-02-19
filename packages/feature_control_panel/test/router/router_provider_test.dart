// TOC:
//  - routerProvider creates a GoRouter with provider overrides
//  - routerProvider respects the initialLocation family argument
//  - routerProvider family caching (same arg → same instance)
//  - routerProvider family partitioning (different args → different instances)
//  - Redirect integration: redirect logic uses routeDecisionEngine under the hood
//  - Event-driven routing: settings/about/onboarding events route via router.go

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/router/route_rules_provider.dart';
import 'package:feature_control_panel/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// A [ProviderContainer] with the minimum overrides needed to prevent
/// [systemLifecycleProvider] and [appFlowProvider] from running their
/// full boot sequence.
ProviderContainer _makeContainer({
  core_domain.SystemLifecycle lifecycle = const core_domain.SystemLifecycle.systemReady(),
  core_domain.AppFlow flow = const core_domain.AppFlow.sessionRunning(),
}) {
  return ProviderContainer(
    overrides: [
      core_domain.systemLifecycleProvider.overrideWithValue(lifecycle),
      core_domain.appFlowProvider.overrideWithValue(flow),
    ],
  );
}

/// Minimal [GoRouter] with simple placeholder builders — lets us test
/// event-driven routing without rendering the real screen widgets.
GoRouter _buildTestRouter() {
  return GoRouter(
    routes: [
      GoRoute(path: core_domain.ControlPanelRoutes.root, builder: (_, __) => const SizedBox()),
      GoRoute(path: core_domain.ControlPanelRoutes.settings, builder: (_, __) => const SizedBox()),
      GoRoute(path: core_domain.ControlPanelRoutes.about, builder: (_, __) => const SizedBox()),
      GoRoute(
        path: core_domain.OnboardingRoutes.onboarding,
        builder: (_, __) => const SizedBox(),
        routes: [GoRoute(path: core_domain.OnboardingRoutes.invitation, builder: (_, __) => const SizedBox())],
      ),
    ],
  );
}

/// Replicates the stream subscription that [routerProvider] establishes.
StreamSubscription<core_domain.AppNavigationEvent> _subscribeRouter(
  StreamController<core_domain.AppNavigationEvent> bus,
  GoRouter router,
) {
  return bus.stream.listen((event) {
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
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // routerProvider — provider-level (no widget tree)
  // -------------------------------------------------------------------------

  group('routerProvider', () {
    testWidgets('returns a GoRouter instance', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final router = container.read(routerProvider(null));
      expect(router, isA<GoRouter>());
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('accepts a custom initial location', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final router = container.read(routerProvider('/settings'));
      expect(router, isA<GoRouter>());
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('same family argument returns the same GoRouter instance', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final a = container.read(routerProvider(null));
      final b = container.read(routerProvider(null));
      expect(identical(a, b), isTrue);
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('different family arguments return different GoRouter instances', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final root = container.read(routerProvider(null));
      final settings = container.read(routerProvider('/settings'));
      expect(identical(root, settings), isFalse);
      await tester.pumpWidget(const SizedBox());
    });
  });

  // -------------------------------------------------------------------------
  // Redirect logic integration
  //
  // routerProvider wires RouteDecisionEngine into GoRouter's redirect callback.
  // We verify the engine behaves correctly end-to-end by calling it directly
  // with the same states that the redirect callback would use.  This mirrors
  // what routerProvider does without requiring a full widget tree to trigger
  // GoRouter navigation.
  // -------------------------------------------------------------------------

  group('routerProvider redirect logic integration', () {
    test('engine returns null for systemReady + sessionRunning (no redirect)', () {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: container.read(core_domain.systemLifecycleProvider),
        flow: container.read(core_domain.appFlowProvider),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('engine decides /live-stream-only when lifecycle is liveStreamOnly', () {
      final container = _makeContainer(lifecycle: const core_domain.SystemLifecycle.liveStreamOnly());
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: container.read(core_domain.systemLifecycleProvider),
        flow: container.read(core_domain.appFlowProvider),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx)?.target, core_domain.ControlPanelRoutes.liveStreamOnly);
    });

    test('liveStreamOnly + sessionRunning decides /live-stream-only (system rule fires, app-flow silent)', () {
      final container = _makeContainer(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.sessionRunning(),
      );
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: container.read(core_domain.systemLifecycleProvider),
        flow: container.read(core_domain.appFlowProvider),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx)?.target, core_domain.ControlPanelRoutes.liveStreamOnly);
    });

    test('liveStreamOnly + onboardingRequired creates unsatisfiable cycle → null', () {
      // Both rules fire simultaneously; engine detects cycle and returns null.
      final container = _makeContainer(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.onboardingRequired(),
      );
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: container.read(core_domain.systemLifecycleProvider),
        flow: container.read(core_domain.appFlowProvider),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });
  });

  // -------------------------------------------------------------------------
  // Event-driven routing
  //
  // routerProvider subscribes to navigationEventBusProvider and calls
  // router.go() directly for one-shot navigations.  We replicate that exact
  // pattern using a simple GoRouter with lightweight screen builders so we can
  // assert on the resulting location without pulling in the real screen widgets.
  // -------------------------------------------------------------------------

  group('event-driven routing pattern', () {
    testWidgets('OpenSettings causes navigation to /settings', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final bus = container.read(core_domain.navigationEventBusProvider);
      final router = _buildTestRouter();
      final sub = _subscribeRouter(bus, router);
      addTearDown(() async {
        await sub.cancel();
        router.dispose();
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      bus.add(const core_domain.OpenSettings());
      await tester.pumpAndSettle();

      expect(router.routerDelegate.currentConfiguration.uri.path, core_domain.ControlPanelRoutes.settings);
    });

    testWidgets('OpenAbout causes navigation to /about', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final bus = container.read(core_domain.navigationEventBusProvider);
      final router = _buildTestRouter();
      final sub = _subscribeRouter(bus, router);
      addTearDown(() async {
        await sub.cancel();
        router.dispose();
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      bus.add(const core_domain.OpenAbout());
      await tester.pumpAndSettle();

      expect(router.routerDelegate.currentConfiguration.uri.path, core_domain.ControlPanelRoutes.about);
    });

    testWidgets('emitting two events navigates to the last destination', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final bus = container.read(core_domain.navigationEventBusProvider);
      final router = _buildTestRouter();
      final sub = _subscribeRouter(bus, router);
      addTearDown(() async {
        await sub.cancel();
        router.dispose();
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      bus.add(const core_domain.OpenSettings());
      bus.add(const core_domain.OpenAbout());
      await tester.pumpAndSettle();

      expect(router.routerDelegate.currentConfiguration.uri.path, core_domain.ControlPanelRoutes.about);
    });

    testWidgets('no event keeps router on root', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final bus = container.read(core_domain.navigationEventBusProvider);
      final router = _buildTestRouter();
      final sub = _subscribeRouter(bus, router);
      addTearDown(() async {
        await sub.cancel();
        router.dispose();
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(router.routerDelegate.currentConfiguration.uri.path, core_domain.ControlPanelRoutes.root);
    });

    testWidgets('OpenOnboarding causes navigation to /onboarding', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final bus = container.read(core_domain.navigationEventBusProvider);
      final router = _buildTestRouter();
      final sub = _subscribeRouter(bus, router);
      addTearDown(() async {
        await sub.cancel();
        router.dispose();
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      bus.add(const core_domain.OpenOnboarding());
      await tester.pumpAndSettle();

      expect(router.routerDelegate.currentConfiguration.uri.path, core_domain.OnboardingRoutes.onboarding);
    });

    testWidgets('OpenOnboardingInvitation causes navigation to onboarding invitation path', (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final bus = container.read(core_domain.navigationEventBusProvider);
      final router = _buildTestRouter();
      final sub = _subscribeRouter(bus, router);
      addTearDown(() async {
        await sub.cancel();
        router.dispose();
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      bus.add(const core_domain.OpenOnboardingInvitation(token: 'invite-token'));
      await tester.pumpAndSettle();

      expect(
        router.routerDelegate.currentConfiguration.uri.toString(),
        core_domain.OnboardingRoutes.onboardingInvitationPath(token: 'invite-token'),
      );
    });
  });
}
