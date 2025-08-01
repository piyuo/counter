import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';

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
Future<bool> isWebcamExists(app.ProjectProvider projectProvider) async {
  final webcamManager = await projectProvider.getWebcamManager();
  if (webcamManager.hasWebcam) {
    return true;
  }

  // show dialog to say camera not found
  await showCupertinoDialog(
    // ignore: use_build_context_synchronously
    context: appkit.globalContext,
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

/// check if we have phone camera permission, this function won't work on macos
Future<bool> havePhoneCameraPermission() async {
  var status = await Permission.camera.status;
  if (status.isPermanentlyDenied) {
    await showCupertinoDialog(
      // ignore: use_build_context_synchronously
      context: appkit.globalContext,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(context.l.video_sources_camera_denied),
          content: Text(context.l.video_sources_camera_denied_msg),
          actions: [
            CupertinoDialogAction(
              textStyle: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.l.cancel),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(context.l.video_sources_photos_goto_settings),
              onPressed: () async {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return false;
  }
  return true;
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
            try {
              if (!await isWebcamExists(projectProvider)) {
                return;
              }

              // add webcam to project
              if (isAddMode) {
                final videoProvider = await projectProvider.newVideoToProject(mediaType: vision.SourceType.webcam);
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
                mediaType: vision.SourceType.webcam,
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

                if (await havePhoneCameraPermission() == false) {
                  videoSourcesProvider.setLoadingCamera(false);
                  return;
                }

                try {
                  // add camera to project
                  if (isAddMode) {
                    final videoProvider = await projectProvider.newVideoToProject(mediaType: vision.SourceType.camera);
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
                    mediaType: vision.SourceType.camera,
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
                  await projectProvider.newVideoToProject(mediaType: vision.SourceType.liveStream, path: url);
                  return projectRoute;
                }
              });
              return;
            }

            // create project with live stream
            Navigator.of(context).pushNamed(urlRoute, arguments: {
              'nextRouteBuilder': (url) async {
                projectProvider.newProject(
                  mediaType: vision.SourceType.liveStream,
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
    // pick video
    CupertinoListTile(
        leading: videoSourcesProvider.isLoadingFile ? CupertinoActivityIndicator() : Icon(CupertinoIcons.folder),
        title: Text(context.l.video_sources_file),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingFile(true);
          try {
            final projectId = app.uuid();
            final filePath = await pickVideo();
            if (filePath == 'denied') {
              var status = await Permission.photos.status;
              if (status.isPermanentlyDenied) {
                await showCupertinoDialog(
                  // ignore: use_build_context_synchronously
                  context: appkit.globalContext,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text(context.l.video_sources_photos_denied),
                      content: Text(context.l.video_sources_photos_denied_msg),
                      actions: [
                        CupertinoDialogAction(
                          textStyle: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(context.l.cancel),
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text(context.l.video_sources_photos_goto_settings),
                          onPressed: () async {
                            openAppSettings();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                // permanently denied, let user go to settings
                return;
              }
              // temporarily denied , just let user to pick again
              return;
            }

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

              await projectProvider.newVideoToProject(mediaType: vision.SourceType.file, path: newFilePath);
              if (context.mounted) Navigator.of(context).pop();
              return;
            }

            // for sandbox safety
            final videoId = 1;
            final newFilePath = await saveFileToAppDirectory(filePath, projectId, videoId);
            // create project with file
            await projectProvider.newProject(
              mediaType: vision.SourceType.file,
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
