// TOC:
//  - invitationCodeProvider initial state
//  - setCode() updates the state
//  - clear() resets to null
//  - consecutive setCode() calls override the previous value

import 'package:core_domain/state/providers/invitation_code_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InvitationCodeNotifier', () {
    test('initial state is null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(invitationCodeProvider), isNull);
    });

    test('setCode() updates state to the given code', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(invitationCodeProvider.notifier).setCode('ABC123');

      expect(container.read(invitationCodeProvider), 'ABC123');
    });

    test('clear() resets state to null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(invitationCodeProvider.notifier).setCode('ABC123');
      container.read(invitationCodeProvider.notifier).clear();

      expect(container.read(invitationCodeProvider), isNull);
    });

    test('consecutive setCode() calls override the previous value', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(invitationCodeProvider.notifier).setCode('FIRST');
      container.read(invitationCodeProvider.notifier).setCode('SECOND');

      expect(container.read(invitationCodeProvider), 'SECOND');
    });
  });
}
