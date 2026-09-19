// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interest_area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterestArea {

 int get id; String get name; int get savedColor; List<PointData> get points; bool get enabled;
/// Create a copy of InterestArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterestAreaCopyWith<InterestArea> get copyWith => _$InterestAreaCopyWithImpl<InterestArea>(this as InterestArea, _$identity);

  /// Serializes this InterestArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InterestArea;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterestArea&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.savedColor, _this.savedColor) || other.savedColor == _this.savedColor)&&const DeepCollectionEquality().equals(other.points, _this.points)&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InterestArea;
  return Object.hash(runtimeType,_this.id,_this.name,_this.savedColor,const DeepCollectionEquality().hash(_this.points),_this.enabled);
}

@override
String toString() {
  final _this = this as InterestArea;
  return 'InterestArea(id: ${_this.id}, name: ${_this.name}, savedColor: ${_this.savedColor}, points: ${_this.points}, enabled: ${_this.enabled})';
}


}

/// @nodoc
abstract mixin class $InterestAreaCopyWith<$Res>  {
  factory $InterestAreaCopyWith(InterestArea value, $Res Function(InterestArea) _then) = _$InterestAreaCopyWithImpl;
@useResult
$Res call({
 int id, String name, int savedColor, List<PointData> points, bool enabled
});




}
/// @nodoc
class _$InterestAreaCopyWithImpl<$Res>
    implements $InterestAreaCopyWith<$Res> {
  _$InterestAreaCopyWithImpl(this._self, this._then);

  final InterestArea _self;
  final $Res Function(InterestArea) _then;

/// Create a copy of InterestArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? savedColor = null,Object? points = null,Object? enabled = null,}) {
  return _then(InterestArea(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,savedColor: null == savedColor ? _self.savedColor : savedColor // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<PointData>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InterestArea].
extension InterestAreaPatterns on InterestArea {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterestArea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterestArea() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterestArea value)  $default,){
final _that = this;
switch (_that) {
case _InterestArea():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterestArea value)?  $default,){
final _that = this;
switch (_that) {
case _InterestArea() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int savedColor,  List<PointData> points,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterestArea() when $default != null:
return $default(_that.id,_that.name,_that.savedColor,_that.points,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int savedColor,  List<PointData> points,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _InterestArea():
return $default(_that.id,_that.name,_that.savedColor,_that.points,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int savedColor,  List<PointData> points,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _InterestArea() when $default != null:
return $default(_that.id,_that.name,_that.savedColor,_that.points,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterestArea extends InterestArea {
  const _InterestArea({required this.id, this.name = '', this.savedColor = 0x00000000,  List<PointData> points = const [], this.enabled = true}): _points = points,super._();
  factory _InterestArea.fromJson(Map<String, dynamic> json) => _$InterestAreaFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  int savedColor;
 final  List<PointData> _points;
@override@JsonKey() List<PointData> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@override@JsonKey() final  bool enabled;

/// Create a copy of InterestArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterestAreaCopyWith<_InterestArea> get copyWith => __$InterestAreaCopyWithImpl<_InterestArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterestAreaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterestArea&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.savedColor, savedColor) || other.savedColor == savedColor)&&const DeepCollectionEquality().equals(other.points, _points)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,savedColor,const DeepCollectionEquality().hash(_points),enabled);
}

@override
String toString() {
    return 'InterestArea(id: $id, name: $name, savedColor: $savedColor, points: $points, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$InterestAreaCopyWith<$Res> implements $InterestAreaCopyWith<$Res> {
  factory _$InterestAreaCopyWith(_InterestArea value, $Res Function(_InterestArea) _then) = __$InterestAreaCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int savedColor, List<PointData> points, bool enabled
});




}
/// @nodoc
class __$InterestAreaCopyWithImpl<$Res>
    implements _$InterestAreaCopyWith<$Res> {
  __$InterestAreaCopyWithImpl(this._self, this._then);

  final _InterestArea _self;
  final $Res Function(_InterestArea) _then;

/// Create a copy of InterestArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? savedColor = null,Object? points = null,Object? enabled = null,}) {
  return _then(_InterestArea(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,savedColor: null == savedColor ? _self.savedColor : savedColor // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PointData>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
