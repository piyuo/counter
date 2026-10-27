// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_YearSummary _$YearSummaryFromJson(Map<String, dynamic> json) => _YearSummary(
  year: (json['year'] as num).toInt(),
  weekdayFiveMinuteObservation: const ObservationSeriesConverter().fromJson(
    json['weekdayFiveMinuteObservation'] as List,
  ),
  weekendFiveMinuteObservation: const ObservationSeriesConverter().fromJson(
    json['weekendFiveMinuteObservation'] as List,
  ),
  dailyTotals: (json['dailyTotals'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  monthlyTotals: (json['monthlyTotals'] as List<dynamic>)
      .map((e) => Observation.fromJson(e as Map<String, dynamic>))
      .toList(),
  yearlyTotal: Observation.fromJson(
    json['yearlyTotal'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$YearSummaryToJson(_YearSummary instance) =>
    <String, dynamic>{
      'year': instance.year,
      'weekdayFiveMinuteObservation': const ObservationSeriesConverter().toJson(
        instance.weekdayFiveMinuteObservation,
      ),
      'weekendFiveMinuteObservation': const ObservationSeriesConverter().toJson(
        instance.weekendFiveMinuteObservation,
      ),
      'dailyTotals': instance.dailyTotals,
      'monthlyTotals': instance.monthlyTotals,
      'yearlyTotal': instance.yearlyTotal,
    };
