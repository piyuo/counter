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

 String get instruction; String get bearerToken; BusinessPiyuoServer? get businessPiyuoServer; BusinessCustomServer? get businessCustomServer; DetectionType? get detection; DetectionParams? get detectionParams; UploadConfig? get uploadConfig;
/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationCopyWith<Invitation> get copyWith => _$InvitationCopyWithImpl<Invitation>(this as Invitation, _$identity);

  /// Serializes this Invitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invitation&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.bearerToken, bearerToken) || other.bearerToken == bearerToken)&&const DeepCollectionEquality().equals(other.businessPiyuoServer, businessPiyuoServer)&&const DeepCollectionEquality().equals(other.businessCustomServer, businessCustomServer)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.uploadConfig, uploadConfig) || other.uploadConfig == uploadConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,instruction,bearerToken,const DeepCollectionEquality().hash(businessPiyuoServer),const DeepCollectionEquality().hash(businessCustomServer),detection,detectionParams,uploadConfig);

@override
String toString() {
  return 'Invitation(instruction: $instruction, bearerToken: $bearerToken, businessPiyuoServer: $businessPiyuoServer, businessCustomServer: $businessCustomServer, detection: $detection, detectionParams: $detectionParams, uploadConfig: $uploadConfig)';
}


}

/// @nodoc
abstract mixin class $InvitationCopyWith<$Res>  {
  factory $InvitationCopyWith(Invitation value, $Res Function(Invitation) _then) = _$InvitationCopyWithImpl;
@useResult
$Res call({
 String instruction, String bearerToken, BusinessPiyuoServer? businessPiyuoServer, BusinessCustomServer? businessCustomServer, DetectionType? detection, DetectionParams? detectionParams, UploadConfig? uploadConfig
});


$DetectionTypeCopyWith<$Res>? get detection;$DetectionParamsCopyWith<$Res>? get detectionParams;$UploadConfigCopyWith<$Res>? get uploadConfig;

}
/// @nodoc
class _$InvitationCopyWithImpl<$Res>
    implements $InvitationCopyWith<$Res> {
  _$InvitationCopyWithImpl(this._self, this._then);

  final Invitation _self;
  final $Res Function(Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? instruction = null,Object? bearerToken = null,Object? businessPiyuoServer = freezed,Object? businessCustomServer = freezed,Object? detection = freezed,Object? detectionParams = freezed,Object? uploadConfig = freezed,}) {
  return _then(_self.copyWith(
instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,bearerToken: null == bearerToken ? _self.bearerToken : bearerToken // ignore: cast_nullable_to_non_nullable
as String,businessPiyuoServer: freezed == businessPiyuoServer ? _self.businessPiyuoServer : businessPiyuoServer // ignore: cast_nullable_to_non_nullable
as BusinessPiyuoServer?,businessCustomServer: freezed == businessCustomServer ? _self.businessCustomServer : businessCustomServer // ignore: cast_nullable_to_non_nullable
as BusinessCustomServer?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams?,uploadConfig: freezed == uploadConfig ? _self.uploadConfig : uploadConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig?,
  ));
}
/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionTypeCopyWith<$Res>? get detection {
    if (_self.detection == null) {
    return null;
  }

  return $DetectionTypeCopyWith<$Res>(_self.detection!, (value) {
    return _then(_self.copyWith(detection: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<$Res>? get detectionParams {
    if (_self.detectionParams == null) {
    return null;
  }

  return $DetectionParamsCopyWith<$Res>(_self.detectionParams!, (value) {
    return _then(_self.copyWith(detectionParams: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res>? get uploadConfig {
    if (_self.uploadConfig == null) {
    return null;
  }

  return $UploadConfigCopyWith<$Res>(_self.uploadConfig!, (value) {
    return _then(_self.copyWith(uploadConfig: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String instruction,  String bearerToken,  BusinessPiyuoServer? businessPiyuoServer,  BusinessCustomServer? businessCustomServer,  DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? uploadConfig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.instruction,_that.bearerToken,_that.businessPiyuoServer,_that.businessCustomServer,_that.detection,_that.detectionParams,_that.uploadConfig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String instruction,  String bearerToken,  BusinessPiyuoServer? businessPiyuoServer,  BusinessCustomServer? businessCustomServer,  DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? uploadConfig)  $default,) {final _that = this;
switch (_that) {
case _Invitation():
return $default(_that.instruction,_that.bearerToken,_that.businessPiyuoServer,_that.businessCustomServer,_that.detection,_that.detectionParams,_that.uploadConfig);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String instruction,  String bearerToken,  BusinessPiyuoServer? businessPiyuoServer,  BusinessCustomServer? businessCustomServer,  DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? uploadConfig)?  $default,) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.instruction,_that.bearerToken,_that.businessPiyuoServer,_that.businessCustomServer,_that.detection,_that.detectionParams,_that.uploadConfig);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invitation implements Invitation {
  const _Invitation({required this.instruction, required this.bearerToken, this.businessPiyuoServer, this.businessCustomServer, this.detection, this.detectionParams, this.uploadConfig});
  factory _Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

@override final  String instruction;
@override final  String bearerToken;
@override final  BusinessPiyuoServer? businessPiyuoServer;
@override final  BusinessCustomServer? businessCustomServer;
@override final  DetectionType? detection;
@override final  DetectionParams? detectionParams;
@override final  UploadConfig? uploadConfig;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invitation&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.bearerToken, bearerToken) || other.bearerToken == bearerToken)&&const DeepCollectionEquality().equals(other.businessPiyuoServer, businessPiyuoServer)&&const DeepCollectionEquality().equals(other.businessCustomServer, businessCustomServer)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.uploadConfig, uploadConfig) || other.uploadConfig == uploadConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,instruction,bearerToken,const DeepCollectionEquality().hash(businessPiyuoServer),const DeepCollectionEquality().hash(businessCustomServer),detection,detectionParams,uploadConfig);

@override
String toString() {
  return 'Invitation(instruction: $instruction, bearerToken: $bearerToken, businessPiyuoServer: $businessPiyuoServer, businessCustomServer: $businessCustomServer, detection: $detection, detectionParams: $detectionParams, uploadConfig: $uploadConfig)';
}


}

/// @nodoc
abstract mixin class _$InvitationCopyWith<$Res> implements $InvitationCopyWith<$Res> {
  factory _$InvitationCopyWith(_Invitation value, $Res Function(_Invitation) _then) = __$InvitationCopyWithImpl;
@override @useResult
$Res call({
 String instruction, String bearerToken, BusinessPiyuoServer? businessPiyuoServer, BusinessCustomServer? businessCustomServer, DetectionType? detection, DetectionParams? detectionParams, UploadConfig? uploadConfig
});


@override $DetectionTypeCopyWith<$Res>? get detection;@override $DetectionParamsCopyWith<$Res>? get detectionParams;@override $UploadConfigCopyWith<$Res>? get uploadConfig;

}
/// @nodoc
class __$InvitationCopyWithImpl<$Res>
    implements _$InvitationCopyWith<$Res> {
  __$InvitationCopyWithImpl(this._self, this._then);

  final _Invitation _self;
  final $Res Function(_Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? instruction = null,Object? bearerToken = null,Object? businessPiyuoServer = freezed,Object? businessCustomServer = freezed,Object? detection = freezed,Object? detectionParams = freezed,Object? uploadConfig = freezed,}) {
  return _then(_Invitation(
instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,bearerToken: null == bearerToken ? _self.bearerToken : bearerToken // ignore: cast_nullable_to_non_nullable
as String,businessPiyuoServer: freezed == businessPiyuoServer ? _self.businessPiyuoServer : businessPiyuoServer // ignore: cast_nullable_to_non_nullable
as BusinessPiyuoServer?,businessCustomServer: freezed == businessCustomServer ? _self.businessCustomServer : businessCustomServer // ignore: cast_nullable_to_non_nullable
as BusinessCustomServer?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams?,uploadConfig: freezed == uploadConfig ? _self.uploadConfig : uploadConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig?,
  ));
}

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionTypeCopyWith<$Res>? get detection {
    if (_self.detection == null) {
    return null;
  }

  return $DetectionTypeCopyWith<$Res>(_self.detection!, (value) {
    return _then(_self.copyWith(detection: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<$Res>? get detectionParams {
    if (_self.detectionParams == null) {
    return null;
  }

  return $DetectionParamsCopyWith<$Res>(_self.detectionParams!, (value) {
    return _then(_self.copyWith(detectionParams: value));
  });
}/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res>? get uploadConfig {
    if (_self.uploadConfig == null) {
    return null;
  }

  return $UploadConfigCopyWith<$Res>(_self.uploadConfig!, (value) {
    return _then(_self.copyWith(uploadConfig: value));
  });
}
}

// dart format on
