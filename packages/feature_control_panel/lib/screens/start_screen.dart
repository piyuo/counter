// TOC:
// - StartScreen: control-panel landing screen
// - detection type tile: shows current selection and opens detection settings
// - upload logs tile: quick access to recent telemetry upload outcomes

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_control_panel/widgets/metrics_area_sections.dart';
import 'package:feature_control_panel/widgets/window_progress_display.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:intl/intl.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../providers/app_version_provider.dart';

final _startScreenAvailableCamerasProvider = FutureProvider.autoDispose<List<core_domain.AvailableCamera>>((ref) async {
  final hardwareCapabilityService = ref.watch(core_domain.hardwareCapabilityServiceProvider);
  return hardwareCapabilityService.listAvailableCameras();
});

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(appVersionProvider).asData?.value ?? '';
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    final windowCount = ref.watch(vision.windowCountProvider);
    final telemetry = ref.watch(core_domain.telemetryServiceProvider);
    final areaState = ref.watch(vision.interestAreaStateProvider);
    final dataServer = appState?.dataServer ?? const core_domain.DataServer.unspecified();
    final dataServerHeadline = _dataServerHeadline(dataServer);
    final availableCameras = ref.watch(_startScreenAvailableCamerasProvider).asData?.value ?? const [];
    final selectedDetectionIndex = switch (appState?.detection) {
      core_domain.DetectionVehicle() => 1,
      _ => 0,
    };

    final locale = Localizations.localeOf(context).toString();
    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          Text('Piyuo Counter', style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            'Pedestrian/Vehicle Counter and Data Collector',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              if (windowCount == null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Center(
                    child: const GlassProgressIndicator.circular(color: Colors.white, strokeWidth: 4, size: 64),
                  ),
                ),
              if (windowCount != null)
                feature_pip.PipPanel(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        title: Text(
                          '${DateFormat.jm(locale).format(windowCount.startUtc.toLocal())} - ${DateFormat.jm(locale).format(windowCount.endUtc.toLocal())}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        /*                        subtitle: nextUpload.when(
                          data: (dt) {
                            final time = DateFormat.jm(locale).format(dt.toLocal());
                            return Text(
                              'Next Upload at $time',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: TextDecoration.none,
                              ),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, _) => const SizedBox.shrink(),
                        ),*/
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          ref.push(const core_domain.OpenPayloadsRecent());
                        },
                      ),
                      WindowProgressDisplay(windowCount: windowCount),
                    ],
                  ),
                ),

              const SizedBox(height: 8),
              if (windowCount != null)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '${windowCount.sessionId}  #${windowCount.windowIndex}',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              if (windowCount != null) MetricsAreaSections(windowCount: windowCount, areaState: areaState),
              const SizedBox(height: 8),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    if (dataServerHeadline.isNotEmpty)
                      ListTile(
                        leading: Icon(Icons.timelapse),
                        title: Text("Upload Logs"),
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
                      title: Text("Video Sources"),
                      trailing: Wrap(
                        children: [
                          Text(
                            _activeVideoSourceLabel(context, appState?.videoSource, availableCameras),
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
                      leading: const Icon(Icons.gps_fixed),
                      title: Text('Detection Type'),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            selectedDetectionIndex == 1 ? 'Vehicle' : 'Pedestrian',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        ref.push(const core_domain.OpenDetectionTypeSelection());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      trailing: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(_dataServerByLabel(dataServer), style: TextStyle(fontSize: 16, color: Colors.grey)),
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
            ],
          ),
        );
      },
    );
  }

  String _activeVideoSourceLabel(
    BuildContext context,
    core_domain.VideoSource? selectedVideoSource,
    List<core_domain.AvailableCamera> availableCameras,
  ) {
    if (selectedVideoSource == null || selectedVideoSource is core_domain.UnspecifiedVideoSource) {
      return '';
    }

    for (final camera in availableCameras) {
      if (camera.videoSource == selectedVideoSource) {
        return camera.displayName;
      }
    }
    return switch (selectedVideoSource) {
      core_domain.CameraVideoSource() => context.l.video_sources_camera,
      core_domain.WebcamVideoSource() => context.l.video_sources_webcam,
      core_domain.FileVideoSource() => context.l.video_sources_file,
      core_domain.LiveVideoSource() => context.l.video_sources_live_stream,
      _ => '',
    };
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

  String _dataServerByLabel(core_domain.DataServer dataServer) {
    return switch (dataServer) {
      core_domain.BusinessDataServer() => 'Invitation',
      core_domain.PersonalDataServer() when dataServer.isPiyuo => 'Piyuo Cloud',
      core_domain.PersonalDataServer() => 'Own Server',
      core_domain.NoDataServer() => 'Demo Mode',
      core_domain.UnspecifiedDataServer() => 'Not Set',
    };
  }

  String _dataServerHeadline(core_domain.DataServer dataServer) {
    return switch (dataServer) {
      core_domain.BusinessDataServer(:final projectName) => projectName,
      core_domain.PersonalDataServer(:final url) => url,
      core_domain.NoDataServer() => 'Demo mode, no data leaves your device.',
      core_domain.UnspecifiedDataServer() => '',
    };
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
