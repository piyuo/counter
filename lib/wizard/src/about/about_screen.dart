import 'package:counter/app/app.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:vision/l10n/vision_localization.dart';
import 'package:vision/vision.dart' as vision;

import '../wizard_navigator.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l = VisionLocalization.of(context);
    return ChangeNotifierProvider<AboutScreenProvider>(
      create: (_) => AboutScreenProvider()..init(),
      child: Consumer2<app.ProjectProvider, AboutScreenProvider>(
        builder: (context, projectProvider, aboutScreenProvider, child) {
          return pip.PipScaffold(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(CupertinoIcons.info, size: 44),
                        const SizedBox(height: 8.0),
                        Text(l.about_screen_about, style: const TextStyle(fontSize: 20.0)),
                      ],
                    ),
                  ),
                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        additionalInfo: Text(aboutScreenProvider.platform),
                        title: Text(l.about_screen_platform),
                      ),
                      CupertinoListTile(
                        additionalInfo: Text(aboutScreenProvider.appVersion),
                        title: Text(l.about_screen_app_version),
                        onTap: () => aboutScreenProvider.onTapVersion(),
                      ),
                    ],
                  ),
                  CupertinoListSection(
                    header: Text(l.about_screen_models),
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    children: [
                      CupertinoListTile(
                        trailing: CupertinoListTileChevron(),
                        title: Text(l.about_screen_benchmark),
                        onTap: () {
                          Navigator.of(context).pushNamed(benchmarkRoute);
                        },
                      ),
                    ],
                  ),
                  if (aboutScreenProvider._versionTapCount >= 10)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      children: [
                        CupertinoListTile(
                          title: Text(l.about_screen_opencv_build_info),
                          trailing: CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).pushNamed(opencvRoute);
                          },
                        ),
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

/// provide about screen support
class AboutScreenProvider with ChangeNotifier {
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
  void onTapVersion() {
    _versionTapCount++;
    if (_versionTapCount >= 10) {
      notifyListeners();
    }
  }
}
