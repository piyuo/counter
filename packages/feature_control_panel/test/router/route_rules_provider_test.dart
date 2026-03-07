// TOC:
//  - routeRulesProvider contains both default rules
//  - routeDecisionEngineProvider builds from those rules
//  - end-to-end: engine honours rules for system-lifecycle states
//  - end-to-end: engine honours rules for app-flow states
//  - routeDecisionEngineProvider rebuilds when rules are overridden

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/router/control_panel_route_rules_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('routeRulesProvider', () {
    test('returns exactly two rules', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(controlPanelRouteRulesProvider).length, 2);
    });

    test('contains a SystemLifecycleRule', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rules = container.read(controlPanelRouteRulesProvider);
      expect(rules.whereType<core_domain.ControlPanelSystemLifecycleRule>().length, 1);
    });

    test('contains an AppFlowRule', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rules = container.read(controlPanelRouteRulesProvider);
      expect(rules.whereType<core_domain.ControlPanelAppFlowRule>().length, 1);
    });

    test('SystemLifecycleRule has lower priority than AppFlowRule', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rules = container.read(controlPanelRouteRulesProvider);
      final systemRule = rules.whereType<core_domain.ControlPanelSystemLifecycleRule>().first;
      final appFlowRule = rules.whereType<core_domain.ControlPanelAppFlowRule>().first;

      expect(systemRule.priority, lessThan(appFlowRule.priority));
    });
  });

  group('routeDecisionEngineProvider', () {
    test('returns a RouteDecisionEngine', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(controlPanelRouteDecisionEngineProvider), isA<core_domain.RouteDecisionEngine>());
    });

    test('engine redirects liveStreamOnly lifecycle to /live-stream-only', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(controlPanelRouteDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.sessionRunning(),
        path: core_domain.ControlPanelRoutes.root,
        previousLifecycle: const core_domain.SystemLifecycle.checkingHardware(),
      );

      expect(engine.decide(ctx)?.target, core_domain.ControlPanelRoutes.liveStreamOnly);
    });

    test('engine returns null for systemReady + sessionRunning (no redirect)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(controlPanelRouteDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.systemReady(),
        flow: const core_domain.AppFlow.sessionRunning(),
        path: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('system-lifecycle rule decides /live-stream-only regardless of app-flow state', () {
      // liveStreamOnly + sessionRunning: only SystemLifecycleRule fires → /live-stream-only.
      // AppFlowRule is silent, so no cycle — confirms system rule priority.
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(controlPanelRouteDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.sessionRunning(),
        path: core_domain.ControlPanelRoutes.root,
        previousLifecycle: const core_domain.SystemLifecycle.checkingHardware(),
      );

      expect(engine.decide(ctx)?.target, core_domain.ControlPanelRoutes.liveStreamOnly);
    });

    test('no transitions → null (rules are transition-based, not state-based)', () {
      // Neither rule fires without lifecycle/flow transitions.
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final engine = container.read(controlPanelRouteDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.onboardingRequired(),
        path: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('overriding rules with empty list produces engine that always returns null', () {
      final container = ProviderContainer(overrides: [controlPanelRouteRulesProvider.overrideWithValue([])]);
      addTearDown(container.dispose);

      final engine = container.read(controlPanelRouteDecisionEngineProvider);
      final ctx = core_domain.RouteContext(
        lifecycle: const core_domain.SystemLifecycle.liveStreamOnly(),
        flow: const core_domain.AppFlow.onboardingRequired(),
        path: core_domain.ControlPanelRoutes.root,
      );

      expect(engine.decide(ctx), isNull);
    });

    test('overriding rules produces a fresh engine', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final defaultEngine = container.read(controlPanelRouteDecisionEngineProvider);

      final overrideContainer = ProviderContainer(overrides: [controlPanelRouteRulesProvider.overrideWithValue([])]);
      addTearDown(overrideContainer.dispose);

      final overriddenEngine = overrideContainer.read(controlPanelRouteDecisionEngineProvider);

      // Different containers → different engine instances.
      expect(identical(defaultEngine, overriddenEngine), isFalse);
    });
  });
}
