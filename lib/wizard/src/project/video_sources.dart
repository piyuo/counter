import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vision/vision.dart' as vision;

import '../wizard_app.dart';
import 'pick_video.dart';

/// check if camera exists, check when user click on camera is much better than check on start, cause check camera on start will slow down the app start
Future<bool> isCameraExists(BuildContext context, app.ProjectProvider projectProvider) async {
  final cameraManager = await projectProvider.getCameraManager();
  if (cameraManager.hasCamera) {
    return true;
  }

  if (!context.mounted) {
    return false;
  }

  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(context.l.video_sources_camera_not_found_title),
        content: Text(context.l.video_sources_camera_not_found_message),
        actions: [
          CupertinoDialogAction(
            child: Text(context.l.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  return false;
}

/// check if webcam exists, check when user click on webcam is much better than check on start, cause check webcam on start will slow down the app start
Future<bool> isWebcamExists(BuildContext context, app.ProjectProvider projectProvider) async {
  final webcamManager = await projectProvider.getWebcamManager();
  if (webcamManager.hasWebcam) {
    return true;
  }

  if (!context.mounted) {
    return false;
  }

  // show dialog to say camera not found
  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(context.l.video_sources_webcam_not_found_title),
        content: Text(context.l.video_sources_webcam_not_found_message),
        actions: [
          CupertinoDialogAction(
            child: Text(context.l.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  return false;
}

/// the video sources, like camera, webcam, live stream, file
List<Widget> buildVideoSources(
  BuildContext context, {
  required app.ProjectProvider projectProvider,
  required VideoSourcesProvider videoSourcesProvider,
  required bool isAddMode, // is add another video to project
  String? previousPageTitle,
}) {
  return [
    // Webcam
    if (UniversalPlatform.isDesktop)
      CupertinoListTile(
          leading: videoSourcesProvider.isLoadingWebcam ? CupertinoActivityIndicator() : Icon(CupertinoIcons.videocam),
          title: Text(context.l.video_sources_webcam),
          trailing: CupertinoListTileChevron(),
          onTap: () async {
            videoSourcesProvider.setLoadingWebcam(true);
            if (!await isWebcamExists(context, projectProvider)) {
              videoSourcesProvider.setLoadingWebcam(false);
              return;
            }

            try {
              // add webcam to project
              if (isAddMode) {
                final videoProvider = await projectProvider.newVideoToProject(mediaType: vision.MediaType.webcam);
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
                mediaType: vision.MediaType.webcam,
                projectId: app.uuid(),
              );
              // wait 1 second for webcam to start. webcam tends to return before it's ready
              await Future.delayed(const Duration(milliseconds: 300));
              if (context.mounted) {
                Navigator.of(context).pushNamed(projectRoute);
              }
            } finally {
              videoSourcesProvider.setLoadingWebcam(false);
            }
          }),
    // Camera
    if (UniversalPlatform.isMobile)
      CupertinoListTile(
        leading: videoSourcesProvider.isLoadingCamera ? CupertinoActivityIndicator() : Icon(CupertinoIcons.camera),
        title: Text(context.l.video_sources_camera,
            style: TextStyle(
              color: projectProvider.project != null && projectProvider.project!.hasCameraInVideos
                  ? CupertinoColors.systemGrey.resolveFrom(context)
                  : CupertinoColors.label.resolveFrom(context),
            )),
        trailing: projectProvider.project != null && projectProvider.project!.hasCameraInVideos
            ? null
            : CupertinoListTileChevron(),
        onTap: projectProvider.project != null && projectProvider.project!.hasCameraInVideos
            ? null
            : () async {
                videoSourcesProvider.setLoadingCamera(true);
                if (!await isCameraExists(context, projectProvider)) {
                  videoSourcesProvider.setLoadingCamera(false);
                  return;
                }
                try {
                  // add camera to project
                  if (isAddMode) {
                    final videoProvider = await projectProvider.newVideoToProject(mediaType: vision.MediaType.camera);
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
        title: Text(context.l.video_sources_live_stream),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingLiveStream(true);
          try {
            // add live stream to project
            if (isAddMode) {
              await Navigator.of(context).pushNamed(urlRoute, arguments: {
                'nextRouteBuilder': (url) async {
                  await projectProvider.newVideoToProject(mediaType: vision.MediaType.live, path: url);
                  return projectRoute;
                }
              });
              return;
            }

            // create project with live stream
            Navigator.of(context).pushNamed(urlRoute, arguments: {
              'nextRouteBuilder': (url) async {
                projectProvider.newProject(
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
        title: Text(context.l.video_sources_file),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingFile(true);
          try {
            final projectId = app.uuid();

            final filePath = await pickVideo();
            if (filePath == null) {
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

              await projectProvider.newVideoToProject(mediaType: vision.MediaType.file, path: newFilePath);
              if (context.mounted) Navigator.of(context).pop();
              return;
            }

            // for sandbox safety
            final videoId = 1;
            final newFilePath = await saveFileToAppDirectory(filePath, projectId, videoId);
            // create project with file
            await projectProvider.newProject(
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
