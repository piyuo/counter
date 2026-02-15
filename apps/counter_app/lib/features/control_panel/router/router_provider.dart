import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/feature_onboarding.dart' as feature_onboarding;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/no_camera_screen.dart';
import '../screens/wizard_screen.dart';
import 'route_mapper.dart';

const _kRoot = '/';
const kOnboarding = '/onboarding';
const kNoCamera = '/no-camera';

class AppRouterConfig {
  const AppRouterConfig({this.appLocale, this.initialLocation = '/'});

  final Locale? appLocale;
  final String initialLocation;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppRouterConfig && other.appLocale == appLocale && other.initialLocation == initialLocation);
  }

  @override
  int get hashCode => Object.hash(appLocale, initialLocation);
}

final appRouterProvider = Provider.family<GoRouter, AppRouterConfig>((ref, config) {
  final lifecycle = ref.watch(core_domain.lifecycleProvider);

  final router = GoRouter(
    initialLocation: config.initialLocation,
    routes: [
      // todo: use go_router_builder when start to implement the route parameters
      GoRoute(
        path: _kRoot,
        builder: (context, state) {
          return WizardScreen(appLocale: config.appLocale, scrollController: ScrollController());
        },
      ),
      GoRoute(
        path: kOnboarding,
        builder: (context, state) {
          return feature_onboarding.OnboardingScreen(scrollController: ScrollController());
        },
      ),
      GoRoute(
        path: kNoCamera,
        builder: (context, state) {
          return NoCameraScreen(scrollController: ScrollController());
        },
      ),
    ],

    redirect: (context, state) {
      final target = routeFromLifecycle(lifecycle);

      if (target == null || state.uri.path == target) {
        return null;
      }

      return target;
    },
  );

  ref.onDispose(router.dispose);

  return router;
});
