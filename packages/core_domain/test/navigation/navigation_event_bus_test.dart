// TOC:
//  - navigationEventBusProvider returns a broadcast StreamController
//  - Events emitted via add() are received by stream listeners
//  - Multiple listeners (broadcast) each receive the event
//  - AppNavigationEvent subtypes: OpenSettings, OpenAbout, onboarding events
//  - StreamController is closed on provider disposal

import 'dart:async';

import 'package:core_domain/navigation/navigation_event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('navigationEventBusProvider', () {
    test('provides a broadcast StreamController', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);

      expect(controller, isA<StreamController<AppNavigationEvent>>());
      expect(controller.stream.isBroadcast, isTrue);
    });

    test('emitted OpenSettings event is received by listener', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <AppNavigationEvent>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.add(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(1));
      expect(received.first, isA<OpenSettings>());
    });

    test('emitted OpenAbout event is received by listener', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <AppNavigationEvent>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.add(const OpenAbout());
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(1));
      expect(received.first, isA<OpenAbout>());
    });

    test('multiple listeners each receive the event (broadcast)', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received1 = <AppNavigationEvent>[];
      final received2 = <AppNavigationEvent>[];

      final sub1 = controller.stream.listen(received1.add);
      final sub2 = controller.stream.listen(received2.add);
      addTearDown(sub1.cancel);
      addTearDown(sub2.cancel);

      controller.add(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received1, hasLength(1));
      expect(received2, hasLength(1));
    });

    test('emitting the same event twice fires navigation twice', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <AppNavigationEvent>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.add(const OpenSettings());
      controller.add(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(2));
    });

    test('mixed event sequence is received in order', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(navigationEventBusProvider);
      final received = <AppNavigationEvent>[];
      final sub = controller.stream.listen(received.add);
      addTearDown(sub.cancel);

      controller.add(const OpenSettings());
      controller.add(const OpenAbout());
      controller.add(const OpenSettings());
      await Future<void>.delayed(Duration.zero);

      expect(received[0], isA<OpenSettings>());
      expect(received[1], isA<OpenAbout>());
      expect(received[2], isA<OpenSettings>());
    });

    test('StreamController is closed when container is disposed', () async {
      final container = ProviderContainer();
      final controller = container.read(navigationEventBusProvider);

      expect(controller.isClosed, isFalse);

      container.dispose();
      await Future<void>.delayed(Duration.zero);

      expect(controller.isClosed, isTrue);
    });

    test('same container always returns the same StreamController instance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final a = container.read(navigationEventBusProvider);
      final b = container.read(navigationEventBusProvider);

      expect(identical(a, b), isTrue);
    });
  });

  group('AppNavigationEvent subtypes', () {
    test('OpenSettings is an AppNavigationEvent', () {
      expect(const OpenSettings(), isA<AppNavigationEvent>());
    });

    test('OpenAbout is an AppNavigationEvent', () {
      expect(const OpenAbout(), isA<AppNavigationEvent>());
    });

    test('OpenOnboarding is an AppNavigationEvent', () {
      expect(const OpenOnboarding(), isA<AppNavigationEvent>());
    });

    test('OpenOnboardingInvitation is an AppNavigationEvent', () {
      expect(const OpenOnboardingInvitation(token: 'abc'), isA<AppNavigationEvent>());
    });
  });
}
