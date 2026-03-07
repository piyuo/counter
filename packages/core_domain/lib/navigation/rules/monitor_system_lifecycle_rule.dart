// TOC:
//  - SystemLifecycleRule: redirects based on hardware/system lifecycle state
//
// Priority: 0 (highest — system state overrides everything else)

import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/route_decision.dart';
import 'package:core_domain/navigation/route_rule.dart';

/// Redirects to degraded-mode routes when the system lifecycle requires it.
///
/// Priority 0 — runs before all other rules.  A hardware failure or
/// live-stream-only boot must be honoured regardless of flow or intent.
class MonitorSystemLifecycleRule implements RouteRule {
  const MonitorSystemLifecycleRule();

  @override
  int get priority => 0;

  @override
  RouteDecision? evaluate(RouteContext context) {
    return switch ((context.previousLifecycle, context.lifecycle)) {
      _ => null,
    };
  }
}
