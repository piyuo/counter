import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

import '../providers/app_version_provider.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get screen height
    final localeDisplayLabels = appkit.localeDisplayLabels;
    final localization = appkit.Localization.of(context);
    final currentLocalDisplayLabel = localization.language;
    final appVersion = ref.watch(appVersionProvider).asData?.value ?? '';

    final pageTitle = 'piyuo.com';

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              feature_pip.PipHeader(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    const SizedBox(width: 8.0),
                    Image(image: AssetImage('assets/icon/icon.png'), width: 48, height: 48),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            context.l.product_name,
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoListSection(
                header: Text(context.l.wizard_screen_open_projects_tip),
                backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                children: [
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.archivebox),
                    title: Text(context.l.wizard_screen_open_projects),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),
              CupertinoListSection(
                header: Text(pageTitle),
                backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                children: [
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.info),
                    additionalInfo: Text(appVersion),
                    title: Text(context.l.wizard_screen_about),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.globe),
                    title: Text(context.l.wizard_screen_language),
                    additionalInfo: Text(currentLocalDisplayLabel),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {
                      ref.read(core_domain.navigationEventBusProvider).add(const core_domain.OpenLanguage());
                    },
                  ),
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.mail),
                    title: Text(context.l.wizard_screen_email_us),
                    trailing: CupertinoListTileChevron(),
                    onTap: () {
                      appkit.netOpenMailTo('service@piyuo.com', '', '');
                    },
                  ),
                ],
              ),
              feature_pip.PipFooter(),
            ],
          ),
        );
      },
    );
  }
}
