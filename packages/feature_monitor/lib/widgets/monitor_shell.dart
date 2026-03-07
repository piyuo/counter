import 'package:feature_monitor/router/monitor_router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonitorShell extends ConsumerWidget {
  const MonitorShell({this.initialRoute, super.key});

  /// the initial route
  final String? initialRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(monitorRouterProvider(initialRoute));

    return ClipRect(
      // clip rect is needed to prevent the navigator animation route from drawing outside the screen
      child: Router(
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
