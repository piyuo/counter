// ignore_for_file: prefer_const_constructors
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/feature_control_panel.dart' as feature_control_panel;
import 'package:feature_monitor/feature_monitor.dart' as feature_monitor;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

/// Global key for the control panel shell state,  make sure only one instance of control panel shell in the app, otherwise it may cause unexpected behavior.
final GlobalKey<feature_control_panel.ControlPanelShellState> _controlPanelKey =
    GlobalKey<feature_control_panel.ControlPanelShellState>();

class AppRouter {
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
    WidgetRef ref,
    List<LocalizationsDelegate<dynamic>> appLocaleDelegates,
  ) {
    Route<dynamic> buildRoute(WidgetBuilder builder) {
      return MaterialPageRoute(settings: settings, builder: builder, fullscreenDialog: false);
    }

    switch (settings.name) {
      case '/':
      default:
        return buildRoute((_) {
          final deviceOrientation = ref.watch(vision.deviceRotationProvider).orientation;

          final locale = ref.watch(appkit.localeProvider);
          final appFlow = ref.watch(core_domain.appFlowProvider);
          return appkit.GlobalContext(
            child: vision.VisionLifecycle(
              child: vision.LightOutWatcher(
                child: feature_pip.PipScreen(
                  deviceOrientation: deviceOrientation,
                  isLockToPortrait: ref.watch(core_domain.portraitOrientationProvider),
                  slidingBuilder: (isPanelOpened) => feature_control_panel.ControlPanelShell(
                    key: _controlPanelKey,
                    appLocaleDelegates: appLocaleDelegates,
                  ),
                  builder: (isSideLayout) => feature_monitor.MonitorShell(),
                ),
              ),
            ),
          );
        });
    }
  }
}
