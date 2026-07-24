import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_l10n/shared_l10n.dart';

class AboutScreen extends ConsumerStatefulWidget {
  const AboutScreen({super.key});

  @override
  ConsumerState<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends ConsumerState<AboutScreen> {
  String platform = '';
  String appVersion = '';
  int _versionTapCount = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final p = await vision.getPlatformVersion() ?? '?';
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      platform = p.split(' ').first;
      appVersion = packageInfo.version;
    });
  }

  void _onTapVersion() {
    _versionTapCount++;
    if (_versionTapCount >= 10) {
      ref.read(core_domain.appRuntimeProvider.notifier).setDevelopMode(true);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return feature_pip.PipScaffold(
      builder: (scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
        child: Column(
          children: [
            Image(image: AssetImage('assets/icon/icon.png'), width: 145, height: 140),
            const SizedBox(height: 8.0),
            Text('Piyuo Counter', style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(context.l.product_desc, style: TextStyle(fontSize: 16.0)),
            ),
            const SizedBox(height: 28),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    trailing: Text(platform, style: TextStyle(fontSize: 18)),
                    title: Text(context.l.about_screen_platform),
                  ),
                  ListTile(
                    trailing: Text(appVersion, style: TextStyle(fontSize: 18)),
                    title: Text(context.l.about_screen_app_version),
                    onTap: _onTapVersion,
                  ),
                ],
              ),
            ),
            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text(context.l.personal_custom_screen_help_action),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      appkit.netOpenUrl('https://piyuo.com/en/docs/payload-format');
                    },
                  ),
                ],
              ),
            ),

            feature_pip.PipPanel(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(context.l.about_screen_email_us),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      appkit.netOpenMailTo('service@piyuo.com', '', '');
                    },
                  ),
                ],
              ),
            ),

            if (_versionTapCount >= 10)
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    ListTile(
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text('OpenCV build info'),
                      onTap: () {
                        ref.push(const core_domain.OpenBuildInfo());
                      },
                    ),
                    if (_versionTapCount >= 10)
                      ListTile(
                        title: Text("End Counting Window and Enqueue"),
                        onTap: () {
                          ref.read(vision.windowCountProvider.notifier).debugForceWindowEnd();
                        },
                      ),
                    if (_versionTapCount >= 10)
                      ListTile(
                        title: Text('Run Upload Worker (Debug)'),
                        onTap: () async {
                          final telemetryService = ref.read(core_domain.telemetryServiceProvider);
                          await telemetryService.uploadNow();
                        },
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                appkit.netOpenUrl('https://piyuo.com/dpa');
              },
              child: Text(context.l.dpa),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    appkit.netOpenUrl('https://piyuo.com/privacy');
                  },
                  child: Text(context.l.privacy),
                ),
                const Text('•'),
                TextButton(
                  onPressed: () {
                    appkit.netOpenUrl('https://piyuo.com/terms');
                  },
                  child: Text(context.l.terms),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
