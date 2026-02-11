import 'package:counter/l10n/l10n.dart';
import 'package:counter/monitor/monitor.dart' as app;
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../control_panel_shell.dart';

/// The video screen for detail and zone editing.
class VideoScreen extends StatelessWidget {
  const VideoScreen({required this.scrollController, required this.videoProvider, this.previousPageTitle, super.key});

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
      return '';
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoScreenProvider>(
          create: (_) => VideoScreenProvider(projectProvider: projectProvider, videoProvider: videoProvider),
        ),
        ChangeNotifierProvider<app.VideoProvider>.value(value: videoProvider),
      ],
      child: Consumer2<VideoScreenProvider, app.VideoProvider>(
        builder: (context, sourceScreenProvider, videoProvider, child) {
          return pip.PipScaffold(
            previousPageTitle: previousPageTitle,
            action: CupertinoButton(
              sizeStyle: CupertinoButtonSize.medium,
              onPressed: () {},
              child: Text(context.l.video_screen_add_zone),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  pip.PipHeader(
                    child: Column(
                      children: [
                        const SizedBox(height: 8.0),
                        Text(pageTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(context.l.video_screen_desc, textAlign: TextAlign.center),
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
                      CupertinoListTile(
                        title: Text(videoProvider.video.path!),
                        leading: const Icon(CupertinoIcons.cloud),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () async {
                          projectProvider.exitVideoScreen(videoProvider);
                          try {
                            dynamic url = await Navigator.of(
                              context,
                            ).pushNamed(urlRoute, arguments: {'url': video.path});
                            if (url != null && url != video.path) {
                              await videoProvider.setVideoPath(projectProvider.project!, url);
                              projectProvider.saveProject(videoProvider);
                            }
                          } finally {
                            projectProvider.enterVideoScreen(videoProvider);
                          }
                        },
                      ),

                      CupertinoListTile(
                        title: Text(
                          '${videoProvider.video.camera!.isFrontCamera ? context.l.camera_screen_front_camera : context.l.camera_screen_back_camera} ${videoProvider.video.camera!.title}',
                        ),
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
                          arguments: {'videoProvider': videoProvider, 'previousPageTitle': pageTitle},
                        ),
                      ),
                      // detection parameter
                      CupertinoListTile(
                        title: Text(context.l.video_screen_detection),
                        leading: const Icon(CupertinoIcons.eye),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () => Navigator.of(context).pushNamed(
                          detectionRoute,
                          arguments: {'videoProvider': videoProvider, 'previousPageTitle': pageTitle},
                        ),
                      ),
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
                            child: Text(
                              context.l.video_screen_delete_button,
                              style: TextStyle(color: CupertinoColors.systemRed),
                            ),
                          ),
                        ),
                      ),
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
  VideoScreenProvider({required this.projectProvider, required this.videoProvider}) {
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
