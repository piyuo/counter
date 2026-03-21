// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadConfig _$UploadConfigFromJson(Map<String, dynamic> json) =>
    _UploadConfig(
      wallClockCadenceMin: (json['intervalMin'] as num?)?.toInt() ?? 60,
      maxBatchSize: (json['maxBatchSize'] as num?)?.toInt() ?? 1008,
      payloadRetentionDays:
          (json['payloadRetentionDays'] as num?)?.toInt() ?? 7,
      uploadLogRetentionDays:
          (json['deliveryLogRetentionDays'] as num?)?.toInt() ?? 7,
      timeoutSec: (json['timeoutSec'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$UploadConfigToJson(_UploadConfig instance) =>
    <String, dynamic>{
      'intervalMin': instance.wallClockCadenceMin,
      'maxBatchSize': instance.maxBatchSize,
      'payloadRetentionDays': instance.payloadRetentionDays,
      'deliveryLogRetentionDays': instance.uploadLogRetentionDays,
      'timeoutSec': instance.timeoutSec,
    };
