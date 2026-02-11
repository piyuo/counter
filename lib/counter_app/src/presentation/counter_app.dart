import 'dart:async';

import 'package:counter/control_panel/control_panel.dart' as control_panel;
import 'package:counter/l10n/src/localization.dart';
import 'package:counter/monitor/monitor.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:provider/provider.dart' as provider;
import 'package:toastification/toastification.dart';
import 'package:universal_platform/universal_platform.dart';

import '../providers/app_lifecycle_notifier.dart';
import 'app_lifecycle_extension.dart';

final GlobalKey<control_panel.ControlPanelShellState> wizardKey = GlobalKey<control_panel.ControlPanelShellState>();

class CounterApp extends ConsumerStatefulWidget {
  const CounterApp({super.key, this.locale});

  /// The locale to use for the app.
  final Locale? locale;

  @override
  ConsumerState<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends ConsumerState<CounterApp> {
  @override
  Widget build(BuildContext context) {
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
            onGetProjectById: (String projectId) async {
              return null;
            },
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

            // app lifecycle start
            final appLifecycle = ref.watch(appLifecycleProvider);
            final defaultLocale = widget.locale ?? appkit.localeSystem;
            return ToastificationWrapper(
              child: MaterialApp(
                navigatorKey: projectProvider.navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: defaultLocale,
                localizationsDelegates: appLocaleDelegates,
                supportedLocales: Localization.supportedLocales,
                localeResolutionCallback: appkit.localeResolutionCallback,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: CupertinoColors.activeBlue),
                  brightness: Brightness.dark,
                  cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark),
                  useMaterial3: true,
                ),
                navigatorObservers: [pipProvider.scrollObserver],
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
                            child: vision.VisionLifecycle(
                              child: pip.PipScreen(
                                defaultSidebarBackgroundColor: appLifecycle.isOnboarding
                                    ? CupertinoColors.white
                                    : CupertinoColors.black,
                                isLockToPortrait: projectProvider.isLockToPortrait,
                                slidingBuilder: (isPanelOpened) => control_panel.ControlPanelShell(
                                  key: wizardKey,
                                  appLocale: locale,
                                  appLocaleDelegates: appLocaleDelegates,
                                  pipProvider: pipProvider,
                                ),
                                builder: (isSideLayout) =>
                                    app.ProjectView(noProjectScreen: buildMainScreen(), isSideLayout: isSideLayout),
                              ),
                            ),
                          );
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
