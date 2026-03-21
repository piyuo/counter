// TOC:
//  - routeRulesProvider: assembles the ordered list of RouteRule plugins
//  - routeDecisionEngineProvider: builds the engine from the registered rules
//
// Architecture note:
//  - This is the plugin registry — the single place to add/remove rules.
//  - Each feature can contribute rules here without touching the router or
//    any other rule.  Ordering is handled by RouteRule.priority, not list order.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Ordered list of all active [core_domain.RouteRule] plugins.
///
/// To add a new routing behaviour:
///   1. Implement [core_domain.RouteRule] in the relevant feature package.
///   2. Add an instance to this list.
///   3. The engine will sort by priority automatically.
///
/// Examples of future rules:
///   AuthenticationRule()        // priority 5
///   SubscriptionGateRule()      // priority 20
///   HardwareErrorRule()         // priority 1
///   FeaturePermissionRule()     // priority 50
final monitorRouteRulesProvider = Provider<List<core_domain.RouteRule>>((ref) {
  return const [core_domain.MonitorSystemLifecycleRule(), core_domain.MonitorAppFlowRule()];
});

/// [core_domain.RouteDecisionEngine] built from [routeRulesProvider].
///
/// Re-created whenever the rule list changes (e.g. dynamic feature loading).
final monitorRouteDecisionEngineProvider = Provider<core_domain.RouteDecisionEngine>((ref) {
  final rules = ref.watch(monitorRouteRulesProvider);
  return core_domain.RouteDecisionEngine('monitor_route', rules);
});
