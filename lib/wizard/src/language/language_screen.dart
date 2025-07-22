import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

class LanguageScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final displayLabels = appkit.localeDisplayLabels;
    final locale = ref.watch(appkit.localeProvider);
    final libcliLocalization = appkit.Localization.of(context);
    //final languageProvider = cli.LanguageProvider.of(context);
    //final languages = cli.Language.fromSupportedLocales(Localization.supportedLocales);
    //final cliLocalization = cli_localization.Localization.of(context);
    //final value = cli.isSystemLocale ? Locale(' ') : cli.defaultLocale;
    return provider.ChangeNotifierProvider<LanguageScreenProvider>(
        create: (_) => LanguageScreenProvider(),
        child: provider.Consumer<LanguageScreenProvider>(builder: (context, languageScreenProvider, child) {
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
                        title: Text(libcliLocalization.language),
                        subtitle: Text('System language'),
                        leading: locale == Locale(' ') ? Icon(CupertinoIcons.checkmark) : SizedBox.shrink(),
                        onTap: () async {
                          ref.read(appkit.localeProvider.notifier).set(Locale(' '));
                        },
                      ),
                      ...displayLabels.entries.map((entry) {
                        final currentLocaleKey = entry.key;
                        final currentLocaleName = entry.value;
                        final currentLocaleEngName = appkit.localeEngNames[currentLocaleKey] ?? locale.toString();
                        final currentLocale = appkit.localeParseString(currentLocaleKey);

                        return CupertinoListTile(
                          title: Text(currentLocaleName),
                          subtitle: Text(currentLocaleEngName),
                          leading: currentLocale == locale ? Icon(CupertinoIcons.checkmark) : SizedBox.shrink(),
                          onTap: () async {
                            ref.read(appkit.localeProvider.notifier).set(currentLocale);
                          },
                        );
                      })
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
