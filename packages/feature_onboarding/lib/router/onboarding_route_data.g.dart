// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$onboardingRouteData];

RouteBase get $onboardingRouteData => GoRouteData.$route(
  path: '/onboarding',
  factory: $OnboardingRouteData._fromState,
  routes: [
    GoRouteData.$route(path: 'cta', factory: $CTARouteData._fromState),
    GoRouteData.$route(
      path: 'invitation',
      factory: $InvitationRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'summary',
          factory: $InvitationSummaryRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'piyuo', factory: $PiyuoRouteData._fromState),
    GoRouteData.$route(
      path: 'server',
      factory: $ServerRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'summary',
          factory: $ServerSummaryRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'demo', factory: $DemoRouteData._fromState),
    GoRouteData.$route(
      path: 'subscription',
      factory: $SubscriptionRouteData._fromState,
    ),
  ],
);

mixin $OnboardingRouteData on GoRouteData {
  static OnboardingRouteData _fromState(GoRouterState state) =>
      const OnboardingRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding');

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

mixin $CTARouteData on GoRouteData {
  static CTARouteData _fromState(GoRouterState state) => const CTARouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/cta');

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

mixin $InvitationRouteData on GoRouteData {
  static InvitationRouteData _fromState(GoRouterState state) =>
      InvitationRouteData(token: state.uri.queryParameters['token']);

  InvitationRouteData get _self => this as InvitationRouteData;

  @override
  String get location => GoRouteData.$location(
    '/onboarding/invitation',
    queryParams: {if (_self.token != null) 'token': _self.token},
  );

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

mixin $InvitationSummaryRouteData on GoRouteData {
  static InvitationSummaryRouteData _fromState(GoRouterState state) =>
      InvitationSummaryRouteData($extra: state.extra as Invitation?);

  InvitationSummaryRouteData get _self => this as InvitationSummaryRouteData;

  @override
  String get location =>
      GoRouteData.$location('/onboarding/invitation/summary');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $PiyuoRouteData on GoRouteData {
  static PiyuoRouteData _fromState(GoRouterState state) =>
      const PiyuoRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/piyuo');

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

mixin $ServerRouteData on GoRouteData {
  static ServerRouteData _fromState(GoRouterState state) =>
      const ServerRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/server');

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

mixin $ServerSummaryRouteData on GoRouteData {
  static ServerSummaryRouteData _fromState(GoRouterState state) =>
      ServerSummaryRouteData(url: state.uri.queryParameters['url']!);

  ServerSummaryRouteData get _self => this as ServerSummaryRouteData;

  @override
  String get location => GoRouteData.$location(
    '/onboarding/server/summary',
    queryParams: {'url': _self.url},
  );

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

mixin $DemoRouteData on GoRouteData {
  static DemoRouteData _fromState(GoRouterState state) => const DemoRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/demo');

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

mixin $SubscriptionRouteData on GoRouteData {
  static SubscriptionRouteData _fromState(GoRouterState state) =>
      const SubscriptionRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/subscription');

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
