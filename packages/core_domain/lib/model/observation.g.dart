// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Observation _$ObservationFromJson(Map<String, dynamic> json) => _Observation(
  granularity:
      $enumDecodeNullable(
        _$ObservationGranularityEnumMap,
        json['granularity'],
      ) ??
      ObservationGranularity.minutes5,
  year: (json['year'] as num).toInt(),
  month: (json['month'] as num).toInt(),
  day: (json['day'] as num).toInt(),
  hour: (json['hour'] as num).toInt(),
  minute: (json['minute'] as num).toInt(),
  confidenceSum: json['confidenceSum'] == null
      ? 0
      : const RoundedDouble().fromJson(json['confidenceSum']),
  confidenceSampleCount: (json['confidenceSampleCount'] as num?)?.toInt() ?? 0,
  coveredSeconds: (json['coveredSeconds'] as num?)?.toInt() ?? 0,
  areas: (json['areas'] as List<dynamic>)
      .map((e) => AreaMetrics.fromJson(e as Map<String, dynamic>))
      .toList(),
  frameCount: (json['frameCount'] as num).toInt(),
);

Map<String, dynamic> _$ObservationToJson(_Observation instance) =>
    <String, dynamic>{
      'granularity': _$ObservationGranularityEnumMap[instance.granularity]!,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hour': instance.hour,
      'minute': instance.minute,
      'confidenceSum': const RoundedDouble().toJson(instance.confidenceSum),
      'confidenceSampleCount': instance.confidenceSampleCount,
      'coveredSeconds': instance.coveredSeconds,
      'areas': instance.areas,
      'frameCount': instance.frameCount,
    };

const _$ObservationGranularityEnumMap = {
  ObservationGranularity.minutes5: 'minutes5',
  ObservationGranularity.hour: 'hour',
  ObservationGranularity.day: 'day',
  ObservationGranularity.month: 'month',
  ObservationGranularity.year: 'year',
};
