// TOC:
//  - controlPanelRouteMap: all GoRoute entries for the control-panel feature
//
// Architecture note:
//  - Path constants come from ControlPanelRoutes — never use raw strings here.
//  - Routing logic (redirects, guards) lives in RouteDecisionEngine rules, not here.
//  - Each builder receives a fresh ScrollController; the screen owns its lifecycle.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_monitor/screens/root_screen.dart';
import 'package:feature_monitor/screens/video_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> monitorRouteMap() {
  return [
    GoRoute(path: core_domain.MonitorRoutes.root, builder: (context, state) => RootScreen()),
    GoRoute(path: core_domain.MonitorRoutes.video, builder: (context, state) => VideoScreen()),
  ];
}
