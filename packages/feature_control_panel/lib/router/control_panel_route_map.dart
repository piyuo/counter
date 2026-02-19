// TOC:
//  - controlPanelRouteMap: all GoRoute entries for the control-panel feature
//
// Architecture note:
//  - Path constants come from ControlPanelRoutes — never use raw strings here.
//  - Routing logic (redirects, guards) lives in RouteDecisionEngine rules, not here.
//  - Each builder receives a fresh ScrollController; the screen owns its lifecycle.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/screens/index_screen.dart';
import 'package:feature_control_panel/screens/no_camera_screen.dart';
import 'package:feature_control_panel/screens/wizard_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> controlPanelRouteMap() {
  return [
    GoRoute(path: core_domain.ControlPanelRoutes.root, builder: (context, state) => IndexScreen()),
    GoRoute(
      path: core_domain.ControlPanelRoutes.liveStreamOnly,
      builder: (context, state) => NoCameraScreen(scrollController: ScrollController()),
    ),
    GoRoute(
      path: core_domain.ControlPanelRoutes.settings,
      // TODO(#119): replace with a dedicated SettingsScreen
      builder: (context, state) => WizardScreen(scrollController: ScrollController()),
    ),
    GoRoute(
      path: core_domain.ControlPanelRoutes.about,
      // TODO(#119): replace with a dedicated AboutScreen
      builder: (context, state) => WizardScreen(scrollController: ScrollController()),
    ),
  ];
}
