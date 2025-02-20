import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'home/video_starter.dart';
import 'wizard_navigator.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProvider>(
      create: (_) => HomeScreenProvider()..init(),
      child: Consumer2<app.ProjectProvider, HomeScreenProvider>(
        builder: (context, projectProvider, homeScreenProvider, child) {
          return pip.PipScaffold(
            title: context.l.welcome_screen_title,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.person_3, size: 44),
                        const SizedBox(height: 8.0),
                        Text(context.l.welcome_screen_people_counting, style: const TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  ChangeNotifierProvider<VideoStarterProvider>(
                      create: (_) => VideoStarterProvider(),
                      child: Consumer<VideoStarterProvider>(
                          builder: (context, videoStarterProvider, child) => CupertinoListSection(
                                backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                                header: Text(context.l.welcome_screen_new_project_from),
                                children: buildVideoStarter(
                                  context,
                                  videoStarterProvider: videoStarterProvider,
                                  projectProvider: projectProvider,
                                  isAddMode: false,
                                ),
                              ))),
                  CupertinoListSection(
                    header: Text(context.l.welcome_screen_title),
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                          leading: Icon(CupertinoIcons.globe),
                          title: Text(context.l.welcome_screen_language),
                          additionalInfo: Text(app.LanguageProvider.of(context).getLanguage(context)),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).pushNamed(languageRoute);
                          }),
                      CupertinoListTile(
                          leading: Icon(CupertinoIcons.info),
                          additionalInfo: Text(homeScreenProvider.appVersion),
                          title: Text(context.l.welcome_screen_about),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).pushNamed(aboutRoute);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// provide home screen support
class HomeScreenProvider with ChangeNotifier {
  /// The version of vision app used.
  String appVersion = '';

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    notifyListeners();
  }
}
