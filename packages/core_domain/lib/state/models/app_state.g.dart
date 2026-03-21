// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
  deviceId: json['deviceId'] as String? ?? '',
  dataServerSelection:
      $enumDecodeNullable(
        _$DataServerSelectionEnumMap,
        json['dataServerSelection'],
        unknownValue: DataServerSelection.unspecified,
      ) ??
      DataServerSelection.unspecified,
  businessDataServer: json['businessDataServer'] == null
      ? null
      : BusinessDataServer.fromJson(
          json['businessDataServer'] as Map<String, dynamic>,
        ),
  customPersonalDataServer: json['customPersonalDataServer'] == null
      ? null
      : PersonalDataServer.fromJson(
          json['customPersonalDataServer'] as Map<String, dynamic>,
        ),
  piyuoPersonalDataServer: json['piyuoPersonalDataServer'] == null
      ? null
      : PersonalDataServer.fromJson(
          json['piyuoPersonalDataServer'] as Map<String, dynamic>,
        ),
  uploadConfig: json['uploadConfig'] == null
      ? const UploadConfig()
      : UploadConfig.fromJson(json['uploadConfig'] as Map<String, dynamic>),
  videoSource: json['videoSource'] == null
      ? const VideoSource.unspecified()
      : VideoSource.fromJson(json['videoSource'] as Map<String, dynamic>),
  detection: json['detection'] == null
      ? const DetectionType.human()
      : DetectionType.fromJson(json['detection'] as Map<String, dynamic>),
  detectionParams: json['detectionParams'] == null
      ? const DetectionParams()
      : DetectionParams.fromJson(
          json['detectionParams'] as Map<String, dynamic>,
        ),
  uploadJitterSec: (json['uploadJitterSec'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'dataServerSelection':
      _$DataServerSelectionEnumMap[instance.dataServerSelection]!,
  'businessDataServer': instance.businessDataServer,
  'customPersonalDataServer': instance.customPersonalDataServer,
  'piyuoPersonalDataServer': instance.piyuoPersonalDataServer,
  'uploadConfig': instance.uploadConfig,
  'videoSource': instance.videoSource,
  'detection': instance.detection,
  'detectionParams': instance.detectionParams,
  'uploadJitterSec': instance.uploadJitterSec,
};

const _$DataServerSelectionEnumMap = {
  DataServerSelection.unspecified: 'unspecified',
  DataServerSelection.none: 'none',
  DataServerSelection.business: 'business',
  DataServerSelection.personalCustom: 'personalCustom',
  DataServerSelection.personalPiyuo: 'personalPiyuo',
};
