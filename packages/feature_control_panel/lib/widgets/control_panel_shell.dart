import 'package:feature_control_panel/router/control_panel_router_provider.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlPanelShell extends ConsumerStatefulWidget {
  const ControlPanelShell({required this.appLocaleDelegates, this.initialRoute, super.key});

  /// the initial route
  final String? initialRoute;

  /// the localizations delegates
  final List<LocalizationsDelegate<dynamic>> appLocaleDelegates;

  @override
  ConsumerState<ControlPanelShell> createState() => ControlPanelShellState();
}

class ControlPanelShellState extends ConsumerState<ControlPanelShell> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(controlPanelRouterProvider(widget.initialRoute));

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final currentPath = router.state.uri.path;
        final pipController = ref.read(feature_pip.pipProvider.notifier);
        pipController.onScrollNotification(currentPath, notification);
        return false;
      },
      child: ClipRect(
        // clip rect is needed to prevent the navigator animation route from drawing outside the screen
        child: Router(
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
