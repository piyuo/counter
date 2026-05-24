// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnspecifiedVideoSource _$UnspecifiedVideoSourceFromJson(
  Map<String, dynamic> json,
) => UnspecifiedVideoSource($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnspecifiedVideoSourceToJson(
  UnspecifiedVideoSource instance,
) => <String, dynamic>{'runtimeType': instance.$type};

CameraVideoSource _$CameraVideoSourceFromJson(Map<String, dynamic> json) =>
    CameraVideoSource(
      cameraIndex: (json['cameraIndex'] as num).toInt(),
      isFaceFront: json['isFaceFront'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CameraVideoSourceToJson(CameraVideoSource instance) =>
    <String, dynamic>{
      'cameraIndex': instance.cameraIndex,
      'isFaceFront': instance.isFaceFront,
      'runtimeType': instance.$type,
    };

WebcamVideoSource _$WebcamVideoSourceFromJson(Map<String, dynamic> json) =>
    WebcamVideoSource(
      webcamIndex: (json['webcamIndex'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WebcamVideoSourceToJson(WebcamVideoSource instance) =>
    <String, dynamic>{
      'webcamIndex': instance.webcamIndex,
      'runtimeType': instance.$type,
    };

FileVideoSource _$FileVideoSourceFromJson(Map<String, dynamic> json) =>
    FileVideoSource(
      path: json['path'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$FileVideoSourceToJson(FileVideoSource instance) =>
    <String, dynamic>{'path': instance.path, 'runtimeType': instance.$type};

LiveVideoSource _$LiveVideoSourceFromJson(Map<String, dynamic> json) =>
    LiveVideoSource(
      url: json['url'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$LiveVideoSourceToJson(LiveVideoSource instance) =>
    <String, dynamic>{'url': instance.url, 'runtimeType': instance.$type};
