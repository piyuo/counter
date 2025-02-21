// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ZoneMetaImpl _$$ZoneMetaImplFromJson(Map<String, dynamic> json) =>
    _$ZoneMetaImpl(
      id: (json['id'] as num).toInt(),
      annotations: (json['annotations'] as List<dynamic>)
          .map((e) => Annotation.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((e) => $enumDecode(_$TallyTypeEnumMap, e))
          .toList(),
      classes: (json['classes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      name: json['name'] as String,
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
      'id': instance.id,
      'annotations': instance.annotations.map((e) => e.toJson()).toList(),
      'types': instance.types.map((e) => _$TallyTypeEnumMap[e]!).toList(),
      'classes': instance.classes,
      'name': instance.name,
      'points': instance.points.map((e) => e.toJson()).toList(),
      'pointIndex': instance.pointIndex,
      'color': const ColorConverter().toJson(instance.color),
      'stagnant': instance.stagnant,
      'reentered': instance.reentered,
      'crossedZones': instance.crossedZones,
      'cooldown': instance.cooldown,
      'ignoreIfCounted': instance.ignoreIfCounted,
    };

const _$TallyTypeEnumMap = {
  TallyType.detected: 'detected',
  TallyType.spawned: 'spawned',
  TallyType.vanished: 'vanished',
  TallyType.entered: 'entered',
  TallyType.exited: 'exited',
  TallyType.stagnant: 'stagnant',
  TallyType.reentered: 'reentered',
  TallyType.occupied: 'occupied',
  TallyType.stayDuration: 'stayDuration',
};
