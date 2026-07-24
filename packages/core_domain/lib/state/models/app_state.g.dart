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
  personalPiyuoServer: json['personalPiyuoServer'] == null
      ? null
      : PersonalPiyuoServer.fromJson(
          json['personalPiyuoServer'] as Map<String, dynamic>,
        ),
  personalCustomServer: json['personalCustomServer'] == null
      ? null
      : PersonalCustomServer.fromJson(
          json['personalCustomServer'] as Map<String, dynamic>,
        ),
  businessPiyuoServer: json['businessPiyuoServer'] == null
      ? null
      : BusinessPiyuoServer.fromJson(
          json['businessPiyuoServer'] as Map<String, dynamic>,
        ),
  businessCustomServer: json['businessCustomServer'] == null
      ? null
      : BusinessCustomServer.fromJson(
          json['businessCustomServer'] as Map<String, dynamic>,
        ),
  uploadConfig: json['uploadConfig'] == null
      ? const UploadConfig()
      : UploadConfig.fromJson(json['uploadConfig'] as Map<String, dynamic>),
  videoSource: json['videoSource'] == null
      ? const VideoSource.unspecified()
      : VideoSource.fromJson(json['videoSource'] as Map<String, dynamic>),
  detectionType: json['detectionType'] == null
      ? const DetectionType.human()
      : DetectionType.fromJson(json['detectionType'] as Map<String, dynamic>),
  detectionParams: json['detectionParams'] == null
      ? const DetectionParams()
      : DetectionParams.fromJson(
          json['detectionParams'] as Map<String, dynamic>,
        ),
  uploadJitterSec: (json['uploadJitterSec'] as num?)?.toInt() ?? 0,
  interestAreas:
      (json['interestAreas'] as List<dynamic>?)
          ?.map((e) => InterestAreaData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isTrackIdVisible: json['isTrackIdVisible'] as bool? ?? false,
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'dataServerSelection':
      _$DataServerSelectionEnumMap[instance.dataServerSelection]!,
  'personalPiyuoServer': instance.personalPiyuoServer,
  'personalCustomServer': instance.personalCustomServer,
  'businessPiyuoServer': instance.businessPiyuoServer,
  'businessCustomServer': instance.businessCustomServer,
  'uploadConfig': instance.uploadConfig,
  'videoSource': instance.videoSource,
  'detectionType': instance.detectionType,
  'detectionParams': instance.detectionParams,
  'uploadJitterSec': instance.uploadJitterSec,
  'interestAreas': instance.interestAreas,
  'isTrackIdVisible': instance.isTrackIdVisible,
};

const _$DataServerSelectionEnumMap = {
  DataServerSelection.unspecified: 'unspecified',
  DataServerSelection.noDataServer: 'noDataServer',
  DataServerSelection.personalPiyuo: 'personalPiyuo',
  DataServerSelection.businessPiyuo: 'businessPiyuo',
  DataServerSelection.personalCustom: 'personalCustom',
  DataServerSelection.businessCustom: 'businessCustom',
};
