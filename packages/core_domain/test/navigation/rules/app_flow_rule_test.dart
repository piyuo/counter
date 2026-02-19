// TOC:
//  - AppFlowRule priority
//  - AppFlowRule redirects to /onboarding for onboarding states
//  - AppFlowRule returns null for non-gated states

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/rules/app_flow_rule.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

RouteContext _ctx(AppFlow flow, {String path = '/'}) =>
    RouteContext(lifecycle: const SystemLifecycle.systemReady(), flow: flow, currentPath: path);

void main() {
  const rule = AppFlowRule();

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
  });
}
