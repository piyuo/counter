// Model: VideoSource (sealed union)
// Description: Vision source the counter reads from. JSON-serialisable; persisted in AppState.
// Variants:
//   - VideoSource.unspecified()          — default before setup
//   - VideoSource.camera({cameraIndex})  — mobile / desktop camera
//   - VideoSource.webcam({webcamIndex})  — desktop webcam
//   - VideoSource.file({fileName})       — local video / image file
//   - VideoSource.liveUrl({url})         — RTSP / HTTP stream URL
// Helpers:
//   - hasMadeDecision : bool — true when not unspecified

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_source.freezed.dart';
part 'video_source.g.dart';

@freezed
sealed class VideoSource with _$VideoSource {
  const VideoSource._();

  const factory VideoSource.unspecified() = UnspecifiedVideoSource;

  const factory VideoSource.camera({required int cameraIndex}) = CameraVideoSource;

  const factory VideoSource.webcam({required int webcamIndex}) = WebcamVideoSource;

  const factory VideoSource.file({required String path}) = FileVideoSource;

  const factory VideoSource.live({required String url}) = LiveVideoSource;

  factory VideoSource.fromJson(Map<String, dynamic> json) => _$VideoSourceFromJson(json);

  bool get hasMadeDecision => this is! UnspecifiedVideoSource;
}
