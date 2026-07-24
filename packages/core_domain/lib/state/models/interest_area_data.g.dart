// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_area_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InterestAreaData _$InterestAreaDataFromJson(Map<String, dynamic> json) =>
    _InterestAreaData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      color: (json['color'] as num?)?.toInt() ?? 0x00000000,
      points:
          (json['points'] as List<dynamic>?)
              ?.map((e) => PointData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$InterestAreaDataToJson(_InterestAreaData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'points': instance.points,
      'enabled': instance.enabled,
    };
