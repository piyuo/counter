// TOC:
//  - RouteDecision construction
//  - RouteDecision toString
//  - RouteDecision equality and hashCode

import 'package:core_domain/navigation/route_decision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RouteDecision', () {
    group('construction', () {
      test('stores target', () {
        const d = RouteDecision(target: '/onboarding');

        expect(d.target, '/onboarding');
      });
    });

    group('toString', () {
      test('returns target', () {
        const d = RouteDecision(target: '/home');

        expect(d.toString(), 'RouteDecision(target: /home)');
      });
    });

    group('equality', () {
      test('equal when targets match', () {
        const a = RouteDecision(target: '/onboarding');
        const b = RouteDecision(target: '/onboarding');

        expect(a, equals(b));
      });

      test('not equal when targets differ', () {
        const a = RouteDecision(target: '/onboarding');
        const b = RouteDecision(target: '/home');

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
        const a = RouteDecision(target: '/onboarding');
        const b = RouteDecision(target: '/onboarding');

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
