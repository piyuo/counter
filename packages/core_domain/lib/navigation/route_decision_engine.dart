// TOC:
//  - RouteDecisionEngine: executes registered rules in priority order
//
// Architecture note:
//  - Accepts a list of RouteRule plugins sorted by priority on construction.
//  - First rule that returns a non-null, non-current path wins ("first match wins").
//  - Deterministic, stateless, and fully testable without a Flutter widget tree.
//  - Loop detection: the full redirect chain is simulated on each decide() call.
//    If any target path repeats in the chain (e.g. /a→/b→/a), decide() returns
//    null instead of triggering an infinite redirect loop in GoRouter.
//  - Logging: every rule verdict and cycle detection is emitted via appkit.logInfo.

import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

import 'route_context.dart';
import 'route_decision.dart';
import 'route_rule.dart';

/// Executes registered [RouteRule] plugins in priority order and returns
/// the first [RouteDecision], or `null` if no rule fires.
///
/// Usage:
/// ```dart
/// final engine = RouteDecisionEngine([SystemLifecycleRule(), AppFlowRule()]);
/// final decision = engine.decide(context); // returns RouteDecision or null
/// ```
class RouteDecisionEngine {
  final List<RouteRule> _rules;

  /// Constructs the engine and sorts [rules] by [RouteRule.priority] ascending.
  RouteDecisionEngine(List<RouteRule> rules)
    : _rules = List.of(rules)..sort((a, b) => a.priority.compareTo(b.priority));

  /// Evaluates all rules against [context] and returns the first [RouteDecision].
  ///
  /// **Loop detection** — before returning, the engine simulates the full
  /// redirect chain internally:
  ///
  /// ```
  /// /a → /b → /a   ← cycle detected, return null
  /// /a → /b → /c   ← safe, return decision for /b (GoRouter handles /b→/c)
  /// ```
  ///
  /// Any path that appears more than once in the simulated chain is treated as
  /// a cycle. The engine also caps at [_maxChainDepth] steps as a safety
  /// backstop against pathological rule combinations.
  ///
  /// **Logging** — the trigger (what changed) and only opinionated rules are
  /// emitted via `appkit.logInfo`:
  ///
  /// ```
  /// [RouteDecisionEngine] decide() at "/home" ← flow: CheckingBackend→OnboardingRequired
  ///   ControlPanelAppFlowRule(p:10) → "/onboarding" [AppFlow transition: checkingBackend -> onboardingRequired]
  /// ```
  ///
  /// Returns `null` when no rule fires or a cycle is detected.
  static const int _maxChainDepth = 20;

  RouteDecision? decide(RouteContext context) {
    _logEvaluations(context);

    // Walk the full chain to detect cycles before returning the first step.
    final visited = <String>{context.path};
    var simulated = context;
    RouteDecision? first;

    for (var depth = 0; depth < _maxChainDepth; depth++) {
      RouteDecision? step;
      for (final rule in _rules) {
        final candidate = rule.evaluate(simulated);
        if (candidate != null && candidate.target != simulated.path) {
          step = candidate;
          break;
        }
      }

      // No rule fired — chain ends cleanly.
      if (step == null) break;

      // A target we have already visited means a cycle.
      if (visited.contains(step.target)) {
        appkit.logInfo(
          '[RouteDecisionEngine] cycle detected: ${visited.join(' → ')} → ${step.target} — returning null',
        );
        return null;
      }

      first ??= step;
      visited.add(step.target);

      // Advance simulation to the next hop.
      simulated = RouteContext(lifecycle: simulated.lifecycle, flow: simulated.flow, path: step.target);
    }

    return first;
  }

  /// Logs the trigger and only opinionated rule verdicts for [context].
  ///
  /// Example output:
  /// ```
  /// [RouteDecisionEngine] decide() at "/home" ← flow: CheckingBackend→OnboardingRequired
  ///   ControlPanelAppFlowRule(p:10) → "/onboarding" [AppFlow transition: checkingBackend -> onboardingRequired]
  /// ```
  void _logEvaluations(RouteContext context) {
    final triggers = <String>[];
    if (context.lifecycleChanged) {
      triggers.add('lifecycle: ${context.previousLifecycle.runtimeType}→${context.lifecycle.runtimeType}');
    }
    if (context.flowChanged) {
      triggers.add('flow: ${context.previousFlow.runtimeType}→${context.flow.runtimeType}');
    }
    if (context.pathChanged) {
      triggers.add('path: ${context.previousPath}→${context.path}');
    }

    final trigger = triggers.isEmpty ? 'initial' : triggers.join(', ');
    appkit.logInfo('[RouteDecisionEngine] decide() at "${context.path}" ← $trigger');

    for (final rule in _rules) {
      final candidate = rule.evaluate(context);
      if (candidate != null && candidate.target != context.path) {
        final ruleName = '${rule.runtimeType}(p:${rule.priority})';
        appkit.logInfo('[RouteDecisionEngine]   $ruleName → "${candidate.target}"');
      }
    }
  }
}
