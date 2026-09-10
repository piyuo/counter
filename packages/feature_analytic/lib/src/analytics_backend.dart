import 'package:flutter/widgets.dart';

/// Extracts a screen name from [RouteSettings]. Structurally compatible with
/// `firebase_analytics`'s own `ScreenNameExtractor` typedef, so it can be
/// passed straight through to a `FirebaseAnalyticsObserver` by an adapter.
typedef ScreenNameExtractor = String? Function(RouteSettings settings);

/// Decides whether a route should be reported. Structurally compatible with
/// `firebase_analytics`'s own `RouteFilter` typedef.
typedef RouteFilter = bool Function(Route<dynamic>? route);

/// Filters out non [PageRoute] routes (the default).
bool defaultRouteFilter(Route<dynamic>? route) => route is PageRoute;

/// Accepts any route, including ones added via `showDialog()`.
bool anyRouteFilter(Route<dynamic>? route) => true;

String? defaultNameExtractor(RouteSettings settings) => settings.name;

/// Plug-in point for a platform-native analytics SDK (e.g. Firebase Analytics).
///
/// `feature_analytic` itself never depends on any native/Firebase package, so
/// implementations of this interface must live in the app (or an adapter
/// package) that is only constructed for the platforms the native SDK
/// actually supports. Platforms without a [NativeAnalyticsBackend] fall back
/// to the built-in GA4 Measurement Protocol HTTP client.
abstract class NativeAnalyticsBackend {
  /// Prepares the native SDK for use. Throwing here causes [initAnalytics] to
  /// fall back to the Measurement Protocol.
  Future<void> init();

  /// Overrides the default user identifier used by the native SDK.
  Future<void> setUserId(String userId);

  /// Sends a single named event with optional parameters.
  void logEvent(String name, Map<String, Object?>? parameters);

  /// Returns a [NavigatorObserver] that reports screen views to the native
  /// SDK, or `null` if the native SDK has no navigation observer of its own.
  NavigatorObserver? createNavigatorObserver({
    ScreenNameExtractor nameExtractor = defaultNameExtractor,
    RouteFilter routeFilter = defaultRouteFilter,
    void Function(Object error)? onError,
  });
}
