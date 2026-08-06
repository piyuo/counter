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
 String get deviceId;/// if dataServerSelection is unspecified, then app need run onboarding flow to let user select a data server.
@JsonKey(unknownEnumValue: DataServerSelection.unspecified) DataServerSelection get dataServerSelection;/// personal subscription plan, use piyuo.com backend, setup by user.
 PersonalPiyuoServer? get personalPiyuoServer;/// personal subscription plan, use their own backend, setup by user.
 PersonalCustomServer? get personalCustomServer;/// business subscription plan, use piyuo.com backend, setup by invitation.
 BusinessPiyuoServer? get businessPiyuoServer;/// business subscription plan, use their own backend, setup by invitation.
 BusinessCustomServer? get businessCustomServer;/// how to upload data to remote server/
 UploadConfig get uploadConfig;/// Vision input selection.
///
/// Stored as a flat AppState field rather than inside a nested vision-session
/// object because source, detection, and params can each change independently.
@JsonKey(name: 'videoSource') VideoSource get videoSource;/// Vision model selection paired with [videoSource] and [detectionParams]
/// to define the desired runtime session.
 DetectionType get detectionType;/// Runtime tuning paired with [videoSource] and [detection].
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
 int get uploadJitterSec;/// User-defined interest areas (detection zones).
///
/// Stored as domain models that can be serialized to JSON. At runtime,
/// these are converted to flutter_vision's InterestArea instances when
/// configuring the vision session.
 List<InterestAreaData> get interestAreas;/// Whether track IDs should be visible in the detection output.
 bool get isTrackIdVisible;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);

  /// Serializes this AppState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.dataServerSelection, dataServerSelection) || other.dataServerSelection == dataServerSelection)&&const DeepCollectionEquality().equals(other.personalPiyuoServer, personalPiyuoServer)&&const DeepCollectionEquality().equals(other.personalCustomServer, personalCustomServer)&&const DeepCollectionEquality().equals(other.businessPiyuoServer, businessPiyuoServer)&&const DeepCollectionEquality().equals(other.businessCustomServer, businessCustomServer)&&(identical(other.uploadConfig, uploadConfig) || other.uploadConfig == uploadConfig)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.detectionType, detectionType) || other.detectionType == detectionType)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.uploadJitterSec, uploadJitterSec) || other.uploadJitterSec == uploadJitterSec)&&const DeepCollectionEquality().equals(other.interestAreas, interestAreas)&&(identical(other.isTrackIdVisible, isTrackIdVisible) || other.isTrackIdVisible == isTrackIdVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,dataServerSelection,const DeepCollectionEquality().hash(personalPiyuoServer),const DeepCollectionEquality().hash(personalCustomServer),const DeepCollectionEquality().hash(businessPiyuoServer),const DeepCollectionEquality().hash(businessCustomServer),uploadConfig,videoSource,detectionType,detectionParams,uploadJitterSec,const DeepCollectionEquality().hash(interestAreas),isTrackIdVisible);

@override
String toString() {
  return 'AppState(deviceId: $deviceId, dataServerSelection: $dataServerSelection, personalPiyuoServer: $personalPiyuoServer, personalCustomServer: $personalCustomServer, businessPiyuoServer: $businessPiyuoServer, businessCustomServer: $businessCustomServer, uploadConfig: $uploadConfig, videoSource: $videoSource, detectionType: $detectionType, detectionParams: $detectionParams, uploadJitterSec: $uploadJitterSec, interestAreas: $interestAreas, isTrackIdVisible: $isTrackIdVisible)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 String deviceId,@JsonKey(unknownEnumValue: DataServerSelection.unspecified) DataServerSelection dataServerSelection, PersonalPiyuoServer? personalPiyuoServer, PersonalCustomServer? personalCustomServer, BusinessPiyuoServer? businessPiyuoServer, BusinessCustomServer? businessCustomServer, UploadConfig uploadConfig,@JsonKey(name: 'videoSource') VideoSource videoSource, DetectionType detectionType, DetectionParams detectionParams, int uploadJitterSec, List<InterestAreaData> interestAreas, bool isTrackIdVisible
});


$UploadConfigCopyWith<$Res> get uploadConfig;$VideoSourceCopyWith<$Res> get videoSource;$DetectionTypeCopyWith<$Res> get detectionType;$DetectionParamsCopyWith<$Res> get detectionParams;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? dataServerSelection = null,Object? personalPiyuoServer = freezed,Object? personalCustomServer = freezed,Object? businessPiyuoServer = freezed,Object? businessCustomServer = freezed,Object? uploadConfig = null,Object? videoSource = null,Object? detectionType = null,Object? detectionParams = null,Object? uploadJitterSec = null,Object? interestAreas = null,Object? isTrackIdVisible = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,dataServerSelection: null == dataServerSelection ? _self.dataServerSelection : dataServerSelection // ignore: cast_nullable_to_non_nullable
as DataServerSelection,personalPiyuoServer: freezed == personalPiyuoServer ? _self.personalPiyuoServer : personalPiyuoServer // ignore: cast_nullable_to_non_nullable
as PersonalPiyuoServer?,personalCustomServer: freezed == personalCustomServer ? _self.personalCustomServer : personalCustomServer // ignore: cast_nullable_to_non_nullable
as PersonalCustomServer?,businessPiyuoServer: freezed == businessPiyuoServer ? _self.businessPiyuoServer : businessPiyuoServer // ignore: cast_nullable_to_non_nullable
as BusinessPiyuoServer?,businessCustomServer: freezed == businessCustomServer ? _self.businessCustomServer : businessCustomServer // ignore: cast_nullable_to_non_nullable
as BusinessCustomServer?,uploadConfig: null == uploadConfig ? _self.uploadConfig : uploadConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig,videoSource: null == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource,detectionType: null == detectionType ? _self.detectionType : detectionType // ignore: cast_nullable_to_non_nullable
as DetectionType,detectionParams: null == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams,uploadJitterSec: null == uploadJitterSec ? _self.uploadJitterSec : uploadJitterSec // ignore: cast_nullable_to_non_nullable
as int,interestAreas: null == interestAreas ? _self.interestAreas : interestAreas // ignore: cast_nullable_to_non_nullable
as List<InterestAreaData>,isTrackIdVisible: null == isTrackIdVisible ? _self.isTrackIdVisible : isTrackIdVisible // ignore: cast_nullable_to_non_nullable
as bool,
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
$DetectionTypeCopyWith<$Res> get detectionType {
  
  return $DetectionTypeCopyWith<$Res>(_self.detectionType, (value) {
    return _then(_self.copyWith(detectionType: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId, @JsonKey(unknownEnumValue: DataServerSelection.unspecified)  DataServerSelection dataServerSelection,  PersonalPiyuoServer? personalPiyuoServer,  PersonalCustomServer? personalCustomServer,  BusinessPiyuoServer? businessPiyuoServer,  BusinessCustomServer? businessCustomServer,  UploadConfig uploadConfig, @JsonKey(name: 'videoSource')  VideoSource videoSource,  DetectionType detectionType,  DetectionParams detectionParams,  int uploadJitterSec,  List<InterestAreaData> interestAreas,  bool isTrackIdVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.deviceId,_that.dataServerSelection,_that.personalPiyuoServer,_that.personalCustomServer,_that.businessPiyuoServer,_that.businessCustomServer,_that.uploadConfig,_that.videoSource,_that.detectionType,_that.detectionParams,_that.uploadJitterSec,_that.interestAreas,_that.isTrackIdVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId, @JsonKey(unknownEnumValue: DataServerSelection.unspecified)  DataServerSelection dataServerSelection,  PersonalPiyuoServer? personalPiyuoServer,  PersonalCustomServer? personalCustomServer,  BusinessPiyuoServer? businessPiyuoServer,  BusinessCustomServer? businessCustomServer,  UploadConfig uploadConfig, @JsonKey(name: 'videoSource')  VideoSource videoSource,  DetectionType detectionType,  DetectionParams detectionParams,  int uploadJitterSec,  List<InterestAreaData> interestAreas,  bool isTrackIdVisible)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.deviceId,_that.dataServerSelection,_that.personalPiyuoServer,_that.personalCustomServer,_that.businessPiyuoServer,_that.businessCustomServer,_that.uploadConfig,_that.videoSource,_that.detectionType,_that.detectionParams,_that.uploadJitterSec,_that.interestAreas,_that.isTrackIdVisible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId, @JsonKey(unknownEnumValue: DataServerSelection.unspecified)  DataServerSelection dataServerSelection,  PersonalPiyuoServer? personalPiyuoServer,  PersonalCustomServer? personalCustomServer,  BusinessPiyuoServer? businessPiyuoServer,  BusinessCustomServer? businessCustomServer,  UploadConfig uploadConfig, @JsonKey(name: 'videoSource')  VideoSource videoSource,  DetectionType detectionType,  DetectionParams detectionParams,  int uploadJitterSec,  List<InterestAreaData> interestAreas,  bool isTrackIdVisible)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.deviceId,_that.dataServerSelection,_that.personalPiyuoServer,_that.personalCustomServer,_that.businessPiyuoServer,_that.businessCustomServer,_that.uploadConfig,_that.videoSource,_that.detectionType,_that.detectionParams,_that.uploadJitterSec,_that.interestAreas,_that.isTrackIdVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppState extends AppState {
  const _AppState({this.deviceId = '', @JsonKey(unknownEnumValue: DataServerSelection.unspecified) this.dataServerSelection = DataServerSelection.unspecified, this.personalPiyuoServer, this.personalCustomServer, this.businessPiyuoServer, this.businessCustomServer, this.uploadConfig = const UploadConfig(), @JsonKey(name: 'videoSource') this.videoSource = const VideoSource.unspecified(), this.detectionType = const DetectionType.human(), this.detectionParams = const DetectionParams(), this.uploadJitterSec = 0, final  List<InterestAreaData> interestAreas = const [], this.isTrackIdVisible = false}): _interestAreas = interestAreas,super._();
  factory _AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

/// auto-generated unique device ID, sent to backend as a safety identifier
@override@JsonKey() final  String deviceId;
/// if dataServerSelection is unspecified, then app need run onboarding flow to let user select a data server.
@override@JsonKey(unknownEnumValue: DataServerSelection.unspecified) final  DataServerSelection dataServerSelection;
/// personal subscription plan, use piyuo.com backend, setup by user.
@override final  PersonalPiyuoServer? personalPiyuoServer;
/// personal subscription plan, use their own backend, setup by user.
@override final  PersonalCustomServer? personalCustomServer;
/// business subscription plan, use piyuo.com backend, setup by invitation.
@override final  BusinessPiyuoServer? businessPiyuoServer;
/// business subscription plan, use their own backend, setup by invitation.
@override final  BusinessCustomServer? businessCustomServer;
/// how to upload data to remote server/
@override@JsonKey() final  UploadConfig uploadConfig;
/// Vision input selection.
///
/// Stored as a flat AppState field rather than inside a nested vision-session
/// object because source, detection, and params can each change independently.
@override@JsonKey(name: 'videoSource') final  VideoSource videoSource;
/// Vision model selection paired with [videoSource] and [detectionParams]
/// to define the desired runtime session.
@override@JsonKey() final  DetectionType detectionType;
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
/// User-defined interest areas (detection zones).
///
/// Stored as domain models that can be serialized to JSON. At runtime,
/// these are converted to flutter_vision's InterestArea instances when
/// configuring the vision session.
 final  List<InterestAreaData> _interestAreas;
/// User-defined interest areas (detection zones).
///
/// Stored as domain models that can be serialized to JSON. At runtime,
/// these are converted to flutter_vision's InterestArea instances when
/// configuring the vision session.
@override@JsonKey() List<InterestAreaData> get interestAreas {
  if (_interestAreas is EqualUnmodifiableListView) return _interestAreas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interestAreas);
}

/// Whether track IDs should be visible in the detection output.
@override@JsonKey() final  bool isTrackIdVisible;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.dataServerSelection, dataServerSelection) || other.dataServerSelection == dataServerSelection)&&const DeepCollectionEquality().equals(other.personalPiyuoServer, personalPiyuoServer)&&const DeepCollectionEquality().equals(other.personalCustomServer, personalCustomServer)&&const DeepCollectionEquality().equals(other.businessPiyuoServer, businessPiyuoServer)&&const DeepCollectionEquality().equals(other.businessCustomServer, businessCustomServer)&&(identical(other.uploadConfig, uploadConfig) || other.uploadConfig == uploadConfig)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.detectionType, detectionType) || other.detectionType == detectionType)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.uploadJitterSec, uploadJitterSec) || other.uploadJitterSec == uploadJitterSec)&&const DeepCollectionEquality().equals(other._interestAreas, _interestAreas)&&(identical(other.isTrackIdVisible, isTrackIdVisible) || other.isTrackIdVisible == isTrackIdVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,dataServerSelection,const DeepCollectionEquality().hash(personalPiyuoServer),const DeepCollectionEquality().hash(personalCustomServer),const DeepCollectionEquality().hash(businessPiyuoServer),const DeepCollectionEquality().hash(businessCustomServer),uploadConfig,videoSource,detectionType,detectionParams,uploadJitterSec,const DeepCollectionEquality().hash(_interestAreas),isTrackIdVisible);

@override
String toString() {
  return 'AppState(deviceId: $deviceId, dataServerSelection: $dataServerSelection, personalPiyuoServer: $personalPiyuoServer, personalCustomServer: $personalCustomServer, businessPiyuoServer: $businessPiyuoServer, businessCustomServer: $businessCustomServer, uploadConfig: $uploadConfig, videoSource: $videoSource, detectionType: $detectionType, detectionParams: $detectionParams, uploadJitterSec: $uploadJitterSec, interestAreas: $interestAreas, isTrackIdVisible: $isTrackIdVisible)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 String deviceId,@JsonKey(unknownEnumValue: DataServerSelection.unspecified) DataServerSelection dataServerSelection, PersonalPiyuoServer? personalPiyuoServer, PersonalCustomServer? personalCustomServer, BusinessPiyuoServer? businessPiyuoServer, BusinessCustomServer? businessCustomServer, UploadConfig uploadConfig,@JsonKey(name: 'videoSource') VideoSource videoSource, DetectionType detectionType, DetectionParams detectionParams, int uploadJitterSec, List<InterestAreaData> interestAreas, bool isTrackIdVisible
});


@override $UploadConfigCopyWith<$Res> get uploadConfig;@override $VideoSourceCopyWith<$Res> get videoSource;@override $DetectionTypeCopyWith<$Res> get detectionType;@override $DetectionParamsCopyWith<$Res> get detectionParams;

}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? dataServerSelection = null,Object? personalPiyuoServer = freezed,Object? personalCustomServer = freezed,Object? businessPiyuoServer = freezed,Object? businessCustomServer = freezed,Object? uploadConfig = null,Object? videoSource = null,Object? detectionType = null,Object? detectionParams = null,Object? uploadJitterSec = null,Object? interestAreas = null,Object? isTrackIdVisible = null,}) {
  return _then(_AppState(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,dataServerSelection: null == dataServerSelection ? _self.dataServerSelection : dataServerSelection // ignore: cast_nullable_to_non_nullable
as DataServerSelection,personalPiyuoServer: freezed == personalPiyuoServer ? _self.personalPiyuoServer : personalPiyuoServer // ignore: cast_nullable_to_non_nullable
as PersonalPiyuoServer?,personalCustomServer: freezed == personalCustomServer ? _self.personalCustomServer : personalCustomServer // ignore: cast_nullable_to_non_nullable
as PersonalCustomServer?,businessPiyuoServer: freezed == businessPiyuoServer ? _self.businessPiyuoServer : businessPiyuoServer // ignore: cast_nullable_to_non_nullable
as BusinessPiyuoServer?,businessCustomServer: freezed == businessCustomServer ? _self.businessCustomServer : businessCustomServer // ignore: cast_nullable_to_non_nullable
as BusinessCustomServer?,uploadConfig: null == uploadConfig ? _self.uploadConfig : uploadConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig,videoSource: null == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource,detectionType: null == detectionType ? _self.detectionType : detectionType // ignore: cast_nullable_to_non_nullable
as DetectionType,detectionParams: null == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams,uploadJitterSec: null == uploadJitterSec ? _self.uploadJitterSec : uploadJitterSec // ignore: cast_nullable_to_non_nullable
as int,interestAreas: null == interestAreas ? _self._interestAreas : interestAreas // ignore: cast_nullable_to_non_nullable
as List<InterestAreaData>,isTrackIdVisible: null == isTrackIdVisible ? _self.isTrackIdVisible : isTrackIdVisible // ignore: cast_nullable_to_non_nullable
as bool,
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
$DetectionTypeCopyWith<$Res> get detectionType {
  
  return $DetectionTypeCopyWith<$Res>(_self.detectionType, (value) {
    return _then(_self.copyWith(detectionType: value));
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
