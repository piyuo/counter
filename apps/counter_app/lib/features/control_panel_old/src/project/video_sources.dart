import 'package:counter_app/features/monitor/monitor.dart' as app;
import 'package:feature_pip/feature_pip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_l10n/shared_l10n.dart' as shared_l10n;
import 'package:universal_platform/universal_platform.dart';

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

  await showMessageDialog(
    context.l.video_sources_camera_not_found_message,
    title: context.l.video_sources_camera_not_found_title,
    label: context.l.ok,
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
  // ignore: use_build_context_synchronously
  await showMessageDialog(
    appkit.globalContext.l.video_sources_webcam_not_found_message,
    title: appkit.globalContext.l.video_sources_webcam_not_found_title,
    label: appkit.globalContext.l.ok,
  );
  return false;
}

/// check if we have phone camera permission, this function won't work on macos
Future<bool> havePhoneCameraPermission() async {
  var status = await Permission.camera.status;
  if (status.isPermanentlyDenied) {
    // ignore: use_build_context_synchronously
    final result = await showYesNoMessageDialog(
      appkit.globalContext.l.video_sources_camera_denied_msg,
      title: appkit.globalContext.l.video_sources_camera_denied,
      noLabel: appkit.globalContext.l.cancel,
      yesLabel: appkit.globalContext.l.video_sources_photos_goto_settings,
    );
    if (result == true) {
      await openAppSettings();
    }
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
        },
      ),
    // Camera
    if (UniversalPlatform.isMobile)
      CupertinoListTile(
        leading: videoSourcesProvider.isLoadingCamera ? CupertinoActivityIndicator() : Icon(CupertinoIcons.camera),
        title: Text(
          context.l.video_sources_camera,
          style: TextStyle(
            color: projectProvider.project != null && projectProvider.project!.hasCameraInVideos
                ? CupertinoColors.systemGrey.resolveFrom(context)
                : CupertinoColors.label.resolveFrom(context),
          ),
        ),
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
              },
      ),
    if (projectProvider.isLiveStreamAllowed)
      CupertinoListTile(
        leading: videoSourcesProvider.isLoadingLiveStream ? CupertinoActivityIndicator() : Icon(CupertinoIcons.cloud),
        title: Text(context.l.video_sources_live_stream),
        trailing: CupertinoListTileChevron(),
        onTap: () async {
          videoSourcesProvider.setLoadingLiveStream(true);
          try {} finally {
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
              // ignore: use_build_context_synchronously
              final result = await showYesNoMessageDialog(
                appkit.globalContext.l.video_sources_photos_denied_msg,
                title: appkit.globalContext.l.video_sources_photos_denied,
                noLabel: appkit.globalContext.l.cancel,
                yesLabel: appkit.globalContext.l.video_sources_photos_goto_settings,
              );
              if (result == true) {
                await openAppSettings();
              }
              // permanently denied, let user go to settings
              return;
            }
            // temporarily denied , just let user to pick again
            return;
          }
        } finally {
          videoSourcesProvider.setLoadingFile(false);
        }
      },
    ),
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
