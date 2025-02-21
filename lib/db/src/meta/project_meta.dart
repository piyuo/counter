import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vision/vision.dart';

import 'filter_meta.dart';
import 'video_meta.dart';

part 'project_meta.freezed.dart';
part 'project_meta.g.dart'; // JSON support

@freezed
class ProjectMeta with _$ProjectMeta {
  @JsonSerializable(explicitToJson: true)
  const factory ProjectMeta({
    required String id,
    required String name,
    required List<VideoMeta> videos,
    required FilterMeta filter,
    required double confidence,
    required double nms,
    required double match,
    required int maxLostSeconds,
    required int valid,
    required double tracking,
    required Models model,
  }) = _ProjectMeta;

  factory ProjectMeta.fromJson(Map<String, Object?> json) => _$ProjectMetaFromJson(json);
}
