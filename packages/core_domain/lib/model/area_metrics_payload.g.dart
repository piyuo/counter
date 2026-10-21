// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_metrics_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AreaMetricsPayload _$AreaMetricsPayloadFromJson(
  Map<String, dynamic> json,
) => _AreaMetricsPayload(
  areaId: (json['areaId'] as num).toInt(),
  areaName: json['areaName'] as String,
  passBy: (json['passBy'] as num?)?.toInt() ?? 0,
  stagnant: (json['stagnant'] as num?)?.toInt() ?? 0,
  entry: (json['entry'] as num?)?.toInt() ?? 0,
  exit: (json['exit'] as num?)?.toInt() ?? 0,
  appear: (json['appear'] as num?)?.toInt() ?? 0,
  disappear: (json['disappear'] as num?)?.toInt() ?? 0,
  occupancySampleCount: (json['occupancySampleCount'] as num?)?.toInt() ?? 0,
  occupancySum: (json['occupancySum'] as num?)?.toInt() ?? 0,
  occupancyMean: json['occupancyMean'] == null
      ? 0
      : const RoundedDouble().fromJson(json['occupancyMean']),
  occupancySumSquares: (json['occupancySumSquares'] as num?)?.toInt() ?? 0,
  occupancyVariance: json['occupancyVariance'] == null
      ? 0
      : const RoundedDouble().fromJson(json['occupancyVariance']),
  occupancyMax: (json['occupancyMax'] as num?)?.toInt() ?? 0,
  occupancyLast: (json['occupancyLast'] as num?)?.toInt() ?? 0,
  dwellSampleCount: (json['dwellSampleCount'] as num?)?.toInt() ?? 0,
  dwellSumSeconds: (json['dwellSumSeconds'] as num?)?.toInt() ?? 0,
  dwellMeanSeconds: const RoundedDouble().fromJson(json['dwellMeanSeconds']),
  dwellMaxSeconds: (json['dwellMaxSeconds'] as num?)?.toInt() ?? 0,
  dwellHistogram:
      (json['dwellHistogram'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [0, 0, 0, 0, 0, 0, 0, 0],
  presenceSampleCount: (json['presenceSampleCount'] as num?)?.toInt() ?? 0,
  presenceSumSeconds: (json['presenceSumSeconds'] as num?)?.toInt() ?? 0,
  presenceMeanSeconds: json['presenceMeanSeconds'] == null
      ? 0
      : const RoundedDouble().fromJson(json['presenceMeanSeconds']),
);

Map<String, dynamic> _$AreaMetricsPayloadToJson(
  _AreaMetricsPayload instance,
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
  'occupancySum': instance.occupancySum,
  'occupancyMean': const RoundedDouble().toJson(instance.occupancyMean),
  'occupancySumSquares': instance.occupancySumSquares,
  'occupancyVariance': const RoundedDouble().toJson(instance.occupancyVariance),
  'occupancyMax': instance.occupancyMax,
  'occupancyLast': instance.occupancyLast,
  'dwellSampleCount': instance.dwellSampleCount,
  'dwellSumSeconds': instance.dwellSumSeconds,
  'dwellMeanSeconds': const RoundedDouble().toJson(instance.dwellMeanSeconds),
  'dwellMaxSeconds': instance.dwellMaxSeconds,
  'dwellHistogram': instance.dwellHistogram,
  'presenceSampleCount': instance.presenceSampleCount,
  'presenceSumSeconds': instance.presenceSumSeconds,
  'presenceMeanSeconds': const RoundedDouble().toJson(
    instance.presenceMeanSeconds,
  ),
};
