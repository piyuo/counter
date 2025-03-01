import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

import 'project/video_sources.dart';
import 'wizard_navigator.dart';

class WizardScreen extends StatelessWidget {
  const WizardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageTitle = 'piyuo.com';
    return ChangeNotifierProvider<WelcomeScreenProvider>(
      create: (_) => WelcomeScreenProvider()..init(),
      child: Consumer2<app.ProjectProvider, WelcomeScreenProvider>(
        builder: (context, projectProvider, homeScreenProvider, child) {
          return pip.PipScaffold(
            titleWidget: Align(
              alignment: Alignment.centerLeft,
              child: Text(pageTitle, style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/icon/icon.png'),
                          width: 55,
                          height: 55,
                        ),
                        const SizedBox(height: 8.0),
                        Text(context.l.product_name,
                            style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Text(context.l.wizard_screen_desc,
                            style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
                      ],
                    ),
                  ),
                  ChangeNotifierProvider<VideoSourcesProvider>(
                      create: (_) => VideoSourcesProvider(),
                      child: Consumer<VideoSourcesProvider>(
                          builder: (context, videoStarterProvider, child) => CupertinoListSection(
                                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                                header: Text(context.l.wizard_screen_new_project_from),
                                children: buildVideoSources(
                                  context,
                                  videoSourcesProvider: videoStarterProvider,
                                  projectProvider: projectProvider,
                                  isAddMode: false,
                                ),
                              ))),
                  CupertinoListSection(
                    header: Text(context.l.wizard_screen_open_projects_tip),
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                          leading: Icon(CupertinoIcons.archivebox),
                          title: Text(context.l.wizard_screen_open_projects),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).pushNamed(openProjectRoute, arguments: {
                              'previousPageTitle': pageTitle,
                            });
                          }),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(pageTitle),
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                          leading: Icon(CupertinoIcons.info),
                          additionalInfo: Text(homeScreenProvider.appVersion),
                          title: Text(context.l.wizard_screen_about),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).pushNamed(aboutRoute, arguments: {
                              'previousPageTitle': pageTitle,
                            });
                          }),
                      CupertinoListTile(
                          leading: Icon(CupertinoIcons.globe),
                          title: Text(context.l.wizard_screen_language),
                          additionalInfo: Text(vision.LanguageProvider.of(context).getLanguage(context)),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).pushNamed(languageRoute, arguments: {
                              'previousPageTitle': pageTitle,
                            });
                          }),
                    ],
                  ),
                  pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide welcome screen support
class WelcomeScreenProvider with ChangeNotifier {
  /// The version of vision app used.
  String appVersion = '';

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    notifyListeners();
  }
}
