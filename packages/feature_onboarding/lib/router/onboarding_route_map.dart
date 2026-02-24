// TOC:
//  - controlPanelRouteMap: all GoRoute entries for the control-panel feature
//
// Architecture note:
//  - Path constants come from ControlPanelRoutes — never use raw strings here.
//  - Routing logic (redirects, guards) lives in RouteDecisionEngine rules, not here.
//  - Each builder receives a fresh ScrollController; the screen owns its lifecycle.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/screens/cta_screen.dart';
import 'package:feature_onboarding/screens/invitation_screen.dart';
import 'package:feature_onboarding/screens/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> onBoardingRouteMap() {
  return [
    GoRoute(
      path: core_domain.OnboardingRoutes.onboarding,
      builder: (context, state) => OnboardingScreen(),
      routes: [
        GoRoute(
          path: core_domain.OnboardingRoutes.invitation,
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            return InvitationScreen(token: token);
          },
        ),
        GoRoute(
          path: core_domain.OnboardingRoutes.cta,
          builder: (context, state) {
            return CTAScreen();
          },
        ),
      ],
    ),
  ];
}
