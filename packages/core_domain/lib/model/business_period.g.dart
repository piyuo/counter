// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessPeriod _$BusinessPeriodFromJson(Map<String, dynamic> json) =>
    _BusinessPeriod(
      id: json['id'] as String,
      name: json['name'] as String,
      startMinute: (json['startMinute'] as num).toInt(),
      endMinute: (json['endMinute'] as num).toInt(),
    );

Map<String, dynamic> _$BusinessPeriodToJson(_BusinessPeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
    };
