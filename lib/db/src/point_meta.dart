import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_meta.freezed.dart';
part 'point_meta.g.dart'; // JSON support

@freezed
class PointMeta with _$PointMeta {
  const factory PointMeta({
    required int x,
    required int y,
  }) = _PointMeta;

  factory PointMeta.fromJson(Map<String, Object?> json) => _$PointMetaFromJson(json);
}
