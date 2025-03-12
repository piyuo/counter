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
      confidence: (json['confidence'] as num).toDouble(),
      nms: (json['nms'] as num).toDouble(),
      match: (json['match'] as num).toDouble(),
      maxLostSeconds: (json['maxLostSeconds'] as num).toInt(),
      valid: (json['valid'] as num).toInt(),
      tracking: (json['tracking'] as num).toDouble(),
      model: $enumDecode(_$ModelsEnumMap, json['model']),
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
      'confidence': instance.confidence,
      'nms': instance.nms,
      'match': instance.match,
      'maxLostSeconds': instance.maxLostSeconds,
      'valid': instance.valid,
      'tracking': instance.tracking,
      'model': _$ModelsEnumMap[instance.model]!,
      'zoom': instance.zoom,
      'zones': instance.zones.map((e) => e.toJson()).toList(),
    };

const _$MediaTypeEnumMap = {
  MediaType.file: 'file',
  MediaType.live: 'live',
  MediaType.camera: 'camera',
  MediaType.webcam: 'webcam',
};

const _$ModelsEnumMap = {
  Models.ncnn_640: 'ncnn_640',
  Models.onnx_640: 'onnx_640',
};
