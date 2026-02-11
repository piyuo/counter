// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frontend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyFrontend _$EmptyFrontendFromJson(Map<String, dynamic> json) =>
    EmptyFrontend($type: json['runtimeType'] as String?);

Map<String, dynamic> _$EmptyFrontendToJson(EmptyFrontend instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

CameraFrontend _$CameraFrontendFromJson(Map<String, dynamic> json) =>
    CameraFrontend(
      cameraIndex: (json['cameraIndex'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CameraFrontendToJson(CameraFrontend instance) =>
    <String, dynamic>{
      'cameraIndex': instance.cameraIndex,
      'runtimeType': instance.$type,
    };

WebcamFrontend _$WebcamFrontendFromJson(Map<String, dynamic> json) =>
    WebcamFrontend(
      webcamIndex: (json['webcamIndex'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WebcamFrontendToJson(WebcamFrontend instance) =>
    <String, dynamic>{
      'webcamIndex': instance.webcamIndex,
      'runtimeType': instance.$type,
    };

FileFrontend _$FileFrontendFromJson(Map<String, dynamic> json) => FileFrontend(
  fileName: json['fileName'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$FileFrontendToJson(FileFrontend instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'runtimeType': instance.$type,
    };

LiveUrlFrontend _$LiveUrlFrontendFromJson(Map<String, dynamic> json) =>
    LiveUrlFrontend(
      url: json['url'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$LiveUrlFrontendToJson(LiveUrlFrontend instance) =>
    <String, dynamic>{'url': instance.url, 'runtimeType': instance.$type};
