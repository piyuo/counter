import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vision/vision.dart';

part 'annotation.freezed.dart';
part 'annotation.g.dart'; // JSON support

@freezed
class Annotation with _$Annotation {
  const factory Annotation({
    required TallyType type,
    required bool enabled,
    required String title,
    required String prefix,
    required String suffix,
  }) = _Annotation;

  factory Annotation.fromJson(Map<String, Object?> json) => _$AnnotationFromJson(json);
}
