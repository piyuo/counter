import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/localization.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libcli/cli/cli.dart' as cli;
import 'package:universal_platform/universal_platform.dart';

import 'about/about_screen.dart';
import 'about/benchmark_screen.dart';
import 'about/opencv_screen.dart';
import 'language/language_screen.dart';
import 'project/detection_screen.dart';
import 'project/filter_screen.dart';
import 'project/objects_screen.dart';
import 'project/open_project_screen.dart';
import 'project/project_screen.dart';
import 'settings/settings_screen.dart';
import 'settings/url_screen.dart';
import 'video/add_video_screen.dart';
import 'video/camera_screen.dart';
import 'video/color_screen.dart';
import 'video/counter_screen.dart';
import 'video/video_screen.dart';
import 'video/webcam_screen.dart';
import 'video/zone_screen.dart';
import 'wizard_screen.dart';

/// The initial route
const initialRoute = '/';

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

class WizardApp extends StatefulWidget {
  const WizardApp({
    required this.appLocale,
    required this.appLocaleDelegates,
    required this.pipProvider,
    required this.isPanelOpened,
    this.initialRoute,
    super.key,
  });

  /// is the sliding panel opened?
  final bool isPanelOpened;

  /// the initial route
  final String? initialRoute;

  /// the pip provider
  final pip.PipProvider pipProvider;

  /// the app locale
  final Locale appLocale;

  /// the localizations delegates
  final List<LocalizationsDelegate<dynamic>> appLocaleDelegates;

  @override
  State<WizardApp> createState() => _WizardAppState();
}

class _WizardAppState extends State<WizardApp> {
  @override
  void initState() {
    super.initState();
    final projectProvider = app.ProjectProvider.of(context);
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
    final projectProvider = app.ProjectProvider.of(context);
    buildRoute({
      required RouteSettings settings,
      required Widget Function(BuildContext) builder,
    }) {
      return UniversalPlatform.isAndroid
          ? MaterialPageRoute(settings: settings, fullscreenDialog: false, builder: builder)
          : CupertinoPageRoute(settings: settings, fullscreenDialog: false, builder: builder);
    }

    return ClipRect(
        // clip rect is needed to prevent the navigator animation route from drawing outside the screen
        child: MaterialApp(
      navigatorKey: projectProvider.navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: widget.appLocale,
      localizationsDelegates: widget.appLocaleDelegates,
      supportedLocales: Localization.supportedLocales,
      localeResolutionCallback: cli.localeResolutionCallback,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: CupertinoColors.activeBlue,
        ),
        brightness: Brightness.dark,
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      navigatorObservers: [widget.pipProvider.scrollObserver],
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        final args = routeSettings.arguments as Map?;
        final scrollController = widget.pipProvider.getScrollController(routeSettings.name!);
        return buildRoute(
          settings: routeSettings,
          builder: (context) {
            switch (routeSettings.name) {
              case aboutRoute:
                return AboutScreen(scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case benchmarkRoute:
                return BenchmarkScreen(
                    scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case opencvRoute:
                return OpencvScreen(scrollController: scrollController);
              case projectRoute:
                return ProjectScreen(scrollController: scrollController);
              case openProjectRoute:
                return OpenProjectScreen(
                    scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case languageRoute:
                return LanguageScreen(
                    scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case filterRoute:
                return FilterScreen(scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case addVideoRoute:
                return AddVideoScreen(
                    scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case videoRoute:
                return VideoScreen(
                    scrollController: scrollController,
                    previousPageTitle: args!['previousPageTitle'],
                    videoProvider: args['videoProvider']);
              case settingsRoute:
                return SettingsScreen(
                    scrollController: scrollController, previousPageTitle: args!['previousPageTitle']);
              case cameraRoute:
                return CameraScreen(
                    scrollController: scrollController,
                    videoProvider: args!['videoProvider'],
                    isAddMode: args['isAddMode'],
                    previousPageTitle: args['previousPageTitle']);
              case webcamRoute:
                return WebcamScreen(
                    scrollController: scrollController,
                    videoProvider: args!['videoProvider'],
                    isAddMode: args['isAddMode'],
                    previousPageTitle: args['previousPageTitle']);
              case objectsRoute:
                return ObjectsScreen(
                  scrollController: scrollController,
                  videoProvider: args!['videoProvider'],
                );
              case tallyRoute:
                return CounterScreen(
                    scrollController: scrollController,
                    videoProvider: args!['videoProvider'],
                    videoZone: args['videoZone'],
                    annotation: args['annotation'],
                    previousPageTitle: args['previousPageTitle']);
              case detectionRoute:
                return DetectionScreen(
                    scrollController: scrollController,
                    videoProvider: args!['videoProvider'],
                    previousPageTitle: args['previousPageTitle']);
              case urlRoute:
                return UrlScreen(
                    scrollController: scrollController,
                    initialUrl: args?['url'] ?? '',
                    nextRouteBuilder: args?['nextRouteBuilder'],
                    previousPageTitle: args?['previousPageTitle']);
              case colorRoute:
                return ColorScreen(
                    scrollController: scrollController,
                    previousPageTitle: args!['previousPageTitle'],
                    videoProvider: args['videoProvider'],
                    videoZone: args['videoZone']);
              case zoneRoute:
                return ZoneScreen(
                  scrollController: scrollController,
                  previousPageTitle: args!['previousPageTitle'],
                  videoProvider: args['videoProvider'],
                  videoZone: args['videoZone'],
                );
              case '/':
              default:
                return WizardScreen(
                  isPanelOpened: widget.isPanelOpened,
                  scrollController: scrollController,
                );
            }
          },
        );
      },
    ));
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
      arguments: {
        'videoProvider': videoProvider,
        'previousPageTitle': previousPageTitle,
      },
    );
  } finally {
    projectProvider.exitVideoScreen(videoProvider);
  }
}
