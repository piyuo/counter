import 'package:freezed_annotation/freezed_annotation.dart';

import 'filter_meta.dart';
import 'video_meta.dart';

part 'project_meta.freezed.dart';
part 'project_meta.g.dart'; // JSON support

@freezed
class ProjectMeta with _$ProjectMeta {
  @JsonSerializable(explicitToJson: true)
  const factory ProjectMeta({
    required String projectId,
    required String projectName,
    required List<VideoMeta> videos,
    required FilterMeta filter,
    required bool isShowCenterRedDotOnTarget,
    required bool isShowGhostTarget,
  }) = _ProjectMeta;

  factory ProjectMeta.fromJson(Map<String, Object?> json) => _$ProjectMetaFromJson(json);
}
