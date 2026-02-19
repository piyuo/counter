// TOC:
//  - RouteContext: unified input object passed to every RouteRule
//
// Architecture note:
//  - Aggregates all routing inputs into a single value object.
//  - Rules receive this object instead of individual parameters.
//  - Pure value object — no Riverpod ref, no mutable intent.
//  - One-shot navigation (openSettings, openAbout, onboarding events) is handled via
//    navigationEventBusProvider stream, not through RouteRule.

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';

/// Unified snapshot of all inputs used to decide where to route.
///
/// Passed to every [RouteRule.evaluate] call so rules are self-contained
/// and can be unit-tested by constructing this object directly.
class RouteContext {
  /// Current hardware/system lifecycle state.
  final SystemLifecycle lifecycle;

  /// Current business-flow state.
  final AppFlow flow;

  /// The path that is currently active in the router.
  final String currentPath;

  const RouteContext({required this.lifecycle, required this.flow, required this.currentPath});
}
