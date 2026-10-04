// ignore_for_file: prefer_const_constructors
import 'package:counter_app/control_panel/device_not_supported_screen.dart';
import 'package:counter_app/control_panel/widgets/control_panel_shell.dart';
import 'package:counter_app/monitor/widgets/monitor_shell.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

/// Global key for the control panel shell state,  make sure only one instance of control panel shell in the app, otherwise it may cause unexpected behavior.
final GlobalKey<ControlPanelShellState> _controlPanelKey = GlobalKey<ControlPanelShellState>();

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
          final rotationOrientation = ref.watch(vision.deviceRotationProvider).orientation;
          return vision.VisionLifecycle(
            child: feature_pip.PipScreen(
              rotationOrientation: rotationOrientation,
              slidingBuilder: (isPanelOpened) =>
                  ControlPanelShell(key: _controlPanelKey, appLocaleDelegates: appLocaleDelegates),
              builder: (isSideLayout) => MonitorShell(),
            ),
          );
        });
    }
  }
}
