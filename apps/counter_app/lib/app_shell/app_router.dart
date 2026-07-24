// ignore_for_file: prefer_const_constructors
import 'package:counter_app/app_shell/device_not_supported_screen.dart';
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
      case '/device_not_supported':
        return buildRoute((_) => const DeviceNotSupportedScreen());
      case '/':
      default:
        return buildRoute((_) {
          final deviceOrientation = ref.watch(vision.deviceRotationProvider).orientation;
          // only watch lockOrientation in visState
          final lockOrientation = ref.watch(vision.visionProvider.select((state) => state.lockOrientation));
          final isLockToHorizontal = switch (lockOrientation) {
            vision.LockOrientation.portrait => false,
            vision.LockOrientation.landscape => true,
            _ => null,
          };

          return appkit.GlobalContext(
            child: vision.VisionLifecycle(
              child: feature_pip.PipScreen(
                deviceOrientation: deviceOrientation,
                //                isDeviceLockToPortrait: ref.watch(core_domain.portraitOrientationProvider),
                isVideoLockToHorizontal: isLockToHorizontal,
                slidingBuilder: (isPanelOpened) => feature_control_panel.ControlPanelShell(
                  key: _controlPanelKey,
                  appLocaleDelegates: appLocaleDelegates,
                ),
                builder: (isSideLayout) => feature_monitor.MonitorShell(),
              ),
            ),
          );
        });
    }
  }
}
