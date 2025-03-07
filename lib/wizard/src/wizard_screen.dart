import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

import 'project/video_sources.dart';
import 'wizard_navigator.dart';

/// if the screen height is less than this value, use compact header
const double _headerHeightThreshold = 600;

class WizardScreen extends StatelessWidget {
  const WizardScreen({
    required this.isPanelOpened,
    required this.onScroll,
    required this.resetScroll,
    super.key,
  });

  /// is the sliding panel opened?
  final bool isPanelOpened;

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  /// the reset scroll event handler need by pip screen
  final VoidCallback resetScroll;

  @override
  Widget build(BuildContext context) {
    // get screen height
    final screenHeight = MediaQuery.of(context).size.height;
    final isCompactHeader = screenHeight < _headerHeightThreshold;

    final pageTitle = 'piyuo.com';
    return ChangeNotifierProvider<WizardScreenProvider>(
      create: (_) => WizardScreenProvider(onScroll, resetScroll)..init(),
      child: Consumer2<app.ProjectProvider, WizardScreenProvider>(
        builder: (context, projectProvider, wizardScreenProvider, child) {
          return pip.PipScaffold(
              titleWidget: Container(
                padding: const EdgeInsets.only(left: 16.0),
                alignment: Alignment.centerLeft,
                child: isPanelOpened
                    ? Text(pageTitle, style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/icon/icon.png'),
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(child: Text(context.l.product_name))
                        ],
                      ),
              ),
              child: SingleChildScrollView(
                controller: wizardScreenProvider._scrollController,
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
                                  width: 52,
                                  height: 52,
                                ),
                                const SizedBox(height: 8.0),
                                Text(context.l.product_name,
                                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
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
                            additionalInfo: Text(vision.LanguageProvider.of(context).getLanguage(context),
                                style: TextStyle(fontSize: 12.0)),
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
              ));
        },
      ),
    );
  }
}

/// provide wizard screen support
class WizardScreenProvider with ChangeNotifier {
  WizardScreenProvider(pip.ScrollCallback onScroll, VoidCallback resetScroll) {
    resetScroll();
    _scrollController.addListener(() => onScroll(_scrollController));
  }

  /// The version of vision app used.
  String appVersion = '';

  /// The scroll controller
  final ScrollController _scrollController = ScrollController();

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
