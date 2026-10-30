// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_period.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessPeriod {

 String get id; String get name;@Assert('startMinute >= 0 && startMinute < 1440') int get startMinute;@Assert('endMinute > startMinute && endMinute <= 1440') int get endMinute;
/// Create a copy of BusinessPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessPeriodCopyWith<BusinessPeriod> get copyWith => _$BusinessPeriodCopyWithImpl<BusinessPeriod>(this as BusinessPeriod, _$identity);

  /// Serializes this BusinessPeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BusinessPeriod;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessPeriod&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.startMinute, _this.startMinute) || other.startMinute == _this.startMinute)&&(identical(other.endMinute, _this.endMinute) || other.endMinute == _this.endMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BusinessPeriod;
  return Object.hash(runtimeType,_this.id,_this.name,_this.startMinute,_this.endMinute);
}

@override
String toString() {
  final _this = this as BusinessPeriod;
  return 'BusinessPeriod(id: ${_this.id}, name: ${_this.name}, startMinute: ${_this.startMinute}, endMinute: ${_this.endMinute})';
}


}

/// @nodoc
abstract mixin class $BusinessPeriodCopyWith<$Res>  {
  factory $BusinessPeriodCopyWith(BusinessPeriod value, $Res Function(BusinessPeriod) _then) = _$BusinessPeriodCopyWithImpl;
@useResult
$Res call({
 String id, String name,@Assert('startMinute >= 0 && startMinute < 1440') int startMinute,@Assert('endMinute > startMinute && endMinute <= 1440') int endMinute
});




}
/// @nodoc
class _$BusinessPeriodCopyWithImpl<$Res>
    implements $BusinessPeriodCopyWith<$Res> {
  _$BusinessPeriodCopyWithImpl(this._self, this._then);

  final BusinessPeriod _self;
  final $Res Function(BusinessPeriod) _then;

/// Create a copy of BusinessPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startMinute = null,Object? endMinute = null,}) {
  return _then(BusinessPeriod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessPeriod].
extension BusinessPeriodPatterns on BusinessPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessPeriod value)  $default,){
final _that = this;
switch (_that) {
case _BusinessPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @Assert('startMinute >= 0 && startMinute < 1440')  int startMinute, @Assert('endMinute > startMinute && endMinute <= 1440')  int endMinute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessPeriod() when $default != null:
return $default(_that.id,_that.name,_that.startMinute,_that.endMinute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @Assert('startMinute >= 0 && startMinute < 1440')  int startMinute, @Assert('endMinute > startMinute && endMinute <= 1440')  int endMinute)  $default,) {final _that = this;
switch (_that) {
case _BusinessPeriod():
return $default(_that.id,_that.name,_that.startMinute,_that.endMinute);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @Assert('startMinute >= 0 && startMinute < 1440')  int startMinute, @Assert('endMinute > startMinute && endMinute <= 1440')  int endMinute)?  $default,) {final _that = this;
switch (_that) {
case _BusinessPeriod() when $default != null:
return $default(_that.id,_that.name,_that.startMinute,_that.endMinute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessPeriod extends BusinessPeriod {
  const _BusinessPeriod({required this.id, required this.name, @Assert('startMinute >= 0 && startMinute < 1440') required this.startMinute, @Assert('endMinute > startMinute && endMinute <= 1440') required this.endMinute}): super._();
  factory _BusinessPeriod.fromJson(Map<String, dynamic> json) => _$BusinessPeriodFromJson(json);

@override final  String id;
@override final  String name;
@override@Assert('startMinute >= 0 && startMinute < 1440') final  int startMinute;
@override@Assert('endMinute > startMinute && endMinute <= 1440') final  int endMinute;

/// Create a copy of BusinessPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessPeriodCopyWith<_BusinessPeriod> get copyWith => __$BusinessPeriodCopyWithImpl<_BusinessPeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessPeriodToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,startMinute,endMinute);
}

@override
String toString() {
    return 'BusinessPeriod(id: $id, name: $name, startMinute: $startMinute, endMinute: $endMinute)';
}


}

/// @nodoc
abstract mixin class _$BusinessPeriodCopyWith<$Res> implements $BusinessPeriodCopyWith<$Res> {
  factory _$BusinessPeriodCopyWith(_BusinessPeriod value, $Res Function(_BusinessPeriod) _then) = __$BusinessPeriodCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@Assert('startMinute >= 0 && startMinute < 1440') int startMinute,@Assert('endMinute > startMinute && endMinute <= 1440') int endMinute
});




}
/// @nodoc
class __$BusinessPeriodCopyWithImpl<$Res>
    implements _$BusinessPeriodCopyWith<$Res> {
  __$BusinessPeriodCopyWithImpl(this._self, this._then);

  final _BusinessPeriod _self;
  final $Res Function(_BusinessPeriod) _then;

/// Create a copy of BusinessPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startMinute = null,Object? endMinute = null,}) {
  return _then(_BusinessPeriod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
