import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'annotation_meta.dart';
import 'color_converter.dart';
import 'point_meta.dart';

part 'zone_meta.freezed.dart';
part 'zone_meta.g.dart'; // JSON support

@freezed
class ZoneMeta with _$ZoneMeta {
  @JsonSerializable(explicitToJson: true)
  const factory ZoneMeta({
    required int zoneId,
    required List<AnnotationMeta> annotations,
    required List<int> classes,
    required String zoneName,
    required List<PointMeta> points,
    required int pointIndex,
    @ColorConverter() required Color color,
    required int stagnant,
    required int reentered,
    required int crossedZones,
    required int cooldown,
    required bool ignoreIfCounted,
  }) = _ZoneMeta;

  factory ZoneMeta.fromJson(Map<String, Object?> json) => _$ZoneMetaFromJson(json);
}
