import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:vision/l10n/vision_localization.dart';

import 'language.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l = VisionLocalization.of(context);
    final languageProvider = app.LanguageProvider.of(context);
    final languages = [
      Language(null, 'System'),
      ...Language.fromSupportedLocales(context),
    ];
    return pip.PipScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            pip.PipHeader(
              child: Column(
                children: [
                  Icon(CupertinoIcons.globe, size: 44),
                  const SizedBox(height: 8.0),
                  Text(l.language_screen_language, style: const TextStyle(fontSize: 20.0)),
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
