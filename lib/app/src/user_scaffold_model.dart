import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as routes;
import 'package:flutter/material.dart';

class UserScaffoldProvider extends ChangeNotifier {
  Future<void> onLogoClicked(BuildContext context) async {
    context.beamToNamed(routes.dashboardPath);
  }

  Future<void> onSettingsClicked(BuildContext context) async {}

  Future<void> onUserClicked(BuildContext context) async {}
}
