import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vision/vision.dart';

import 'camera_meta.dart';
import 'webcam_meta.dart';
import 'zone_meta.dart';

part 'video_meta.freezed.dart';
part 'video_meta.g.dart'; // JSON support

@freezed
class VideoMeta with _$VideoMeta {
  @JsonSerializable(explicitToJson: true)
  const factory VideoMeta({
    required int videoId,
    required MediaType mediaType,
    required String videoName,
    required String? path,
    required CameraMeta? camera,
    required WebcamMeta? webcam,
    required double zoom,
    required List<ZoneMeta> zones,
  }) = _VideoMeta;

  factory VideoMeta.fromJson(Map<String, Object?> json) => _$VideoMetaFromJson(json);
}
