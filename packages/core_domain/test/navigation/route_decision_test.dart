// TOC:
//  - RouteDecision construction
//  - RouteDecision toString
//  - RouteDecision equality and hashCode

import 'package:core_domain/navigation/route_decision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RouteDecision', () {
    group('construction', () {
      test('stores target and optional reason', () {
        const d = RouteDecision(target: '/onboarding', reason: 'onboarding gate');

        expect(d.target, '/onboarding');
        expect(d.reason, 'onboarding gate');
      });

      test('reason defaults to null', () {
        const d = RouteDecision(target: '/home');

        expect(d.reason, isNull);
      });
    });

    group('toString', () {
      test('includes reason when present', () {
        const d = RouteDecision(target: '/onboarding', reason: 'test reason');

        expect(d.toString(), 'RouteDecision(target: /onboarding, reason: test reason)');
      });

      test('omits reason when null', () {
        const d = RouteDecision(target: '/home');

        expect(d.toString(), 'RouteDecision(target: /home)');
      });
    });

    group('equality', () {
      test('equal when target and reason match', () {
        const a = RouteDecision(target: '/onboarding', reason: 'gate');
        const b = RouteDecision(target: '/onboarding', reason: 'gate');

        expect(a, equals(b));
      });

      test('equal when both reasons are null', () {
        const a = RouteDecision(target: '/home');
        const b = RouteDecision(target: '/home');

        expect(a, equals(b));
      });

      test('not equal when targets differ', () {
        const a = RouteDecision(target: '/onboarding');
        const b = RouteDecision(target: '/home');

        expect(a, isNot(equals(b)));
      });

      test('not equal when reasons differ', () {
        const a = RouteDecision(target: '/onboarding', reason: 'reason-a');
        const b = RouteDecision(target: '/onboarding', reason: 'reason-b');

        expect(a, isNot(equals(b)));
      });

      test('not equal when one reason is null', () {
        const a = RouteDecision(target: '/onboarding', reason: 'some reason');
        const b = RouteDecision(target: '/onboarding');

        expect(a, isNot(equals(b)));
      });

      test('identical instance equals itself', () {
        const d = RouteDecision(target: '/settings');

        // ignore: prefer_const_declarations
        expect(d, equals(d));
      });
    });

    group('hashCode', () {
      test('equal objects have equal hashCodes', () {
        const a = RouteDecision(target: '/onboarding', reason: 'gate');
        const b = RouteDecision(target: '/onboarding', reason: 'gate');

        expect(a.hashCode, equals(b.hashCode));
      });

      test('can be used as map key', () {
        const d = RouteDecision(target: '/settings');
        final map = {d: true};

        expect(map[const RouteDecision(target: '/settings')], isTrue);
      });
    });
  });
}
