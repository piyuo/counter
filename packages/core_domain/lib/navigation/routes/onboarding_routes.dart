// TOC:
//  - OnboardingRoutes: minimal path constants used by the rule engine only
//
// Architecture note:
//  - Only constants referenced by core_domain rule engine and
//    ControlPanelRouterProvider belong here.
//  - All other route paths are owned by go_router_builder typed routes
//    in feature_onboarding (onboarding_route_data.dart).
class OnboardingRoutes {
  const OnboardingRoutes._();

  static const String onboarding = '/onboarding';
  static const String onboarding1 = '/onboarding/1';
  static const String onboarding2 = '/onboarding/1/2';
  static const String system = '/onboarding/1/2/system';
  static const String cta = '/cta';
  static const String ctaInvitation = '/cta/invitation';
}
