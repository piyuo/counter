// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ZoneMetaImpl _$$ZoneMetaImplFromJson(Map<String, dynamic> json) =>
    _$ZoneMetaImpl(
      zoneId: (json['zoneId'] as num).toInt(),
      showSummaryOnScreen: json['showSummaryOnScreen'] as bool,
      annotations: (json['annotations'] as List<dynamic>)
          .map((e) => AnnotationMeta.fromJson(e as Map<String, dynamic>))
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
      'showSummaryOnScreen': instance.showSummaryOnScreen,
      'annotations': instance.annotations.map((e) => e.toJson()).toList(),
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
