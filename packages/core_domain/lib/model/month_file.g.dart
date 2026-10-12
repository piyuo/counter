// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonthFile _$MonthFileFromJson(Map<String, dynamic> json) => _MonthFile(
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  dailyObservations: (json['dailyObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  hourlyObservations: (json['hourlyObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  monthlyObservation: Observation.fromJson(
    json['monthlyObservation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MonthFileToJson(_MonthFile instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'dailyObservations': instance.dailyObservations,
      'hourlyObservations': instance.hourlyObservations,
      'monthlyObservation': instance.monthlyObservation,
    };
