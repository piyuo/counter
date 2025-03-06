import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';

import 'about/about_screen.dart';
import 'about/benchmark_screen.dart';
import 'about/opencv_screen.dart';
import 'language/language_screen.dart';
import 'project/filter_screen.dart';
import 'project/open_project_screen.dart';
import 'project/project_screen.dart';
import 'settings/add_source_screen.dart';
import 'settings/detection_screen.dart';
import 'settings/settings_screen.dart';
import 'settings/url_screen.dart';
import 'settings/webcam_screen.dart';
import 'source/camera_screen.dart';
import 'source/color_screen.dart';
import 'source/counter_screen.dart';
import 'source/objects_screen.dart';
import 'source/source_screen.dart';
import 'source/zone_screen.dart';
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
const addSourceRoute = '/addSource';

/// The video source route
const sourceRoute = '/source';

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

class WizardNavigator extends StatefulWidget {
  const WizardNavigator({
    required this.onScroll,
    this.initialRoute,
    super.key,
  });

  final String? initialRoute;

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  @override
  State<WizardNavigator> createState() => _WizardNavigatorState();
}

class _WizardNavigatorState extends State<WizardNavigator> {
  @override
  void initState() {
    super.initState();
    final projectProvider = app.ProjectProvider.of(context);
    projectProvider.wizardStreamController.stream.listen((command) {
      switch (command.wizardCommands) {
        case app.WizardCommands.showVideoSettings:
          if (context.mounted) {
            gotoSourceRoute(projectProvider: projectProvider, videoProvider: command.arguments);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          //projectProvider.currentWizardRouteScrollOffset = notification.metrics.pixels;

          // 当子 widget 滚动时，更新父 widget 的滚动位置
          //if (notification.depth == 0) {
          //  widget.scrollController!.jumpTo(notification.metrics.pixels);
          // }
          return false; // 允许通知继续冒泡
        },
        child: Navigator(
          key: projectProvider.navigatorKey,
          initialRoute: '/',
          onGenerateRoute: (routeSettings) {
            final args = routeSettings.arguments as Map?;
            return CupertinoPageRoute(
              builder: (context) {
                switch (routeSettings.name) {
                  case '/':
                    return WizardScreen(onScroll: widget.onScroll);
                  case aboutRoute:
                    return AboutScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case benchmarkRoute:
                    return BenchmarkScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case opencvRoute:
                    return OpencvScreen();
                  case projectRoute:
                    return ProjectScreen();
                  case openProjectRoute:
                    return OpenProjectScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case languageRoute:
                    return LanguageScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case filterRoute:
                    return FilterScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case addSourceRoute:
                    return AddSourceScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case sourceRoute:
                    return SourceScreen(
                      previousPageTitle: args!['previousPageTitle'],
                      videoProvider: args['videoProvider'],
                    );
                  case settingsRoute:
                    return SettingsScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case cameraRoute:
                    return CameraScreen(
                      videoProvider: args!['videoProvider'],
                      isAddMode: args['isAddMode'],
                      previousPageTitle: args['previousPageTitle'],
                    );
                  case webcamRoute:
                    return WebcamScreen(
                      videoProvider: args!['videoProvider'],
                      isAddMode: args['isAddMode'],
                      previousPageTitle: args['previousPageTitle'],
                    );
                  case objectsRoute:
                    return ObjectsScreen(
                      videoProvider: args!['videoProvider'],
                      videoZone: args['videoZone'],
                    );
                  case tallyRoute:
                    return CounterScreen(
                      videoProvider: args!['videoProvider'],
                      videoZone: args['videoZone'],
                      annotation: args['annotation'],
                      previousPageTitle: args['previousPageTitle'],
                    );
                  case detectionRoute:
                    return DetectionScreen(
                      previousPageTitle: args!['previousPageTitle'],
                    );
                  case urlRoute:
                    return UrlScreen(
                      initialUrl: args?['url'] ?? '',
                      nextRouteBuilder: args?['nextRouteBuilder'],
                      previousPageTitle: args?['previousPageTitle'],
                    );
                  case colorRoute:
                    return ColorScreen(
                      previousPageTitle: args!['previousPageTitle'],
                      videoProvider: args['videoProvider'],
                      videoZone: args['videoZone'],
                    );
                  case zoneRoute:
                    return ZoneScreen(
                      previousPageTitle: args!['previousPageTitle'],
                      videoProvider: args['videoProvider'],
                      videoZone: args['videoZone'],
                    );
                  default:
                    return WizardScreen(onScroll: widget.onScroll);
                }
              },
            );
          },
        ));
  }
}

///  Navigate to the video source route
void gotoSourceRoute({
  required app.ProjectProvider projectProvider,
  required videoProvider,
  String? previousPageTitle,
}) async {
  await projectProvider.enterVideoScreen(videoProvider);
  try {
    await projectProvider.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      sourceRoute,
      (route) =>
          (route.isCurrent && route.settings.name == sourceRoute) ||
          route.settings.name == null ||
          route.settings.name == '/',
      arguments: {
        'videoProvider': videoProvider,
        'previousPageTitle': previousPageTitle,
      },
    );
  } finally {
    projectProvider.exitVideoScreen(videoProvider);
  }
}
