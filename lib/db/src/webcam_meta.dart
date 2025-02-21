import 'package:freezed_annotation/freezed_annotation.dart';

part 'webcam_meta.freezed.dart';
part 'webcam_meta.g.dart'; // JSON support

@freezed
class WebcamMeta with _$WebcamMeta {
  const factory WebcamMeta({
    required int index,
    required String name,
  }) = _WebcamMeta;

  factory WebcamMeta.fromJson(Map<String, Object?> json) => _$WebcamMetaFromJson(json);
}
