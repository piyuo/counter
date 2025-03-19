import 'package:counter/l10n/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:locale_names/locale_names.dart';

class Language {
  final Locale locale;
  final String name;

  Language(this.locale, this.name);

  static List<Language> fromSupportedLocales(BuildContext context) {
    return Localization.supportedLocales.map((locale) {
      String name = locale.nativeDisplayLanguage;
      if (locale.nativeDisplayCountry.isNotEmpty) {
        name += ' (${locale.nativeDisplayCountry})';
      }
      return Language(locale, name);
    }).toList();
  }
}
