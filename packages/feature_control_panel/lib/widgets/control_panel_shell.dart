import 'package:feature_control_panel/router/router_provider.dart';
import 'package:flutter/cupertino.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider(widget.initialRoute));
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
