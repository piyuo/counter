import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

import 'language.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    required this.scrollController,
    this.previousPageTitle,
    super.key,
  });

  /// The title of the previous page.
  final String? previousPageTitle;

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final languageProvider = vision.LanguageProvider.of(context);
    final languages = Language.fromSupportedLocales(context);

    return ChangeNotifierProvider<LanguageScreenProvider>(
        create: (_) => LanguageScreenProvider(),
        child: Consumer<LanguageScreenProvider>(builder: (context, languageScreenProvider, child) {
          return pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              controller: scrollController,
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
                              leading: language.locale.toString() == Intl.getCurrentLocale()
                                  ? Icon(CupertinoIcons.checkmark)
                                  : SizedBox.shrink(),
                              onTap: () async {
                                await languageProvider.setLocale(language.locale);
                              },
                            ))
                        .toList(),
                  ),
                  pip.PipFooter(),
                ],
              ),
            ),
          );
        }));
  }
}

/// provide language screen support
class LanguageScreenProvider with ChangeNotifier {
  LanguageScreenProvider();
}
