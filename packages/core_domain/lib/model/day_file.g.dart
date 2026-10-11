// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DayFile _$DayFileFromJson(Map<String, dynamic> json) => _DayFile(
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  day: (json['day'] as num).toInt(),
  fiveMinuteObservations: (json['fiveMinuteObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  hourlyObservations: (json['hourlyObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  dailyObservation: Observation.fromJson(
    json['dailyObservation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DayFileToJson(_DayFile instance) => <String, dynamic>{
  'year': instance.year,
  'month': instance.month,
  'day': instance.day,
  'fiveMinuteObservations': instance.fiveMinuteObservations,
  'hourlyObservations': instance.hourlyObservations,
  'dailyObservation': instance.dailyObservation,
};
