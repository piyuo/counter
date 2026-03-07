// TOC:
//  - AppFlowRule: redirects based on business-flow state (onboarding gates etc.)
//
// Priority: 10 (below system lifecycle, above user intents)

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/route_decision.dart';
import 'package:core_domain/navigation/route_rule.dart';
import 'package:core_domain/navigation/routes/control_panel_routes.dart';
import 'package:core_domain/navigation/routes/onboarding_routes.dart';

/// Redirects to flow-required routes when the app is in a gated state.
///
/// Priority 10 — runs after system rules but before user navigation intents.
/// Covers all onboarding variants so the gate cannot be bypassed by intent.
class ControlPanelAppFlowRule implements RouteRule {
  const ControlPanelAppFlowRule();

  @override
  int get priority => 10;

  @override
  RouteDecision? evaluate(RouteContext context) {
    return switch ((context.previousFlow, context.flow)) {
      (WaitingForStart(), OnboardingByInvitation()) => RouteDecision(target: OnboardingRoutes.onboardingInvitation),
      (CheckingBackend(), OnboardingRequired()) => const RouteDecision(target: OnboardingRoutes.onboarding),
      (OnboardingRequired(), SessionRunning()) => const RouteDecision(target: ControlPanelRoutes.start),
      (CheckingBackend(), SessionRunning()) => const RouteDecision(target: ControlPanelRoutes.start),
      _ => null,
    };
  }
}
