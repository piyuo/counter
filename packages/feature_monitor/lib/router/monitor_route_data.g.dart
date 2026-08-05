// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$dummyRouteData, $visionRouteData];

RouteBase get $dummyRouteData => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $DummyRouteData._fromState,
);

mixin $DummyRouteData on GoRouteData {
  static DummyRouteData _fromState(GoRouterState state) =>
      const DummyRouteData();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $visionRouteData => GoRouteData.$route(
  path: '/vision',
  hasOverriddenOnExit: false,
  factory: $VisionRouteData._fromState,
);

mixin $VisionRouteData on GoRouteData {
  static VisionRouteData _fromState(GoRouterState state) =>
      const VisionRouteData();

  @override
  String get location => GoRouteData.$location('/vision');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
