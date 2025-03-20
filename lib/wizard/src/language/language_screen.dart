import 'package:counter/l10n/l10n.dart';
import 'package:counter/l10n/localization.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:libcli/cli/cli.dart' as cli;
import 'package:provider/provider.dart';

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
    final languageProvider = cli.LanguageProvider.of(context);
    final languages = cli.Language.fromSupportedLocales(Localization.supportedLocales);

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
                              subtitle: Text(language.engName),
                              leading: language.locale == cli.defaultLocale
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
