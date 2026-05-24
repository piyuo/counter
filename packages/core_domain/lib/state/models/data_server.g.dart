// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalPiyuoServer _$PersonalPiyuoServerFromJson(Map<String, dynamic> json) =>
    PersonalPiyuoServer(
      url: json['url'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PersonalPiyuoServerToJson(
  PersonalPiyuoServer instance,
) => <String, dynamic>{'url': instance.url, 'runtimeType': instance.$type};

BusinessPiyuoServer _$BusinessPiyuoServerFromJson(Map<String, dynamic> json) =>
    BusinessPiyuoServer(
      url: json['url'] as String,
      projectId: json['projectId'] as String,
      projectName: json['projectName'] as String,
      assignedId: json['assignedId'] as String,
      assignedName: json['assignedName'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$BusinessPiyuoServerToJson(
  BusinessPiyuoServer instance,
) => <String, dynamic>{
  'url': instance.url,
  'projectId': instance.projectId,
  'projectName': instance.projectName,
  'assignedId': instance.assignedId,
  'assignedName': instance.assignedName,
  'runtimeType': instance.$type,
};

PersonalCustomServer _$PersonalCustomServerFromJson(
  Map<String, dynamic> json,
) => PersonalCustomServer(
  url: json['url'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PersonalCustomServerToJson(
  PersonalCustomServer instance,
) => <String, dynamic>{'url': instance.url, 'runtimeType': instance.$type};

BusinessCustomServer _$BusinessCustomServerFromJson(
  Map<String, dynamic> json,
) => BusinessCustomServer(
  url: json['url'] as String,
  projectId: json['projectId'] as String,
  projectName: json['projectName'] as String,
  assignedId: json['assignedId'] as String,
  assignedName: json['assignedName'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$BusinessCustomServerToJson(
  BusinessCustomServer instance,
) => <String, dynamic>{
  'url': instance.url,
  'projectId': instance.projectId,
  'projectName': instance.projectName,
  'assignedId': instance.assignedId,
  'assignedName': instance.assignedName,
  'runtimeType': instance.$type,
};

NoDataServer _$NoDataServerFromJson(Map<String, dynamic> json) =>
    NoDataServer($type: json['runtimeType'] as String?);

Map<String, dynamic> _$NoDataServerToJson(NoDataServer instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
