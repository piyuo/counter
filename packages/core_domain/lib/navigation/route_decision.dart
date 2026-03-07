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
/// Rules return `null` to signal "no opinion"; they return a [RouteDecision]
/// when they want to redirect navigation.
class RouteDecision {
  /// The path the router should navigate to.
  final String target;

  const RouteDecision({required this.target});

  @override
  String toString() => 'RouteDecision(target: $target)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is RouteDecision && runtimeType == other.runtimeType && target == other.target;

  @override
  int get hashCode => target.hashCode;
}
