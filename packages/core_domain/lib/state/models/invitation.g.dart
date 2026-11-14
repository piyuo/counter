// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Invitation _$InvitationFromJson(Map<String, dynamic> json) => _Invitation(
  instruction: json['instruction'] as String,
  bearerToken: json['bearerToken'] as String,
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
  detection: $enumDecodeNullable(_$DetectionTypeEnumMap, json['detection']),
  detectionParams: json['detectionParams'] == null
      ? null
      : DetectionParams.fromJson(
          json['detectionParams'] as Map<String, dynamic>,
        ),
  uploadConfig: json['uploadConfig'] == null
      ? null
      : UploadConfig.fromJson(json['uploadConfig'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InvitationToJson(_Invitation instance) =>
    <String, dynamic>{
      'instruction': instance.instruction,
      'bearerToken': instance.bearerToken,
      'businessPiyuoServer': instance.businessPiyuoServer,
      'businessCustomServer': instance.businessCustomServer,
      'detection': _$DetectionTypeEnumMap[instance.detection],
      'detectionParams': instance.detectionParams,
      'uploadConfig': instance.uploadConfig,
    };

const _$DetectionTypeEnumMap = {
  DetectionType.people: 'people',
  DetectionType.vehicle: 'vehicle',
};
