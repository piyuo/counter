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
  confidenceRatioSum: const RoundedDouble().fromJson(
    json['confidenceRatioSum'],
  ),
  confidenceSampleCount: (json['confidenceSampleCount'] as num).toInt(),
  confidenceRatio: const RoundedDouble().fromJson(json['confidenceRatio']),
  coveredSeconds: (json['coveredSeconds'] as num).toInt(),
  expectedSeconds: (json['expectedSeconds'] as num).toInt(),
  coverageRatio: const RoundedDouble().fromJson(json['coverageRatio']),
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
      'confidenceRatioSum': const RoundedDouble().toJson(
        instance.confidenceRatioSum,
      ),
      'confidenceSampleCount': instance.confidenceSampleCount,
      'confidenceRatio': const RoundedDouble().toJson(instance.confidenceRatio),
      'coveredSeconds': instance.coveredSeconds,
      'expectedSeconds': instance.expectedSeconds,
      'coverageRatio': const RoundedDouble().toJson(instance.coverageRatio),
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

_AreaMetrics _$AreaMetricsFromJson(Map<String, dynamic> json) => _AreaMetrics(
  areaId: (json['areaId'] as num).toInt(),
  areaName: json['areaName'] as String,
  passBy: (json['passBy'] as num).toInt(),
  stagnant: (json['stagnant'] as num).toInt(),
  entry: (json['entry'] as num).toInt(),
  exit: (json['exit'] as num).toInt(),
  appear: (json['appear'] as num).toInt(),
  disappear: (json['disappear'] as num).toInt(),
  occupancySampleCount: (json['occupancySampleCount'] as num).toInt(),
  occupancySampleSum: (json['occupancySampleSum'] as num).toInt(),
  occupancyAvg: const RoundedDouble().fromJson(json['occupancyAvg']),
  occupancyMax: (json['occupancyMax'] as num).toInt(),
  occupancyLast: (json['occupancyLast'] as num).toInt(),
  dwellSumSeconds: (json['dwellSumSeconds'] as num).toInt(),
  dwellSampleCount: (json['dwellSampleCount'] as num).toInt(),
  dwellAvgSeconds: const RoundedDouble().fromJson(json['dwellAvgSeconds']),
  dwellMaxSeconds: (json['dwellMaxSeconds'] as num).toInt(),
);

Map<String, dynamic> _$AreaMetricsToJson(_AreaMetrics instance) =>
    <String, dynamic>{
      'areaId': instance.areaId,
      'areaName': instance.areaName,
      'passBy': instance.passBy,
      'stagnant': instance.stagnant,
      'entry': instance.entry,
      'exit': instance.exit,
      'appear': instance.appear,
      'disappear': instance.disappear,
      'occupancySampleCount': instance.occupancySampleCount,
      'occupancySampleSum': instance.occupancySampleSum,
      'occupancyAvg': const RoundedDouble().toJson(instance.occupancyAvg),
      'occupancyMax': instance.occupancyMax,
      'occupancyLast': instance.occupancyLast,
      'dwellSumSeconds': instance.dwellSumSeconds,
      'dwellSampleCount': instance.dwellSampleCount,
      'dwellAvgSeconds': const RoundedDouble().toJson(instance.dwellAvgSeconds),
      'dwellMaxSeconds': instance.dwellMaxSeconds,
    };
