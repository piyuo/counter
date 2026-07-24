// TOC:
// - StartScreen: control-panel landing screen
// - detection type tile: shows current selection and opens detection settings
// - upload logs tile: quick access to recent telemetry upload outcomes

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/utils/video_source_name.dart';
import 'package:feature_control_panel/widgets/clickable_url.dart';
import 'package:feature_control_panel/widgets/metrics_dashboard.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart';
import 'package:universal_platform/universal_platform.dart';

import '../providers/app_version_provider.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }

    final appVersion = ref.watch(appVersionProvider).asData?.value ?? '';
    final telemetry = ref.watch(core_domain.telemetryServiceProvider);
    final areaState = ref.watch(vision.interestAreaProvider);

    final serverTitle = switch (appState.dataServerSelection) {
      core_domain.DataServerSelection.unspecified => '',
      core_domain.DataServerSelection.noDataServer => '',
      core_domain.DataServerSelection.businessPiyuo => appState.businessPiyuoServer?.projectName ?? '???',
      core_domain.DataServerSelection.businessCustom => appState.businessCustomServer?.projectName ?? '???',
      core_domain.DataServerSelection.personalPiyuo => context.l.start_screen_server_personal,
      core_domain.DataServerSelection.personalCustom => context.l.start_screen_server_personal,
    };

    final serverSubTitle = switch (appState.dataServerSelection) {
      core_domain.DataServerSelection.unspecified => '',
      core_domain.DataServerSelection.noDataServer => context.l.start_screen_server_none,
      core_domain.DataServerSelection.personalPiyuo => appState.personalPiyuoServer?.url ?? '',
      core_domain.DataServerSelection.personalCustom => appState.personalCustomServer?.url ?? '',
      core_domain.DataServerSelection.businessPiyuo => appState.businessPiyuoServer?.assignedName ?? '',
      core_domain.DataServerSelection.businessCustom => appState.businessCustomServer?.assignedName ?? '',
    };

    final isPedestrian = switch (appState.detectionType) {
      core_domain.DetectionVehicle() => false,
      _ => true,
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

              MetricsDashboard(areaState: areaState),
              const SizedBox(height: 8),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    if (appState.hasDataServer)
                      ListTile(
                        leading: Icon(Icons.timelapse),
                        title: Text(context.l.start_screen_upload_logs),
                        trailing: ValueListenableBuilder<DateTime?>(
                          valueListenable: telemetry.nextUploadTimeListenable,
                          builder: (context, nextUpload, child) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _StatusIconWithTime(
                                icon: Icons.schedule,
                                color: Colors.blueGrey,
                                timeLabel: _formatVeryShortLocalTime(context, nextUpload),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                        onTap: () => ref.push(const core_domain.OpenUploadLogs()),
                      ),
                    ListTile(
                      leading: Icon(Icons.video_camera_back),
                      title: Text(context.l.start_screen_video_sources),
                      trailing: Wrap(
                        children: [
                          Text(
                            buildVideoSourceShortName(context, appState.videoSource),
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        ref.push(const core_domain.OpenVideoSources());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(context.l.start_screen_settings),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            isPedestrian ? context.l.target_pedestrian : context.l.target_vehicle,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
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
                      title: Text(context.l.start_screen_about),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(appVersion, style: TextStyle(fontSize: 16, color: Colors.grey)),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios),
                        ],
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

  String _formatVeryShortLocalTime(BuildContext context, DateTime? value) {
    if (value == null) return '--';
    final local = value.toLocal();
    final alwaysUse24HourFormat = MediaQuery.maybeOf(context)?.alwaysUse24HourFormat ?? false;
    return MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(TimeOfDay.fromDateTime(local), alwaysUse24HourFormat: alwaysUse24HourFormat);
  }
}

class _StatusIconWithTime extends StatelessWidget {
  const _StatusIconWithTime({required this.icon, required this.color, required this.timeLabel});

  final IconData icon;
  final Color color;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(timeLabel, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
      ],
    );
  }
}
