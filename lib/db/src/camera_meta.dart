import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_meta.freezed.dart';
part 'camera_meta.g.dart'; // JSON support

@freezed
class CameraMeta with _$CameraMeta {
  const factory CameraMeta({
    required String name,
    required String title,
    required bool isFront,
  }) = _CameraMeta;

  factory CameraMeta.fromJson(Map<String, Object?> json) => _$CameraMetaFromJson(json);
}
