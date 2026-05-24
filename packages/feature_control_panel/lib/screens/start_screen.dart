// TOC:
// - StartScreen: control-panel landing screen
// - detection type tile: shows current selection and opens detection settings
// - upload logs tile: quick access to recent telemetry upload outcomes

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/utils/video_source_name.dart';
import 'package:feature_control_panel/widgets/metrics_area_sections.dart';
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
    final dataServerHeadline = switch (appState.dataServerSelection) {
      core_domain.DataServerSelection.none => 'Local device only, no uploads',
      core_domain.DataServerSelection.personalPiyuo =>
        'Counting summary data uploads hourly to: ${appState.personalPiyuoServer?.url}',
      core_domain.DataServerSelection.businessPiyuo =>
        'Data uploads hourly to:${appState.businessPiyuoServer?.projectName}',
      core_domain.DataServerSelection.personalCustom =>
        'Counting summary data uploads hourly to: ${appState.personalCustomServer?.url}',
      core_domain.DataServerSelection.businessCustom =>
        'Data uploads hourly to:${appState.businessCustomServer?.projectName}',
    };

    final selectedDetectionIndex = switch (appState.detectionType) {
      core_domain.DetectionVehicle() => 1,
      _ => 0,
    };

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with app icon, name, and description
              feature_pip.PipPanel(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/icon/icon.png'), width: 64, height: 64),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(context.l.start_screen_product_title, style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            dataServerHeadline,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              MetricsAreaSections(areaState: areaState),
              const SizedBox(height: 8),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    if (appState.hasDataServer)
                      ListTile(
                        leading: Icon(Icons.timelapse),
                        title: Text(context.l.upload_logs_screen_title),
                        trailing: ValueListenableBuilder<DateTime?>(
                          valueListenable: telemetry.nextUploadTimeListenable,
                          builder: (context, nextUpload, child) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildUploadStatusIndicator(context, telemetry, nextUpload),
                              const SizedBox(width: 10),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                        onTap: () => ref.push(const core_domain.OpenUploadLogs()),
                      ),
                    ListTile(
                      leading: Icon(Icons.video_camera_back),
                      title: Text(context.l.video_sources_screen_title),
                      trailing: Wrap(
                        children: [
                          Text(
                            buildVideoSourceName(context, appState.videoSource),
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
                      title: Text(context.l.settings_screen_title),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            selectedDetectionIndex == 1
                                ? context.l.detection_type_screen_vehicle_title
                                : context.l.detection_type_screen_pedestrian_title,
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
                      title: Text(context.l.wizard_screen_about),
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

  Widget _buildUploadStatusIndicator(
    BuildContext context,
    core_domain.TelemetryService telemetry,
    DateTime? nextUpload,
  ) {
    final status = telemetry.isLastUploadSuccess;
    if (status == true) {
      return _StatusIconWithTime(
        icon: Icons.check_circle,
        color: Colors.green,
        timeLabel: _formatVeryShortLocalTime(context, telemetry.lastUploadTimeUtc),
      );
    }

    if (status == false) {
      return _StatusIconWithTime(
        icon: Icons.error,
        color: Colors.orange,
        timeLabel: _formatVeryShortLocalTime(context, telemetry.lastUploadTimeUtc),
      );
    }

    if (nextUpload != null) {
      return _StatusIconWithTime(
        icon: Icons.schedule,
        color: Colors.blueGrey,
        timeLabel: _formatVeryShortLocalTime(context, nextUpload),
      );
    }

    return const _StatusIconWithTime(icon: Icons.schedule, color: Colors.blueGrey, timeLabel: '...');
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
