// TOC:
//  - SystemLifecycleRule: redirects based on hardware/system lifecycle state
//
// Priority: 0 (highest — system state overrides everything else)

import 'package:core_domain/navigation/control_panel_routes.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/route_decision.dart';
import 'package:core_domain/navigation/route_rule.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';

/// Redirects to degraded-mode routes when the system lifecycle requires it.
///
/// Priority 0 — runs before all other rules.  A hardware failure or
/// live-stream-only boot must be honoured regardless of flow or intent.
class SystemLifecycleRule implements RouteRule {
  const SystemLifecycleRule();

  @override
  int get priority => 0;

  @override
  RouteDecision? evaluate(RouteContext context) {
    final target = context.lifecycle.whenOrNull(liveStreamOnly: () => ControlPanelRoutes.liveStreamOnly);
    if (target == null) return null;
    return RouteDecision(target: target, reason: 'system-lifecycle: liveStreamOnly');
  }
}
