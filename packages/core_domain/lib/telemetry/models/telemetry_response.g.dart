// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryResponse _$TelemetryResponseFromJson(Map<String, dynamic> json) =>
    _TelemetryResponse(
      v: (json['v'] as num).toInt(),
      ok: json['ok'] as bool,
      errorCode: $enumDecodeNullable(
        _$TelemetryErrorCodeEnumMap,
        json['errorCode'],
      ),
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : ServerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TelemetryResponseToJson(_TelemetryResponse instance) =>
    <String, dynamic>{
      'v': instance.v,
      'ok': instance.ok,
      'errorCode': _$TelemetryErrorCodeEnumMap[instance.errorCode],
      'error': instance.error,
      'data': instance.data,
    };

const _$TelemetryErrorCodeEnumMap = {
  TelemetryErrorCode.connectionRefused: 'connectionRefused',
  TelemetryErrorCode.dnsLookupFailed: 'dnsLookupFailed',
  TelemetryErrorCode.socketError: 'socketError',
  TelemetryErrorCode.networkError: 'networkError',
  TelemetryErrorCode.invalidUrl: 'invalidUrl',
  TelemetryErrorCode.connectionTimeout: 'connectionTimeout',
  TelemetryErrorCode.connectionReset: 'connectionReset',
  TelemetryErrorCode.httpErrorStatus: 'httpErrorStatus',
  TelemetryErrorCode.transportException: 'transportException',
  TelemetryErrorCode.httpUnknownError: 'httpUnknownError',
};

_ServerData _$ServerDataFromJson(Map<String, dynamic> json) => _ServerData(
  detection: json['detection'] == null
      ? null
      : DetectionType.fromJson(json['detection'] as Map<String, dynamic>),
  detectionParams: json['detectionParams'] == null
      ? null
      : DetectionParams.fromJson(
          json['detectionParams'] as Map<String, dynamic>,
        ),
  deliveryConfig: json['deliveryConfig'] == null
      ? null
      : UploadConfig.fromJson(json['deliveryConfig'] as Map<String, dynamic>),
  config: json['config'] == null
      ? null
      : ServerConfig.fromJson(json['config'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ServerDataToJson(_ServerData instance) =>
    <String, dynamic>{
      'detection': instance.detection,
      'detectionParams': instance.detectionParams,
      'deliveryConfig': instance.deliveryConfig,
      'config': instance.config,
    };

_ServerConfig _$ServerConfigFromJson(Map<String, dynamic> json) =>
    _ServerConfig(
      uploadIntervalSec: (json['uploadIntervalSec'] as num?)?.toInt(),
      detectionParams: json['detectionParams'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ServerConfigToJson(_ServerConfig instance) =>
    <String, dynamic>{
      'uploadIntervalSec': instance.uploadIntervalSec,
      'detectionParams': instance.detectionParams,
    };
