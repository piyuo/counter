import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;

class AboutScreen extends StatelessWidget {
  const AboutScreen({required this.scrollController, this.previousPageTitle, super.key});

  /// The title of the previous page.
  final String? previousPageTitle;

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final pageTitle = context.l.about_screen_title;
    return ChangeNotifierProvider<AboutScreenProvider>(
      create: (_) => AboutScreenProvider()..init(),
      child: Consumer2<app.ProjectProvider, AboutScreenProvider>(
        builder: (context, projectProvider, aboutScreenProvider, child) {
          return feature_pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  feature_pip.PipHeader(
                    child: Column(
                      children: [
                        Image(image: AssetImage('assets/icon/icon.png'), width: 145, height: 140),
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: const TextStyle(fontSize: 20.0)),
                        Text(
                          context.l.product_name,
                          style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                        ),
                      ],
                    ),
                  ),
                  CupertinoListSection(
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        additionalInfo: Text(aboutScreenProvider.platform),
                        title: Text(context.l.about_screen_platform),
                      ),
                      CupertinoListTile(
                        additionalInfo: Text(aboutScreenProvider.appVersion),
                        title: Text(context.l.about_screen_app_version),
                        onTap: () => aboutScreenProvider.onTapVersion(projectProvider),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(context.l.about_screen_models),
                    backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        trailing: CupertinoListTileChevron(),
                        title: Text(context.l.about_screen_benchmark),
                        onTap: () {},
                      ),
                    ],
                  ),
                  if (aboutScreenProvider._versionTapCount >= 10)
                    CupertinoListSection(
                      backgroundColor: feature_pip.getCupertinoListSectionBackgroundColor(context),
                      children: [
                        CupertinoListTile(
                          title: Text(context.l.about_screen_opencv_build_info),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {},
                        ),
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

/// provide about screen support
class AboutScreenProvider with ChangeNotifier {
  AboutScreenProvider();

  /// The platform the system is running on.
  String platform = '';

  /// The version of vision app used.
  String appVersion = '';

  /// The version tap count.
  int _versionTapCount = 0;

  Future<void> init() async {
    platform = await vision.getPlatformVersion() ?? '?';
    platform = getShortPlatformName(platform);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  String getShortPlatformName(String platform) {
    return platform.split(' ').first;
  }

  /// tap version 10 times to enable build info
  void onTapVersion(app.ProjectProvider provider) {
    _versionTapCount++;
    if (_versionTapCount >= 10) {
      provider.developMode = true;
      notifyListeners();
    }
  }
}
