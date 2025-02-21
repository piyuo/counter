// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoMetaImpl _$$VideoMetaImplFromJson(Map<String, dynamic> json) =>
    _$VideoMetaImpl(
      id: (json['id'] as num).toInt(),
      type: $enumDecode(_$MediaTypeEnumMap, json['type']),
      name: json['name'] as String,
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
      'id': instance.id,
      'type': _$MediaTypeEnumMap[instance.type]!,
      'name': instance.name,
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
