// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppState {

/// auto-generated unique device ID, sent to backend as a safety identifier
 String get deviceId;/// Which remembered data-server choice is currently active.
@JsonKey(unknownEnumValue: DataServerSelection.unspecified) DataServerSelection get dataServerSelection;/// Last invitation/business server remembered for later reuse.
 BusinessDataServer? get businessDataServer;/// Last custom personal server remembered for later reuse.
 PersonalDataServer? get customPersonalDataServer;/// Stable personal Piyuo Cloud server remembered for later reuse.
 PersonalDataServer? get piyuoPersonalDataServer;/// how to upload data to remote server/
 UploadConfig get uploadConfig;/// Vision input selection.
///
/// Stored as a flat AppState field rather than inside a nested vision-session
/// object because source, detection, and params can each change independently.
@JsonKey(name: 'videoSource') VideoSource get videoSource;/// Vision model selection paired with [videoSource] and [detectionParams]
/// to define the desired runtime session.
 DetectionType get detection;/// Runtime tuning paired with [videoSource] and [detection].
///
/// Kept flat in AppState so small parameter edits remain ordinary app-state
/// updates instead of forcing a wrapper type with weak domain meaning.
 DetectionParams get detectionParams;/// Stable per-device jitter added to every wall-clock upload boundary.
///
/// Generated once on first boot (range: 0–180 seconds) and never changed.
/// Spreads simultaneous uploads across a 3-minute window to prevent
/// thundering herd against the backend (Lambda / DynamoDB).
///
/// A value of 0 means "not yet generated" and triggers auto-generation in
/// [AppNotifier.build].
 int get uploadJitterSec;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);

  /// Serializes this AppState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.dataServerSelection, dataServerSelection) || other.dataServerSelection == dataServerSelection)&&const DeepCollectionEquality().equals(other.businessDataServer, businessDataServer)&&const DeepCollectionEquality().equals(other.customPersonalDataServer, customPersonalDataServer)&&const DeepCollectionEquality().equals(other.piyuoPersonalDataServer, piyuoPersonalDataServer)&&(identical(other.uploadConfig, uploadConfig) || other.uploadConfig == uploadConfig)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.uploadJitterSec, uploadJitterSec) || other.uploadJitterSec == uploadJitterSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,dataServerSelection,const DeepCollectionEquality().hash(businessDataServer),const DeepCollectionEquality().hash(customPersonalDataServer),const DeepCollectionEquality().hash(piyuoPersonalDataServer),uploadConfig,videoSource,detection,detectionParams,uploadJitterSec);

@override
String toString() {
  return 'AppState(deviceId: $deviceId, dataServerSelection: $dataServerSelection, businessDataServer: $businessDataServer, customPersonalDataServer: $customPersonalDataServer, piyuoPersonalDataServer: $piyuoPersonalDataServer, uploadConfig: $uploadConfig, videoSource: $videoSource, detection: $detection, detectionParams: $detectionParams, uploadJitterSec: $uploadJitterSec)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 String deviceId,@JsonKey(unknownEnumValue: DataServerSelection.unspecified) DataServerSelection dataServerSelection, BusinessDataServer? businessDataServer, PersonalDataServer? customPersonalDataServer, PersonalDataServer? piyuoPersonalDataServer, UploadConfig uploadConfig,@JsonKey(name: 'videoSource') VideoSource videoSource, DetectionType detection, DetectionParams detectionParams, int uploadJitterSec
});


$UploadConfigCopyWith<$Res> get uploadConfig;$VideoSourceCopyWith<$Res> get videoSource;$DetectionTypeCopyWith<$Res> get detection;$DetectionParamsCopyWith<$Res> get detectionParams;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? dataServerSelection = null,Object? businessDataServer = freezed,Object? customPersonalDataServer = freezed,Object? piyuoPersonalDataServer = freezed,Object? uploadConfig = null,Object? videoSource = null,Object? detection = null,Object? detectionParams = null,Object? uploadJitterSec = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,dataServerSelection: null == dataServerSelection ? _self.dataServerSelection : dataServerSelection // ignore: cast_nullable_to_non_nullable
as DataServerSelection,businessDataServer: freezed == businessDataServer ? _self.businessDataServer : businessDataServer // ignore: cast_nullable_to_non_nullable
as BusinessDataServer?,customPersonalDataServer: freezed == customPersonalDataServer ? _self.customPersonalDataServer : customPersonalDataServer // ignore: cast_nullable_to_non_nullable
as PersonalDataServer?,piyuoPersonalDataServer: freezed == piyuoPersonalDataServer ? _self.piyuoPersonalDataServer : piyuoPersonalDataServer // ignore: cast_nullable_to_non_nullable
as PersonalDataServer?,uploadConfig: null == uploadConfig ? _self.uploadConfig : uploadConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig,videoSource: null == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource,detection: null == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType,detectionParams: null == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams,uploadJitterSec: null == uploadJitterSec ? _self.uploadJitterSec : uploadJitterSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res> get uploadConfig {
  
  return $UploadConfigCopyWith<$Res>(_self.uploadConfig, (value) {
    return _then(_self.copyWith(uploadConfig: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSourceCopyWith<$Res> get videoSource {
  
  return $VideoSourceCopyWith<$Res>(_self.videoSource, (value) {
    return _then(_self.copyWith(videoSource: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionTypeCopyWith<$Res> get detection {
  
  return $DetectionTypeCopyWith<$Res>(_self.detection, (value) {
    return _then(_self.copyWith(detection: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<$Res> get detectionParams {
  
  return $DetectionParamsCopyWith<$Res>(_self.detectionParams, (value) {
    return _then(_self.copyWith(detectionParams: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId, @JsonKey(unknownEnumValue: DataServerSelection.unspecified)  DataServerSelection dataServerSelection,  BusinessDataServer? businessDataServer,  PersonalDataServer? customPersonalDataServer,  PersonalDataServer? piyuoPersonalDataServer,  UploadConfig uploadConfig, @JsonKey(name: 'videoSource')  VideoSource videoSource,  DetectionType detection,  DetectionParams detectionParams,  int uploadJitterSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.deviceId,_that.dataServerSelection,_that.businessDataServer,_that.customPersonalDataServer,_that.piyuoPersonalDataServer,_that.uploadConfig,_that.videoSource,_that.detection,_that.detectionParams,_that.uploadJitterSec);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId, @JsonKey(unknownEnumValue: DataServerSelection.unspecified)  DataServerSelection dataServerSelection,  BusinessDataServer? businessDataServer,  PersonalDataServer? customPersonalDataServer,  PersonalDataServer? piyuoPersonalDataServer,  UploadConfig uploadConfig, @JsonKey(name: 'videoSource')  VideoSource videoSource,  DetectionType detection,  DetectionParams detectionParams,  int uploadJitterSec)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.deviceId,_that.dataServerSelection,_that.businessDataServer,_that.customPersonalDataServer,_that.piyuoPersonalDataServer,_that.uploadConfig,_that.videoSource,_that.detection,_that.detectionParams,_that.uploadJitterSec);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId, @JsonKey(unknownEnumValue: DataServerSelection.unspecified)  DataServerSelection dataServerSelection,  BusinessDataServer? businessDataServer,  PersonalDataServer? customPersonalDataServer,  PersonalDataServer? piyuoPersonalDataServer,  UploadConfig uploadConfig, @JsonKey(name: 'videoSource')  VideoSource videoSource,  DetectionType detection,  DetectionParams detectionParams,  int uploadJitterSec)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.deviceId,_that.dataServerSelection,_that.businessDataServer,_that.customPersonalDataServer,_that.piyuoPersonalDataServer,_that.uploadConfig,_that.videoSource,_that.detection,_that.detectionParams,_that.uploadJitterSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppState extends AppState {
  const _AppState({this.deviceId = '', @JsonKey(unknownEnumValue: DataServerSelection.unspecified) this.dataServerSelection = DataServerSelection.unspecified, this.businessDataServer, this.customPersonalDataServer, this.piyuoPersonalDataServer, this.uploadConfig = const UploadConfig(), @JsonKey(name: 'videoSource') this.videoSource = const VideoSource.unspecified(), this.detection = const DetectionType.human(), this.detectionParams = const DetectionParams(), this.uploadJitterSec = 0}): super._();
  factory _AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

/// auto-generated unique device ID, sent to backend as a safety identifier
@override@JsonKey() final  String deviceId;
/// Which remembered data-server choice is currently active.
@override@JsonKey(unknownEnumValue: DataServerSelection.unspecified) final  DataServerSelection dataServerSelection;
/// Last invitation/business server remembered for later reuse.
@override final  BusinessDataServer? businessDataServer;
/// Last custom personal server remembered for later reuse.
@override final  PersonalDataServer? customPersonalDataServer;
/// Stable personal Piyuo Cloud server remembered for later reuse.
@override final  PersonalDataServer? piyuoPersonalDataServer;
/// how to upload data to remote server/
@override@JsonKey() final  UploadConfig uploadConfig;
/// Vision input selection.
///
/// Stored as a flat AppState field rather than inside a nested vision-session
/// object because source, detection, and params can each change independently.
@override@JsonKey(name: 'videoSource') final  VideoSource videoSource;
/// Vision model selection paired with [videoSource] and [detectionParams]
/// to define the desired runtime session.
@override@JsonKey() final  DetectionType detection;
/// Runtime tuning paired with [videoSource] and [detection].
///
/// Kept flat in AppState so small parameter edits remain ordinary app-state
/// updates instead of forcing a wrapper type with weak domain meaning.
@override@JsonKey() final  DetectionParams detectionParams;
/// Stable per-device jitter added to every wall-clock upload boundary.
///
/// Generated once on first boot (range: 0–180 seconds) and never changed.
/// Spreads simultaneous uploads across a 3-minute window to prevent
/// thundering herd against the backend (Lambda / DynamoDB).
///
/// A value of 0 means "not yet generated" and triggers auto-generation in
/// [AppNotifier.build].
@override@JsonKey() final  int uploadJitterSec;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.dataServerSelection, dataServerSelection) || other.dataServerSelection == dataServerSelection)&&const DeepCollectionEquality().equals(other.businessDataServer, businessDataServer)&&const DeepCollectionEquality().equals(other.customPersonalDataServer, customPersonalDataServer)&&const DeepCollectionEquality().equals(other.piyuoPersonalDataServer, piyuoPersonalDataServer)&&(identical(other.uploadConfig, uploadConfig) || other.uploadConfig == uploadConfig)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.uploadJitterSec, uploadJitterSec) || other.uploadJitterSec == uploadJitterSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,dataServerSelection,const DeepCollectionEquality().hash(businessDataServer),const DeepCollectionEquality().hash(customPersonalDataServer),const DeepCollectionEquality().hash(piyuoPersonalDataServer),uploadConfig,videoSource,detection,detectionParams,uploadJitterSec);

@override
String toString() {
  return 'AppState(deviceId: $deviceId, dataServerSelection: $dataServerSelection, businessDataServer: $businessDataServer, customPersonalDataServer: $customPersonalDataServer, piyuoPersonalDataServer: $piyuoPersonalDataServer, uploadConfig: $uploadConfig, videoSource: $videoSource, detection: $detection, detectionParams: $detectionParams, uploadJitterSec: $uploadJitterSec)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 String deviceId,@JsonKey(unknownEnumValue: DataServerSelection.unspecified) DataServerSelection dataServerSelection, BusinessDataServer? businessDataServer, PersonalDataServer? customPersonalDataServer, PersonalDataServer? piyuoPersonalDataServer, UploadConfig uploadConfig,@JsonKey(name: 'videoSource') VideoSource videoSource, DetectionType detection, DetectionParams detectionParams, int uploadJitterSec
});


@override $UploadConfigCopyWith<$Res> get uploadConfig;@override $VideoSourceCopyWith<$Res> get videoSource;@override $DetectionTypeCopyWith<$Res> get detection;@override $DetectionParamsCopyWith<$Res> get detectionParams;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? dataServerSelection = null,Object? businessDataServer = freezed,Object? customPersonalDataServer = freezed,Object? piyuoPersonalDataServer = freezed,Object? uploadConfig = null,Object? videoSource = null,Object? detection = null,Object? detectionParams = null,Object? uploadJitterSec = null,}) {
  return _then(_AppState(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,dataServerSelection: null == dataServerSelection ? _self.dataServerSelection : dataServerSelection // ignore: cast_nullable_to_non_nullable
as DataServerSelection,businessDataServer: freezed == businessDataServer ? _self.businessDataServer : businessDataServer // ignore: cast_nullable_to_non_nullable
as BusinessDataServer?,customPersonalDataServer: freezed == customPersonalDataServer ? _self.customPersonalDataServer : customPersonalDataServer // ignore: cast_nullable_to_non_nullable
as PersonalDataServer?,piyuoPersonalDataServer: freezed == piyuoPersonalDataServer ? _self.piyuoPersonalDataServer : piyuoPersonalDataServer // ignore: cast_nullable_to_non_nullable
as PersonalDataServer?,uploadConfig: null == uploadConfig ? _self.uploadConfig : uploadConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig,videoSource: null == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource,detection: null == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType,detectionParams: null == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams,uploadJitterSec: null == uploadJitterSec ? _self.uploadJitterSec : uploadJitterSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res> get uploadConfig {
  
  return $UploadConfigCopyWith<$Res>(_self.uploadConfig, (value) {
    return _then(_self.copyWith(uploadConfig: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSourceCopyWith<$Res> get videoSource {
  
  return $VideoSourceCopyWith<$Res>(_self.videoSource, (value) {
    return _then(_self.copyWith(videoSource: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionTypeCopyWith<$Res> get detection {
  
  return $DetectionTypeCopyWith<$Res>(_self.detection, (value) {
    return _then(_self.copyWith(detection: value));
  });
}/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<$Res> get detectionParams {
  
  return $DetectionParamsCopyWith<$Res>(_self.detectionParams, (value) {
    return _then(_self.copyWith(detectionParams: value));
  });
}
}

// dart format on
