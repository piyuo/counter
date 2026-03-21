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
  static const String onboardingInvitation = '/onboarding/invitation';
}
