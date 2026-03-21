// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadResult {

 bool get isSuccess; String? get message; DetectionType? get detection; DetectionParams? get detectionParams; UploadConfig? get deliveryConfig;
/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadResultCopyWith<UploadResult> get copyWith => _$UploadResultCopyWithImpl<UploadResult>(this as UploadResult, _$identity);

  /// Serializes this UploadResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadResult&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.message, message) || other.message == message)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.deliveryConfig, deliveryConfig) || other.deliveryConfig == deliveryConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSuccess,message,detection,detectionParams,deliveryConfig);

@override
String toString() {
  return 'UploadResult(isSuccess: $isSuccess, message: $message, detection: $detection, detectionParams: $detectionParams, deliveryConfig: $deliveryConfig)';
}


}

/// @nodoc
abstract mixin class $UploadResultCopyWith<$Res>  {
  factory $UploadResultCopyWith(UploadResult value, $Res Function(UploadResult) _then) = _$UploadResultCopyWithImpl;
@useResult
$Res call({
 bool isSuccess, String? message, DetectionType? detection, DetectionParams? detectionParams, UploadConfig? deliveryConfig
});


$DetectionTypeCopyWith<$Res>? get detection;$DetectionParamsCopyWith<$Res>? get detectionParams;$UploadConfigCopyWith<$Res>? get deliveryConfig;

}
/// @nodoc
class _$UploadResultCopyWithImpl<$Res>
    implements $UploadResultCopyWith<$Res> {
  _$UploadResultCopyWithImpl(this._self, this._then);

  final UploadResult _self;
  final $Res Function(UploadResult) _then;

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSuccess = null,Object? message = freezed,Object? detection = freezed,Object? detectionParams = freezed,Object? deliveryConfig = freezed,}) {
  return _then(_self.copyWith(
isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams?,deliveryConfig: freezed == deliveryConfig ? _self.deliveryConfig : deliveryConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig?,
  ));
}
/// Create a copy of UploadResult
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
}/// Create a copy of UploadResult
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
}/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res>? get deliveryConfig {
    if (_self.deliveryConfig == null) {
    return null;
  }

  return $UploadConfigCopyWith<$Res>(_self.deliveryConfig!, (value) {
    return _then(_self.copyWith(deliveryConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [UploadResult].
extension UploadResultPatterns on UploadResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadResult value)  $default,){
final _that = this;
switch (_that) {
case _UploadResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadResult value)?  $default,){
final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSuccess,  String? message,  DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? deliveryConfig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
return $default(_that.isSuccess,_that.message,_that.detection,_that.detectionParams,_that.deliveryConfig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSuccess,  String? message,  DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? deliveryConfig)  $default,) {final _that = this;
switch (_that) {
case _UploadResult():
return $default(_that.isSuccess,_that.message,_that.detection,_that.detectionParams,_that.deliveryConfig);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSuccess,  String? message,  DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? deliveryConfig)?  $default,) {final _that = this;
switch (_that) {
case _UploadResult() when $default != null:
return $default(_that.isSuccess,_that.message,_that.detection,_that.detectionParams,_that.deliveryConfig);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadResult implements UploadResult {
  const _UploadResult({required this.isSuccess, this.message, this.detection, this.detectionParams, this.deliveryConfig});
  factory _UploadResult.fromJson(Map<String, dynamic> json) => _$UploadResultFromJson(json);

@override final  bool isSuccess;
@override final  String? message;
@override final  DetectionType? detection;
@override final  DetectionParams? detectionParams;
@override final  UploadConfig? deliveryConfig;

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadResultCopyWith<_UploadResult> get copyWith => __$UploadResultCopyWithImpl<_UploadResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadResult&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.message, message) || other.message == message)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.deliveryConfig, deliveryConfig) || other.deliveryConfig == deliveryConfig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSuccess,message,detection,detectionParams,deliveryConfig);

@override
String toString() {
  return 'UploadResult(isSuccess: $isSuccess, message: $message, detection: $detection, detectionParams: $detectionParams, deliveryConfig: $deliveryConfig)';
}


}

/// @nodoc
abstract mixin class _$UploadResultCopyWith<$Res> implements $UploadResultCopyWith<$Res> {
  factory _$UploadResultCopyWith(_UploadResult value, $Res Function(_UploadResult) _then) = __$UploadResultCopyWithImpl;
@override @useResult
$Res call({
 bool isSuccess, String? message, DetectionType? detection, DetectionParams? detectionParams, UploadConfig? deliveryConfig
});


@override $DetectionTypeCopyWith<$Res>? get detection;@override $DetectionParamsCopyWith<$Res>? get detectionParams;@override $UploadConfigCopyWith<$Res>? get deliveryConfig;

}
/// @nodoc
class __$UploadResultCopyWithImpl<$Res>
    implements _$UploadResultCopyWith<$Res> {
  __$UploadResultCopyWithImpl(this._self, this._then);

  final _UploadResult _self;
  final $Res Function(_UploadResult) _then;

/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSuccess = null,Object? message = freezed,Object? detection = freezed,Object? detectionParams = freezed,Object? deliveryConfig = freezed,}) {
  return _then(_UploadResult(
isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams?,deliveryConfig: freezed == deliveryConfig ? _self.deliveryConfig : deliveryConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig?,
  ));
}

/// Create a copy of UploadResult
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
}/// Create a copy of UploadResult
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
}/// Create a copy of UploadResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<$Res>? get deliveryConfig {
    if (_self.deliveryConfig == null) {
    return null;
  }

  return $UploadConfigCopyWith<$Res>(_self.deliveryConfig!, (value) {
    return _then(_self.copyWith(deliveryConfig: value));
  });
}
}

// dart format on
