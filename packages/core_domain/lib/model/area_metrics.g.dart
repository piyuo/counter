// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
  occupancySampleSumSquares: (json['occupancySampleSumSquares'] as num).toInt(),
  occupancyMean: const RoundedDouble().fromJson(json['occupancyMean']),
  occupancyMax: (json['occupancyMax'] as num).toInt(),
  occupancyLast: (json['occupancyLast'] as num).toInt(),
  dwellSampleCount: (json['dwellSampleCount'] as num).toInt(),
  dwellSumSeconds: (json['dwellSumSeconds'] as num).toInt(),
  dwellMeanSeconds: const RoundedDouble().fromJson(json['dwellMeanSeconds']),
  dwellMaxSeconds: (json['dwellMaxSeconds'] as num).toInt(),
  dwellHistogram:
      (json['dwellHistogram'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [0, 0, 0, 0, 0],
  presenceTrackCount: (json['presenceTrackCount'] as num?)?.toInt() ?? 0,
  presenceSumSeconds: (json['presenceSumSeconds'] as num?)?.toInt() ?? 0,
  presenceMeanSeconds: json['presenceMeanSeconds'] == null
      ? 0
      : const RoundedDouble().fromJson(json['presenceMeanSeconds']),
);

Map<String, dynamic> _$AreaMetricsToJson(
  _AreaMetrics instance,
) => <String, dynamic>{
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
  'occupancySampleSumSquares': instance.occupancySampleSumSquares,
  'occupancyMean': const RoundedDouble().toJson(instance.occupancyMean),
  'occupancyMax': instance.occupancyMax,
  'occupancyLast': instance.occupancyLast,
  'dwellSampleCount': instance.dwellSampleCount,
  'dwellSumSeconds': instance.dwellSumSeconds,
  'dwellMeanSeconds': const RoundedDouble().toJson(instance.dwellMeanSeconds),
  'dwellMaxSeconds': instance.dwellMaxSeconds,
  'dwellHistogram': instance.dwellHistogram,
  'presenceTrackCount': instance.presenceTrackCount,
  'presenceSumSeconds': instance.presenceSumSeconds,
  'presenceMeanSeconds': const RoundedDouble().toJson(
    instance.presenceMeanSeconds,
  ),
};
