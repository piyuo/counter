// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
  backend: json['backend'] == null
      ? const Backend.empty()
      : Backend.fromJson(json['backend'] as Map<String, dynamic>),
  frontend: json['frontend'] == null
      ? const Frontend.empty()
      : Frontend.fromJson(json['frontend'] as Map<String, dynamic>),
  setupBy: json['setupBy'] == null
      ? const SetupBy.empty()
      : SetupBy.fromJson(json['setupBy'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'backend': instance.backend,
  'frontend': instance.frontend,
  'setupBy': instance.setupBy,
};
