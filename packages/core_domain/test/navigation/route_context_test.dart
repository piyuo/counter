// TOC:
//  - RouteContext construction and property access

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RouteContext', () {
    test('stores lifecycle, flow, and currentPath', () {
      const ctx = RouteContext(
        lifecycle: SystemLifecycle.systemReady(),
        flow: AppFlow.sessionRunning(),
        currentPath: '/home',
      );

      expect(ctx.lifecycle, const SystemLifecycle.systemReady());
      expect(ctx.flow, const AppFlow.sessionRunning());
      expect(ctx.currentPath, '/home');
    });

    test('accepts different lifecycle states', () {
      const ctx = RouteContext(
        lifecycle: SystemLifecycle.liveStreamOnly(),
        flow: AppFlow.waitingForStart(),
        currentPath: '/',
      );

      expect(ctx.lifecycle, const SystemLifecycle.liveStreamOnly());
    });

    test('accepts onboarding flow states', () {
      const ctx = RouteContext(
        lifecycle: SystemLifecycle.systemReady(),
        flow: AppFlow.onboardingRequired(),
        currentPath: '/',
      );

      expect(ctx.flow, const AppFlow.onboardingRequired());
    });

    test('accepts empty string currentPath', () {
      const ctx = RouteContext(lifecycle: SystemLifecycle.booting(), flow: AppFlow.checkingBackend(), currentPath: '');

      expect(ctx.currentPath, '');
    });
  });
}
