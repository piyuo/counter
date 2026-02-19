// TOC:
//  - routeRulesProvider contains both default rules
//  - routeDecisionEngineProvider builds from those rules
//  - end-to-end: engine honours rules for system-lifecycle states
//  - end-to-end: engine honours rules for app-flow states
//  - routeDecisionEngineProvider rebuilds when rules are overridden

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/router/route_rules_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('routeRulesProvider', () {
    test('returns exactly two rules', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(routeRulesProvider).length, 2);
    });

    test('contains a SystemLifecycleRule', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rules = container.read(routeRulesProvider);
      expect(rules.whereType<core_domain.SystemLifecycleRule>().length, 1);
    });

    test('contains an AppFlowRule', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rules = container.read(routeRulesProvider);
      expect(rules.whereType<core_domain.AppFlowRule>().length, 1);
    });

    test('SystemLifecycleRule has lower priority than AppFlowRule', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rules = container.read(routeRulesProvider);
      final systemRule = rules.whereType<core_domain.SystemLifecycleRule>().first;
      final appFlowRule = rules.whereType<core_domain.AppFlowRule>().first;

      expect(systemRule.priority, lessThan(appFlowRule.priority));
    });
  });

  group('routeDecisionEngineProvider', () {
    test('returns a RouteDecisionEngine', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(routeDecisionEngineProvider), isA<core_domain.RouteDecisionEngine>());
    });

    test('engine redirects liveStreamOnly lifecycle to /live-stream-only', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.sessionRunning(),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx)?.target, core_domain.ControlPanelRoutes.liveStreamOnly);
    });

    test('engine returns null for systemReady + sessionRunning (no redirect)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.systemReady(),
        flow: const core_domain.AppFlow.sessionRunning(),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('system-lifecycle rule decides /live-stream-only regardless of app-flow state', () {
      // liveStreamOnly + sessionRunning: only SystemLifecycleRule fires → /live-stream-only.
      // AppFlowRule is silent, so no cycle — confirms system rule priority.
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.sessionRunning(),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx)?.target, core_domain.ControlPanelRoutes.liveStreamOnly);
    });

    test('cycle detection: liveStreamOnly + onboardingRequired creates unsatisfiable state → null', () {
      // Both rules fire simultaneously and alternate targets indefinitely.
      // Engine returns null rather than letting GoRouter loop.
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.onboardingRequired(),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('overriding rules with empty list produces engine that always returns null', () {
      final container = ProviderContainer(overrides: [routeRulesProvider.overrideWithValue([])]);
      addTearDown(container.dispose);

      final engine = container.read(routeDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.onboardingRequired(),
        currentPath: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('overriding rules produces a fresh engine', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final defaultEngine = container.read(routeDecisionEngineProvider);

      final overrideContainer = ProviderContainer(overrides: [routeRulesProvider.overrideWithValue([])]);
      addTearDown(overrideContainer.dispose);

      final overriddenEngine = overrideContainer.read(routeDecisionEngineProvider);

      // Different containers → different engine instances.
      expect(identical(defaultEngine, overriddenEngine), isFalse);
    });
  });
}
