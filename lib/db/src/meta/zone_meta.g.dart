// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ZoneMetaImpl _$$ZoneMetaImplFromJson(Map<String, dynamic> json) =>
    _$ZoneMetaImpl(
      zoneId: (json['zoneId'] as num).toInt(),
      annotations: (json['annotations'] as List<dynamic>)
          .map((e) => AnnotationMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      classes: (json['classes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      zoneName: json['zoneName'] as String,
      points: (json['points'] as List<dynamic>)
          .map((e) => PointMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      pointIndex: (json['pointIndex'] as num).toInt(),
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      stagnant: (json['stagnant'] as num).toInt(),
      reentered: (json['reentered'] as num).toInt(),
      crossedZones: (json['crossedZones'] as num).toInt(),
      cooldown: (json['cooldown'] as num).toInt(),
      ignoreIfCounted: json['ignoreIfCounted'] as bool,
    );

Map<String, dynamic> _$$ZoneMetaImplToJson(_$ZoneMetaImpl instance) =>
    <String, dynamic>{
      'zoneId': instance.zoneId,
      'annotations': instance.annotations.map((e) => e.toJson()).toList(),
      'classes': instance.classes,
      'zoneName': instance.zoneName,
      'points': instance.points.map((e) => e.toJson()).toList(),
      'pointIndex': instance.pointIndex,
      'color': const ColorConverter().toJson(instance.color),
      'stagnant': instance.stagnant,
      'reentered': instance.reentered,
      'crossedZones': instance.crossedZones,
      'cooldown': instance.cooldown,
      'ignoreIfCounted': instance.ignoreIfCounted,
    };
