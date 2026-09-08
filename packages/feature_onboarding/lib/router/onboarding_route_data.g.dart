// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$onboardingRouteData, $cTARouteData];

RouteBase get $onboardingRouteData => GoRouteData.$route(
  path: '/onboarding',
  hasOverriddenOnExit: false,
  factory: $OnboardingRouteData._fromState,
  routes: [
    GoRouteData.$route(
      path: 'intro_privacy',
      hasOverriddenOnExit: false,
      factory: $OnboardingIntroPrivacyRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'intro_collect',
          hasOverriddenOnExit: false,
          factory: $OnboardingIntroCollectRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: 'camera_test',
              hasOverriddenOnExit: false,
              factory: $CameraTestRouteData._fromState,
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

mixin $OnboardingIntroPrivacyRouteData on GoRouteData {
  static OnboardingIntroPrivacyRouteData _fromState(GoRouterState state) =>
      const OnboardingIntroPrivacyRouteData();

  @override
  String get location => GoRouteData.$location('/onboarding/intro_privacy');

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

mixin $OnboardingIntroCollectRouteData on GoRouteData {
  static OnboardingIntroCollectRouteData _fromState(GoRouterState state) =>
      const OnboardingIntroCollectRouteData();

  @override
  String get location =>
      GoRouteData.$location('/onboarding/intro_privacy/intro_collect');

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

mixin $CameraTestRouteData on GoRouteData {
  static CameraTestRouteData _fromState(GoRouterState state) =>
      const CameraTestRouteData();

  @override
  String get location => GoRouteData.$location(
    '/onboarding/intro_privacy/intro_collect/camera_test',
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

RouteBase get $cTARouteData => GoRouteData.$route(
  path: '/cta',
  hasOverriddenOnExit: false,
  factory: $CTARouteData._fromState,
  routes: [
    GoRouteData.$route(
      path: 'cta_subscription',
      hasOverriddenOnExit: false,
      factory: $SubscriptionRouteData._fromState,
    ),
    GoRouteData.$route(
      path: 'cta_invitation',
      hasOverriddenOnExit: false,
      factory: $InvitationRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'cta_invitation_success',
          hasOverriddenOnExit: false,
          factory: $InvitationSuccessRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'cta_personal_piyuo',
      hasOverriddenOnExit: false,
      factory: $PersonalPiyuoRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'cta_personal_piyuo_success',
          hasOverriddenOnExit: false,
          factory: $PersonalPiyuoSuccessRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'cta_personal_custom',
      hasOverriddenOnExit: false,
      factory: $PersonalCustomRouteData._fromState,
      routes: [
        GoRouteData.$route(
          path: 'cta_personal_custom_success',
          hasOverriddenOnExit: false,
          factory: $PersonalCustomSuccessRouteData._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'cta_local_only',
      hasOverriddenOnExit: false,
      factory: $LocalOnlyRouteData._fromState,
    ),
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

mixin $SubscriptionRouteData on GoRouteData {
  static SubscriptionRouteData _fromState(GoRouterState state) =>
      SubscriptionRouteData(nextPage: state.uri.queryParameters['next-page']!);

  SubscriptionRouteData get _self => this as SubscriptionRouteData;

  @override
  String get location => GoRouteData.$location(
    '/cta/cta_subscription',
    queryParams: {'next-page': _self.nextPage},
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

mixin $InvitationRouteData on GoRouteData {
  static InvitationRouteData _fromState(GoRouterState state) =>
      InvitationRouteData(token: state.uri.queryParameters['token']);

  InvitationRouteData get _self => this as InvitationRouteData;

  @override
  String get location => GoRouteData.$location(
    '/cta/cta_invitation',
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
  String get location =>
      GoRouteData.$location('/cta/cta_invitation/cta_invitation_success');

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

mixin $PersonalPiyuoRouteData on GoRouteData {
  static PersonalPiyuoRouteData _fromState(GoRouterState state) =>
      const PersonalPiyuoRouteData();

  @override
  String get location => GoRouteData.$location('/cta/cta_personal_piyuo');

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

mixin $PersonalPiyuoSuccessRouteData on GoRouteData {
  static PersonalPiyuoSuccessRouteData _fromState(GoRouterState state) =>
      PersonalPiyuoSuccessRouteData(url: state.uri.queryParameters['url']!);

  PersonalPiyuoSuccessRouteData get _self =>
      this as PersonalPiyuoSuccessRouteData;

  @override
  String get location => GoRouteData.$location(
    '/cta/cta_personal_piyuo/cta_personal_piyuo_success',
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

mixin $PersonalCustomRouteData on GoRouteData {
  static PersonalCustomRouteData _fromState(GoRouterState state) =>
      const PersonalCustomRouteData();

  @override
  String get location => GoRouteData.$location('/cta/cta_personal_custom');

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

mixin $PersonalCustomSuccessRouteData on GoRouteData {
  static PersonalCustomSuccessRouteData _fromState(GoRouterState state) =>
      PersonalCustomSuccessRouteData(url: state.uri.queryParameters['url']!);

  PersonalCustomSuccessRouteData get _self =>
      this as PersonalCustomSuccessRouteData;

  @override
  String get location => GoRouteData.$location(
    '/cta/cta_personal_custom/cta_personal_custom_success',
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

mixin $LocalOnlyRouteData on GoRouteData {
  static LocalOnlyRouteData _fromState(GoRouterState state) =>
      const LocalOnlyRouteData();

  @override
  String get location => GoRouteData.$location('/cta/cta_local_only');

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
