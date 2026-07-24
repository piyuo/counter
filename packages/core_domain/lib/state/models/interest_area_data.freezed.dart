// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interest_area_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterestAreaData {

 int get id; String get name; int get color; List<PointData> get points; bool get enabled;
/// Create a copy of InterestAreaData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterestAreaDataCopyWith<InterestAreaData> get copyWith => _$InterestAreaDataCopyWithImpl<InterestAreaData>(this as InterestAreaData, _$identity);

  /// Serializes this InterestAreaData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterestAreaData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.points, points)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,const DeepCollectionEquality().hash(points),enabled);

@override
String toString() {
  return 'InterestAreaData(id: $id, name: $name, color: $color, points: $points, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $InterestAreaDataCopyWith<$Res>  {
  factory $InterestAreaDataCopyWith(InterestAreaData value, $Res Function(InterestAreaData) _then) = _$InterestAreaDataCopyWithImpl;
@useResult
$Res call({
 int id, String name, int color, List<PointData> points, bool enabled
});




}
/// @nodoc
class _$InterestAreaDataCopyWithImpl<$Res>
    implements $InterestAreaDataCopyWith<$Res> {
  _$InterestAreaDataCopyWithImpl(this._self, this._then);

  final InterestAreaData _self;
  final $Res Function(InterestAreaData) _then;

/// Create a copy of InterestAreaData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = null,Object? points = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<PointData>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InterestAreaData].
extension InterestAreaDataPatterns on InterestAreaData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterestAreaData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterestAreaData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterestAreaData value)  $default,){
final _that = this;
switch (_that) {
case _InterestAreaData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterestAreaData value)?  $default,){
final _that = this;
switch (_that) {
case _InterestAreaData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int color,  List<PointData> points,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterestAreaData() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.points,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int color,  List<PointData> points,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _InterestAreaData():
return $default(_that.id,_that.name,_that.color,_that.points,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int color,  List<PointData> points,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _InterestAreaData() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.points,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterestAreaData extends InterestAreaData {
  const _InterestAreaData({required this.id, this.name = '', this.color = 0x00000000, final  List<PointData> points = const [], this.enabled = true}): _points = points,super._();
  factory _InterestAreaData.fromJson(Map<String, dynamic> json) => _$InterestAreaDataFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  int color;
 final  List<PointData> _points;
@override@JsonKey() List<PointData> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override@JsonKey() final  bool enabled;

/// Create a copy of InterestAreaData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterestAreaDataCopyWith<_InterestAreaData> get copyWith => __$InterestAreaDataCopyWithImpl<_InterestAreaData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterestAreaDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterestAreaData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._points, _points)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,const DeepCollectionEquality().hash(_points),enabled);

@override
String toString() {
  return 'InterestAreaData(id: $id, name: $name, color: $color, points: $points, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$InterestAreaDataCopyWith<$Res> implements $InterestAreaDataCopyWith<$Res> {
  factory _$InterestAreaDataCopyWith(_InterestAreaData value, $Res Function(_InterestAreaData) _then) = __$InterestAreaDataCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int color, List<PointData> points, bool enabled
});




}
/// @nodoc
class __$InterestAreaDataCopyWithImpl<$Res>
    implements _$InterestAreaDataCopyWith<$Res> {
  __$InterestAreaDataCopyWithImpl(this._self, this._then);

  final _InterestAreaData _self;
  final $Res Function(_InterestAreaData) _then;

/// Create a copy of InterestAreaData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = null,Object? points = null,Object? enabled = null,}) {
  return _then(_InterestAreaData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PointData>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
