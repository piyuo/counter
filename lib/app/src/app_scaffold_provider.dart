import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:counter/app/app.dart' as routes;
import 'package:flutter/material.dart';

class PortalScaffoldProvider extends ChangeNotifier {
  Map<String, String> languages = {
    'en_US': 'English',
    'zh': '中文 (简体, 中国)',
    'zh_TW': '中文 (繁體, 台灣)',
  };

  Future<void> onLogoClicked(BuildContext context) async {
    context.beamToNamed(routes.indexPath);
  }

  Future<void> onSignInClicked(BuildContext context) async {
    context.beamToNamed(routes.signinPath);
  }

  Future<void> onSelectLanguage(BuildContext context, String? localeID) async {
    if (localeID != null) {
      //   final i18nProvider = i18n.I18nProvider.of(context);
      // await i18nProvider.overrideLocaleTemporary(i18n.stringToLocale(localeID));
      notifyListeners();
    }
  }
}
