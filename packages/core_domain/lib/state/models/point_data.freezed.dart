// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PointData {

 double get dx; double get dy;
/// Create a copy of PointData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointDataCopyWith<PointData> get copyWith => _$PointDataCopyWithImpl<PointData>(this as PointData, _$identity);

  /// Serializes this PointData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointData&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dx,dy);

@override
String toString() {
  return 'PointData(dx: $dx, dy: $dy)';
}


}

/// @nodoc
abstract mixin class $PointDataCopyWith<$Res>  {
  factory $PointDataCopyWith(PointData value, $Res Function(PointData) _then) = _$PointDataCopyWithImpl;
@useResult
$Res call({
 double dx, double dy
});




}
/// @nodoc
class _$PointDataCopyWithImpl<$Res>
    implements $PointDataCopyWith<$Res> {
  _$PointDataCopyWithImpl(this._self, this._then);

  final PointData _self;
  final $Res Function(PointData) _then;

/// Create a copy of PointData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dx = null,Object? dy = null,}) {
  return _then(_self.copyWith(
dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PointData].
extension PointDataPatterns on PointData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointData value)  $default,){
final _that = this;
switch (_that) {
case _PointData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointData value)?  $default,){
final _that = this;
switch (_that) {
case _PointData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double dx,  double dy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointData() when $default != null:
return $default(_that.dx,_that.dy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double dx,  double dy)  $default,) {final _that = this;
switch (_that) {
case _PointData():
return $default(_that.dx,_that.dy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double dx,  double dy)?  $default,) {final _that = this;
switch (_that) {
case _PointData() when $default != null:
return $default(_that.dx,_that.dy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointData extends PointData {
  const _PointData({this.dx = 0.0, this.dy = 0.0}): super._();
  factory _PointData.fromJson(Map<String, dynamic> json) => _$PointDataFromJson(json);

@override@JsonKey() final  double dx;
@override@JsonKey() final  double dy;

/// Create a copy of PointData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointDataCopyWith<_PointData> get copyWith => __$PointDataCopyWithImpl<_PointData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointData&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dx,dy);

@override
String toString() {
  return 'PointData(dx: $dx, dy: $dy)';
}


}

/// @nodoc
abstract mixin class _$PointDataCopyWith<$Res> implements $PointDataCopyWith<$Res> {
  factory _$PointDataCopyWith(_PointData value, $Res Function(_PointData) _then) = __$PointDataCopyWithImpl;
@override @useResult
$Res call({
 double dx, double dy
});




}
/// @nodoc
class __$PointDataCopyWithImpl<$Res>
    implements _$PointDataCopyWith<$Res> {
  __$PointDataCopyWithImpl(this._self, this._then);

  final _PointData _self;
  final $Res Function(_PointData) _then;

/// Create a copy of PointData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dx = null,Object? dy = null,}) {
  return _then(_PointData(
dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
