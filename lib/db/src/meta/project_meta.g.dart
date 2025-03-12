// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectMetaImpl _$$ProjectMetaImplFromJson(Map<String, dynamic> json) =>
    _$ProjectMetaImpl(
      projectId: json['projectId'] as String,
      projectName: json['projectName'] as String,
      videos: (json['videos'] as List<dynamic>)
          .map((e) => VideoMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      filter: FilterMeta.fromJson(json['filter'] as Map<String, dynamic>),
      isShowCenterRedDotOnTarget: json['isShowCenterRedDotOnTarget'] as bool,
      isShowGhostTarget: json['isShowGhostTarget'] as bool,
    );

Map<String, dynamic> _$$ProjectMetaImplToJson(_$ProjectMetaImpl instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'videos': instance.videos.map((e) => e.toJson()).toList(),
      'filter': instance.filter.toJson(),
      'isShowCenterRedDotOnTarget': instance.isShowCenterRedDotOnTarget,
      'isShowGhostTarget': instance.isShowGhostTarget,
    };
