import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:vision/vision.dart' as vision;

import '../wizard_navigator.dart';
import 'pick_video.dart';

/// the video sources, like camera, webcam, live stream, file
List<Widget> buildVideoSources(
  BuildContext context, {
  required app.ProjectProvider projectProvider,
  required VideoSourcesProvider videoSourcesProvider,
  required bool isAddMode, // is add another video to project
  String? previousPageTitle,
}) {
  return [
    if (projectProvider.hasWebcam)
      CupertinoListTile(
          leading: videoSourcesProvider.isLoadingWebcam ? CupertinoActivityIndicator() : Icon(CupertinoIcons.videocam),
          title: Text(context.l.video_starter_webcam),
          trailing: CupertinoListTileChevron(),
          onTap: () async {
            videoSourcesProvider.setLoadingWebcam(true);
            try {
              // add webcam to project
              if (isAddMode) {
                final videoProvider =
                    await projectProvider.newVideoToProject(context, mediaType: vision.MediaType.webcam);
                if (context.mounted && videoProvider != null) {
                  Navigator.of(context).pushReplacementNamed(
                    webcamRoute,
                    arguments: {
                      'videoProvider': videoProvider,
                      'isAddMode': isAddMode,
                      'previousPageTitle': previousPageTitle,
                    },
                  );
                }
                return;
              }
              // create project with webcam
              await projectProvider.newProject(
                context,
                mediaType: vision.MediaType.webcam,
                projectId: app.uuid(),
              );
              if (context.mounted) {
                // wait 1 second for webcam to start. webcam tends to return before it's ready
                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  Navigator.of(context).pushNamed(projectRoute);
                }
              }
            } finally {
              videoSourcesProvider.setLoadingWebcam(false);
            }
          }),
    if (projectProvider.hasCamera && projectProvider.isAddCameraAllowed)
      CupertinoListTile(
        leading: videoSourcesProvider.isLoadingCamera ? CupertinoActivityIndicator() : Icon(CupertinoIcons.camera),
        title: Text(context.l.video_starter_camera),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingCamera(true);
          try {
            // add camera to project
            if (isAddMode) {
              final videoProvider =
                  await projectProvider.newVideoToProject(context, mediaType: vision.MediaType.camera);
              if (context.mounted && videoProvider != null) {
                Navigator.of(context).pushReplacementNamed(cameraRoute, arguments: {
                  'videoProvider': videoProvider,
                  'isAddMode': isAddMode,
                  'previousPageTitle': previousPageTitle,
                });
              }
              return;
            }

            // create project with camera
            await projectProvider.newProject(
              context,
              mediaType: vision.MediaType.camera,
              projectId: app.uuid(),
            );
            if (context.mounted) {
              // first goto start screen then camera screen immediately
              Navigator.of(context).pushNamed(projectRoute);
            }
          } finally {
            videoSourcesProvider.setLoadingCamera(false);
          }
        },
      ),
    if (projectProvider.isLiveStreamAllowed)
      CupertinoListTile(
        leading: videoSourcesProvider.isLoadingLiveStream ? CupertinoActivityIndicator() : Icon(CupertinoIcons.cloud),
        title: Text(context.l.video_starter_live_stream),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingLiveStream(true);
          try {
            // add live stream to project
            if (isAddMode) {
              await Navigator.of(context).pushNamed(urlRoute, arguments: {
                'nextRouteBuilder': (url) async {
                  await projectProvider.newVideoToProject(context, mediaType: vision.MediaType.live, path: url);
                  return projectRoute;
                }
              });
              return;
            }

            // create project with live stream
            Navigator.of(context).pushNamed(urlRoute, arguments: {
              'nextRouteBuilder': (url) async {
                projectProvider.newProject(
                  context,
                  mediaType: vision.MediaType.live,
                  path: url,
                  projectId: app.uuid(),
                );
                return projectRoute;
              }
            });
          } finally {
            videoSourcesProvider.setLoadingLiveStream(false);
          }
        },
      ),
    CupertinoListTile(
        leading: videoSourcesProvider.isLoadingFile ? CupertinoActivityIndicator() : Icon(CupertinoIcons.folder),
        title: Text(context.l.video_starter_file),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingFile(true);
          try {
            final projectId = app.uuid();

            final filePath = await pickVideo();
            if (!context.mounted || filePath == null) {
              return;
            }

            // add file to project
            if (isAddMode) {
              final videoId = projectProvider.getNextVideoId();
              final newFilePath = await saveFileToAppDirectory(
                filePath,
                projectProvider.project!.projectId,
                videoId,
              );
              if (!context.mounted) {
                return;
              }

              await projectProvider.newVideoToProject(context, mediaType: vision.MediaType.file, path: newFilePath);
              if (context.mounted) Navigator.of(context).pop();
              return;
            }

            // for sandbox safety
            final videoId = 1;
            final newFilePath = await saveFileToAppDirectory(filePath, projectId, videoId);
            if (!context.mounted) {
              return;
            }

            // create project with file
            await projectProvider.newProject(
              context,
              mediaType: vision.MediaType.file,
              path: newFilePath,
              projectId: projectId,
              videoId: videoId,
            );
            if (context.mounted) {
              Navigator.of(context).pushNamed(projectRoute);
            }
          } finally {
            videoSourcesProvider.setLoadingFile(false);
          }
        }),
  ];
}

/// provide video starter support.
class VideoSourcesProvider with ChangeNotifier {
  /// is loading camera
  bool isLoadingCamera = false;

  /// is loading webcam
  bool isLoadingWebcam = false;

  /// is loading file
  bool isLoadingFile = false;

  /// is loading live stream
  bool isLoadingLiveStream = false;

  /// set loading camera
  void setLoadingCamera(bool value) {
    isLoadingCamera = value;
    notifyListeners();
  }

  /// set loading webcam
  void setLoadingWebcam(bool value) {
    isLoadingWebcam = value;
    notifyListeners();
  }

  /// set loading file
  void setLoadingFile(bool value) {
    isLoadingFile = value;
    notifyListeners();
  }

  /// set loading live stream
  void setLoadingLiveStream(bool value) {
    isLoadingLiveStream = value;
    notifyListeners();
  }
}
