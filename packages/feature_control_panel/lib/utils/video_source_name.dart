// TOC:
// - ImportedVideoPickStatus: status for file pick/import flow
// - ImportedVideoPickResult: result payload for file pick/import flow
// - pickAndImportVideoFile: picks a video and copies it into app support storage
// - isManagedImportedVideoPath: identifies files managed by this feature
// - deleteManagedImportedVideo: deletes a previously imported managed file

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/widgets.dart';

String buildVideoSourceName(BuildContext context, core_domain.VideoSource videoSource) {
  return switch (videoSource) {
    core_domain.CameraVideoSource(:final cameraIndex, :final isFaceFront) =>
      '${isFaceFront ? 'Front Camera' : 'Back Camera'} $cameraIndex',
    core_domain.WebcamVideoSource(:final webcamIndex) => 'Webcam $webcamIndex',
    core_domain.FileVideoSource(:final path) => 'File ${path.split(path).last}',
    core_domain.LiveVideoSource(:final url) => 'Live $url',
    core_domain.UnspecifiedVideoSource() => 'Unspecified',
  };
}
