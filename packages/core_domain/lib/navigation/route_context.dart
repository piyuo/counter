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
///
/// [previousFlow] and [previousLifecycle] are non-null **only** when the
/// redirect was triggered by a state change (not by a route navigation).
/// Rules can check [flowChanged] / [lifecycleChanged] to fire only on
/// transition into a state, avoiding spurious redirects on every push/go.
class RouteContext {
  /// Current hardware/system lifecycle state.
  final SystemLifecycle lifecycle;

  /// Current business-flow state.
  final AppFlow flow;

  /// The path being navigated to (the new path in a redirect evaluation).
  final String path;

  /// The path that was active before this navigation, or `null` on first load.
  final String? previousPath;

  /// The lifecycle state before the most-recent state change, or `null` if
  /// this redirect was triggered by a route navigation (no lifecycle change).
  final SystemLifecycle? previousLifecycle;

  /// The flow state before the most-recent state change, or `null` if this
  /// redirect was triggered by a route navigation (no flow change).
  final AppFlow? previousFlow;

  const RouteContext({
    required this.lifecycle,
    required this.flow,
    required this.path,
    this.previousPath,
    this.previousLifecycle,
    this.previousFlow,
  });

  /// True when [flow] changed in the trigger that caused this redirect.
  bool get flowChanged => previousFlow != null && previousFlow != flow;

  /// True when [lifecycle] changed in the trigger that caused this redirect.
  bool get lifecycleChanged => previousLifecycle != null && previousLifecycle != lifecycle;

  /// True when [path] differs from [previousPath].
  bool get pathChanged => previousPath != null && previousPath != path;
}
