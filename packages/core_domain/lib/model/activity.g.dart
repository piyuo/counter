// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Activity _$ActivityFromJson(Map<String, dynamic> json) => _Activity(
  areaId: (json['areaId'] as num).toInt(),
  areaName: json['areaName'] as String,
  passBy: json['passBy'] == null
      ? 0
      : const RoundedDouble().fromJson(json['passBy']),
  stagnant: json['stagnant'] == null
      ? 0
      : const RoundedDouble().fromJson(json['stagnant']),
  entry: json['entry'] == null
      ? 0
      : const RoundedDouble().fromJson(json['entry']),
  exit: json['exit'] == null ? 0 : const RoundedDouble().fromJson(json['exit']),
  appear: json['appear'] == null
      ? 0
      : const RoundedDouble().fromJson(json['appear']),
  disappear: json['disappear'] == null
      ? 0
      : const RoundedDouble().fromJson(json['disappear']),
  occupancySampleCount: (json['occupancySampleCount'] as num?)?.toInt() ?? 0,
  occupancySum: (json['occupancySum'] as num?)?.toInt() ?? 0,
  occupancySumSquares: (json['occupancySumSquares'] as num?)?.toInt() ?? 0,
  occupancyMax: (json['occupancyMax'] as num?)?.toInt() ?? 0,
  occupancyLast: (json['occupancyLast'] as num?)?.toInt() ?? 0,
  dwellSampleCount: (json['dwellSampleCount'] as num?)?.toInt() ?? 0,
  dwellSumSeconds: (json['dwellSumSeconds'] as num?)?.toInt() ?? 0,
  dwellMaxSeconds: (json['dwellMaxSeconds'] as num?)?.toInt() ?? 0,
  dwellHistogram:
      (json['dwellHistogram'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [0, 0, 0, 0, 0, 0, 0, 0],
  presenceSampleCount: (json['presenceSampleCount'] as num?)?.toInt() ?? 0,
  presenceSumSeconds: (json['presenceSumSeconds'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ActivityToJson(_Activity instance) => <String, dynamic>{
  'areaId': instance.areaId,
  'areaName': instance.areaName,
  'passBy': const RoundedDouble().toJson(instance.passBy),
  'stagnant': const RoundedDouble().toJson(instance.stagnant),
  'entry': const RoundedDouble().toJson(instance.entry),
  'exit': const RoundedDouble().toJson(instance.exit),
  'appear': const RoundedDouble().toJson(instance.appear),
  'disappear': const RoundedDouble().toJson(instance.disappear),
  'occupancySampleCount': instance.occupancySampleCount,
  'occupancySum': instance.occupancySum,
  'occupancySumSquares': instance.occupancySumSquares,
  'occupancyMax': instance.occupancyMax,
  'occupancyLast': instance.occupancyLast,
  'dwellSampleCount': instance.dwellSampleCount,
  'dwellSumSeconds': instance.dwellSumSeconds,
  'dwellMaxSeconds': instance.dwellMaxSeconds,
  'dwellHistogram': instance.dwellHistogram,
  'presenceSampleCount': instance.presenceSampleCount,
  'presenceSumSeconds': instance.presenceSumSeconds,
};
