// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoMetaImpl _$$VideoMetaImplFromJson(Map<String, dynamic> json) =>
    _$VideoMetaImpl(
      videoId: (json['videoId'] as num).toInt(),
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      videoName: json['videoName'] as String,
      path: json['path'] as String?,
      camera: json['camera'] == null
          ? null
          : CameraMeta.fromJson(json['camera'] as Map<String, dynamic>),
      webcam: json['webcam'] == null
          ? null
          : WebcamMeta.fromJson(json['webcam'] as Map<String, dynamic>),
      zoom: (json['zoom'] as num).toDouble(),
      zones: (json['zones'] as List<dynamic>)
          .map((e) => ZoneMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VideoMetaImplToJson(_$VideoMetaImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'videoName': instance.videoName,
      'path': instance.path,
      'camera': instance.camera?.toJson(),
      'webcam': instance.webcam?.toJson(),
      'zoom': instance.zoom,
      'zones': instance.zones.map((e) => e.toJson()).toList(),
    };

const _$MediaTypeEnumMap = {
  MediaType.file: 'file',
  MediaType.live: 'live',
  MediaType.camera: 'camera',
  MediaType.webcam: 'webcam',
};
