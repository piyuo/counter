import 'package:feature_usage/feature_usage.dart' as feature_usage;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// Adapts Firebase Analytics to [feature_usage.NativeUsageBackend].
///
/// Only construct this on platforms Firebase Analytics actually supports
/// (Android, iOS, macOS, Web). Never construct it on Windows/Linux, so the
/// Firebase packages never get exercised there.
class FirebaseAnalyticsBackend implements feature_usage.NativeUsageBackend {
  FirebaseAnalyticsBackend({this.firebaseOptions});

  final FirebaseOptions? firebaseOptions;
  FirebaseAnalytics? _analytics;

  @override
  Future<void> init() async {
    await Firebase.initializeApp(options: firebaseOptions);
    _analytics = FirebaseAnalytics.instance;
  }

  @override
  Future<void> setUserId(String userId) async {
    await _analytics?.setUserId(id: userId);
  }

  @override
  void logEvent(String name, Map<String, Object?>? parameters) {
    _analytics?.logEvent(name: name, parameters: parameters?.cast<String, Object>());
  }

  @override
  NavigatorObserver? createNavigatorObserver({
    feature_usage.ScreenNameExtractor nameExtractor = feature_usage.defaultNameExtractor,
    feature_usage.RouteFilter routeFilter = feature_usage.defaultRouteFilter,
    void Function(Object error)? onError,
  }) {
    final analytics = _analytics;
    if (analytics == null) return null;
    return FirebaseAnalyticsObserver(
      analytics: analytics,
      nameExtractor: nameExtractor,
      routeFilter: routeFilter,
      onError: onError == null ? null : (error) => onError(error),
    );
  }
}
