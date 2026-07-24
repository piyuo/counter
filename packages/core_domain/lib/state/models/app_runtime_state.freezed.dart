// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_runtime_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppRuntimeState {

 bool get developMode; bool get isVisionRunning; String get bearerToken;
/// Create a copy of AppRuntimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppRuntimeStateCopyWith<AppRuntimeState> get copyWith => _$AppRuntimeStateCopyWithImpl<AppRuntimeState>(this as AppRuntimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRuntimeState&&(identical(other.developMode, developMode) || other.developMode == developMode)&&(identical(other.isVisionRunning, isVisionRunning) || other.isVisionRunning == isVisionRunning)&&(identical(other.bearerToken, bearerToken) || other.bearerToken == bearerToken));
}


@override
int get hashCode => Object.hash(runtimeType,developMode,isVisionRunning,bearerToken);

@override
String toString() {
  return 'AppRuntimeState(developMode: $developMode, isVisionRunning: $isVisionRunning, bearerToken: $bearerToken)';
}


}

/// @nodoc
abstract mixin class $AppRuntimeStateCopyWith<$Res>  {
  factory $AppRuntimeStateCopyWith(AppRuntimeState value, $Res Function(AppRuntimeState) _then) = _$AppRuntimeStateCopyWithImpl;
@useResult
$Res call({
 bool developMode, bool isVisionRunning, String bearerToken
});




}
/// @nodoc
class _$AppRuntimeStateCopyWithImpl<$Res>
    implements $AppRuntimeStateCopyWith<$Res> {
  _$AppRuntimeStateCopyWithImpl(this._self, this._then);

  final AppRuntimeState _self;
  final $Res Function(AppRuntimeState) _then;

/// Create a copy of AppRuntimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? developMode = null,Object? isVisionRunning = null,Object? bearerToken = null,}) {
  return _then(_self.copyWith(
developMode: null == developMode ? _self.developMode : developMode // ignore: cast_nullable_to_non_nullable
as bool,isVisionRunning: null == isVisionRunning ? _self.isVisionRunning : isVisionRunning // ignore: cast_nullable_to_non_nullable
as bool,bearerToken: null == bearerToken ? _self.bearerToken : bearerToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppRuntimeState].
extension AppRuntimeStatePatterns on AppRuntimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppRuntimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppRuntimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppRuntimeState value)  $default,){
final _that = this;
switch (_that) {
case _AppRuntimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppRuntimeState value)?  $default,){
final _that = this;
switch (_that) {
case _AppRuntimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool developMode,  bool isVisionRunning,  String bearerToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppRuntimeState() when $default != null:
return $default(_that.developMode,_that.isVisionRunning,_that.bearerToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool developMode,  bool isVisionRunning,  String bearerToken)  $default,) {final _that = this;
switch (_that) {
case _AppRuntimeState():
return $default(_that.developMode,_that.isVisionRunning,_that.bearerToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool developMode,  bool isVisionRunning,  String bearerToken)?  $default,) {final _that = this;
switch (_that) {
case _AppRuntimeState() when $default != null:
return $default(_that.developMode,_that.isVisionRunning,_that.bearerToken);case _:
  return null;

}
}

}

/// @nodoc


class _AppRuntimeState implements AppRuntimeState {
  const _AppRuntimeState({this.developMode = false, this.isVisionRunning = false, this.bearerToken = ''});
  

@override@JsonKey() final  bool developMode;
@override@JsonKey() final  bool isVisionRunning;
@override@JsonKey() final  String bearerToken;

/// Create a copy of AppRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppRuntimeStateCopyWith<_AppRuntimeState> get copyWith => __$AppRuntimeStateCopyWithImpl<_AppRuntimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppRuntimeState&&(identical(other.developMode, developMode) || other.developMode == developMode)&&(identical(other.isVisionRunning, isVisionRunning) || other.isVisionRunning == isVisionRunning)&&(identical(other.bearerToken, bearerToken) || other.bearerToken == bearerToken));
}


@override
int get hashCode => Object.hash(runtimeType,developMode,isVisionRunning,bearerToken);

@override
String toString() {
  return 'AppRuntimeState(developMode: $developMode, isVisionRunning: $isVisionRunning, bearerToken: $bearerToken)';
}


}

/// @nodoc
abstract mixin class _$AppRuntimeStateCopyWith<$Res> implements $AppRuntimeStateCopyWith<$Res> {
  factory _$AppRuntimeStateCopyWith(_AppRuntimeState value, $Res Function(_AppRuntimeState) _then) = __$AppRuntimeStateCopyWithImpl;
@override @useResult
$Res call({
 bool developMode, bool isVisionRunning, String bearerToken
});




}
/// @nodoc
class __$AppRuntimeStateCopyWithImpl<$Res>
    implements _$AppRuntimeStateCopyWith<$Res> {
  __$AppRuntimeStateCopyWithImpl(this._self, this._then);

  final _AppRuntimeState _self;
  final $Res Function(_AppRuntimeState) _then;

/// Create a copy of AppRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? developMode = null,Object? isVisionRunning = null,Object? bearerToken = null,}) {
  return _then(_AppRuntimeState(
developMode: null == developMode ? _self.developMode : developMode // ignore: cast_nullable_to_non_nullable
as bool,isVisionRunning: null == isVisionRunning ? _self.isVisionRunning : isVisionRunning // ignore: cast_nullable_to_non_nullable
as bool,bearerToken: null == bearerToken ? _self.bearerToken : bearerToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
