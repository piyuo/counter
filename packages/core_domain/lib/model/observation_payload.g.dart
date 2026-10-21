// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ObservationPayload _$ObservationPayloadFromJson(Map<String, dynamic> json) =>
    _ObservationPayload(
      granularity: json['granularity'] as String? ?? '',
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      day: (json['day'] as num).toInt(),
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      businessDate: json['businessDate'] as String? ?? '',
      confidenceRatio: json['confidenceRatio'] == null
          ? 0
          : const RoundedDouble().fromJson(json['confidenceRatio']),
      expectedSeconds: (json['expectedSeconds'] as num?)?.toInt() ?? 0,
      coveredSeconds: (json['coveredSeconds'] as num?)?.toInt() ?? 0,
      coverageRatio: json['coverageRatio'] == null
          ? 0
          : const RoundedDouble().fromJson(json['coverageRatio']),
      areas: (json['areas'] as List<dynamic>)
          .map((e) => AreaMetricsPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
      frameCount: (json['frameCount'] as num).toInt(),
    );

Map<String, dynamic> _$ObservationPayloadToJson(_ObservationPayload instance) =>
    <String, dynamic>{
      'granularity': instance.granularity,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hour': instance.hour,
      'minute': instance.minute,
      'id': instance.id,
      'businessDate': instance.businessDate,
      'confidenceRatio': const RoundedDouble().toJson(instance.confidenceRatio),
      'expectedSeconds': instance.expectedSeconds,
      'coveredSeconds': instance.coveredSeconds,
      'coverageRatio': const RoundedDouble().toJson(instance.coverageRatio),
      'areas': instance.areas,
      'frameCount': instance.frameCount,
    };
