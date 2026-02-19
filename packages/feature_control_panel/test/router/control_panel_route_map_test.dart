// TOC:
//  - controlPanelRouteMap route count
//  - controlPanelRouteMap path constants coverage
//  - controlPanelRouteMap all paths are distinct

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/router/control_panel_route_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('controlPanelRouteMap', () {
    late List<GoRoute> routes;

    setUp(() => routes = controlPanelRouteMap());

    test('returns exactly 5 routes', () {
      expect(routes.length, 5);
    });

    test('contains a route for the root path', () {
      expect(routes.map((r) => r.path), contains(core_domain.ControlPanelRoutes.root));
    });

    test('contains a route for liveStreamOnly', () {
      expect(routes.map((r) => r.path), contains(core_domain.ControlPanelRoutes.liveStreamOnly));
    });

    test('contains a route for settings', () {
      expect(routes.map((r) => r.path), contains(core_domain.ControlPanelRoutes.settings));
    });

    test('contains a route for about', () {
      expect(routes.map((r) => r.path), contains(core_domain.ControlPanelRoutes.about));
    });

    test('all route paths are distinct', () {
      final paths = routes.map((r) => r.path).toList();
      expect(paths.toSet().length, paths.length);
    });

    test('every route has a non-null builder', () {
      for (final route in routes) {
        expect(route.builder, isNotNull, reason: 'Route ${route.path} must have a builder');
      }
    });
  });
}
