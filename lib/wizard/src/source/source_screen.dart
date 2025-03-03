import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vision/vision.dart' as vision;

import '../project/pick_video.dart';
import '../wizard_navigator.dart';

/// The source screen for detail and zone editing.
class SourceScreen extends StatelessWidget {
  const SourceScreen({
    required this.videoProvider,
    this.previousPageTitle,
    super.key,
  });

  /// the previous page title
  final String? previousPageTitle;

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final video = videoProvider.video;
    final pageTitle = video.videoName;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoSourceScreenProvider>(
          create: (_) => VideoSourceScreenProvider(
            projectProvider: projectProvider,
            videoProvider: videoProvider,
          ),
        ),
        ChangeNotifierProvider<app.VideoProvider>.value(
          value: videoProvider,
        ),
      ],
      child: Consumer2<VideoSourceScreenProvider, app.VideoProvider>(
        builder: (context, videoSourceScreenProvider, videoProvider, child) {
          return pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            action: CupertinoButton(
              onPressed: () {
                final videoZone = videoProvider.addZone(context);
                videoSourceScreenProvider.zoneAdded();
                Navigator.of(context).pushNamed(zoneRoute, arguments: {
                  'previousPageTitle': pageTitle,
                  'videoProvider': videoProvider,
                  'videoZone': videoZone,
                });
              },
              child: Text(context.l.source_screen_add_zone),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(videoProvider.getMediaTypeIcon(), size: 44),
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(
                          context.l.source_screen_desc,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.source_screen_video_name),
                    footer: videoSourceScreenProvider._videoNameErrorMessage.isNotEmpty
                        ? Text(
                            videoSourceScreenProvider._videoNameErrorMessage,
                            style: TextStyle(color: CupertinoColors.systemRed),
                          )
                        : null,
                    children: [
                      CupertinoTextField(
                        decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        placeholder: context.l.source_screen_edit_placeholder,
                        padding: const EdgeInsets.all(16),
                        maxLength: 128,
                        controller: videoSourceScreenProvider.videoNameController,
                        onChanged: (text) => videoSourceScreenProvider.setVideoName(text),
                      ),
                    ],
                  ),

                  // live stream
                  if (video.mediaType == vision.MediaType.live)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.source_screen_url),
                      children: [
                        CupertinoListTile(
                          title: Text(videoProvider.video.path!),
                          leading: const Icon(CupertinoIcons.cloud),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () async {
                            projectProvider.exitVideoScreen(videoProvider);
                            try {
                              dynamic url =
                                  await Navigator.of(context).pushNamed(urlRoute, arguments: {'url': video.path});
                              if (url != null && url != video.path) {
                                if (context.mounted) {
                                  await videoProvider.setVideoPath(context, projectProvider.project!, url);
                                }
                                projectProvider.saveProject(videoProvider);
                              }
                            } finally {
                              projectProvider.enterVideoScreen(videoProvider);
                            }
                          },
                        ),
                      ],
                    ),
                  // file
                  if (video.mediaType == vision.MediaType.file)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.source_screen_file),
                      children: [
                        CupertinoListTile(
                          title: Text(context.l.source_screen_change_file),
                          leading: const Icon(CupertinoIcons.folder),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () async {
                            final videoPath = await pickVideo();
                            if (!context.mounted || videoPath == null) {
                              return;
                            }
                            final newFilePath = await saveFileToAppDirectory(
                              videoPath,
                              projectProvider.project!.projectId,
                              video.videoId,
                            );
                            if (!context.mounted) {
                              return;
                            }

                            videoProvider.setVideoPath(context, projectProvider.project!, newFilePath);
                            projectProvider.saveProject(videoProvider);
                          },
                        ),
                      ],
                    ),
                  if (video.mediaType == vision.MediaType.camera)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.source_screen_camera),
                      children: [
                        CupertinoListTile(
                          title: Text(
                              '${videoProvider.video.camera!.isFrontCamera ? context.l.camera_screen_front_camera : context.l.camera_screen_back_camera} ${videoProvider.video.camera!.title}'),
                          leading: const Icon(CupertinoIcons.camera),
                          trailing: projectProvider.cameraManager.cameraDefines.length > 1
                              ? const CupertinoListTileChevron()
                              : null,
                          onTap: projectProvider.cameraManager.cameraDefines.length > 1
                              ? () async {
                                  projectProvider.exitVideoScreen(videoProvider);
                                  try {
                                    await Navigator.of(context).pushNamed(
                                      cameraRoute,
                                      arguments: {
                                        'videoProvider': videoProvider,
                                        'isAddMode': false,
                                        'previousPageTitle': pageTitle,
                                      },
                                    );
                                  } finally {
                                    projectProvider.enterVideoScreen(videoProvider);
                                  }
                                }
                              : null,
                        ),
                      ],
                    ),

                  if (video.mediaType == vision.MediaType.webcam)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.source_screen_webcam),
                      children: [
                        CupertinoListTile(
                          title: Text(videoProvider.video.webcam!.name),
                          leading: const Icon(CupertinoIcons.videocam),
                          trailing: projectProvider.webcamManager.webcamDefines.length > 1
                              ? const CupertinoListTileChevron()
                              : null,
                          onTap: projectProvider.webcamManager.webcamDefines.length > 1
                              ? () async {
                                  projectProvider.exitVideoScreen(videoProvider);
                                  try {
                                    await Navigator.of(context).pushNamed(
                                      webcamRoute,
                                      arguments: {
                                        'videoProvider': videoProvider,
                                        'isAddMode': false,
                                        'previousPageTitle': pageTitle,
                                      },
                                    );
                                  } finally {
                                    projectProvider.enterVideoScreen(videoProvider);
                                  }
                                }
                              : null,
                        ),
                      ],
                    ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.source_screen_zones),
                    footer: Text(context.l.source_screen_zones_desc),
                    children: video.zones
                        .map((zone) => CupertinoListTile(
                              title: Text(zone.name),
                              leading: Icon(CupertinoIcons.square_stack, color: zone.color),
                              //  leading: const Icon(CupertinoIcons.dot_square),
                              trailing: const CupertinoListTileChevron(),
                              onTap: () {
                                videoProvider.zoneEditorController!.setSelectedZone(zone);
                                Navigator.of(context).pushNamed(
                                  zoneRoute,
                                  arguments: {
                                    'editVideoScreenProvider': videoSourceScreenProvider,
                                    'previousPageTitle': pageTitle,
                                    'videoProvider': videoProvider,
                                    'videoZone': zone,
                                  },
                                );
                              },
                            ))
                        .toList(),
                  ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.source_screen_tools),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.source_screen_move_bottom),
                        leading: const Icon(CupertinoIcons.down_arrow),
                        onTap: () => videoProvider.zoneEditorController!.moveZoneToBottom(),
                      ),
                      CupertinoListTile(
                        title: Text(context.l.source_screen_add_point),
                        leading: const Icon(CupertinoIcons.plus),
                        onTap: () => videoProvider.zoneEditorController!.addPoint(),
                      ),
                      CupertinoListTile(
                        title: Text(context.l.source_screen_remove_point),
                        leading: const Icon(CupertinoIcons.minus),
                        onTap: () => videoProvider.zoneEditorController!.removePoint(),
                      ),
                    ],
                  ),

                  // playback speed
                  if (video.mediaType == vision.MediaType.file)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.source_screen_playback_speed),
                      footer: Text(
                          '${context.l.source_screen_playback_current}${videoProvider.visionController.playbackSpeed}x'),
                      children: [
                        CupertinoListTile(
                            leadingSize: 52,
                            leading: Text(context.l.source_screen_playback_14x),
                            trailing: Text(context.l.source_screen_playback_2x),
                            additionalInfo: SizedBox.shrink(),
                            title: SizedBox(
                              width: double.infinity,
                              child: CupertinoSlider(
                                value: videoProvider.visionController.playbackSpeed,
                                max: 2,
                                min: 0.25,
                                divisions: 4,
                                onChanged: (double value) async {
                                  await videoProvider.visionController.setPlaybackSpeed(value);
                                  videoSourceScreenProvider.playbackSpeedChanged();
                                },
                              ),
                            )),
                      ],
                    ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.source_screen_delete_header),
                    children: [
                      CupertinoListTile(
                        title: Center(
                            child: CupertinoButton(
                          onPressed: () async {
                            // show confirmation dialog
                            final bool? result = await showCupertinoDialog<bool>(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text(context.l.source_screen_delete_header),
                                  content: Text(context.l.source_screen_delete_content),
                                  actions: [
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      textStyle: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
                                      onPressed: () => Navigator.pop(context, false),
                                      child: Text(context.l.cancel),
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      onPressed: () => Navigator.pop(context, true),
                                      child: Text(context.l.source_screen_delete_button),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (result == null || !result) return;

                            await projectProvider.deleteVideo(videoProvider);
                            if (context.mounted) Navigator.pop(context);
                          },
                          child: Text(context.l.source_screen_delete_button,
                              style: TextStyle(color: CupertinoColors.systemRed)),
                        )),
                      )
                    ],
                  ),
                  pip.PipFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Provide video source screen support
class VideoSourceScreenProvider with ChangeNotifier {
  VideoSourceScreenProvider({
    required this.projectProvider,
    required this.videoProvider,
  }) {
    videoNameController.text = videoProvider.video.videoName;
  }

  /// the project provider
  final app.ProjectProvider projectProvider;

  /// the video provider
  final app.VideoProvider videoProvider;

  /// the video name controller
  TextEditingController videoNameController = TextEditingController();

  /// the error message for video name
  String _videoNameErrorMessage = '';

  @override
  void dispose() {
    videoNameController.dispose();
    super.dispose();
  }

  /// set video name
  void setVideoName(String text) {
    if (text.isEmpty) {
      _videoNameErrorMessage = "The video name cannot be empty";
    } else {
      _videoNameErrorMessage = '';
      videoProvider.setVideoName(text);
    }
    notifyListeners();
  }

  /// redraw screen when zone added
  void zoneAdded() {
    notifyListeners();
  }

  /// redraw screen when zone's name changed
  void zoneNameChanged() {
    notifyListeners();
  }

  /// redraw screen when playback speed changed
  void playbackSpeedChanged() {
    notifyListeners();
  }

  /// redraw screen when zoom changed
  void zoomChanged() {
    notifyListeners();
  }
}
