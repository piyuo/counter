import 'dart:ui' as ui;

import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/src/localization.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:counter/wizard/wizard.dart' as wizard;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:universal_platform/universal_platform.dart';

final GlobalKey<wizard.WizardAppState> wizardKey = GlobalKey<wizard.WizardAppState>();

void main() {
  appkit.appRun(
    (locale) {
      return MyApp(locale: locale);
    },
    errorCallback: (e) {
      if (e is PlatformException || e is MissingPluginException) {
        return false;
      }
      return true;
    },
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, this.locale});

  /// The locale to use for the app.
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    pip.SlidingPanelState getPanelPositionWhenProjectOpened() {
      final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      return isPortrait ? pip.SlidingPanelState.halfOpen : pip.SlidingPanelState.open;
    }

    final appLocaleDelegates = [
      Localization.delegate,
      appkit.Localization.delegate,
      vision.Localization.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];

    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider<app.ProjectProvider>(
          create: (context) => app.ProjectProvider(
            onDatabaseMaintain: () {},
            onClearActivities: (String projectId) async {},
            onProjectOpened: (_) async {
              final pipProvider = pip.PipProvider.of(appkit.globalContext);
              await Future.delayed(const Duration(seconds: 2)); // 2 seconds wait to avoid busy state when open project
              pipProvider.animatePanelToSnapPoint();
            },
            onProjectSave: (app.Project project, app.Video? video) async {},
            onGetProjectSummaries: () async {
              return [];
            },
            onGetProjectById: (String projectId) async {},
            onDeleteProject: (String projectId) async {},
          )..init(context),
        ),
        provider.ChangeNotifierProvider<pip.PipProvider>(
          create: (_) => pip.PipProvider()..init(const Duration(seconds: 2), getPanelPositionWhenProjectOpened()),
        ),
      ],
      child: CupertinoTheme(
        data: CupertinoThemeData(brightness: Brightness.dark),
        child: provider.Consumer2<app.ProjectProvider, pip.PipProvider>(
          builder: (context, projectProvider, pipProvider, child) {
            buildMainScreen() {
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
                  ),
                ),
              );
            }

            buildRoute({required RouteSettings settings, required Widget Function(BuildContext) builder}) {
              return UniversalPlatform.isAndroid
                  ? MaterialPageRoute(settings: settings, fullscreenDialog: false, builder: builder)
                  : CupertinoPageRoute(settings: settings, fullscreenDialog: false, builder: builder);
            }

            final defaultLocale = locale ?? appkit.localeSystem;
            final isRTL = Bidi.isRtlLanguage((locale ?? appkit.localeSystem).toString());
            return Directionality(
              textDirection: isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
              child: Localizations(
                locale: defaultLocale,
                delegates: appLocaleDelegates,
                child: Navigator(
                  initialRoute: '/',
                  onGenerateRoute: (routeSettings) {
                    return buildRoute(
                      settings: routeSettings,
                      builder: (_) {
                        switch (routeSettings.name) {
                          case '/':
                          default:
                            final locale = ref.watch(appkit.localeProvider);
                            return appkit.GlobalContext(
                              child: pip.PipScreen(
                                isLockToPortrait: projectProvider.isLockToPortrait,
                                slidingBuilder: (isPanelOpened) => wizard.WizardApp(
                                  key: wizardKey,
                                  appLocale: locale,
                                  appLocaleDelegates: appLocaleDelegates,
                                  pipProvider: pipProvider,
                                ),
                                builder: (isSideLayout) => Overlay(
                                  initialEntries: [
                                    OverlayEntry(
                                      builder: (context) => app.ProjectView(
                                        noProjectScreen: buildMainScreen(),
                                        isSideLayout: isSideLayout,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        }
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
