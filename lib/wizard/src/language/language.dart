import 'package:flutter/cupertino.dart';
import 'package:locale_names/locale_names.dart';
import 'package:vision/l10n/vision_localization.dart';

class Language {
  final Locale? locale;
  final String name;

  Language(this.locale, this.name);

  static List<Language> fromSupportedLocales(BuildContext context) {
    return VisionLocalization.supportedLocales.map((locale) {
      String name = locale.nativeDisplayLanguage;
      if (locale.nativeDisplayCountry.isNotEmpty) {
        name += ' (${locale.nativeDisplayCountry})';
      }
      return Language(locale, name);
    }).toList();
  }
}
