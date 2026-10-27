// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MonthSummary _$MonthSummaryFromJson(Map<String, dynamic> json) =>
    _MonthSummary(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      weekdayFiveMinuteObservation: const ObservationSeriesConverter().fromJson(
        json['weekdayFiveMinuteObservation'] as List,
      ),
      weekendFiveMinuteObservation: const ObservationSeriesConverter().fromJson(
        json['weekendFiveMinuteObservation'] as List,
      ),
      hourlyTotals: (json['hourlyTotals'] as List<dynamic>)
          .map((e) => Observation.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyTotals: (json['dailyTotals'] as List<dynamic>)
          .map((e) => Observation.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyTotal: Observation.fromJson(
        json['monthlyTotal'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MonthSummaryToJson(_MonthSummary instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'weekdayFiveMinuteObservation': const ObservationSeriesConverter().toJson(
        instance.weekdayFiveMinuteObservation,
      ),
      'weekendFiveMinuteObservation': const ObservationSeriesConverter().toJson(
        instance.weekendFiveMinuteObservation,
      ),
      'hourlyTotals': instance.hourlyTotals,
      'dailyTotals': instance.dailyTotals,
      'monthlyTotal': instance.monthlyTotal,
    };
