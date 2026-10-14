// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummary _$YearSummaryFromJson(Map<String, dynamic> json) => _YearSummary(
  year: (json['year'] as num).toInt(),
  fiveMinuteObservations: (json['fiveMinuteObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  dailyObservations: (json['dailyObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  monthlyObservations: (json['monthlyObservations'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  yearlyObservation: Observation.fromJson(
    json['yearlyObservation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$YearSummaryToJson(_YearSummary instance) =>
    <String, dynamic>{
      'year': instance.year,
      'fiveMinuteObservations': instance.fiveMinuteObservations,
      'dailyObservations': instance.dailyObservations,
      'monthlyObservations': instance.monthlyObservations,
      'yearlyObservation': instance.yearlyObservation,
    };
