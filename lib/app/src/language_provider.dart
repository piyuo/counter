import 'package:flutter/cupertino.dart';
import 'package:locale_names/locale_names.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provide language support
class LanguageProvider with ChangeNotifier {
  /// current locale
  Locale? _locale;

  /// get current locale
  Locale? get locale => _locale;

  /// get a language provider
  static LanguageProvider of(BuildContext context) {
    return Provider.of<LanguageProvider>(context, listen: false);
  }

  /// get language name
  String getLanguage(BuildContext context) {
    if (_locale == null) {
      return 'System';
    }
    return _locale!.nativeDisplayLanguage;
  }

  /// load locale from shared preferences
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code');
    final countryCode = prefs.getString('country_code');
    if (languageCode != null) {
      _locale = Locale(languageCode, countryCode);
    }
    notifyListeners();
  }

  /// set locale to shared preferences
  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('language_code');
      await prefs.remove('country_code');
    } else {
      await prefs.setString('language_code', locale.languageCode);
      if (locale.countryCode != null) {
        await prefs.setString('country_code', locale.countryCode!);
      }
    }
    notifyListeners();
  }
}
