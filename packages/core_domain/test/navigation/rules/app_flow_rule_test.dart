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

RouteContext _ctx(AppFlow flow, {String path = '/'}) =>
    RouteContext(lifecycle: const SystemLifecycle.systemReady(), flow: flow, path: path);

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
        expect(rule.evaluate(_ctx(const AppFlow.checkingBackend())), isNull);
      });

      test('sessionRunning → null', () {
        expect(rule.evaluate(_ctx(const AppFlow.sessionRunning())), isNull);
      });
    });

    group('onboardingRequired gating', () {
      test('redirects to onboarding from non-onboarding path', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingRequired(), path: '/settings'));

        expect(decision, isNotNull);
        expect(decision!.target, OnboardingRoutes.onboarding);
      });

      test('allows onboarding root path', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingRequired(), path: OnboardingRoutes.onboarding));
        expect(decision, isNull);
      });

      test('allows onboarding CTA sub-route', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingRequired(), path: OnboardingRoutes.onboardingCTA));
        expect(decision, isNull);
      });
    });

    group('onboardingByInvitation gating', () {
      test('redirects to onboarding invitation from non-onboarding path', () {
        final decision = rule.evaluate(_ctx(const AppFlow.onboardingByInvitation(), path: '/settings'));

        expect(decision, isNotNull);
        expect(decision!.target, OnboardingRoutes.onboardingInvitation);
      });

      test('allows onboarding invitation path', () {
        final decision = rule.evaluate(
          _ctx(const AppFlow.onboardingByInvitation(), path: OnboardingRoutes.onboardingInvitation),
        );
        expect(decision, isNull);
      });

      test('allows onboarding subtree path', () {
        final decision = rule.evaluate(
          _ctx(const AppFlow.onboardingByInvitation(), path: OnboardingRoutes.onboardingCTA),
        );
        expect(decision, isNull);
      });
    });
  });
}
