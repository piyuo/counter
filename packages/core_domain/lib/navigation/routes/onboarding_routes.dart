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
  static const String onboardingIntroPrivacy = '/onboarding/intro_privacy';
  static const String onboardingIntroCollect = '/onboarding/intro_privacy/intro_collect';
  static const String cameraTest = '/onboarding/intro_privacy/intro_collect/camera_test';
  static const String cta = '/cta';
  static const String ctaInvitation = '/cta/cta_invitation';
}
