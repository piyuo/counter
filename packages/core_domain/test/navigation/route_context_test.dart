// TOC:
//  - RouteContext construction and property access

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RouteContext', () {
    test('stores lifecycle, flow, and path', () {
      const ctx = RouteContext(lifecycle: SystemLifecycle.systemReady(), flow: AppFlow.sessionRunning(), path: '/home');

      expect(ctx.lifecycle, const SystemLifecycle.systemReady());
      expect(ctx.flow, const AppFlow.sessionRunning());
      expect(ctx.path, '/home');
    });

    test('accepts onboarding flow states', () {
      const ctx = RouteContext(lifecycle: SystemLifecycle.systemReady(), flow: AppFlow.onboardingBegin(), path: '/');

      expect(ctx.flow, const AppFlow.onboardingBegin());
    });

    test('accepts empty string path', () {
      const ctx = RouteContext(lifecycle: SystemLifecycle.booting(), flow: AppFlow.checkingDataServer(), path: '');

      expect(ctx.path, '');
    });

    test('previousPath is null when not provided', () {
      const ctx = RouteContext(lifecycle: SystemLifecycle.systemReady(), flow: AppFlow.sessionRunning(), path: '/home');

      expect(ctx.previousPath, isNull);
      expect(ctx.pathChanged, isFalse);
    });

    test('pathChanged is true when previousPath differs from path', () {
      const ctx = RouteContext(
        lifecycle: SystemLifecycle.systemReady(),
        flow: AppFlow.sessionRunning(),
        path: '/settings',
        previousPath: '/home',
      );

      expect(ctx.pathChanged, isTrue);
    });

    test('pathChanged is false when previousPath equals path', () {
      const ctx = RouteContext(
        lifecycle: SystemLifecycle.systemReady(),
        flow: AppFlow.sessionRunning(),
        path: '/home',
        previousPath: '/home',
      );

      expect(ctx.pathChanged, isFalse);
    });
  });
}
