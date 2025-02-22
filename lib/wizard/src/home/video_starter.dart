import 'package:counter/app/app.dart' as app;
import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:vision/clib/clib.dart' as clib;

import '../wizard_navigator.dart';
import 'pick_video.dart';

/// the video starter list,like camera, webcam, live stream, file
List<Widget> buildVideoStarter(
  BuildContext context, {
  required app.ProjectProvider projectProvider,
  required VideoStarterProvider videoStarterProvider,
  required bool isAddMode,
  String? previousPageTitle,
}) {
  return [
    if (projectProvider.hasWebcam)
      CupertinoListTile(
          leading: videoStarterProvider.isLoadingWebcam ? CupertinoActivityIndicator() : Icon(CupertinoIcons.videocam),
          title: Text(context.l.video_starter_webcam),
          trailing: CupertinoListTileChevron(),
          onTap: () async {
            videoStarterProvider.setLoadingWebcam(true);
            try {
              // add webcam to project
              if (isAddMode) {
                final videoProvider = await projectProvider.newVideoToProject(context, type: clib.MediaType.webcam);
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
              await projectProvider.newProject(context, type: clib.MediaType.webcam);
              if (context.mounted) {
                Navigator.of(context).pushNamed(homeRoute);
              }
            } finally {
              videoStarterProvider.setLoadingWebcam(false);
            }
          }),
    if (projectProvider.hasCamera && projectProvider.isAddCameraAllowed)
      CupertinoListTile(
        leading: videoStarterProvider.isLoadingCamera ? CupertinoActivityIndicator() : Icon(CupertinoIcons.camera),
        title: Text(context.l.video_starter_camera),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoStarterProvider.setLoadingCamera(true);
          try {
            // add camera to project
            if (isAddMode) {
              final videoProvider = await projectProvider.newVideoToProject(context, type: clib.MediaType.camera);
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
            await projectProvider.newProject(context, type: clib.MediaType.camera);
            if (context.mounted) {
              // first goto start screen then camera screen immediately
              Navigator.of(context).pushNamed(homeRoute);
            }
          } finally {
            videoStarterProvider.setLoadingCamera(false);
          }
        },
      ),
    if (projectProvider.isLiveStreamAllowed)
      CupertinoListTile(
        leading: videoStarterProvider.isLoadingLiveStream ? CupertinoActivityIndicator() : Icon(CupertinoIcons.cloud),
        title: Text(context.l.video_starter_live_stream),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoStarterProvider.setLoadingLiveStream(true);
          try {
            // add live stream to project
            if (isAddMode) {
              await Navigator.of(context).pushNamed(urlRoute, arguments: {
                'nextRouteBuilder': (url) async {
                  await projectProvider.newVideoToProject(context, type: clib.MediaType.live, path: url);
                  return homeRoute;
                }
              });
              return;
            }

            // create project with live stream
            Navigator.of(context).pushNamed(urlRoute, arguments: {
              'nextRouteBuilder': (url) async {
                projectProvider.newProject(context, type: clib.MediaType.live, path: url);
                return homeRoute;
              }
            });
          } finally {
            videoStarterProvider.setLoadingLiveStream(false);
          }
        },
      ),
    CupertinoListTile(
        leading: videoStarterProvider.isLoadingFile ? CupertinoActivityIndicator() : Icon(CupertinoIcons.folder),
        title: Text(context.l.video_starter_file),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoStarterProvider.setLoadingFile(true);
          try {
            final filePath = await pickVideo();
            if (!context.mounted || filePath == null) {
              return;
            }

            // add file to project
            if (isAddMode) {
              await projectProvider.newVideoToProject(context, type: clib.MediaType.file, path: filePath);
              if (context.mounted) Navigator.of(context).pop();
              return;
            }

            // create project with file
            await projectProvider.newProject(context, type: clib.MediaType.file, path: filePath);
            if (context.mounted) {
              Navigator.of(context).pushNamed(homeRoute);
            }
          } finally {
            videoStarterProvider.setLoadingFile(false);
          }
        }),
  ];
}

/// provide video starter support.
class VideoStarterProvider with ChangeNotifier {
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
