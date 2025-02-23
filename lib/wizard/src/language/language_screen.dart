import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';

import 'language.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    this.previousPageTitle,
    super.key,
  });

  /// The title of the previous page.
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    final languageProvider = app.LanguageProvider.of(context);
    final languages = [
      Language(null, 'System'),
      ...Language.fromSupportedLocales(context),
    ];
    return pip.PipScaffold(
      previousPageTitle: previousPageTitle,
      child: SingleChildScrollView(
        child: Column(
          children: [
            pip.PipHeader(
              child: Column(
                children: [
                  Icon(CupertinoIcons.globe, size: 44),
                  const SizedBox(height: 8.0),
                  Text(context.l.language_screen_language, style: const TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            CupertinoListSection(
              children: languages
                  .map((language) => CupertinoListTile(
                        title: Text(language.name),
                        leading: language.locale == languageProvider.locale
                            ? Icon(CupertinoIcons.checkmark)
                            : SizedBox.shrink(),
                        onTap: () async {
                          await languageProvider.setLocale(language.locale);
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
