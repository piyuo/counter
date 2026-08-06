// TOC:
//  - routerProvider creates a GoRouter with provider overrides
//  - routerProvider respects the initialLocation family argument
//  - routerProvider family caching (same arg → same instance)
//  - routerProvider family partitioning (different args → different instances)
//  - Redirect integration: redirect logic uses routeDecisionEngine under the hood
//  - Event-driven routing: settings/about/onboarding events route via router.go

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/router/control_panel_route_rules_provider.dart';
import 'package:feature_control_panel/router/control_panel_router_provider.dart';
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
      GoRoute(path: core_domain.ControlPanelRoutes.root, builder: (_, _) => const SizedBox()),
      GoRoute(path: '/settings', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/settings/piyuo', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/settings/server', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/about', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/detection', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/delivery-config', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/upload-logs', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/recent-payloads', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/recent-payloads/hour/:slotMs', builder: (_, _) => const SizedBox()),
      GoRoute(path: '/recent-payloads/payload/:payloadId', builder: (_, _) => const SizedBox()),
      GoRoute(
        path: core_domain.OnboardingRoutes.onboarding,
        builder: (_, _) => const SizedBox(),
        routes: [
          GoRoute(
            path: '1',
            builder: (_, _) => const SizedBox(),
            routes: [
              GoRoute(
                path: '2',
                builder: (_, _) => const SizedBox(),
                routes: [
                  GoRoute(
                    path: 'system',
                    builder: (_, _) => const SizedBox(),
                    routes: [
                      GoRoute(
                        path: 'cta',
                        builder: (_, _) => const SizedBox(),
                        routes: [
                          GoRoute(path: 'invitation', builder: (_, _) => const SizedBox()),
                          GoRoute(path: 'piyuo', builder: (_, _) => const SizedBox()),
                          GoRoute(path: 'server', builder: (_, _) => const SizedBox()),
                          GoRoute(path: 'demo', builder: (_, _) => const SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Replicates the stream subscription that [controlPanelRouterProvider] establishes.
StreamSubscription<core_domain.NavigationAction> _subscribeRouter(core_domain.NavigationEventBus bus, GoRouter router) {
  return bus.stream.listen((action) {
    final path = switch (action.event) {
      core_domain.OpenSettings() => '/settings',
      core_domain.OpenSettingsPiyuo() => '/settings/piyuo',
      core_domain.OpenSettingsServer() => '/settings/server',
      core_domain.OpenSettingsLocal() => '/settings/local',
      core_domain.OpenDetection() => '/detection',
      core_domain.OpenDeliveryConfig() => '/delivery-config',
      core_domain.OpenUploadLogs() => '/upload-logs',
      core_domain.OpenPayloadsRecent() => '/recent-payloads',
      core_domain.OpenPayloadsHour(slotMs: final slotMs) => '/recent-payloads/hour/$slotMs',
      core_domain.OpenPayloadDetail(payloadId: final payloadId) => '/recent-payloads/payload/$payloadId',
      core_domain.OpenAbout() => '/about',
      core_domain.OpenBuildInfo() => '/build-info',
      core_domain.OpenOnboarding() => core_domain.OnboardingRoutes.onboarding,
      core_domain.OpenOnboarding1() => core_domain.OnboardingRoutes.onboarding1,
      core_domain.OpenOnboarding2() => core_domain.OnboardingRoutes.onboarding2,
      core_domain.OpenOnboardingSystem() => core_domain.OnboardingRoutes.system,
      core_domain.OpenOnboardingCTA() => core_domain.OnboardingRoutes.cta,
      core_domain.OpenOnboardingPiyuoSubscription() => '${core_domain.OnboardingRoutes.cta}/piyuo-subscription',
      core_domain.OpenOnboardingServerSubscription() => '${core_domain.OnboardingRoutes.cta}/server-subscription',
      core_domain.OpenOnboardingPiyuo() => '${core_domain.OnboardingRoutes.cta}/piyuo',
      core_domain.OpenOnboardingServer() => '${core_domain.OnboardingRoutes.cta}/server',
      core_domain.OpenOnboardingServerSuccess(url: final url) => Uri(
        path: '${core_domain.OnboardingRoutes.cta}/server/success',
        queryParameters: {'url': url},
      ).toString(),
      core_domain.OpenOnboardingLocal() => '${core_domain.OnboardingRoutes.cta}/demo',
      core_domain.OpenOnboardingInvitation(token: final token) =>
        token != null
            ? '${core_domain.OnboardingRoutes.ctaInvitation}?token=$token'
            : core_domain.OnboardingRoutes.ctaInvitation,
      core_domain.OpenOnboardingInvitationSuccess(invitation: _) =>
        '${core_domain.OnboardingRoutes.ctaInvitation}/success',
      core_domain.OpenLightOffScreen() => null,
      core_domain.OpenLanguage() => null,
      core_domain.OpenVideoSources() => '/video-sources',
      core_domain.OpenLiveUrl() => '/live-url',
      core_domain.OpenTarget() => '/target',
      core_domain.OpenUploadLogDetail() => '/upload-logs',
    };
    if (path == null) return;
    switch (action) {
      case core_domain.PushAction():
        router.push(path.toString());
      case core_domain.GoAction():
        router.go(path.toString());
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

      final router = container.read(controlPanelRouterProvider(null));
      expect(router, isA<GoRouter>());
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('accepts a custom initial location', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final router = container.read(controlPanelRouterProvider('/settings'));
      expect(router, isA<GoRouter>());
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('same family argument returns the same GoRouter instance', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final a = container.read(controlPanelRouterProvider(null));
      final b = container.read(controlPanelRouterProvider(null));
      expect(identical(a, b), isTrue);
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('different family arguments return different GoRouter instances', (tester) async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      final root = container.read(controlPanelRouterProvider(null));
      final settings = container.read(controlPanelRouterProvider('/settings'));
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

      final engine = container.read(controlPanelRouteDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: container.read(core_domain.systemLifecycleProvider),
        flow: container.read(core_domain.appFlowProvider),
        path: core_domain.ControlPanelRoutes.root,
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
      await tester.pump();

      bus.push(const core_domain.OpenSettings());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/settings');
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
      await tester.pump();

      bus.push(const core_domain.OpenAbout());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/about');
    });

    testWidgets('OpenSettingsPiyuo causes navigation to /settings/piyuo', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenSettingsPiyuo());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/settings/piyuo');
    });

    testWidgets('OpenSettingsServer causes navigation to /settings/server', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenSettingsServer());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/settings/server');
    });

    testWidgets('OpenDetectionParams causes navigation to /detection', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenDetection());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/detection');
    });

    testWidgets('OpenDeliveryConfig causes navigation to /delivery-config', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenDeliveryConfig());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/delivery-config');
    });

    testWidgets('OpenUploadLogs causes navigation to /upload-logs', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenUploadLogs());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/upload-logs');
    });

    testWidgets('OpenRecentPayloads causes navigation to /recent-payloads', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenPayloadsRecent());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/recent-payloads');
    });

    testWidgets('OpenRecentPayloadHour causes navigation to /recent-payloads/hour/:slotMs', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenPayloadsHour(slotMs: 123));
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/recent-payloads/hour/123');
    });

    testWidgets('OpenRecentPayloadDetail causes navigation to /recent-payloads/payload/:payloadId', (tester) async {
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
      await tester.pump();

      bus.push(const core_domain.OpenPayloadDetail(payloadId: 'abc-123'));
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/recent-payloads/payload/abc-123');
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
      await tester.pump();

      bus.push(const core_domain.OpenSettings());
      bus.push(const core_domain.OpenAbout());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, '/about');
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

      expect(router.state.uri.path, '/');
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

      bus.push(const core_domain.OpenOnboarding());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, core_domain.OnboardingRoutes.onboarding);
    });

    testWidgets('OpenOnboarding1 causes navigation to /onboarding/1', (tester) async {
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

      bus.push(const core_domain.OpenOnboarding1());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, core_domain.OnboardingRoutes.onboarding1);
    });

    testWidgets('OpenOnboarding2 causes navigation to /onboarding/1/2', (tester) async {
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

      bus.push(const core_domain.OpenOnboarding2());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, core_domain.OnboardingRoutes.onboarding2);
    });

    testWidgets('OpenOnboardingCTA causes navigation to /onboarding/1/2/cta', (tester) async {
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

      bus.push(const core_domain.OpenOnboardingCTA());
      await tester.pumpAndSettle();

      expect(router.state.uri.path, core_domain.OnboardingRoutes.cta);
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
      await tester.pump();

      bus.push(const core_domain.OpenOnboardingInvitation(token: 'invite-token'));
      await tester.pumpAndSettle();

      expect(router.state.uri.toString(), '${core_domain.OnboardingRoutes.ctaInvitation}?token=invite-token');
    });
  });
}
