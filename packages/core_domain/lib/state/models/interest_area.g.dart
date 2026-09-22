// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InterestArea _$InterestAreaFromJson(Map<String, dynamic> json) =>
    _InterestArea(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      savedColor: (json['savedColor'] as num?)?.toInt() ?? 0x00000000,
      points:
          (json['points'] as List<dynamic>?)
              ?.map((e) => PointData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$InterestAreaToJson(_InterestArea instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'savedColor': instance.savedColor,
      'points': instance.points,
      'enabled': instance.enabled,
    };
