import 'package:feature_analytic/feature_analytic.dart' as feature_analytic;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// Adapts Firebase Analytics to [feature_analytic.NativeAnalyticsBackend].
///
/// Only construct this on platforms Firebase Analytics actually supports
/// (Android, iOS, macOS, Web). Never construct it on Windows/Linux, so the
/// Firebase packages never get exercised there.
class FirebaseAnalyticsBackend implements feature_analytic.NativeAnalyticsBackend {
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
    feature_analytic.ScreenNameExtractor nameExtractor = feature_analytic.defaultNameExtractor,
    feature_analytic.RouteFilter routeFilter = feature_analytic.defaultRouteFilter,
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
