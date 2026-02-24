// TOC:
//  - AppFlowRule: redirects based on business-flow state (onboarding gates etc.)
//
// Priority: 10 (below system lifecycle, above user intents)

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/onboarding_routes.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/route_decision.dart';
import 'package:core_domain/navigation/route_rule.dart';

/// Redirects to flow-required routes when the app is in a gated state.
///
/// Priority 10 — runs after system rules but before user navigation intents.
/// Covers all onboarding variants so the gate cannot be bypassed by intent.
class AppFlowRule implements RouteRule {
  const AppFlowRule();

  bool _isWithinOnboarding(String path) =>
      path == OnboardingRoutes.onboarding || path.startsWith('${OnboardingRoutes.onboarding}/');

  @override
  int get priority => 10;

  @override
  RouteDecision? evaluate(RouteContext context) {
    return context.flow.whenOrNull(
      onboardingRequired: () {
        if (_isWithinOnboarding(context.currentPath)) return null;
        return const RouteDecision(target: OnboardingRoutes.onboarding, reason: 'app-flow gate');
      },
      onboardingByInvitation: () {
        if (_isWithinOnboarding(context.currentPath)) return null;
        return RouteDecision(target: OnboardingRoutes.onboardingInvitation, reason: 'app-flow gate');
      },
    );
  }
}
