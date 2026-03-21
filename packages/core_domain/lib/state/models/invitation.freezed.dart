// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Invitation {

 BusinessDataServer get businessDataServer; String get bearerToken; String get deviceName; String get instruction; DetectionType get detection; DetectionParams get detectionParams; UploadConfig get deliveryConfig;
/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationCopyWith<Invitation> get copyWith => _$InvitationCopyWithImpl<Invitation>(this as Invitation, _$identity);

  /// Serializes this Invitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invitation&&const DeepCollectionEquality().equals(other.businessDataServer, businessDataServer)&&(identical(other.bearerToken, bearerToken) || other.bearerToken == bearerToken)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.deliveryConfig, deliveryConfig) || other.deliveryConfig == deliveryConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(businessDataServer),bearerToken,deviceName,instruction,detection,detectionParams,deliveryConfig);

@override
String toString() {
  return 'Invitation(businessDataServer: $businessDataServer, bearerToken: $bearerToken, deviceName: $deviceName, instruction: $instruction, detection: $detection, detectionParams: $detectionParams, deliveryConfig: $deliveryConfig)';
}


}

/// @nodoc
abstract mixin class $InvitationCopyWith<$Res>  {
  factory $InvitationCopyWith(Invitation value, $Res Function(Invitation) _then) = _$InvitationCopyWithImpl;
@useResult
$Res call({
 BusinessDataServer businessDataServer, String bearerToken, String deviceName, String instruction, DetectionType detection, DetectionParams detectionParams, UploadConfig deliveryConfig
});


$DetectionTypeCopyWith<$Res> get detection;$DetectionParamsCopyWith<$Res> get detectionParams;$UploadConfigCopyWith<$Res> get deliveryConfig;

}
/// @nodoc
class _$InvitationCopyWithImpl<$Res>
    implements $InvitationCopyWith<$Res> {
  _$InvitationCopyWithImpl(this._self, this._then);

  final Invitation _self;
  final $Res Function(Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessDataServer = freezed,Object? bearerToken = null,Object? deviceName = null,Object? instruction = null,Object? detection = null,Object? detectionParams = null,Object? deliveryConfig = null,}) {
  return _then(_self.copyWith(
businessDataServer: freezed == businessDataServer ? _self.businessDataServer : businessDataServer // ignore: cast_nullable_to_non_nullable
as BusinessDataServer,bearerToken: null == bearerToken ? _self.bearerToken : bearerToken // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,detection: null == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType,detectionParams: null == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams,deliveryConfig: null == deliveryConfig ? _self.deliveryConfig : deliveryConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig,
  ));
}
/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionTypeCopyWith<$Res> get detection {
  
  return $DetectionTypeCopyWith<$Res>(_self.detection, (value) {
    return _then(_self.copyWith(detection: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<$Res> get detectionParams {
  
  return $DetectionParamsCopyWith<$Res>(_self.detectionParams, (value) {
    return _then(_self.copyWith(detectionParams: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res> get deliveryConfig {
  
  return $UploadConfigCopyWith<$Res>(_self.deliveryConfig, (value) {
    return _then(_self.copyWith(deliveryConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [Invitation].
extension InvitationPatterns on Invitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Invitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Invitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Invitation value)  $default,){
final _that = this;
switch (_that) {
case _Invitation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Invitation value)?  $default,){
final _that = this;
switch (_that) {
case _Invitation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BusinessDataServer businessDataServer,  String bearerToken,  String deviceName,  String instruction,  DetectionType detection,  DetectionParams detectionParams,  UploadConfig deliveryConfig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.businessDataServer,_that.bearerToken,_that.deviceName,_that.instruction,_that.detection,_that.detectionParams,_that.deliveryConfig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BusinessDataServer businessDataServer,  String bearerToken,  String deviceName,  String instruction,  DetectionType detection,  DetectionParams detectionParams,  UploadConfig deliveryConfig)  $default,) {final _that = this;
switch (_that) {
case _Invitation():
return $default(_that.businessDataServer,_that.bearerToken,_that.deviceName,_that.instruction,_that.detection,_that.detectionParams,_that.deliveryConfig);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BusinessDataServer businessDataServer,  String bearerToken,  String deviceName,  String instruction,  DetectionType detection,  DetectionParams detectionParams,  UploadConfig deliveryConfig)?  $default,) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.businessDataServer,_that.bearerToken,_that.deviceName,_that.instruction,_that.detection,_that.detectionParams,_that.deliveryConfig);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invitation implements Invitation {
  const _Invitation({required this.businessDataServer, required this.bearerToken, required this.deviceName, required this.instruction, required this.detection, required this.detectionParams, required this.deliveryConfig});
  factory _Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

@override final  BusinessDataServer businessDataServer;
@override final  String bearerToken;
@override final  String deviceName;
@override final  String instruction;
@override final  DetectionType detection;
@override final  DetectionParams detectionParams;
@override final  UploadConfig deliveryConfig;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationCopyWith<_Invitation> get copyWith => __$InvitationCopyWithImpl<_Invitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invitation&&const DeepCollectionEquality().equals(other.businessDataServer, businessDataServer)&&(identical(other.bearerToken, bearerToken) || other.bearerToken == bearerToken)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.deliveryConfig, deliveryConfig) || other.deliveryConfig == deliveryConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(businessDataServer),bearerToken,deviceName,instruction,detection,detectionParams,deliveryConfig);

@override
String toString() {
  return 'Invitation(businessDataServer: $businessDataServer, bearerToken: $bearerToken, deviceName: $deviceName, instruction: $instruction, detection: $detection, detectionParams: $detectionParams, deliveryConfig: $deliveryConfig)';
}


}

/// @nodoc
abstract mixin class _$InvitationCopyWith<$Res> implements $InvitationCopyWith<$Res> {
  factory _$InvitationCopyWith(_Invitation value, $Res Function(_Invitation) _then) = __$InvitationCopyWithImpl;
@override @useResult
$Res call({
 BusinessDataServer businessDataServer, String bearerToken, String deviceName, String instruction, DetectionType detection, DetectionParams detectionParams, UploadConfig deliveryConfig
});


@override $DetectionTypeCopyWith<$Res> get detection;@override $DetectionParamsCopyWith<$Res> get detectionParams;@override $UploadConfigCopyWith<$Res> get deliveryConfig;

}
/// @nodoc
class __$InvitationCopyWithImpl<$Res>
    implements _$InvitationCopyWith<$Res> {
  __$InvitationCopyWithImpl(this._self, this._then);

  final _Invitation _self;
  final $Res Function(_Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businessDataServer = freezed,Object? bearerToken = null,Object? deviceName = null,Object? instruction = null,Object? detection = null,Object? detectionParams = null,Object? deliveryConfig = null,}) {
  return _then(_Invitation(
businessDataServer: freezed == businessDataServer ? _self.businessDataServer : businessDataServer // ignore: cast_nullable_to_non_nullable
as BusinessDataServer,bearerToken: null == bearerToken ? _self.bearerToken : bearerToken // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,detection: null == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType,detectionParams: null == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams,deliveryConfig: null == deliveryConfig ? _self.deliveryConfig : deliveryConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig,
  ));
}

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionTypeCopyWith<$Res> get detection {
  
  return $DetectionTypeCopyWith<$Res>(_self.detection, (value) {
    return _then(_self.copyWith(detection: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<$Res> get detectionParams {
  
  return $DetectionParamsCopyWith<$Res>(_self.detectionParams, (value) {
    return _then(_self.copyWith(detectionParams: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res> get deliveryConfig {
  
  return $UploadConfigCopyWith<$Res>(_self.deliveryConfig, (value) {
    return _then(_self.copyWith(deliveryConfig: value));
  });
}
}

// dart format on
