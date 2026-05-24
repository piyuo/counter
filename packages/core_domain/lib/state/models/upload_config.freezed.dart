// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadConfig {

/// Upload cadence in minutes, aligned to local wall-clock boundaries.
///
/// Examples:
/// - 60: 01:00, 02:00, 03:00...
/// - 5: 01:00, 01:05, 01:10...
@JsonKey(name: 'intervalMin') int get wallClockCadenceMin;
/// Create a copy of UploadConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<UploadConfig> get copyWith => _$UploadConfigCopyWithImpl<UploadConfig>(this as UploadConfig, _$identity);

  /// Serializes this UploadConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadConfig&&(identical(other.wallClockCadenceMin, wallClockCadenceMin) || other.wallClockCadenceMin == wallClockCadenceMin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallClockCadenceMin);

@override
String toString() {
  return 'UploadConfig(wallClockCadenceMin: $wallClockCadenceMin)';
}


}

/// @nodoc
abstract mixin class $UploadConfigCopyWith<$Res>  {
  factory $UploadConfigCopyWith(UploadConfig value, $Res Function(UploadConfig) _then) = _$UploadConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'intervalMin') int wallClockCadenceMin
});




}
/// @nodoc
class _$UploadConfigCopyWithImpl<$Res>
    implements $UploadConfigCopyWith<$Res> {
  _$UploadConfigCopyWithImpl(this._self, this._then);

  final UploadConfig _self;
  final $Res Function(UploadConfig) _then;

/// Create a copy of UploadConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wallClockCadenceMin = null,}) {
  return _then(_self.copyWith(
wallClockCadenceMin: null == wallClockCadenceMin ? _self.wallClockCadenceMin : wallClockCadenceMin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadConfig].
extension UploadConfigPatterns on UploadConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadConfig value)  $default,){
final _that = this;
switch (_that) {
case _UploadConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadConfig value)?  $default,){
final _that = this;
switch (_that) {
case _UploadConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'intervalMin')  int wallClockCadenceMin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadConfig() when $default != null:
return $default(_that.wallClockCadenceMin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'intervalMin')  int wallClockCadenceMin)  $default,) {final _that = this;
switch (_that) {
case _UploadConfig():
return $default(_that.wallClockCadenceMin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'intervalMin')  int wallClockCadenceMin)?  $default,) {final _that = this;
switch (_that) {
case _UploadConfig() when $default != null:
return $default(_that.wallClockCadenceMin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadConfig extends UploadConfig {
  const _UploadConfig({@JsonKey(name: 'intervalMin') this.wallClockCadenceMin = 60}): super._();
  factory _UploadConfig.fromJson(Map<String, dynamic> json) => _$UploadConfigFromJson(json);

/// Upload cadence in minutes, aligned to local wall-clock boundaries.
///
/// Examples:
/// - 60: 01:00, 02:00, 03:00...
/// - 5: 01:00, 01:05, 01:10...
@override@JsonKey(name: 'intervalMin') final  int wallClockCadenceMin;

/// Create a copy of UploadConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadConfigCopyWith<_UploadConfig> get copyWith => __$UploadConfigCopyWithImpl<_UploadConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadConfig&&(identical(other.wallClockCadenceMin, wallClockCadenceMin) || other.wallClockCadenceMin == wallClockCadenceMin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallClockCadenceMin);

@override
String toString() {
  return 'UploadConfig(wallClockCadenceMin: $wallClockCadenceMin)';
}


}

/// @nodoc
abstract mixin class _$UploadConfigCopyWith<$Res> implements $UploadConfigCopyWith<$Res> {
  factory _$UploadConfigCopyWith(_UploadConfig value, $Res Function(_UploadConfig) _then) = __$UploadConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'intervalMin') int wallClockCadenceMin
});




}
/// @nodoc
class __$UploadConfigCopyWithImpl<$Res>
    implements _$UploadConfigCopyWith<$Res> {
  __$UploadConfigCopyWithImpl(this._self, this._then);

  final _UploadConfig _self;
  final $Res Function(_UploadConfig) _then;

/// Create a copy of UploadConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wallClockCadenceMin = null,}) {
  return _then(_UploadConfig(
wallClockCadenceMin: null == wallClockCadenceMin ? _self.wallClockCadenceMin : wallClockCadenceMin // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
