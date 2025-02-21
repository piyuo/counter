// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterMetaImpl _$$FilterMetaImplFromJson(Map<String, dynamic> json) =>
    _$FilterMetaImpl(
      filterType: $enumDecode(_$FilterTypeEnumMap, json['filterType']),
      start: TimeOfDayMeta.fromJson(json['start'] as Map<String, dynamic>),
      end: TimeOfDayMeta.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FilterMetaImplToJson(_$FilterMetaImpl instance) =>
    <String, dynamic>{
      'filterType': _$FilterTypeEnumMap[instance.filterType]!,
      'start': instance.start.toJson(),
      'end': instance.end.toJson(),
    };

const _$FilterTypeEnumMap = {
  FilterType.pass1Hour: 'pass1Hour',
  FilterType.pass2Hour: 'pass2Hour',
  FilterType.pass4Hour: 'pass4Hour',
  FilterType.pass8Hour: 'pass8Hour',
  FilterType.past12Hour: 'past12Hour',
  FilterType.past24Hour: 'past24Hour',
  FilterType.custom: 'custom',
};
