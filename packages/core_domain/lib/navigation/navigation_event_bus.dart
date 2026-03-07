// TOC:
//  - AppNavigationEvent: sealed class for one-shot navigation events
//  - navigationEventBusProvider: broadcast StreamController for the router
//
// Architecture note:
//  - Events are ephemeral — fire-and-forget. No consume() or clear() needed.
//  - The router subscribes to the stream and calls router.go() directly,
//    bypassing GoRouter's redirect cycle for user-initiated navigation.
//  - State-driven routing (lifecycle, flow gates) still uses RouteRule/redirect.

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One-shot navigation events emitted by UI widgets or services.
///
/// These are not stored in state — the stream is a broadcast channel.
/// Emitting the same event twice triggers navigation twice (intended).
sealed class NavigationEvent {
  const NavigationEvent();
}

class OpenLanguage extends NavigationEvent {
  const OpenLanguage();
}

/// Request to navigate to the settings screen.
class OpenSettings extends NavigationEvent {
  const OpenSettings();
}

class OpenLightOffScreen extends NavigationEvent {
  const OpenLightOffScreen();
}

/// Request to navigate to the about screen.
class OpenAbout extends NavigationEvent {
  const OpenAbout();
}

/// Request to navigate to the onboarding root screen.
class OpenOnboarding extends NavigationEvent {
  const OpenOnboarding();
}

/// Request to navigate to onboarding CTA screen.
class OpenOnboardingCTA extends NavigationEvent {
  const OpenOnboardingCTA();
}

/// Request to navigate to onboarding invitation, optionally with token.
class OpenOnboardingInvitation extends NavigationEvent {
  final String? token;

  const OpenOnboardingInvitation({this.token});
}

/// Request to navigate to onboarding sign-up screen.
class OpenOnboardingSignup extends NavigationEvent {
  const OpenOnboardingSignup();
}

/// Request to navigate to onboarding demo screen.
class OpenOnboardingDemo extends NavigationEvent {
  const OpenOnboardingDemo();
}

/// Broadcast [StreamController] carrying [NavigationEvent]s.
///
/// Kept alive by whoever subscribes to it (the router provider).
/// Disposed automatically via [ref.onDispose] when the container shuts down.
///
/// Emit from anywhere:
/// ```dart
/// ref.read(navigationEventBusProvider).add(const OpenSettings());
/// ```
final navigationEventBusProvider = Provider<StreamController<NavigationEvent>>((ref) {
  final controller = StreamController<NavigationEvent>.broadcast();
  ref.onDispose(controller.close);
  return controller;
});
