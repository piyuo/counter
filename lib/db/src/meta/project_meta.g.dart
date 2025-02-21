// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectMetaImpl _$$ProjectMetaImplFromJson(Map<String, dynamic> json) =>
    _$ProjectMetaImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      videos: (json['videos'] as List<dynamic>)
          .map((e) => VideoMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      filter: FilterMeta.fromJson(json['filter'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toDouble(),
      nms: (json['nms'] as num).toDouble(),
      match: (json['match'] as num).toDouble(),
      maxLostSeconds: (json['maxLostSeconds'] as num).toInt(),
      valid: (json['valid'] as num).toInt(),
      tracking: (json['tracking'] as num).toDouble(),
      model: $enumDecode(_$ModelsEnumMap, json['model']),
    );

Map<String, dynamic> _$$ProjectMetaImplToJson(_$ProjectMetaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'videos': instance.videos.map((e) => e.toJson()).toList(),
      'filter': instance.filter.toJson(),
      'confidence': instance.confidence,
      'nms': instance.nms,
      'match': instance.match,
      'maxLostSeconds': instance.maxLostSeconds,
      'valid': instance.valid,
      'tracking': instance.tracking,
      'model': _$ModelsEnumMap[instance.model]!,
    };

const _$ModelsEnumMap = {
  Models.ncnn_640: 'ncnn_640',
  Models.onnx_640: 'onnx_640',
};
