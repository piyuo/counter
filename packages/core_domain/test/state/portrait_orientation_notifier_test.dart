// TOC:
//  - portraitOrientationProvider initial state
//  - lockToPortrait() updates state and calls service once
//  - repeated lockToPortrait() is a no-op
//  - unlockFromPortrait() is a no-op when already unlocked
//  - unlockFromPortrait() resets state after locking

import 'package:core_domain/core_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PortraitOrientationNotifier', () {
    test('initial state is unlocked', () {
      final service = _FakePortraitOrientationService();
      final container = ProviderContainer(
        overrides: [portraitOrientationServiceProvider.overrideWith((ref) => service)],
      );
      addTearDown(container.dispose);

      expect(container.read(portraitOrientationProvider), isFalse);
    });

    test('lockToPortrait() updates state and calls service once', () async {
      final service = _FakePortraitOrientationService();
      final container = ProviderContainer(
        overrides: [portraitOrientationServiceProvider.overrideWith((ref) => service)],
      );
      addTearDown(container.dispose);

      await container.read(portraitOrientationProvider.notifier).lockToPortrait();

      expect(container.read(portraitOrientationProvider), isTrue);
      expect(service.lockCalls, 1);
      expect(service.unlockCalls, 0);
    });

    test('repeated lockToPortrait() is a no-op', () async {
      final service = _FakePortraitOrientationService();
      final container = ProviderContainer(
        overrides: [portraitOrientationServiceProvider.overrideWith((ref) => service)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(portraitOrientationProvider.notifier);
      await notifier.lockToPortrait();
      await notifier.lockToPortrait();

      expect(container.read(portraitOrientationProvider), isTrue);
      expect(service.lockCalls, 1);
    });

    test('unlockFromPortrait() is a no-op when already unlocked', () async {
      final service = _FakePortraitOrientationService();
      final container = ProviderContainer(
        overrides: [portraitOrientationServiceProvider.overrideWith((ref) => service)],
      );
      addTearDown(container.dispose);

      await container.read(portraitOrientationProvider.notifier).unlockFromPortrait();

      expect(container.read(portraitOrientationProvider), isFalse);
      expect(service.unlockCalls, 0);
    });

    test('unlockFromPortrait() resets state after locking', () async {
      final service = _FakePortraitOrientationService();
      final container = ProviderContainer(
        overrides: [portraitOrientationServiceProvider.overrideWith((ref) => service)],
      );
      addTearDown(container.dispose);

      final notifier = container.read(portraitOrientationProvider.notifier);
      await notifier.lockToPortrait();
      await notifier.unlockFromPortrait();

      expect(container.read(portraitOrientationProvider), isFalse);
      expect(service.lockCalls, 1);
      expect(service.unlockCalls, 1);
    });
  });
}

class _FakePortraitOrientationService implements PortraitOrientationService {
  int lockCalls = 0;
  int unlockCalls = 0;

  @override
  Future<void> lockToPortrait() async {
    lockCalls += 1;
  }

  @override
  Future<void> unlockFromPortrait() async {
    unlockCalls += 1;
  }
}
