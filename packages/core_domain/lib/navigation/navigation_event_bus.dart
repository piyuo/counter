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
sealed class AppNavigationEvent {
  const AppNavigationEvent();
}

/// Request to navigate to the settings screen.
class OpenSettings extends AppNavigationEvent {
  const OpenSettings();
}

/// Request to navigate to the about screen.
class OpenAbout extends AppNavigationEvent {
  const OpenAbout();
}

/// Request to navigate to the onboarding root screen.
class OpenOnboarding extends AppNavigationEvent {
  const OpenOnboarding();
}

/// Request to navigate to onboarding invitation, optionally with token.
class OpenOnboardingInvitation extends AppNavigationEvent {
  final String? token;

  const OpenOnboardingInvitation({this.token});
}

/// Broadcast [StreamController] carrying [AppNavigationEvent]s.
///
/// Kept alive by whoever subscribes to it (the router provider).
/// Disposed automatically via [ref.onDispose] when the container shuts down.
///
/// Emit from anywhere:
/// ```dart
/// ref.read(navigationEventBusProvider).add(const OpenSettings());
/// ```
final navigationEventBusProvider = Provider<StreamController<AppNavigationEvent>>((ref) {
  final controller = StreamController<AppNavigationEvent>.broadcast();
  ref.onDispose(controller.close);
  return controller;
});
