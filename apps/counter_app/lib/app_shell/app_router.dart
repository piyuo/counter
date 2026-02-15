// ignore_for_file: prefer_const_constructors
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:counter_app/app_shell/screens/main_screen.dart';
import 'package:counter_app/features/control_panel/control_panel.dart' as control_panel;
import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:universal_platform/universal_platform.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
    WidgetRef ref,
    app.ProjectProvider projectProvider,
    GlobalKey<control_panel.ControlPanelShellState> wizardKey,
    List<LocalizationsDelegate<dynamic>> appLocaleDelegates,
  ) {
    Route<dynamic> buildRoute(WidgetBuilder builder) {
      if (UniversalPlatform.isAndroid) {
        return MaterialPageRoute(settings: settings, builder: builder, fullscreenDialog: false);
      }
      return CupertinoPageRoute(settings: settings, builder: builder, fullscreenDialog: false);
    }

    final lifecycle = ref.watch(core_domain.lifecycleProvider);

    switch (settings.name) {
      case '/':
      default:
        return buildRoute((_) {
          final locale = ref.watch(appkit.localeProvider);
          return appkit.GlobalContext(
            child: vision.VisionLifecycle(
              child: feature_pip.PipScreen(
                defaultSidebarBackgroundColor: lifecycle.isOnboarding ? CupertinoColors.white : CupertinoColors.black,
                isLockToPortrait: projectProvider.isLockToPortrait,
                slidingBuilder: (isPanelOpened) => control_panel.ControlPanelShell(
                  key: wizardKey,
                  appLocale: locale,
                  appLocaleDelegates: appLocaleDelegates,
                ),
                builder: (isSideLayout) =>
                    app.ProjectView(noProjectScreen: const MainScreen(), isSideLayout: isSideLayout),
              ),
            ),
          );
        });
    }
  }
}
