// TOC:
//  - navigationEventBusProvider returns a NavigationEventBus
//  - Events emitted via push() are wrapped in PushAction and received by stream listeners
//  - Events emitted via go() are wrapped in GoAction and received by stream listeners
//  - Multiple listeners (broadcast) each receive the action
//  - NavigationEvent subtypes: OpenSettings, OpenAbout, onboarding events
//  - NavigationEventBus is closed on provider disposal

import 'package:core_domain/navigation/navigation_event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('navigationEventBusProvider', () {
    test('provides a NavigationEventBus with a broadcast stream', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);

      expect(controller, isA<NavigationEventBus>());
      expect(controller.stream.isBroadcast, isTrue);
    });

    test('push() emits a PushAction wrapping the event', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <NavigationAction>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.push(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(1));
      expect(received.first, isA<PushAction>());
      expect((received.first as PushAction).event, isA<OpenSettings>());
    });

    test('go() emits a GoAction wrapping the event', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <NavigationAction>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.go(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(1));
      expect(received.first, isA<GoAction>());
      expect((received.first as GoAction).event, isA<OpenSettings>());
    });

    test('multiple listeners each receive the action (broadcast)', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received1 = <NavigationAction>[];
      final received2 = <NavigationAction>[];

      final sub1 = controller.stream.listen(received1.add);
      final sub2 = controller.stream.listen(received2.add);
      addTearDown(sub1.cancel);
      addTearDown(sub2.cancel);

      controller.push(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received1, hasLength(1));
      expect(received2, hasLength(1));
    });

    test('emitting the same event twice fires navigation twice', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <NavigationAction>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.push(const OpenSettings());
      controller.push(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(2));
    });

    test('mixed action sequence is received in order', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <NavigationAction>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.push(const OpenSettings());
      controller.go(const OpenAbout());
      controller.push(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received[0], isA<PushAction>());
      expect(received[1], isA<GoAction>());
      expect(received[2], isA<PushAction>());
    });

    test('NavigationEventBus is closed when container is disposed', () async {
      final container = ProviderContainer();
      final controller = container.read(navigationEventBusProvider);

      expect(controller.isClosed, isFalse);

      container.dispose();
      await Future<void>.delayed(Duration.zero);

      expect(controller.isClosed, isTrue);
    });

    test('same container always returns the same NavigationEventBus instance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final a = container.read(navigationEventBusProvider);
      final b = container.read(navigationEventBusProvider);

      expect(identical(a, b), isTrue);
    });
  });

  group('AppNavigationEvent subtypes', () {
    test('OpenSettings is an AppNavigationEvent', () {
      expect(const OpenSettings(), isA<NavigationEvent>());
    });

    test('OpenAbout is an AppNavigationEvent', () {
      expect(const OpenAbout(), isA<NavigationEvent>());
    });

    test('OpenOnboarding is an AppNavigationEvent', () {
      expect(const OpenOnboarding(), isA<NavigationEvent>());
    });

    test('OpenOnboardingCTA is an AppNavigationEvent', () {
      expect(const OpenOnboardingCTA(), isA<NavigationEvent>());
    });

    test('OpenOnboardingInvitation is an AppNavigationEvent', () {
      expect(const OpenOnboardingInvitation(token: 'abc'), isA<NavigationEvent>());
    });
  });
}
