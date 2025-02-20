// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnnotationImpl _$$AnnotationImplFromJson(Map<String, dynamic> json) =>
    _$AnnotationImpl(
      type: $enumDecode(_$TallyTypeEnumMap, json['type']),
      lastName: json['lastName'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$$AnnotationImplToJson(_$AnnotationImpl instance) =>
    <String, dynamic>{
      'type': _$TallyTypeEnumMap[instance.type]!,
      'lastName': instance.lastName,
      'age': instance.age,
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
