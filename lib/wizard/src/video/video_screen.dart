import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:provider/provider.dart';

import '../project/pick_video.dart';
import '../wizard_app.dart';

/// The video screen for detail and zone editing.
class VideoScreen extends StatelessWidget {
  const VideoScreen({
    required this.scrollController,
    required this.videoProvider,
    this.previousPageTitle,
    super.key,
  });

  /// the scroll controller
  final ScrollController scrollController;

  /// the previous page title
  final String? previousPageTitle;

  /// the video provider this settings provider is working on
  final app.VideoProvider videoProvider;

  @override
  Widget build(BuildContext context) {
    final projectProvider = app.ProjectProvider.of(context);
    final video = videoProvider.video;
    final pageTitle = video.videoName;

    String getCurrentObjectClassNames(BuildContext context) {
      final nameList =
          videoProvider.video.objectClasses.map((classId) => vision.objectClassToString(context, classId)).toList();
      String name = nameList.join(', ');
      // truncate the name if it is longer than 16 characters
      if (name.length > 12) {
        name = '${name.substring(0, 12)} ...';
      }
      return name;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoScreenProvider>(
          create: (_) => VideoScreenProvider(
            projectProvider: projectProvider,
            videoProvider: videoProvider,
          ),
        ),
        ChangeNotifierProvider<app.VideoProvider>.value(
          value: videoProvider,
        ),
      ],
      child: Consumer2<VideoScreenProvider, app.VideoProvider>(
        builder: (context, sourceScreenProvider, videoProvider, child) {
          return pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            action: CupertinoButton(
              sizeStyle: CupertinoButtonSize.medium,
              onPressed: () {
                final videoZone = videoProvider.addZone(context);
                sourceScreenProvider.zoneAdded();
                Navigator.of(context).pushNamed(zoneRoute, arguments: {
                  'previousPageTitle': pageTitle,
                  'videoProvider': videoProvider,
                  'videoZone': videoZone,
                });
              },
              child: Text(context.l.video_screen_add_zone),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        Icon(videoProvider.getMediaTypeIcon(), size: 44),
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(
                          context.l.video_screen_desc,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.video_screen_video_name),
                    footer: sourceScreenProvider._videoNameErrorMessage.isNotEmpty
                        ? Text(
                            sourceScreenProvider._videoNameErrorMessage,
                            style: TextStyle(color: CupertinoColors.systemRed),
                          )
                        : null,
                    children: [
                      CupertinoTextField(
                        decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        placeholder: context.l.video_screen_edit_placeholder,
                        padding: const EdgeInsets.all(16),
                        maxLength: 128,
                        controller: sourceScreenProvider.videoNameController,
                        onChanged: (text) => sourceScreenProvider.setVideoName(context, text),
                      ),
                    ],
                  ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.video_screen_sources),
                    children: [
                      // file
                      if (video.sourceType == vision.SourceType.file)
                        CupertinoListTile(
                          title: Text(context.l.video_screen_change_file),
                          leading: const Icon(CupertinoIcons.folder),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () async {
                            final videoPath = await pickVideo();
                            if (videoPath == null) {
                              return;
                            }
                            final newFilePath = await saveFileToAppDirectory(
                              videoPath,
                              projectProvider.project!.projectId,
                              video.videoId,
                            );

                            videoProvider.setVideoPath(projectProvider.project!, newFilePath);
                            projectProvider.saveProject(videoProvider);
                          },
                        ),
                      // live stream
                      if (video.sourceType == vision.SourceType.liveStream)
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
                                await videoProvider.setVideoPath(projectProvider.project!, url);
                                projectProvider.saveProject(videoProvider);
                              }
                            } finally {
                              projectProvider.enterVideoScreen(videoProvider);
                            }
                          },
                        ),

                      // camera
                      if (video.sourceType == vision.SourceType.camera)
                        CupertinoListTile(
                          title: Text(
                              '${videoProvider.video.camera!.isFrontCamera ? context.l.camera_screen_front_camera : context.l.camera_screen_back_camera} ${videoProvider.video.camera!.title}'),
                          leading: const Icon(CupertinoIcons.camera),
                          trailing: projectProvider.cameraCount > 1 ? const CupertinoListTileChevron() : null,
                          onTap: projectProvider.cameraCount > 1
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

                      // webcam
                      if (video.sourceType == vision.SourceType.webcam)
                        CupertinoListTile(
                          title: Text(videoProvider.video.webcam!.name),
                          leading: const Icon(CupertinoIcons.videocam),
                          trailing: projectProvider.webcamCount > 1 ? const CupertinoListTileChevron() : null,
                          onTap: projectProvider.webcamCount > 1
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

                      // object classes
                      CupertinoListTile(
                        title: Text(context.l.video_screen_targets),
                        leading: const Icon(CupertinoIcons.list_bullet),
                        trailing: const CupertinoListTileChevron(),
                        additionalInfo: Text(getCurrentObjectClassNames(context)),
                        onTap: () => Navigator.of(context).pushNamed(
                          objectsRoute,
                          arguments: {
                            'videoProvider': videoProvider,
                            'previousPageTitle': pageTitle,
                          },
                        ),
                      ),
                      // detection parameter
                      CupertinoListTile(
                        title: Text(context.l.video_screen_detection),
                        leading: const Icon(CupertinoIcons.eye),
                        trailing: const CupertinoListTileChevron(),
                        additionalInfo: projectProvider.project != null ? Text(videoProvider.video.model.name) : null,
                        onTap: () => Navigator.of(context).pushNamed(detectionRoute, arguments: {
                          'videoProvider': videoProvider,
                          'previousPageTitle': pageTitle,
                        }),
                      ),
                    ],
                  ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.video_screen_zones),
                    footer: Text(context.l.video_screen_zones_desc),
                    children: video.zones
                        .map((zone) => CupertinoListTile(
                              title: Text(zone.name),
                              leading: Icon(CupertinoIcons.square_stack, color: zone.color.withValues(alpha: 1)),
                              //  leading: const Icon(CupertinoIcons.dot_square),
                              trailing: const CupertinoListTileChevron(),
                              onTap: () {
                                videoProvider.zoneEditorController!.setSelectedZone(zone);
                                Navigator.of(context).pushNamed(
                                  zoneRoute,
                                  arguments: {
                                    'editVideoScreenProvider': sourceScreenProvider,
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
                    header: Text(context.l.video_screen_tools),
                    children: [
                      CupertinoListTile(
                        title: Text(context.l.video_screen_move_bottom),
                        leading: const Icon(CupertinoIcons.down_arrow),
                        onTap: () => videoProvider.zoneEditorController!.moveZoneToBottom(),
                      ),
                      CupertinoListTile(
                        title: Text(context.l.video_screen_add_point),
                        leading: const Icon(CupertinoIcons.plus),
                        onTap: () => videoProvider.zoneEditorController!.addPoint(),
                      ),
                      CupertinoListTile(
                        title: Text(context.l.video_screen_remove_point),
                        leading: const Icon(CupertinoIcons.minus),
                        onTap: () => videoProvider.zoneEditorController!.removePoint(),
                      ),
                    ],
                  ),

                  // playback speed
                  if (video.sourceType == vision.SourceType.file)
                    CupertinoListSection(
                      backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                      header: Text(context.l.video_screen_playback_speed),
                      footer: Text(
                          '${context.l.video_screen_playback_current}${videoProvider.visionController.playbackSpeed}x'),
                      children: [
                        CupertinoListTile(
                            leadingSize: 52,
                            leading: Text(context.l.video_screen_playback_14x),
                            trailing: Text(context.l.video_screen_playback_2x),
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
                                  sourceScreenProvider.playbackSpeedChanged();
                                },
                              ),
                            )),
                      ],
                    ),

                  CupertinoListSection(
                    backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                    header: Text(context.l.video_screen_delete_header),
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
                                  title: Text(context.l.video_screen_delete_header),
                                  content: Text(context.l.video_screen_delete_content),
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
                                      child: Text(context.l.video_screen_delete_button),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (result == null || !result) return;

                            await projectProvider.deleteVideo(videoProvider);
                            if (context.mounted) Navigator.pop(context);
                          },
                          child: Text(context.l.video_screen_delete_button,
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

/// Provide video screen support
class VideoScreenProvider with ChangeNotifier {
  VideoScreenProvider({
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
  void setVideoName(BuildContext context, String text) {
    if (text.isEmpty) {
      _videoNameErrorMessage = context.l.video_screen_name_empty;
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
