// TOC:
// - video source list: reads available cameras from HardwareCapabilityService
// - active selection: highlights and updates the current AppState video source

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart' as core_runtime;
import 'package:feature_control_panel/utils/video_source_name.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:shared_l10n/shared_l10n.dart';

import '../utils/video_file_importer.dart';

const _tileHorizontalPadding = 12.0;
const _tileVerticalPadding = 14.0;

class VideoSourcesScreen extends ConsumerStatefulWidget {
  const VideoSourcesScreen({super.key});

  @override
  ConsumerState<VideoSourcesScreen> createState() => _VideoSourcesScreenState();
}

class _VideoSourcesScreenState extends ConsumerState<VideoSourcesScreen> {
  bool _isImportingVideoFile = false;

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(core_domain.appProvider).asData?.value;
    if (appState == null) {
      return const SizedBox.shrink();
    }
    final selectedVideoSource = appState.videoSource;
    final cameraDeviceState = ref.watch(vision.cameraDeviceProvider);
    final availableCameras = cameraDeviceState.asData?.value.availableCameras ?? [];
    final availableVideoSources = <core_domain.VideoSource>[
      for (var i = 0; i < availableCameras.length; i++) core_runtime.cameraDeviceToVideoSource(availableCameras[i], i),
    ];

    return feature_pip.PipScaffold(
      builder: (scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: feature_pip.kScrollContentAppbarPadding),
          child: Column(
            children: [
              feature_pip.PipHeader(
                icon: Icons.video_camera_back,
                title: context.l.video_sources_screen_title,
                subtitle: context.l.video_sources_screen_body,
              ),
              feature_pip.PipPanel(
                child: Column(
                  children: [
                    for (final videoSource in availableVideoSources)
                      _SourceOptionTile(
                        leading: _selectionIndicator(context, _isSelected(videoSource, selectedVideoSource)),
                        title: buildVideoSourceName(context, videoSource),
                        titleIcon: _iconForVideoSource(videoSource),
                        subtitle: _labelForVideoSource(context, videoSource),
                        isSelected: _isSelected(videoSource, selectedVideoSource),
                        onTap: () async {
                          await ref.read(core_domain.appProvider.notifier).setVideoSource(videoSource);
                        },
                      ),
                    if (availableVideoSources.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              context.l.video_sources_camera_not_found_title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              context.l.video_sources_camera_not_found_message,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              feature_pip.PipPanel(
                child: _SourceOptionTile(
                  leading: _selectionIndicator(context, selectedVideoSource is core_domain.LiveVideoSource),
                  title: context.l.url_screen_title,
                  titleIcon: Icons.cloud_outlined,
                  isSelected: selectedVideoSource is core_domain.LiveVideoSource,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    ref.push(const core_domain.OpenLiveUrl());
                  },
                ),
              ),
              const SizedBox(height: 10),
              feature_pip.PipPanel(
                child: _SourceOptionTile(
                  leading: _selectionIndicator(context, selectedVideoSource is core_domain.FileVideoSource),
                  title: context.l.video_sources_file,
                  titleIcon: Icons.folder_open,
                  isSelected: selectedVideoSource is core_domain.FileVideoSource,
                  trailing: _isImportingVideoFile
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5))
                      : const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: _isImportingVideoFile ? null : () => _handleImportFromFile(context),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  bool _isSelected(core_domain.VideoSource candidate, core_domain.VideoSource? selectedVideoSource) {
    return selectedVideoSource == candidate;
  }

  Widget? _selectionIndicator(BuildContext context, bool isSelected) {
    return isSelected
        ? Icon(Icons.check, size: 22, color: Theme.of(context).colorScheme.primary)
        : const SizedBox(width: 22);
  }

  Future<void> _handleImportFromFile(BuildContext context) async {
    final appState = await ref.read(core_domain.appProvider.future);
    final previousFilePath = switch (appState.videoSource) {
      core_domain.FileVideoSource(path: final pathValue) => pathValue,
      _ => null,
    };

    setState(() {
      _isImportingVideoFile = true;
    });
    try {
      final result = await pickAndImportVideoFile(
        projectId: appState.deviceId,
        videoId: DateTime.now().microsecondsSinceEpoch,
      );

      switch (result.status) {
        case ImportedVideoPickStatus.cancelled:
          return;
        case ImportedVideoPickStatus.permissionDenied:
          if (context.mounted) {
            await showMessageDialog(context.l.video_sources_photos_denied_msg);
          }
          return;
        case ImportedVideoPickStatus.selected:
          final importedFilePath = result.importedFilePath!;
          await ref
              .read(core_domain.appProvider.notifier)
              .setVideoSource(core_domain.VideoSource.file(path: importedFilePath));

          if (previousFilePath != null && previousFilePath != importedFilePath) {
            await deleteManagedImportedVideo(previousFilePath);
          }
      }
    } catch (error) {
      if (context.mounted) {
        await showMessageDialog(context.l.video_sources_import_error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isImportingVideoFile = false;
        });
      }
    }
  }

  IconData _iconForVideoSource(core_domain.VideoSource videoSource) {
    return switch (videoSource) {
      core_domain.CameraVideoSource() => Icons.camera_alt,
      core_domain.WebcamVideoSource() => Icons.videocam,
      core_domain.FileVideoSource() => Icons.folder,
      core_domain.LiveVideoSource() => Icons.stream,
      _ => Icons.video_camera_back,
    };
  }

  String _labelForVideoSource(BuildContext context, core_domain.VideoSource videoSource) {
    return switch (videoSource) {
      core_domain.CameraVideoSource() => context.l.video_sources_camera,
      core_domain.WebcamVideoSource() => context.l.video_sources_webcam,
      core_domain.FileVideoSource() => context.l.video_sources_file,
      core_domain.LiveVideoSource() => context.l.video_sources_live_stream,
      _ => context.l.video_sources_screen_title,
    };
  }
}

class _SourceOptionTile extends StatelessWidget {
  const _SourceOptionTile({
    required this.leading,
    required this.title,
    required this.titleIcon,
    this.subtitle,
    required this.isSelected,
    this.trailing,
    this.onTap,
  });

  final Widget? leading;
  final String title;
  final IconData titleIcon;
  final String? subtitle;
  final bool isSelected;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _tileHorizontalPadding, vertical: _tileVerticalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 28,
              child: Align(alignment: Alignment.centerLeft, child: leading ?? const SizedBox.shrink()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(titleIcon, size: 18, color: iconColor),
                      const SizedBox(width: 10),
                      Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(subtitle!, maxLines: 2, overflow: TextOverflow.ellipsis, style: subtitleStyle),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              IconTheme.merge(
                data: IconThemeData(color: Colors.grey.shade400),
                child: trailing!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
