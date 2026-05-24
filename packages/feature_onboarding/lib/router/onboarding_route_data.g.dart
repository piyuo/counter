// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$onboardingRouteData, $cTARouteData];

RouteBase get $onboardingRouteData => GoRouteData.$route(
  path: '/onboarding',
  factory: $OnboardingRouteData._fromState,
  routes: [
    GoRouteData.$route(
      path: '1',
      factory: $Onboarding1RouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: '2',
          factory: $Onboarding2RouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: 'system',
              factory: $SystemRouteData._fromState,
            ),
          ],
        ),
      ],
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

mixin $Onboarding1RouteData on GoRouteData {
  static Onboarding1RouteData _fromState(GoRouterState state) =>
      const Onboarding1RouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/1');

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

mixin $Onboarding2RouteData on GoRouteData {
  static Onboarding2RouteData _fromState(GoRouterState state) =>
      const Onboarding2RouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/1/2');

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

mixin $SystemRouteData on GoRouteData {
  static SystemRouteData _fromState(GoRouterState state) =>
      const SystemRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/1/2/system');

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

RouteBase get $cTARouteData => GoRouteData.$route(
  path: '/cta',
  factory: $CTARouteData._fromState,
  routes: [
    GoRouteData.$route(
      path: 'piyuo-subscription',
      factory: $PiyuoSubscriptionRouteData._fromState,
    ),
    GoRouteData.$route(
      path: 'server-subscription',
      factory: $ServerSubscriptionRouteData._fromState,
    ),
    GoRouteData.$route(
      path: 'invitation',
      factory: $InvitationRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'success',
          factory: $InvitationSuccessRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'piyuo', factory: $PiyuoRouteData._fromState),
    GoRouteData.$route(
      path: 'server',
      factory: $ServerRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'success',
          factory: $ServerSuccessRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'demo', factory: $DemoRouteData._fromState),
  ],
);

mixin $CTARouteData on GoRouteData {
  static CTARouteData _fromState(GoRouterState state) => const CTARouteData();

  @override
  String get location => GoRouteData.$location('/cta');

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

mixin $PiyuoSubscriptionRouteData on GoRouteData {
  static PiyuoSubscriptionRouteData _fromState(GoRouterState state) =>
      const PiyuoSubscriptionRouteData();

  @override
  String get location => GoRouteData.$location('/cta/piyuo-subscription');

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

mixin $ServerSubscriptionRouteData on GoRouteData {
  static ServerSubscriptionRouteData _fromState(GoRouterState state) =>
      const ServerSubscriptionRouteData();

  @override
  String get location => GoRouteData.$location('/cta/server-subscription');

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
    '/cta/invitation',
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

mixin $InvitationSuccessRouteData on GoRouteData {
  static InvitationSuccessRouteData _fromState(GoRouterState state) =>
      InvitationSuccessRouteData($extra: state.extra as Invitation?);

  InvitationSuccessRouteData get _self => this as InvitationSuccessRouteData;

  @override
  String get location => GoRouteData.$location('/cta/invitation/success');

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
  String get location => GoRouteData.$location('/cta/piyuo');

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
  String get location => GoRouteData.$location('/cta/server');

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

mixin $ServerSuccessRouteData on GoRouteData {
  static ServerSuccessRouteData _fromState(GoRouterState state) =>
      ServerSuccessRouteData(url: state.uri.queryParameters['url']!);

  ServerSuccessRouteData get _self => this as ServerSuccessRouteData;

  @override
  String get location => GoRouteData.$location(
    '/cta/server/success',
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
  String get location => GoRouteData.$location('/cta/demo');

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
