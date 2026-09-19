import 'package:flutter/widgets.dart';

import 'feature_usage_controller.dart';
import 'predefined_events.dart';
import 'usage_backend.dart';

/// Reports screen views by intercepting Flutter navigation events.
///
/// Delegates to the [nativeBackend]'s own [NavigatorObserver] when one is
/// available; otherwise (or additionally, if [alwaysSendScreenViewCust] is
/// true) sends a custom [PredefinedEvents.screenViewCust] event via
/// whichever backend is active.
class FeatureUsageObserver extends RouteObserver<ModalRoute<dynamic>> {
  FeatureUsageObserver({
    this.nameExtractor = defaultNameExtractor,
    this.routeFilter = defaultRouteFilter,
    this.alwaysSendScreenViewCust = false,
    void Function(Object error)? onError,
  }) {
    _nativeObserver = nativeBackend?.createNavigatorObserver(
      nameExtractor: nameExtractor,
      routeFilter: routeFilter,
      onError: onError,
    );
  }

  NavigatorObserver? _nativeObserver;
  final ScreenNameExtractor nameExtractor;
  final RouteFilter routeFilter;
  final bool alwaysSendScreenViewCust;

  void _sendScreenView(Route<dynamic> route) {
    assert(route.settings.name != null, 'Route name cannot be null');
    final name = route.settings.name;
    if (name == null) return;
    sendEvent(name: PredefinedEvents.screenViewCust, parameters: {'screen_name': name});
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (!isUsageInitialized || isUsageDisabled) return;

    super.didPush(route, previousRoute);
    if (_nativeObserver != null) {
      _nativeObserver!.didPush(route, previousRoute);
      if (!alwaysSendScreenViewCust) return;
    }
    if (routeFilter(route)) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (!isUsageInitialized || isUsageDisabled) return;

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (_nativeObserver != null) {
      _nativeObserver!.didReplace(newRoute: newRoute, oldRoute: oldRoute);
      if (!alwaysSendScreenViewCust) return;
    }
    if (newRoute != null && routeFilter(newRoute)) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (!isUsageInitialized || isUsageDisabled) return;

    super.didPop(route, previousRoute);
    if (_nativeObserver != null) {
      _nativeObserver!.didPop(route, previousRoute);
      if (!alwaysSendScreenViewCust) return;
    }
    if (previousRoute != null && routeFilter(previousRoute) && routeFilter(route)) {
      _sendScreenView(previousRoute);
    }
  }
}
