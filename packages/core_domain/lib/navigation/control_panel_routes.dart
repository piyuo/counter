// TOC:
//  - ControlPanelRoutes: named path constants for the control-panel feature
//
// Architecture note:
//  - Routing logic is handled by the RouteDecisionEngine + rule plugins.
//  - This class is intentionally a constants-only namespace.

/// Named path constants shared across the control-panel feature.
///
/// Rules in `packages/core_domain/lib/navigation/rules/` reference these
/// constants so every redirect target is defined in one place.
class ControlPanelRoutes {
  const ControlPanelRoutes._();

  // onboarding will be controlled by OnboardingRoutes

  static const String root = '/';
  static const String liveStreamOnly = '/live-stream-only';

  static const String settings = '/settings';
  static const String about = '/about';
}
