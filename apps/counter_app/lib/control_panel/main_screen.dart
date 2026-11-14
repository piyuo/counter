// TOC:
// - StartScreen: control-panel landing screen
// - detection type tile: shows current selection and opens detection settings

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:counter_app/control_panel/insights/insight_display.dart';
import 'package:counter_app/control_panel/utils/video_source_name.dart';
import 'package:counter_app/control_panel/widgets/clickable_url.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart';
import 'package:universal_platform/universal_platform.dart';

import '../providers/app_version_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }

    final appVersion = ref.watch(appVersionProvider).asData?.value ?? '';
    final areaState = ref.watch(core_runtime.interestAreaProvider);
    final interestAreaHelpText = areaState.areas.isEmpty
        ? context.l.main_screen_interest_area_empty
        : areaState.areas.length.toString();

    final serverTitle = switch (appState.dataServerSelection) {
      core_domain.DataServerSelection.unspecified => '',
      core_domain.DataServerSelection.noDataServer => '',
      core_domain.DataServerSelection.businessPiyuo => appState.businessPiyuoServer?.projectName ?? '???',
      core_domain.DataServerSelection.businessCustom => appState.businessCustomServer?.projectName ?? '???',
      core_domain.DataServerSelection.personalPiyuo => context.l.main_screen_server_personal,
      core_domain.DataServerSelection.personalCustom => context.l.main_screen_server_personal,
    };

    final serverSubTitle = switch (appState.dataServerSelection) {
      core_domain.DataServerSelection.unspecified => '',
      core_domain.DataServerSelection.noDataServer => context.l.main_screen_server_none,
      core_domain.DataServerSelection.personalPiyuo => appState.personalPiyuoServer?.url ?? '',
      core_domain.DataServerSelection.personalCustom => appState.personalCustomServer?.url ?? '',
      core_domain.DataServerSelection.businessPiyuo => appState.businessPiyuoServer?.assignedName ?? '',
      core_domain.DataServerSelection.businessCustom => appState.businessCustomServer?.assignedName ?? '',
    };

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
          child: Column(
            children: [
              // Header with app icon, name, and description
              feature_pip.PipPanel(
                backgroundColor: Colors.black45,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/icon/icon.png'), width: 64, height: 64),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Piyuo Counter',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(serverTitle, style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ClickableUrl(text: serverSubTitle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InsightDisplay(),
              feature_pip.PipPanel(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.video_camera_back),
                      title: Text(context.l.main_screen_video_sources),
                      trailing: Wrap(
                        children: [
                          Text(buildVideoSourceShortName(context, appState.videoSource)),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        ref.push(const core_domain.OpenVideoSources());
                      },
                    ),
                    // Interest Area ---
                    ListTile(
                      leading: Icon(Icons.crop_square),
                      title: Text(context.l.main_screen_interest_areas),
                      trailing: Wrap(
                        children: [Text(interestAreaHelpText), SizedBox(width: 10), Icon(Icons.arrow_forward_ios)],
                      ),
                      onTap: () {
                        final interestAreaController = ref.read(core_runtime.interestAreaProvider.notifier);
                        final visionState = ref.read(vision.visionProvider);
                        interestAreaController.startEditing(
                          videoWidth: visionState.videoWidth,
                          videoHeight: visionState.videoHeight,
                        );

                        ref.push(const core_domain.OpenInterestAreas());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(context.l.main_screen_settings),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            appState.detectionType == core_domain.DetectionType.people
                                ? context.l.detection_type_people
                                : context.l.detection_type_vehicle,
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        ref.push(const core_domain.OpenSettings());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text(context.l.main_screen_about),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [Text(appVersion), SizedBox(width: 10), Icon(Icons.arrow_forward_ios)],
                      ),

                      onTap: () {
                        ref.push(const core_domain.OpenAbout());
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: UniversalPlatform.isMobile ? 60 : 20),
            ],
          ),
        );
      },
    );
  }
}
