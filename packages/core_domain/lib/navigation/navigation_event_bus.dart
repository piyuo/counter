// TOC:
//  - NavigationEvent: sealed class for one-shot navigation events (carries path + extra)
//  - NavigationAction: wraps NavigationEvent with push() or go() intent
//  - NavigationEventBus: bus.push() adds to stack, bus.go() replaces stack
//  - navigationEventBusProvider: NavigationEventBus for the router
//  - NavigationWidgetRefX: ref.push() / ref.go() shortcuts for widgets
//
// Architecture note:
//  - Events are ephemeral — fire-and-forget. No consume() or clear() needed.
//  - The router subscribes to the stream and calls router.push() or router.go()
//    directly, bypassing GoRouter's redirect cycle for user-initiated navigation.
//  - State-driven routing (lifecycle, flow gates) still uses RouteRule/redirect.

import 'dart:async';

import 'package:core_domain/navigation/routes/onboarding_routes.dart';
import 'package:core_domain/state/models/invitation.dart';
import 'package:core_domain/telemetry/models/upload_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One-shot navigation events emitted by UI widgets or services.
///
/// These are not stored in state — the stream is a broadcast channel.
/// Emitting the same event twice triggers navigation twice (intended).
///
/// Each subclass declares its own [path] so the router needs no switch.
/// Return `null` from [path] to signal that this router should ignore the event.
sealed class NavigationEvent {
  const NavigationEvent();

  /// Target path for this event, or null if the current router does not handle it.
  String? get path => null;

  /// Optional extra data forwarded to the route (e.g., non-serialisable objects).
  Object? get extra => null;
}

class OpenLanguage extends NavigationEvent {
  const OpenLanguage();
  @override
  String? get path => '/language';
}

/// Request to navigate to the settings screen.
class OpenSettings extends NavigationEvent {
  const OpenSettings();
  @override
  String? get path => '/settings';
}

class OpenSettingsPiyuo extends NavigationEvent {
  const OpenSettingsPiyuo();
  @override
  String? get path => '/settings/piyuo';
}

class OpenSettingsServer extends NavigationEvent {
  const OpenSettingsServer();
  @override
  String? get path => '/settings/server';
}

class OpenSettingsLocal extends NavigationEvent {
  const OpenSettingsLocal();
  @override
  String? get path => '/settings/local';
}

/// Request to navigate to the detection parameters screen.
class OpenDetection extends NavigationEvent {
  const OpenDetection();
  @override
  String? get path => '/detection';
}

/// Request to navigate to the detection type selection screen.
class OpenTarget extends NavigationEvent {
  const OpenTarget();
  @override
  String? get path => '/target';
}

/// Request to navigate to the delivery configuration screen.
class OpenDeliveryConfig extends NavigationEvent {
  const OpenDeliveryConfig();
  @override
  String? get path => '/delivery-config';
}

/// Request to navigate to the upload logs screen.
class OpenUploadLogs extends NavigationEvent {
  const OpenUploadLogs();
  @override
  String? get path => '/upload-logs';
}

/// Request to navigate to one upload-attempt detail.
class OpenUploadLogDetail extends NavigationEvent {
  const OpenUploadLogDetail({required this.log});

  final UploadLog log;

  @override
  String? get path => '/upload-logs/detail/${log.attemptedAtUtc.millisecondsSinceEpoch}/${log.success ? 1 : 0}';

  @override
  Object? get extra => log;
}

/// Request to navigate to the recent payloads screen.
class OpenPayloadsRecent extends NavigationEvent {
  const OpenPayloadsRecent();
  @override
  String? get path => '/recent-payloads';
}

/// Request to navigate to one recent payload delivery-hour group.
class OpenPayloadsHour extends NavigationEvent {
  const OpenPayloadsHour({required this.slotMs});

  final int slotMs;

  @override
  String? get path => '/recent-payloads/hour/$slotMs';
}

/// Request to navigate to one recent payload detail.
class OpenPayloadDetail extends NavigationEvent {
  const OpenPayloadDetail({required this.payloadId});

  final String payloadId;

  @override
  String? get path => '/recent-payloads/payload/$payloadId';
}

/// Request to navigate to the video sources screen.
class OpenVideoSources extends NavigationEvent {
  const OpenVideoSources();
  @override
  String? get path => '/video-sources';
}

/// Request to navigate to the live URL video source screen.
class OpenLiveUrl extends NavigationEvent {
  const OpenLiveUrl();
  @override
  String? get path => '/live-url';
}

class OpenLightOffScreen extends NavigationEvent {
  const OpenLightOffScreen();
  // path returns null — not handled by the control-panel router.
}

/// Request to navigate to the about screen.
class OpenAbout extends NavigationEvent {
  const OpenAbout();
  @override
  String? get path => '/about';
}

class OpenBuildInfo extends NavigationEvent {
  const OpenBuildInfo();
  @override
  String? get path => '/build-info';
}

/// Request to navigate to the onboarding root screen.
class OpenOnboarding extends NavigationEvent {
  const OpenOnboarding();
  @override
  String? get path => OnboardingRoutes.onboarding;
}

class OpenOnboarding1 extends NavigationEvent {
  const OpenOnboarding1();
  @override
  String? get path => OnboardingRoutes.onboarding1;
}

class OpenOnboarding2 extends NavigationEvent {
  const OpenOnboarding2();
  @override
  String? get path => OnboardingRoutes.onboarding2;
}

/// Request to navigate to onboarding system check screen.
class OpenOnboardingSystem extends NavigationEvent {
  const OpenOnboardingSystem();
  @override
  String? get path => OnboardingRoutes.system;
}

/// Request to navigate to CTA screen (root level, breaks back stack).
class OpenOnboardingCTA extends NavigationEvent {
  const OpenOnboardingCTA();
  @override
  String? get path => OnboardingRoutes.cta;
}

/// Request to navigate to onboarding invitation, optionally with token.
class OpenOnboardingInvitation extends NavigationEvent {
  final String? token;

  const OpenOnboardingInvitation({this.token});

  @override
  String? get path =>
      Uri(path: OnboardingRoutes.ctaInvitation, queryParameters: token != null ? {'token': token} : null).toString();
}

class OpenOnboardingInvitationSuccess extends NavigationEvent {
  const OpenOnboardingInvitationSuccess({required this.invitation});
  final Invitation invitation;

  @override
  String? get path => '${OnboardingRoutes.ctaInvitation}/success';

  @override
  Object? get extra => invitation;
}

class OpenOnboardingPiyuo extends NavigationEvent {
  const OpenOnboardingPiyuo();
  @override
  String? get path => '${OnboardingRoutes.cta}/piyuo';
}

class OpenOnboardingServer extends NavigationEvent {
  const OpenOnboardingServer();
  @override
  String? get path => '${OnboardingRoutes.cta}/server';
}

class OpenOnboardingServerSuccess extends NavigationEvent {
  const OpenOnboardingServerSuccess({required this.url});
  final String url;

  @override
  String? get path => Uri(path: '${OnboardingRoutes.cta}/server/success', queryParameters: {'url': url}).toString();
}

class OpenOnboardingLocal extends NavigationEvent {
  const OpenOnboardingLocal();
  @override
  String? get path => '${OnboardingRoutes.cta}/demo';
}

class OpenOnboardingPiyuoSubscription extends NavigationEvent {
  const OpenOnboardingPiyuoSubscription();
  @override
  String? get path => Uri(path: '${OnboardingRoutes.cta}/piyuo-subscription').toString();
}

class OpenOnboardingServerSubscription extends NavigationEvent {
  const OpenOnboardingServerSubscription();
  @override
  String? get path => Uri(path: '${OnboardingRoutes.cta}/server-subscription').toString();
}

/// Wraps a [NavigationEvent] with the routing intent.
///
/// - [PushAction] → `router.push()`: adds the screen to the stack; back button available.
/// - [GoAction]   → `router.go()`: replaces the stack; no back button.
sealed class NavigationAction {
  final NavigationEvent event;
  const NavigationAction(this.event);
}

final class PushAction extends NavigationAction {
  const PushAction(super.event);
}

final class GoAction extends NavigationAction {
  const GoAction(super.event);
}

/// Thin wrapper around a broadcast [StreamController<NavigationAction>].
///
/// - [push] navigates to a screen and keeps the back stack (→ `router.push`).
/// - [go] navigates to a screen and clears the back stack (→ `router.go`).
class NavigationEventBus {
  final StreamController<NavigationAction> _controller = StreamController<NavigationAction>.broadcast();

  /// The broadcast stream. Subscribe here to react to navigation actions.
  Stream<NavigationAction> get stream => _controller.stream;

  /// Push the screen onto the stack — back button will be available.
  void push(NavigationEvent event) => _controller.add(PushAction(event));

  /// Navigate to the screen and replace the stack — no back button.
  void go(NavigationEvent event) => _controller.add(GoAction(event));

  bool get isClosed => _controller.isClosed;

  Future<void> close() => _controller.close();
}

/// [NavigationEventBus] instance shared across the app.
///
/// Kept alive by whoever subscribes to it (the router provider).
/// Disposed automatically via [ref.onDispose] when the container shuts down.
///
/// Emit from anywhere:
/// ```dart
/// ref.push(const OpenSettings()); // with back button
/// ref.go(const OpenSettings());   // without back button
/// ```
final navigationEventBusProvider = Provider<NavigationEventBus>((ref) {
  final bus = NavigationEventBus();
  ref.onDispose(bus.close);
  return bus;
});

/// Shortcuts so widgets write `ref.push(event)` / `ref.go(event)` instead of
/// `ref.read(navigationEventBusProvider).push/go(event)`.
extension NavigationWidgetRefX on WidgetRef {
  /// Push the screen onto the stack — back button will be available.
  void push(NavigationEvent event) => read(navigationEventBusProvider).push(event);

  /// Navigate to the screen and replace the stack — no back button.
  void go(NavigationEvent event) => read(navigationEventBusProvider).go(event);
}
