// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnspecifiedDataServer _$UnspecifiedDataServerFromJson(
  Map<String, dynamic> json,
) => UnspecifiedDataServer($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnspecifiedDataServerToJson(
  UnspecifiedDataServer instance,
) => <String, dynamic>{'runtimeType': instance.$type};

BusinessDataServer _$BusinessDataServerFromJson(Map<String, dynamic> json) =>
    BusinessDataServer(
      url: json['url'] as String,
      projectName: json['projectName'] as String,
      projectId: json['projectId'] as String,
      assignedId: json['assignedId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$BusinessDataServerToJson(BusinessDataServer instance) =>
    <String, dynamic>{
      'url': instance.url,
      'projectName': instance.projectName,
      'projectId': instance.projectId,
      'assignedId': instance.assignedId,
      'runtimeType': instance.$type,
    };

PersonalDataServer _$PersonalDataServerFromJson(Map<String, dynamic> json) =>
    PersonalDataServer(
      url: json['url'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PersonalDataServerToJson(PersonalDataServer instance) =>
    <String, dynamic>{'url': instance.url, 'runtimeType': instance.$type};

NoDataServer _$NoDataServerFromJson(Map<String, dynamic> json) =>
    NoDataServer($type: json['runtimeType'] as String?);

Map<String, dynamic> _$NoDataServerToJson(NoDataServer instance) =>
    <String, dynamic>{'runtimeType': instance.$type};
