// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DaySummary _$DaySummaryFromJson(Map<String, dynamic> json) => _DaySummary(
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  day: (json['day'] as num).toInt(),
  fiveMinuteObservations: const ObservationSeriesConverter().fromJson(
    json['fiveMinuteObservations'] as List,
  ),
  hourlyTotals: (json['hourlyTotals'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  dailyTotal: Observation.fromJson(json['dailyTotal'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DaySummaryToJson(_DaySummary instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'fiveMinuteObservations': const ObservationSeriesConverter().toJson(
        instance.fiveMinuteObservations,
      ),
      'hourlyTotals': instance.hourlyTotals,
      'dailyTotal': instance.dailyTotal,
    };
