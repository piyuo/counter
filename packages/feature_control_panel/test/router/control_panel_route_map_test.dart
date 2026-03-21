// TOC:
//  - controlPanelRouteMap route count
//  - controlPanelRouteMap path constants coverage
//  - controlPanelRouteMap all paths are distinct
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/router/control_panel_route_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> controlPanelRouteMap() => $appRoutes;

void main() {
  group('controlPanelRouteMap', () {
    late List<RouteBase> routes;

    setUp(() => routes = controlPanelRouteMap());

    test('contains a route for the root path', () {
      expect(routes.whereType<GoRoute>().map((r) => r.path), contains(core_domain.ControlPanelRoutes.root));
    });

    test('contains a route for liveStreamOnly', () {
      expect(routes.whereType<GoRoute>().map((r) => r.path), contains(core_domain.ControlPanelRoutes.liveStreamOnly));
    });

    test('contains a route for about', () {
      expect(routes.whereType<GoRoute>().map((r) => r.path), contains(AboutRouteData().location));
    });

    test('contains a route for settings piyuo', () {
      expect(routes.whereType<GoRoute>().map((r) => r.path), contains(SettingsPiyuoRouteData().location));
    });

    test('contains a route for settings server', () {
      expect(routes.whereType<GoRoute>().map((r) => r.path), contains(SettingsServerRouteData().location));
    });

    test('every route has a non-null builder', () {
      for (final route in routes.whereType<GoRoute>()) {
        expect(route.builder, isNotNull, reason: 'Route ${route.path} must have a builder');
      }
    });
  });
}
