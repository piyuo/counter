import 'package:counter/counter_app/counter_app.dart' as counter_app;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'no_camera/no_camera_screen.dart';
import 'onboarding/guide_screen.dart';
import 'route_mapper.dart';
import 'wizard_screen.dart';

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
  final appLifecycle = ref.watch(counter_app.appLifecycleProvider);

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
          return GuideScreen(scrollController: ScrollController());
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
      final target = routeFromLifecycle(appLifecycle);

      if (target == null || state.uri.path == target) {
        return null;
      }

      return target;
    },
  );

  ref.onDispose(router.dispose);

  return router;
});
