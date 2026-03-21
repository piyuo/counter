// TOC:
//  - ControlPanelRoutes: named path constants for the control-panel feature
//
// Architecture note:
//  - Routing logic is handled by the RouteDecisionEngine + rule plugins.
//  - This class is intentionally a constants-only namespace.
//  - Only paths used by redirect rules (core_domain) live here.
//    All other paths are owned by typed RouteData classes in feature_control_panel.

/// Named path constants used by redirect rules in core_domain.
///
/// Only constants referenced by RouteDecisionEngine rules belong here.
/// Feature-local routes are accessed via RouteData().location instead.
class ControlPanelRoutes {
  const ControlPanelRoutes._();
  static const String root = '/'; // booting screen, shows a loading indicator while the app determines where to go
  static const String start = '/start'; // start screen for pedestrian detection

  // onboarding will be controlled by OnboardingRoutes

  static const String liveStreamOnly = '/live-stream-only';
}
