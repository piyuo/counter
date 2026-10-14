// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonthSummary _$MonthSummaryFromJson(Map<String, dynamic> json) =>
    _MonthSummary(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      fiveMinuteObservations: (json['fiveMinuteObservations'] as List<dynamic>)
          .map((e) => Observation.fromJson(e as Map<String, dynamic>))
          .toList(),
      hourlyObservations: (json['hourlyObservations'] as List<dynamic>)
          .map((e) => Observation.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyObservations: (json['dailyObservations'] as List<dynamic>)
          .map((e) => Observation.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyObservation: Observation.fromJson(
        json['monthlyObservation'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MonthSummaryToJson(_MonthSummary instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'fiveMinuteObservations': instance.fiveMinuteObservations,
      'hourlyObservations': instance.hourlyObservations,
      'dailyObservations': instance.dailyObservations,
      'monthlyObservation': instance.monthlyObservation,
    };
