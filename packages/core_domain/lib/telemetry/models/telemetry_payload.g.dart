// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryPayload _$TelemetryPayloadFromJson(Map<String, dynamic> json) =>
    _TelemetryPayload(
      session: json['session'] as String,
      sequence: (json['sequence'] as num).toInt(),
      startUtc: DateTime.parse(json['startUtc'] as String),
      startBusiness: DateTime.parse(json['startBusiness'] as String),
      businessDate: json['businessDate'] as String,
      frameCount: (json['frameCount'] as num).toInt(),
      missingSec: (json['missingSec'] as num).toInt(),
      confidence: const RoundedDouble2().fromJson(json['confidence']),
      isPartial: json['isPartial'] as bool,
      coverage: const RoundedDouble2().fromJson(json['coverage']),
      fps: const RoundedDouble2().fromJson(json['fps']),
      areas: (json['areas'] as List<dynamic>)
          .map((e) => AreaPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TelemetryPayloadToJson(_TelemetryPayload instance) =>
    <String, dynamic>{
      'session': instance.session,
      'sequence': instance.sequence,
      'startUtc': instance.startUtc.toIso8601String(),
      'startBusiness': instance.startBusiness.toIso8601String(),
      'businessDate': instance.businessDate,
      'frameCount': instance.frameCount,
      'missingSec': instance.missingSec,
      'confidence': const RoundedDouble2().toJson(instance.confidence),
      'isPartial': instance.isPartial,
      'coverage': const RoundedDouble2().toJson(instance.coverage),
      'fps': const RoundedDouble2().toJson(instance.fps),
      'areas': instance.areas,
    };

_AreaPayload _$AreaPayloadFromJson(Map<String, dynamic> json) => _AreaPayload(
  areaId: (json['areaId'] as num).toInt(),
  passBy: (json['passBy'] as num?)?.toInt() ?? 0,
  stay: (json['stay'] as num?)?.toInt() ?? 0,
  entry: (json['entry'] as num?)?.toInt() ?? 0,
  exit: (json['exit'] as num?)?.toInt() ?? 0,
  appear: (json['appear'] as num?)?.toInt() ?? 0,
  disappear: (json['disappear'] as num?)?.toInt() ?? 0,
  avgOccupancy: json['avgOccupancy'] == null
      ? 0
      : const RoundedDouble2().fromJson(json['avgOccupancy']),
  maxOccupancy: (json['maxOccupancy'] as num?)?.toInt() ?? 0,
  avgDwellSec: json['avgDwellSec'] == null
      ? 0
      : const RoundedDouble2().fromJson(json['avgDwellSec']),
  maxDwellSec: (json['maxDwellSec'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AreaPayloadToJson(_AreaPayload instance) =>
    <String, dynamic>{
      'areaId': instance.areaId,
      'passBy': instance.passBy,
      'stay': instance.stay,
      'entry': instance.entry,
      'exit': instance.exit,
      'appear': instance.appear,
      'disappear': instance.disappear,
      'avgOccupancy': const RoundedDouble2().toJson(instance.avgOccupancy),
      'maxOccupancy': instance.maxOccupancy,
      'avgDwellSec': const RoundedDouble2().toJson(instance.avgDwellSec),
      'maxDwellSec': instance.maxDwellSec,
    };
