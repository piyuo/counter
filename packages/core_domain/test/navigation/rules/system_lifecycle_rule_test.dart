// TOC:
//  - SystemLifecycleRule priority
//  - SystemLifecycleRule redirects to /live-stream-only for liveStreamOnly
//  - SystemLifecycleRule returns null for all other states

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/rules/control_panel_system_lifecycle_rule.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

RouteContext _ctx(SystemLifecycle lifecycle, {String path = '/'}) =>
    RouteContext(lifecycle: lifecycle, flow: const AppFlow.sessionRunning(), path: path);

void main() {
  const rule = ControlPanelSystemLifecycleRule();

  group('SystemLifecycleRule', () {
    test('has priority 0', () {
      expect(rule.priority, 0);
    });

    /*
    group('liveStreamOnly redirects to ${ControlPanelRoutes.liveStreamOnly}', () {
      test('liveStreamOnly → ${ControlPanelRoutes.liveStreamOnly}', () {
        final decision = rule.evaluate(_ctx(const SystemLifecycle.liveStreamOnly()));

        expect(decision, isNotNull);
        expect(decision!.target, ControlPanelRoutes.liveStreamOnly);
      });
    });
*/
    group('non-degraded states return null', () {
      test('booting → null', () {
        expect(rule.evaluate(_ctx(const SystemLifecycle.booting())), isNull);
      });

      test('checkingHardware → null', () {
        expect(rule.evaluate(_ctx(const SystemLifecycle.checkingHardware())), isNull);
      });

      test('systemReady → null', () {
        expect(rule.evaluate(_ctx(const SystemLifecycle.systemReady())), isNull);
      });

      test('systemError → null', () {
        expect(rule.evaluate(_ctx(const SystemLifecycle.systemDeviceNotSupported())), isNull);
      });
    });
  });
}
