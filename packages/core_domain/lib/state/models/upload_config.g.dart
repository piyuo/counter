// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadConfig _$UploadConfigFromJson(Map<String, dynamic> json) =>
    _UploadConfig(
      wallClockCadenceMin: (json['intervalMin'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$UploadConfigToJson(_UploadConfig instance) =>
    <String, dynamic>{'intervalMin': instance.wallClockCadenceMin};
