import 'package:flutter_vision/flutter_vision.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'annotation_meta.freezed.dart';
part 'annotation_meta.g.dart'; // JSON support

@freezed
class AnnotationMeta with _$AnnotationMeta {
  const factory AnnotationMeta({
    required TallyType type,
    required bool enabled,
    required String title,
    required String prefix,
    required String suffix,
  }) = _AnnotationMeta;

  factory AnnotationMeta.fromJson(Map<String, Object?> json) => _$AnnotationMetaFromJson(json);
}
