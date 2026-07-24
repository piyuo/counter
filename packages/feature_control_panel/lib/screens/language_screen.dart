import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({this.previousPageTitle, super.key});

  /// The title of the previous page.
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayLabels = appkit.localeDisplayLabels;
    final locale = ref.watch(appkit.localeProvider);
    final localization = appkit.Localization.of(context);
    return feature_pip.PipScaffold(
      previousPageTitle: previousPageTitle,
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            feature_pip.PipHeader(
              icon: Icons.language,
              title: context.l.settings_screen_language_title,
              subtitle: context.l.language_screen_subtitle,
            ),
            ListTile(
              title: Text(localization.language),
              subtitle: Text('using System Language'),
              leading: locale == null ? Icon(Icons.check) : SizedBox.shrink(),
              onTap: () async {
                ref.read(appkit.localeProvider.notifier).set(null);
              },
            ),

            ...displayLabels.entries.map((entry) {
              final currentLocaleKey = entry.key;
              final currentLocaleName = entry.value;
              final currentLocaleEngName = appkit.localeEngNames[currentLocaleKey] ?? locale.toString();
              final currentLocale = appkit.localeParseString(currentLocaleKey);

              return ListTile(
                title: Text(currentLocaleName),
                subtitle: Text(currentLocaleEngName),
                leading: currentLocale == locale ? Icon(Icons.check) : SizedBox.shrink(),
                onTap: () async {
                  ref.read(appkit.localeProvider.notifier).set(currentLocale);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
