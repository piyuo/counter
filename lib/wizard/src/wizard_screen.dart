import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'project/video_sources.dart';
import 'wizard_app.dart';

/// if the screen height is less than this value, use compact header
const double _headerHeightThreshold = 600;

class WizardScreen extends StatelessWidget {
  const WizardScreen({
    required this.scrollController,
    this.appLocale,
    super.key,
  });

  /// the scroll controller
  final ScrollController scrollController;

  /// the app locale
  final Locale? appLocale;

  @override
  Widget build(BuildContext context) {
    // get screen height
    final screenHeight = MediaQuery.of(context).size.height;
    final isCompactHeader = screenHeight < _headerHeightThreshold;
    final localeDisplayLabels = appkit.localeDisplayLabels;
    final localization = appkit.Localization.of(context);

    final currentLocalDisplayLabel =
        appLocale == null ? localization.language : localeDisplayLabels[appLocale.toString()] ?? appLocale.toString();

    final pageTitle = 'piyuo.com';
    return ChangeNotifierProvider<WizardScreenProvider>(
      create: (_) => WizardScreenProvider()..init(),
      child: Consumer2<app.ProjectProvider, WizardScreenProvider>(
        builder: (context, projectProvider, wizardScreenProvider, child) {
          return pip.PipScaffold(
              titleWidget: Text(
                pageTitle,
                style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    pip.PipHeader(
                      padding: EdgeInsets.all(10),
                      child: isCompactHeader
                          ? Row(children: [
                              const SizedBox(width: 8.0),
                              Image(
                                image: AssetImage('assets/icon/icon.png'),
                                width: 48,
                                height: 48,
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(context.l.product_name,
                                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8.0),
                                    Text(context.l.wizard_screen_desc,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: CupertinoColors.secondaryLabel.resolveFrom(context),
                                        )),
                                  ],
                                ),
                              )
                            ])
                          : Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/icon/icon.png'),
                                  width: 84,
                                  height: 84,
                                ),
                                const SizedBox(height: 8.0),
                                Text(context.l.product_name,
                                    style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4.0),
                                Text(context.l.wizard_screen_desc,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.0, color: CupertinoColors.secondaryLabel.resolveFrom(context))),
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
                            additionalInfo: Text(wizardScreenProvider.appVersion),
                            title: Text(context.l.wizard_screen_about),
                            trailing: CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                aboutRoute,
                                arguments: {
                                  'previousPageTitle': pageTitle,
                                },
                              );
                            }),
                        CupertinoListTile(
                            leading: Icon(CupertinoIcons.globe),
                            title: Text(context.l.wizard_screen_language),
                            additionalInfo: Text(currentLocalDisplayLabel),
                            trailing: CupertinoListTileChevron(),
                            onTap: () {
                              Navigator.of(context).pushNamed(languageRoute, arguments: {
                                'previousPageTitle': pageTitle,
                              });
                            }),
                        CupertinoListTile(
                            leading: Icon(CupertinoIcons.mail),
                            title: Text(context.l.wizard_screen_email_us),
                            trailing: CupertinoListTileChevron(),
                            onTap: () {
                              //throw MyReleaseException('Email us is not implemented yet');
                              appkit.netOpenMailTo('service@piyuo.com', '', '');
                            }),
                      ],
                    ),
                    pip.PipFooter(),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

/// provide wizard screen support
class WizardScreenProvider with ChangeNotifier {
  WizardScreenProvider();

  /// The version of vision app used.
  String appVersion = '';

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }
}

class MyReleaseException implements Exception {
  final String message;

  MyReleaseException(this.message);

  @override
  String toString() => 'MyException: $message';
}
