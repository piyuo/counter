// TOC:
// - ImportedVideoPickStatus: status for file pick/import flow
// - ImportedVideoPickResult: result payload for file pick/import flow
// - pickAndImportVideoFile: picks a video and copies it into app support storage
// - isManagedImportedVideoPath: identifies files managed by this feature
// - deleteManagedImportedVideo: deletes a previously imported managed file

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/widgets.dart';
import 'package:shared_l10n/shared_l10n.dart';

String buildVideoSourceName(BuildContext context, core_domain.VideoSource videoSource) {
  return switch (videoSource) {
    core_domain.CameraVideoSource(:final cameraIndex, :final isFaceFront) =>
      '${isFaceFront ? context.l.video_sources_front_camera : context.l.video_sources_back_camera} $cameraIndex',
    core_domain.WebcamVideoSource(:final webcamIndex) => '${context.l.video_sources_webcam} $webcamIndex',
    core_domain.FileVideoSource(:final path) => '${context.l.video_sources_file} ${path.split(path).last}',
    core_domain.LiveVideoSource(:final url) => '${context.l.video_sources_live_stream} $url',
    core_domain.UnspecifiedVideoSource() => 'Unspecified',
  };
}

String buildVideoSourceShortName(BuildContext context, core_domain.VideoSource videoSource) {
  return switch (videoSource) {
    core_domain.CameraVideoSource() => context.l.video_sources_camera,
    core_domain.WebcamVideoSource() => context.l.video_sources_webcam,
    core_domain.FileVideoSource() => context.l.video_sources_file,
    core_domain.LiveVideoSource() => context.l.video_sources_live_stream,
    core_domain.UnspecifiedVideoSource() => 'Unspecified',
  };
}
