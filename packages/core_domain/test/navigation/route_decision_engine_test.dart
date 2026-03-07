// TOC:
//  - RouteDecisionEngine with no rules
//  - RouteDecisionEngine with a single rule
//  - RouteDecisionEngine priority ordering
//  - RouteDecisionEngine skips same-path decisions
//  - RouteDecisionEngine cycle detection
//  - RouteDecisionEngine multi-hop chain (returns first hop)
//  - RouteDecisionEngine max-depth backstop

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/navigation/route_context.dart';
import 'package:core_domain/navigation/route_decision.dart';
import 'package:core_domain/navigation/route_decision_engine.dart';
import 'package:core_domain/navigation/route_rule.dart';
import 'package:core_domain/system_lifecycle/models/system_lifecycle.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

RouteContext _ctx(String path) =>
    RouteContext(lifecycle: const SystemLifecycle.systemReady(), flow: const AppFlow.sessionRunning(), path: path);

/// A rule that always redirects to [target] regardless of context.
class _AlwaysRule implements RouteRule {
  _AlwaysRule(this.priority, this.target);

  @override
  final int priority;
  final String target;

  @override
  RouteDecision? evaluate(RouteContext context) => RouteDecision(target: target);
}

/// A rule that always returns null (no opinion).
class _NeverRule implements RouteRule {
  _NeverRule(this.priority);

  @override
  final int priority;

  @override
  RouteDecision? evaluate(RouteContext context) => null;
}

/// A rule that redirects to [target] only when the current path matches [from].
class _ChainRule implements RouteRule {
  _ChainRule(this.priority, this.from, this.target);

  @override
  final int priority;
  final String from;
  final String target;

  @override
  RouteDecision? evaluate(RouteContext context) => context.path == from ? RouteDecision(target: target) : null;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('RouteDecisionEngine', () {
    group('empty / no-opinion rules', () {
      test('returns null when rule list is empty', () {
        final engine = RouteDecisionEngine([]);
        expect(engine.decide(_ctx('/')), isNull);
      });

      test('returns null when all rules return null', () {
        final engine = RouteDecisionEngine([_NeverRule(0), _NeverRule(10)]);
        expect(engine.decide(_ctx('/')), isNull);
      });

      test('returns null when only matching decision equals path', () {
        // Rule wants to go to '/', which is already the path.
        final engine = RouteDecisionEngine([_AlwaysRule(0, '/')]);
        expect(engine.decide(_ctx('/')), isNull);
      });
    });

    group('single firing rule', () {
      test('returns the decision when rule fires for a different path', () {
        final engine = RouteDecisionEngine([_AlwaysRule(0, '/onboarding')]);
        final decision = engine.decide(_ctx('/'));

        expect(decision, isNotNull);
        expect(decision!.target, '/onboarding');
      });

      test('skips decision whose target equals path (pass to next rule)', () {
        // ChainRule(0, '/home', '/home') fires from /home → target=/home == path → skipped.
        // ChainRule(10, '/home', '/settings') fires from /home → target=/settings → wins.
        // Simulation at /settings: no rules fire → chain ends cleanly.
        final engine = RouteDecisionEngine([_ChainRule(0, '/home', '/home'), _ChainRule(10, '/home', '/settings')]);
        final decision = engine.decide(_ctx('/home'));

        expect(decision?.target, '/settings');
      });
    });

    group('priority ordering', () {
      test('lower priority number runs first and wins', () {
        // ChainRule fires only from '/', so the simulation terminates cleanly
        // after the first hop without cycling back.
        final engine = RouteDecisionEngine([_ChainRule(15, '/', '/second'), _ChainRule(5, '/', '/first')]);
        final decision = engine.decide(_ctx('/'));

        expect(decision?.target, '/first');
      });

      test('higher-priority rule that has no opinion falls through to next', () {
        final engine = RouteDecisionEngine([_NeverRule(0), _AlwaysRule(10, '/fallback')]);
        expect(engine.decide(_ctx('/'))?.target, '/fallback');
      });
    });

    group('cycle detection', () {
      test('detects A → B → A and returns null', () {
        // /a → /b, /b → /a
        final engine = RouteDecisionEngine([_ChainRule(0, '/a', '/b'), _ChainRule(0, '/b', '/a')]);
        expect(engine.decide(_ctx('/a')), isNull);
      });

      test('detects A → B → C → A and returns null', () {
        final engine = RouteDecisionEngine([
          _ChainRule(0, '/a', '/b'),
          _ChainRule(0, '/b', '/c'),
          _ChainRule(0, '/c', '/a'),
        ]);
        expect(engine.decide(_ctx('/a')), isNull);
      });
    });

    group('multi-hop chain', () {
      test('returns the first hop when chain is clean (A → B → C)', () {
        // /a → /b → /c → no more rules fire
        final engine = RouteDecisionEngine([_ChainRule(0, '/a', '/b'), _ChainRule(0, '/b', '/c')]);
        final decision = engine.decide(_ctx('/a'));

        // Engine returns the first redirect step (/b).
        expect(decision?.target, '/b');
      });

      test('returns null when starting path has no matching rule', () {
        final engine = RouteDecisionEngine([_ChainRule(0, '/other', '/somewhere')]);
        expect(engine.decide(_ctx('/unrelated')), isNull);
      });
    });

    group('max chain depth backstop', () {
      test('does not throw with a long but non-cyclic chain', () {
        // Build a 22-step chain /p0 → /p1 → ... → /p21
        // (exceeds _maxChainDepth of 20, but no path repeats).
        final rules = List.generate(22, (i) => _ChainRule(i, '/p$i', '/p${i + 1}'));
        final engine = RouteDecisionEngine(rules);

        // Should not throw and should return the first hop.
        expect(() => engine.decide(_ctx('/p0')), returnsNormally);
        final decision = engine.decide(_ctx('/p0'));
        expect(decision?.target, '/p1');
      });
    });
  });
}
