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
@JsonKey(name: 'intervalMin') int get wallClockCadenceMin;/// Maximum records bundled into a single upload request.
/// 1008 ≈ 3.5 days per batch — since we only keep 7 days of data, so two batches would cover the retention period.
 int get maxBatchSize;/// Prune queued payloads older than this many days.
 int get payloadRetentionDays;/// Prune upload-attempt logs older than this many days.
@JsonKey(name: 'deliveryLogRetentionDays') int get uploadLogRetentionDays;/// HTTP connection + response timeout per upload request, in seconds.
 int get timeoutSec;
/// Create a copy of UploadConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadConfigCopyWith<UploadConfig> get copyWith => _$UploadConfigCopyWithImpl<UploadConfig>(this as UploadConfig, _$identity);

  /// Serializes this UploadConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadConfig&&(identical(other.wallClockCadenceMin, wallClockCadenceMin) || other.wallClockCadenceMin == wallClockCadenceMin)&&(identical(other.maxBatchSize, maxBatchSize) || other.maxBatchSize == maxBatchSize)&&(identical(other.payloadRetentionDays, payloadRetentionDays) || other.payloadRetentionDays == payloadRetentionDays)&&(identical(other.uploadLogRetentionDays, uploadLogRetentionDays) || other.uploadLogRetentionDays == uploadLogRetentionDays)&&(identical(other.timeoutSec, timeoutSec) || other.timeoutSec == timeoutSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallClockCadenceMin,maxBatchSize,payloadRetentionDays,uploadLogRetentionDays,timeoutSec);

@override
String toString() {
  return 'UploadConfig(wallClockCadenceMin: $wallClockCadenceMin, maxBatchSize: $maxBatchSize, payloadRetentionDays: $payloadRetentionDays, uploadLogRetentionDays: $uploadLogRetentionDays, timeoutSec: $timeoutSec)';
}


}

/// @nodoc
abstract mixin class $UploadConfigCopyWith<$Res>  {
  factory $UploadConfigCopyWith(UploadConfig value, $Res Function(UploadConfig) _then) = _$UploadConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'intervalMin') int wallClockCadenceMin, int maxBatchSize, int payloadRetentionDays,@JsonKey(name: 'deliveryLogRetentionDays') int uploadLogRetentionDays, int timeoutSec
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
@pragma('vm:prefer-inline') @override $Res call({Object? wallClockCadenceMin = null,Object? maxBatchSize = null,Object? payloadRetentionDays = null,Object? uploadLogRetentionDays = null,Object? timeoutSec = null,}) {
  return _then(_self.copyWith(
wallClockCadenceMin: null == wallClockCadenceMin ? _self.wallClockCadenceMin : wallClockCadenceMin // ignore: cast_nullable_to_non_nullable
as int,maxBatchSize: null == maxBatchSize ? _self.maxBatchSize : maxBatchSize // ignore: cast_nullable_to_non_nullable
as int,payloadRetentionDays: null == payloadRetentionDays ? _self.payloadRetentionDays : payloadRetentionDays // ignore: cast_nullable_to_non_nullable
as int,uploadLogRetentionDays: null == uploadLogRetentionDays ? _self.uploadLogRetentionDays : uploadLogRetentionDays // ignore: cast_nullable_to_non_nullable
as int,timeoutSec: null == timeoutSec ? _self.timeoutSec : timeoutSec // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'intervalMin')  int wallClockCadenceMin,  int maxBatchSize,  int payloadRetentionDays, @JsonKey(name: 'deliveryLogRetentionDays')  int uploadLogRetentionDays,  int timeoutSec)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadConfig() when $default != null:
return $default(_that.wallClockCadenceMin,_that.maxBatchSize,_that.payloadRetentionDays,_that.uploadLogRetentionDays,_that.timeoutSec);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'intervalMin')  int wallClockCadenceMin,  int maxBatchSize,  int payloadRetentionDays, @JsonKey(name: 'deliveryLogRetentionDays')  int uploadLogRetentionDays,  int timeoutSec)  $default,) {final _that = this;
switch (_that) {
case _UploadConfig():
return $default(_that.wallClockCadenceMin,_that.maxBatchSize,_that.payloadRetentionDays,_that.uploadLogRetentionDays,_that.timeoutSec);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'intervalMin')  int wallClockCadenceMin,  int maxBatchSize,  int payloadRetentionDays, @JsonKey(name: 'deliveryLogRetentionDays')  int uploadLogRetentionDays,  int timeoutSec)?  $default,) {final _that = this;
switch (_that) {
case _UploadConfig() when $default != null:
return $default(_that.wallClockCadenceMin,_that.maxBatchSize,_that.payloadRetentionDays,_that.uploadLogRetentionDays,_that.timeoutSec);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadConfig extends UploadConfig {
  const _UploadConfig({@JsonKey(name: 'intervalMin') this.wallClockCadenceMin = 60, this.maxBatchSize = 1008, this.payloadRetentionDays = 7, @JsonKey(name: 'deliveryLogRetentionDays') this.uploadLogRetentionDays = 7, this.timeoutSec = 30}): super._();
  factory _UploadConfig.fromJson(Map<String, dynamic> json) => _$UploadConfigFromJson(json);

/// Upload cadence in minutes, aligned to local wall-clock boundaries.
///
/// Examples:
/// - 60: 01:00, 02:00, 03:00...
/// - 5: 01:00, 01:05, 01:10...
@override@JsonKey(name: 'intervalMin') final  int wallClockCadenceMin;
/// Maximum records bundled into a single upload request.
/// 1008 ≈ 3.5 days per batch — since we only keep 7 days of data, so two batches would cover the retention period.
@override@JsonKey() final  int maxBatchSize;
/// Prune queued payloads older than this many days.
@override@JsonKey() final  int payloadRetentionDays;
/// Prune upload-attempt logs older than this many days.
@override@JsonKey(name: 'deliveryLogRetentionDays') final  int uploadLogRetentionDays;
/// HTTP connection + response timeout per upload request, in seconds.
@override@JsonKey() final  int timeoutSec;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadConfig&&(identical(other.wallClockCadenceMin, wallClockCadenceMin) || other.wallClockCadenceMin == wallClockCadenceMin)&&(identical(other.maxBatchSize, maxBatchSize) || other.maxBatchSize == maxBatchSize)&&(identical(other.payloadRetentionDays, payloadRetentionDays) || other.payloadRetentionDays == payloadRetentionDays)&&(identical(other.uploadLogRetentionDays, uploadLogRetentionDays) || other.uploadLogRetentionDays == uploadLogRetentionDays)&&(identical(other.timeoutSec, timeoutSec) || other.timeoutSec == timeoutSec));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wallClockCadenceMin,maxBatchSize,payloadRetentionDays,uploadLogRetentionDays,timeoutSec);

@override
String toString() {
  return 'UploadConfig(wallClockCadenceMin: $wallClockCadenceMin, maxBatchSize: $maxBatchSize, payloadRetentionDays: $payloadRetentionDays, uploadLogRetentionDays: $uploadLogRetentionDays, timeoutSec: $timeoutSec)';
}


}

/// @nodoc
abstract mixin class _$UploadConfigCopyWith<$Res> implements $UploadConfigCopyWith<$Res> {
  factory _$UploadConfigCopyWith(_UploadConfig value, $Res Function(_UploadConfig) _then) = __$UploadConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'intervalMin') int wallClockCadenceMin, int maxBatchSize, int payloadRetentionDays,@JsonKey(name: 'deliveryLogRetentionDays') int uploadLogRetentionDays, int timeoutSec
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
@override @pragma('vm:prefer-inline') $Res call({Object? wallClockCadenceMin = null,Object? maxBatchSize = null,Object? payloadRetentionDays = null,Object? uploadLogRetentionDays = null,Object? timeoutSec = null,}) {
  return _then(_UploadConfig(
wallClockCadenceMin: null == wallClockCadenceMin ? _self.wallClockCadenceMin : wallClockCadenceMin // ignore: cast_nullable_to_non_nullable
as int,maxBatchSize: null == maxBatchSize ? _self.maxBatchSize : maxBatchSize // ignore: cast_nullable_to_non_nullable
as int,payloadRetentionDays: null == payloadRetentionDays ? _self.payloadRetentionDays : payloadRetentionDays // ignore: cast_nullable_to_non_nullable
as int,uploadLogRetentionDays: null == uploadLogRetentionDays ? _self.uploadLogRetentionDays : uploadLogRetentionDays // ignore: cast_nullable_to_non_nullable
as int,timeoutSec: null == timeoutSec ? _self.timeoutSec : timeoutSec // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
