// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_lifecycle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SystemLifecycle {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemLifecycle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemLifecycle()';
}


}

/// @nodoc
class $SystemLifecycleCopyWith<$Res>  {
$SystemLifecycleCopyWith(SystemLifecycle _, $Res Function(SystemLifecycle) __);
}


/// Adds pattern-matching-related methods to [SystemLifecycle].
extension SystemLifecyclePatterns on SystemLifecycle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Booting value)?  booting,TResult Function( CheckingHardware value)?  checkingHardware,TResult Function( LiveStreamOnly value)?  liveStreamOnly,TResult Function( SystemReady value)?  systemReady,TResult Function( SystemError value)?  systemError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting(_that);case CheckingHardware() when checkingHardware != null:
return checkingHardware(_that);case LiveStreamOnly() when liveStreamOnly != null:
return liveStreamOnly(_that);case SystemReady() when systemReady != null:
return systemReady(_that);case SystemError() when systemError != null:
return systemError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Booting value)  booting,required TResult Function( CheckingHardware value)  checkingHardware,required TResult Function( LiveStreamOnly value)  liveStreamOnly,required TResult Function( SystemReady value)  systemReady,required TResult Function( SystemError value)  systemError,}){
final _that = this;
switch (_that) {
case Booting():
return booting(_that);case CheckingHardware():
return checkingHardware(_that);case LiveStreamOnly():
return liveStreamOnly(_that);case SystemReady():
return systemReady(_that);case SystemError():
return systemError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Booting value)?  booting,TResult? Function( CheckingHardware value)?  checkingHardware,TResult? Function( LiveStreamOnly value)?  liveStreamOnly,TResult? Function( SystemReady value)?  systemReady,TResult? Function( SystemError value)?  systemError,}){
final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting(_that);case CheckingHardware() when checkingHardware != null:
return checkingHardware(_that);case LiveStreamOnly() when liveStreamOnly != null:
return liveStreamOnly(_that);case SystemReady() when systemReady != null:
return systemReady(_that);case SystemError() when systemError != null:
return systemError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  booting,TResult Function()?  checkingHardware,TResult Function()?  liveStreamOnly,TResult Function()?  systemReady,TResult Function( String message)?  systemError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting();case CheckingHardware() when checkingHardware != null:
return checkingHardware();case LiveStreamOnly() when liveStreamOnly != null:
return liveStreamOnly();case SystemReady() when systemReady != null:
return systemReady();case SystemError() when systemError != null:
return systemError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  booting,required TResult Function()  checkingHardware,required TResult Function()  liveStreamOnly,required TResult Function()  systemReady,required TResult Function( String message)  systemError,}) {final _that = this;
switch (_that) {
case Booting():
return booting();case CheckingHardware():
return checkingHardware();case LiveStreamOnly():
return liveStreamOnly();case SystemReady():
return systemReady();case SystemError():
return systemError(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  booting,TResult? Function()?  checkingHardware,TResult? Function()?  liveStreamOnly,TResult? Function()?  systemReady,TResult? Function( String message)?  systemError,}) {final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting();case CheckingHardware() when checkingHardware != null:
return checkingHardware();case LiveStreamOnly() when liveStreamOnly != null:
return liveStreamOnly();case SystemReady() when systemReady != null:
return systemReady();case SystemError() when systemError != null:
return systemError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Booting implements SystemLifecycle {
  const Booting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemLifecycle.booting()';
}


}




/// @nodoc


class CheckingHardware implements SystemLifecycle {
  const CheckingHardware();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckingHardware);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemLifecycle.checkingHardware()';
}


}




/// @nodoc


class LiveStreamOnly implements SystemLifecycle {
  const LiveStreamOnly();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveStreamOnly);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemLifecycle.liveStreamOnly()';
}


}




/// @nodoc


class SystemReady implements SystemLifecycle {
  const SystemReady();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemReady);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemLifecycle.systemReady()';
}


}




/// @nodoc


class SystemError implements SystemLifecycle {
  const SystemError(this.message);
  

 final  String message;

/// Create a copy of SystemLifecycle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemErrorCopyWith<SystemError> get copyWith => _$SystemErrorCopyWithImpl<SystemError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SystemLifecycle.systemError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SystemErrorCopyWith<$Res> implements $SystemLifecycleCopyWith<$Res> {
  factory $SystemErrorCopyWith(SystemError value, $Res Function(SystemError) _then) = _$SystemErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SystemErrorCopyWithImpl<$Res>
    implements $SystemErrorCopyWith<$Res> {
  _$SystemErrorCopyWithImpl(this._self, this._then);

  final SystemError _self;
  final $Res Function(SystemError) _then;

/// Create a copy of SystemLifecycle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SystemError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
