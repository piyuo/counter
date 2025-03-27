import 'package:counter/l10n/l10n.dart';
import 'package:counter/l10n/localization.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:libcli/cli/cli.dart' as cli;
import 'package:libcli/l10n/localization.dart' as cli_localization;
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
    final cliLocalization = cli_localization.Localization.of(context);
    final value = cli.isSystemLocale ? Locale(' ') : cli.defaultLocale;
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
                    children: [
                      CupertinoListTile(
                        title: Text(cliLocalization.system_language),
                        subtitle: Text('System language'),
                        leading: value == Locale(' ') ? Icon(CupertinoIcons.checkmark) : SizedBox.shrink(),
                        onTap: () async {
                          await languageProvider.setLocale(Locale(' '));
                        },
                      ),
                      ...languages.map((language) => CupertinoListTile(
                            title: Text(language.name),
                            subtitle: Text(language.engName),
                            leading: language.locale == value ? Icon(CupertinoIcons.checkmark) : SizedBox.shrink(),
                            onTap: () async {
                              await languageProvider.setLocale(language.locale);
                            },
                          ))
                    ],
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
