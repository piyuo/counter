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

  @override
  int get priority => 10;

  @override
  RouteDecision? evaluate(RouteContext context) {
    final target = context.flow.whenOrNull(
      onboardingRequired: () => OnboardingRoutes.onboarding,
      onboardingByInvitation: () => OnboardingRoutes.onboardingInvitation,
    );
    if (target == null) return null;
    return RouteDecision(target: target, reason: 'app-flow gate');
  }
}
