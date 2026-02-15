import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({required this.scrollController, this.previousPageTitle, super.key});

  /// The title of the previous page.
  final String? previousPageTitle;

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayLabels = appkit.localeDisplayLabels;
    final locale = ref.watch(appkit.localeProvider);
    final localization = appkit.Localization.of(context);
    return provider.ChangeNotifierProvider<LanguageScreenProvider>(
      create: (_) => LanguageScreenProvider(),
      child: provider.Consumer<LanguageScreenProvider>(
        builder: (context, languageScreenProvider, child) {
          return feature_pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  feature_pip.PipHeader(
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
                        title: Text(localization.language),
                        subtitle: Text('System language'),
                        leading: locale == null ? Icon(CupertinoIcons.checkmark) : SizedBox.shrink(),
                        onTap: () async {
                          ref.read(appkit.localeProvider.notifier).set(null);
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
                      }),
                    ],
                  ),
                  feature_pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide language screen support
class LanguageScreenProvider with ChangeNotifier {
  LanguageScreenProvider();
}
