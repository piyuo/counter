import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/router_provider.dart';

/// The initial route
const initialRoute = '/';

/// The example route
const exampleRoute = '/example';

/// The about route
const aboutRoute = '/about';

/// The benchmark route
const benchmarkRoute = '/benchmark';

/// The opencv route
const opencvRoute = '/opencv';

/// The add video source route
const addVideoRoute = '/addVideo';

/// The video source route
const videoRoute = '/video';

/// The camera route
const cameraRoute = '/camera';

/// The color route
const colorRoute = '/color';

/// The ai route
const detectionRoute = '/detection';

/// The filter route
const filterRoute = '/filter';

/// The language route
const languageRoute = '/language';

/// The objects route
const objectsRoute = '/objects';

/// The project route
const projectRoute = '/project';

/// The open project route
const openProjectRoute = '/openProject';

/// The settings route
const settingsRoute = '/settings';

/// The tally route
const tallyRoute = '/tally';

/// The url route
const urlRoute = '/url';

/// The webcam route
const webcamRoute = '/webcam';

/// The zone route
const zoneRoute = '/zone';

class ControlPanelShell extends ConsumerStatefulWidget {
  const ControlPanelShell({required this.appLocale, required this.appLocaleDelegates, this.initialRoute, super.key});

  /// the initial route
  final String? initialRoute;

  /// the app locale
  final Locale? appLocale;

  /// the localizations delegates
  final List<LocalizationsDelegate<dynamic>> appLocaleDelegates;

  @override
  ConsumerState<ControlPanelShell> createState() => ControlPanelShellState();
}

class ControlPanelShellState extends ConsumerState<ControlPanelShell> {
  @override
  void initState() {
    super.initState();
    final projectProvider = app.ProjectProvider.of(context);
    //todo: remove this
    projectProvider.wizardStreamController.stream.listen((command) {
      switch (command.wizardCommands) {
        case app.WizardCommands.showVideoSettings:
          _gotoVideoRoute(projectProvider: projectProvider, videoProvider: command.arguments);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(
      appRouterProvider(AppRouterConfig(appLocale: widget.appLocale, initialLocation: widget.initialRoute ?? '/')),
    );
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

///  Navigate to the video source route
void _gotoVideoRoute({
  required app.ProjectProvider projectProvider,
  required videoProvider,
  String? previousPageTitle,
}) async {
  await projectProvider.enterVideoScreen(videoProvider);
  try {
    await projectProvider.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      videoRoute,
      (route) =>
          (route.isCurrent && route.settings.name == videoRoute) ||
          route.settings.name == null ||
          route.settings.name == projectRoute,
      arguments: {'videoProvider': videoProvider, 'previousPageTitle': previousPageTitle},
    );
  } finally {
    projectProvider.exitVideoScreen(videoProvider);
  }
}
