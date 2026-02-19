// TOC:
//  - RouteRule: abstract plugin contract for routing decisions
//
// Architecture note:
//  - Every feature that needs to influence routing implements this interface.
//  - Lower priority number = higher precedence (system beats flow beats intent).
//  - Returning null means "this rule has no opinion; pass to the next rule".

import 'route_context.dart';
import 'route_decision.dart';

/// Plugin contract for a single routing rule.
///
/// Features implement this interface to register routing behaviour without
/// touching the central router or other rules.
///
/// Rules are executed in ascending [priority] order by [RouteDecisionEngine].
/// The first rule that returns a non-null, non-current-path value wins.
abstract class RouteRule {
  /// Execution order — lower number runs first (higher priority).
  ///
  /// Recommended ranges:
  ///   0–9   → system lifecycle (hardware errors, degraded states)
  ///  10–99  → app flow (onboarding, authentication, subscription gates)
  /// 100–999 → user-initiated navigation intents
  int get priority;

  /// Evaluates whether this rule wants to redirect to a different route.
  ///
  /// Returns a [RouteDecision] describing the target and optional metadata,
  /// or `null` if this rule has no opinion.
  /// The engine skips decisions whose [RouteDecision.target] equals
  /// [RouteContext.currentPath].
  RouteDecision? evaluate(RouteContext context);
}
