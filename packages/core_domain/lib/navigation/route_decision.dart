// TOC:
//  - RouteDecision: value object returned by RouteRule.evaluate()
//
// Architecture note:
//  - Carries the redirect target together with optional metadata used for
//    logging, analytics, debugging, and future transition policies.
//  - GoRouter's redirect callback only supports returning a path string,
//    which GoRouter always treats as a replace (go). Push-style one-shot
//    navigation belongs in the Event Bus, not in RouteRule.

/// The result of a [RouteRule] evaluation.
///
/// Contains the navigation target and optional metadata that supports
/// logging, analytics, debugging, and future transition policies.
///
/// Rules return `null` to signal "no opinion"; they return a [RouteDecision]
/// when they want to redirect navigation.
class RouteDecision {
  /// The path the router should navigate to.
  final String target;

  /// Optional human-readable explanation for why this decision was made.
  ///
  /// Useful for debug logging, analytics events, and routing diagnostics.
  final String? reason;

  const RouteDecision({required this.target, this.reason});

  @override
  String toString() => 'RouteDecision(target: $target${reason != null ? ', reason: $reason' : ''})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteDecision && runtimeType == other.runtimeType && target == other.target && reason == other.reason;

  @override
  int get hashCode => Object.hash(target, reason);
}
