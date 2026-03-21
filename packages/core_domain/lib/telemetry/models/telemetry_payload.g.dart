// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryPayload _$TelemetryPayloadFromJson(Map<String, dynamic> json) =>
    _TelemetryPayload(
      id: json['id'] as String,
      startUtc: DateTime.parse(json['startUtc'] as String),
      endUtc: DateTime.parse(json['endUtc'] as String),
      sessionId: json['sessionId'] as String,
      windowIndex: (json['windowIndex'] as num).toInt(),
      frameCount: (json['frameCount'] as num).toInt(),
      missingDurationMs: (json['missingDurationMs'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
      isPartial: json['isPartial'] as bool,
      coverageRatio: (json['coverageRatio'] as num).toDouble(),
      fps: (json['fps'] as num).toDouble(),
      areas: (json['areas'] as List<dynamic>)
          .map((e) => AreaPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TelemetryPayloadToJson(_TelemetryPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startUtc': instance.startUtc.toIso8601String(),
      'endUtc': instance.endUtc.toIso8601String(),
      'sessionId': instance.sessionId,
      'windowIndex': instance.windowIndex,
      'frameCount': instance.frameCount,
      'missingDurationMs': instance.missingDurationMs,
      'confidence': instance.confidence,
      'isPartial': instance.isPartial,
      'coverageRatio': instance.coverageRatio,
      'fps': instance.fps,
      'areas': instance.areas,
    };

_AreaPayload _$AreaPayloadFromJson(Map<String, dynamic> json) => _AreaPayload(
  id: (json['id'] as num).toInt(),
  passBy: (json['passBy'] as num?)?.toInt() ?? 0,
  stay: (json['stay'] as num?)?.toInt() ?? 0,
  entry: (json['entry'] as num?)?.toInt() ?? 0,
  exit: (json['exit'] as num?)?.toInt() ?? 0,
  appear: (json['appear'] as num?)?.toInt() ?? 0,
  disappear: (json['disappear'] as num?)?.toInt() ?? 0,
  occupancyAvg: (json['occupancyAvg'] as num?)?.toDouble() ?? 0,
  occupancyPeak: (json['occupancyPeak'] as num?)?.toInt() ?? 0,
  dwellAvgSec: (json['dwellAvgSec'] as num?)?.toDouble() ?? 0,
  dwellPeakSec: (json['dwellPeakSec'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AreaPayloadToJson(_AreaPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'passBy': instance.passBy,
      'stay': instance.stay,
      'entry': instance.entry,
      'exit': instance.exit,
      'appear': instance.appear,
      'disappear': instance.disappear,
      'occupancyAvg': instance.occupancyAvg,
      'occupancyPeak': instance.occupancyPeak,
      'dwellAvgSec': instance.dwellAvgSec,
      'dwellPeakSec': instance.dwellPeakSec,
    };
