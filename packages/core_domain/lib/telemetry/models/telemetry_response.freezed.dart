// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelemetryResponse {

 int get v; bool get ok; String? get error; ServerData? get data;
/// Create a copy of TelemetryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetryResponseCopyWith<TelemetryResponse> get copyWith => _$TelemetryResponseCopyWithImpl<TelemetryResponse>(this as TelemetryResponse, _$identity);

  /// Serializes this TelemetryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetryResponse&&(identical(other.v, v) || other.v == v)&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,v,ok,error,data);

@override
String toString() {
  return 'TelemetryResponse(v: $v, ok: $ok, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class $TelemetryResponseCopyWith<$Res>  {
  factory $TelemetryResponseCopyWith(TelemetryResponse value, $Res Function(TelemetryResponse) _then) = _$TelemetryResponseCopyWithImpl;
@useResult
$Res call({
 int v, bool ok, String? error, ServerData? data
});


$ServerDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$TelemetryResponseCopyWithImpl<$Res>
    implements $TelemetryResponseCopyWith<$Res> {
  _$TelemetryResponseCopyWithImpl(this._self, this._then);

  final TelemetryResponse _self;
  final $Res Function(TelemetryResponse) _then;

/// Create a copy of TelemetryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? v = null,Object? ok = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ServerData?,
  ));
}
/// Create a copy of TelemetryResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ServerDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [TelemetryResponse].
extension TelemetryResponsePatterns on TelemetryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetryResponse value)  $default,){
final _that = this;
switch (_that) {
case _TelemetryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int v,  bool ok,  String? error,  ServerData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetryResponse() when $default != null:
return $default(_that.v,_that.ok,_that.error,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int v,  bool ok,  String? error,  ServerData? data)  $default,) {final _that = this;
switch (_that) {
case _TelemetryResponse():
return $default(_that.v,_that.ok,_that.error,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int v,  bool ok,  String? error,  ServerData? data)?  $default,) {final _that = this;
switch (_that) {
case _TelemetryResponse() when $default != null:
return $default(_that.v,_that.ok,_that.error,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelemetryResponse implements TelemetryResponse {
  const _TelemetryResponse({required this.v, required this.ok, this.error, this.data});
  factory _TelemetryResponse.fromJson(Map<String, dynamic> json) => _$TelemetryResponseFromJson(json);

@override final  int v;
@override final  bool ok;
@override final  String? error;
@override final  ServerData? data;

/// Create a copy of TelemetryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetryResponseCopyWith<_TelemetryResponse> get copyWith => __$TelemetryResponseCopyWithImpl<_TelemetryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelemetryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetryResponse&&(identical(other.v, v) || other.v == v)&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.error, error) || other.error == error)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,v,ok,error,data);

@override
String toString() {
  return 'TelemetryResponse(v: $v, ok: $ok, error: $error, data: $data)';
}


}

/// @nodoc
abstract mixin class _$TelemetryResponseCopyWith<$Res> implements $TelemetryResponseCopyWith<$Res> {
  factory _$TelemetryResponseCopyWith(_TelemetryResponse value, $Res Function(_TelemetryResponse) _then) = __$TelemetryResponseCopyWithImpl;
@override @useResult
$Res call({
 int v, bool ok, String? error, ServerData? data
});


@override $ServerDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$TelemetryResponseCopyWithImpl<$Res>
    implements _$TelemetryResponseCopyWith<$Res> {
  __$TelemetryResponseCopyWithImpl(this._self, this._then);

  final _TelemetryResponse _self;
  final $Res Function(_TelemetryResponse) _then;

/// Create a copy of TelemetryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? v = null,Object? ok = null,Object? error = freezed,Object? data = freezed,}) {
  return _then(_TelemetryResponse(
v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ServerData?,
  ));
}

/// Create a copy of TelemetryResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $ServerDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ServerData {

 DetectionType? get detection; DetectionParams? get detectionParams; UploadConfig? get deliveryConfig; ServerConfig? get config;
/// Create a copy of ServerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerDataCopyWith<ServerData> get copyWith => _$ServerDataCopyWithImpl<ServerData>(this as ServerData, _$identity);

  /// Serializes this ServerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerData&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.deliveryConfig, deliveryConfig) || other.deliveryConfig == deliveryConfig)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detection,detectionParams,deliveryConfig,config);

@override
String toString() {
  return 'ServerData(detection: $detection, detectionParams: $detectionParams, deliveryConfig: $deliveryConfig, config: $config)';
}


}

/// @nodoc
abstract mixin class $ServerDataCopyWith<$Res>  {
  factory $ServerDataCopyWith(ServerData value, $Res Function(ServerData) _then) = _$ServerDataCopyWithImpl;
@useResult
$Res call({
 DetectionType? detection, DetectionParams? detectionParams, UploadConfig? deliveryConfig, ServerConfig? config
});


$DetectionTypeCopyWith<$Res>? get detection;$DetectionParamsCopyWith<$Res>? get detectionParams;$UploadConfigCopyWith<$Res>? get deliveryConfig;$ServerConfigCopyWith<$Res>? get config;

}
/// @nodoc
class _$ServerDataCopyWithImpl<$Res>
    implements $ServerDataCopyWith<$Res> {
  _$ServerDataCopyWithImpl(this._self, this._then);

  final ServerData _self;
  final $Res Function(ServerData) _then;

/// Create a copy of ServerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detection = freezed,Object? detectionParams = freezed,Object? deliveryConfig = freezed,Object? config = freezed,}) {
  return _then(_self.copyWith(
detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams?,deliveryConfig: freezed == deliveryConfig ? _self.deliveryConfig : deliveryConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ServerConfig?,
  ));
}
/// Create a copy of ServerData
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
}/// Create a copy of ServerData
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
}/// Create a copy of ServerData
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
}/// Create a copy of ServerData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $ServerConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [ServerData].
extension ServerDataPatterns on ServerData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerData value)  $default,){
final _that = this;
switch (_that) {
case _ServerData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerData value)?  $default,){
final _that = this;
switch (_that) {
case _ServerData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? deliveryConfig,  ServerConfig? config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerData() when $default != null:
return $default(_that.detection,_that.detectionParams,_that.deliveryConfig,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? deliveryConfig,  ServerConfig? config)  $default,) {final _that = this;
switch (_that) {
case _ServerData():
return $default(_that.detection,_that.detectionParams,_that.deliveryConfig,_that.config);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DetectionType? detection,  DetectionParams? detectionParams,  UploadConfig? deliveryConfig,  ServerConfig? config)?  $default,) {final _that = this;
switch (_that) {
case _ServerData() when $default != null:
return $default(_that.detection,_that.detectionParams,_that.deliveryConfig,_that.config);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerData implements ServerData {
  const _ServerData({this.detection, this.detectionParams, this.deliveryConfig, this.config});
  factory _ServerData.fromJson(Map<String, dynamic> json) => _$ServerDataFromJson(json);

@override final  DetectionType? detection;
@override final  DetectionParams? detectionParams;
@override final  UploadConfig? deliveryConfig;
@override final  ServerConfig? config;

/// Create a copy of ServerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerDataCopyWith<_ServerData> get copyWith => __$ServerDataCopyWithImpl<_ServerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerData&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.detectionParams, detectionParams) || other.detectionParams == detectionParams)&&(identical(other.deliveryConfig, deliveryConfig) || other.deliveryConfig == deliveryConfig)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detection,detectionParams,deliveryConfig,config);

@override
String toString() {
  return 'ServerData(detection: $detection, detectionParams: $detectionParams, deliveryConfig: $deliveryConfig, config: $config)';
}


}

/// @nodoc
abstract mixin class _$ServerDataCopyWith<$Res> implements $ServerDataCopyWith<$Res> {
  factory _$ServerDataCopyWith(_ServerData value, $Res Function(_ServerData) _then) = __$ServerDataCopyWithImpl;
@override @useResult
$Res call({
 DetectionType? detection, DetectionParams? detectionParams, UploadConfig? deliveryConfig, ServerConfig? config
});


@override $DetectionTypeCopyWith<$Res>? get detection;@override $DetectionParamsCopyWith<$Res>? get detectionParams;@override $UploadConfigCopyWith<$Res>? get deliveryConfig;@override $ServerConfigCopyWith<$Res>? get config;

}
/// @nodoc
class __$ServerDataCopyWithImpl<$Res>
    implements _$ServerDataCopyWith<$Res> {
  __$ServerDataCopyWithImpl(this._self, this._then);

  final _ServerData _self;
  final $Res Function(_ServerData) _then;

/// Create a copy of ServerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detection = freezed,Object? detectionParams = freezed,Object? deliveryConfig = freezed,Object? config = freezed,}) {
  return _then(_ServerData(
detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionType?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as DetectionParams?,deliveryConfig: freezed == deliveryConfig ? _self.deliveryConfig : deliveryConfig // ignore: cast_nullable_to_non_nullable
as UploadConfig?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ServerConfig?,
  ));
}

/// Create a copy of ServerData
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
}/// Create a copy of ServerData
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
}/// Create a copy of ServerData
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
}/// Create a copy of ServerData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $ServerConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// @nodoc
mixin _$ServerConfig {

 int? get uploadIntervalSec; Map<String, dynamic>? get detectionParams;
/// Create a copy of ServerConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerConfigCopyWith<ServerConfig> get copyWith => _$ServerConfigCopyWithImpl<ServerConfig>(this as ServerConfig, _$identity);

  /// Serializes this ServerConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerConfig&&(identical(other.uploadIntervalSec, uploadIntervalSec) || other.uploadIntervalSec == uploadIntervalSec)&&const DeepCollectionEquality().equals(other.detectionParams, detectionParams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uploadIntervalSec,const DeepCollectionEquality().hash(detectionParams));

@override
String toString() {
  return 'ServerConfig(uploadIntervalSec: $uploadIntervalSec, detectionParams: $detectionParams)';
}


}

/// @nodoc
abstract mixin class $ServerConfigCopyWith<$Res>  {
  factory $ServerConfigCopyWith(ServerConfig value, $Res Function(ServerConfig) _then) = _$ServerConfigCopyWithImpl;
@useResult
$Res call({
 int? uploadIntervalSec, Map<String, dynamic>? detectionParams
});




}
/// @nodoc
class _$ServerConfigCopyWithImpl<$Res>
    implements $ServerConfigCopyWith<$Res> {
  _$ServerConfigCopyWithImpl(this._self, this._then);

  final ServerConfig _self;
  final $Res Function(ServerConfig) _then;

/// Create a copy of ServerConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uploadIntervalSec = freezed,Object? detectionParams = freezed,}) {
  return _then(_self.copyWith(
uploadIntervalSec: freezed == uploadIntervalSec ? _self.uploadIntervalSec : uploadIntervalSec // ignore: cast_nullable_to_non_nullable
as int?,detectionParams: freezed == detectionParams ? _self.detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerConfig].
extension ServerConfigPatterns on ServerConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerConfig value)  $default,){
final _that = this;
switch (_that) {
case _ServerConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ServerConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? uploadIntervalSec,  Map<String, dynamic>? detectionParams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerConfig() when $default != null:
return $default(_that.uploadIntervalSec,_that.detectionParams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? uploadIntervalSec,  Map<String, dynamic>? detectionParams)  $default,) {final _that = this;
switch (_that) {
case _ServerConfig():
return $default(_that.uploadIntervalSec,_that.detectionParams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? uploadIntervalSec,  Map<String, dynamic>? detectionParams)?  $default,) {final _that = this;
switch (_that) {
case _ServerConfig() when $default != null:
return $default(_that.uploadIntervalSec,_that.detectionParams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerConfig implements ServerConfig {
  const _ServerConfig({this.uploadIntervalSec, final  Map<String, dynamic>? detectionParams}): _detectionParams = detectionParams;
  factory _ServerConfig.fromJson(Map<String, dynamic> json) => _$ServerConfigFromJson(json);

@override final  int? uploadIntervalSec;
 final  Map<String, dynamic>? _detectionParams;
@override Map<String, dynamic>? get detectionParams {
  final value = _detectionParams;
  if (value == null) return null;
  if (_detectionParams is EqualUnmodifiableMapView) return _detectionParams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ServerConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerConfigCopyWith<_ServerConfig> get copyWith => __$ServerConfigCopyWithImpl<_ServerConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerConfig&&(identical(other.uploadIntervalSec, uploadIntervalSec) || other.uploadIntervalSec == uploadIntervalSec)&&const DeepCollectionEquality().equals(other._detectionParams, _detectionParams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uploadIntervalSec,const DeepCollectionEquality().hash(_detectionParams));

@override
String toString() {
  return 'ServerConfig(uploadIntervalSec: $uploadIntervalSec, detectionParams: $detectionParams)';
}


}

/// @nodoc
abstract mixin class _$ServerConfigCopyWith<$Res> implements $ServerConfigCopyWith<$Res> {
  factory _$ServerConfigCopyWith(_ServerConfig value, $Res Function(_ServerConfig) _then) = __$ServerConfigCopyWithImpl;
@override @useResult
$Res call({
 int? uploadIntervalSec, Map<String, dynamic>? detectionParams
});




}
/// @nodoc
class __$ServerConfigCopyWithImpl<$Res>
    implements _$ServerConfigCopyWith<$Res> {
  __$ServerConfigCopyWithImpl(this._self, this._then);

  final _ServerConfig _self;
  final $Res Function(_ServerConfig) _then;

/// Create a copy of ServerConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uploadIntervalSec = freezed,Object? detectionParams = freezed,}) {
  return _then(_ServerConfig(
uploadIntervalSec: freezed == uploadIntervalSec ? _self.uploadIntervalSec : uploadIntervalSec // ignore: cast_nullable_to_non_nullable
as int?,detectionParams: freezed == detectionParams ? _self._detectionParams : detectionParams // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
