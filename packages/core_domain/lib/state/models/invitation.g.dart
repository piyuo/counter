// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Invitation _$InvitationFromJson(Map<String, dynamic> json) => _Invitation(
  businessDataServer: BusinessDataServer.fromJson(
    json['businessDataServer'] as Map<String, dynamic>,
  ),
  bearerToken: json['bearerToken'] as String,
  deviceName: json['deviceName'] as String,
  instruction: json['instruction'] as String,
  detection: DetectionType.fromJson(json['detection'] as Map<String, dynamic>),
  detectionParams: DetectionParams.fromJson(
    json['detectionParams'] as Map<String, dynamic>,
  ),
  deliveryConfig: UploadConfig.fromJson(
    json['deliveryConfig'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$InvitationToJson(_Invitation instance) =>
    <String, dynamic>{
      'businessDataServer': instance.businessDataServer,
      'bearerToken': instance.bearerToken,
      'deviceName': instance.deviceName,
      'instruction': instance.instruction,
      'detection': instance.detection,
      'detectionParams': instance.detectionParams,
      'deliveryConfig': instance.deliveryConfig,
    };
