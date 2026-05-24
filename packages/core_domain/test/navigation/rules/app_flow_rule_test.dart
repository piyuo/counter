// TOC:
//  - AppFlowRule priority
//  - AppFlowRule returns null for non-gated states
//  - AppFlowRule onboardingRequired gating behavior
//  - AppFlowRule onboardingByInvitation gating behavior

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/routes/onboarding_routes.dart';
import 'package:core_domain/navigation/rules/control_panel_app_flow_rule.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

RouteContext _ctx(AppFlow flow, {String path = '/', AppFlow? previousFlow}) =>
    RouteContext(lifecycle: const SystemLifecycle.systemReady(), flow: flow, path: path, previousFlow: previousFlow);

void main() {
  const rule = ControlPanelAppFlowRule();

  group('AppFlowRule', () {
    test('has priority 10', () {
      expect(rule.priority, 10);
    });

    group('non-gated states return null', () {
      test('waitingForStart → null', () {
        expect(rule.evaluate(_ctx(const AppFlow.waitingForStart())), isNull);
      });

      test('checkingBackend → null', () {
        expect(rule.evaluate(_ctx(const AppFlow.checkingDataServer())), isNull);
      });

      test('sessionRunning → null', () {
        expect(rule.evaluate(_ctx(const AppFlow.sessionRunning())), isNull);
      });
    });

    group('onboardingRequired gating', () {
      test('redirects to onboarding from non-onboarding path', () {
        final decision = rule.evaluate(
          _ctx(const AppFlow.onboardingBegin(), path: '/settings', previousFlow: const AppFlow.checkingDataServer()),
        );

        expect(decision, isNotNull);
        expect(decision!.target, OnboardingRoutes.onboarding);
      });

      test('allows onboarding root path', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingBegin(), path: OnboardingRoutes.onboarding));
        expect(decision, isNull);
      });

      test('allows onboarding CTA sub-route', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingBegin(), path: OnboardingRoutes.cta));
        expect(decision, isNull);
      });
    });

    group('onboardingByInvitation gating', () {
      test('redirects to CTA invitation from non-onboarding path', () {
        final decision = rule.evaluate(
          _ctx(
            const AppFlow.onboardingByInvitation(),
            path: '/settings',
            previousFlow: const AppFlow.checkingDataServer(),
          ),
        );

        expect(decision, isNotNull);
        expect(decision!.target, OnboardingRoutes.ctaInvitation);
      });

      test('allows CTA invitation path', () {
        final decision = rule.evaluate(
          _ctx(const AppFlow.onboardingByInvitation(), path: OnboardingRoutes.ctaInvitation),
        );
        expect(decision, isNull);
      });

      test('allows onboarding subtree path', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingByInvitation(), path: OnboardingRoutes.cta));
        expect(decision, isNull);
      });
    });
  });
}
