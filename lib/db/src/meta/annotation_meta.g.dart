// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnnotationMetaImpl _$$AnnotationMetaImplFromJson(Map<String, dynamic> json) =>
    _$AnnotationMetaImpl(
      type: $enumDecode(_$TallyTypeEnumMap, json['type']),
      enabled: json['enabled'] as bool,
      title: json['title'] as String,
      prefix: json['prefix'] as String,
      suffix: json['suffix'] as String,
    );

Map<String, dynamic> _$$AnnotationMetaImplToJson(
        _$AnnotationMetaImpl instance) =>
    <String, dynamic>{
      'type': _$TallyTypeEnumMap[instance.type]!,
      'enabled': instance.enabled,
      'title': instance.title,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
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
