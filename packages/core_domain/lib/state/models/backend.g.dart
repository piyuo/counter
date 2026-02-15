// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyBackend _$EmptyBackendFromJson(Map<String, dynamic> json) =>
    EmptyBackend($type: json['runtimeType'] as String?);

Map<String, dynamic> _$EmptyBackendToJson(EmptyBackend instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

PiyuoBackend _$PiyuoBackendFromJson(Map<String, dynamic> json) => PiyuoBackend(
  token: json['token'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$PiyuoBackendToJson(PiyuoBackend instance) =>
    <String, dynamic>{'token': instance.token, 'runtimeType': instance.$type};

CustomServerBackend _$CustomServerBackendFromJson(Map<String, dynamic> json) =>
    CustomServerBackend(
      serverUrl: json['serverUrl'] as String,
      token: json['token'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CustomServerBackendToJson(
  CustomServerBackend instance,
) => <String, dynamic>{
  'serverUrl': instance.serverUrl,
  'token': instance.token,
  'runtimeType': instance.$type,
};

NoBackend _$NoBackendFromJson(Map<String, dynamic> json) =>
    NoBackend($type: json['runtimeType'] as String?);

Map<String, dynamic> _$NoBackendToJson(NoBackend instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};
