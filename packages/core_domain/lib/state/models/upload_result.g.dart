// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadResult _$UploadResultFromJson(Map<String, dynamic> json) =>
    _UploadResult(
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String?,
      detection: $enumDecodeNullable(_$DetectionTypeEnumMap, json['detection']),
      detectionParams: json['detectionParams'] == null
          ? null
          : DetectionParams.fromJson(
              json['detectionParams'] as Map<String, dynamic>,
            ),
      deliveryConfig: json['deliveryConfig'] == null
          ? null
          : UploadConfig.fromJson(
              json['deliveryConfig'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UploadResultToJson(_UploadResult instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'detection': _$DetectionTypeEnumMap[instance.detection],
      'detectionParams': instance.detectionParams,
      'deliveryConfig': instance.deliveryConfig,
    };

const _$DetectionTypeEnumMap = {
  DetectionType.people: 'people',
  DetectionType.vehicle: 'vehicle',
};
