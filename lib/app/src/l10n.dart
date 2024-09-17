import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

extension L10nBuildContext on BuildContext {
  /// l10n return AppLocalizations of current context
  ///
  ///     context.l10n;
  ///
  AppLocalizations get l10n => Localizations.of<AppLocalizations>(this, AppLocalizations) ?? AppLocalizationsEn();
}
