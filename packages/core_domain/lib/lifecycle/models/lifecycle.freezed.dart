// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lifecycle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Lifecycle {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lifecycle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle()';
}


}

/// @nodoc
class $LifecycleCopyWith<$Res>  {
$LifecycleCopyWith(Lifecycle _, $Res Function(Lifecycle) __);
}


/// Adds pattern-matching-related methods to [Lifecycle].
extension LifecyclePatterns on Lifecycle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Booting value)?  booting,TResult Function( CheckingHardware value)?  checkingHardware,TResult Function( NeedsOnboarding value)?  needsOnboarding,TResult Function( NoCamera value)?  noCamera,TResult Function( Ready value)?  ready,TResult Function( Background value)?  background,TResult Function( Suspended value)?  suspended,TResult Function( Rebooting value)?  rebooting,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting(_that);case CheckingHardware() when checkingHardware != null:
return checkingHardware(_that);case NeedsOnboarding() when needsOnboarding != null:
return needsOnboarding(_that);case NoCamera() when noCamera != null:
return noCamera(_that);case Ready() when ready != null:
return ready(_that);case Background() when background != null:
return background(_that);case Suspended() when suspended != null:
return suspended(_that);case Rebooting() when rebooting != null:
return rebooting(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Booting value)  booting,required TResult Function( CheckingHardware value)  checkingHardware,required TResult Function( NeedsOnboarding value)  needsOnboarding,required TResult Function( NoCamera value)  noCamera,required TResult Function( Ready value)  ready,required TResult Function( Background value)  background,required TResult Function( Suspended value)  suspended,required TResult Function( Rebooting value)  rebooting,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Booting():
return booting(_that);case CheckingHardware():
return checkingHardware(_that);case NeedsOnboarding():
return needsOnboarding(_that);case NoCamera():
return noCamera(_that);case Ready():
return ready(_that);case Background():
return background(_that);case Suspended():
return suspended(_that);case Rebooting():
return rebooting(_that);case Error():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Booting value)?  booting,TResult? Function( CheckingHardware value)?  checkingHardware,TResult? Function( NeedsOnboarding value)?  needsOnboarding,TResult? Function( NoCamera value)?  noCamera,TResult? Function( Ready value)?  ready,TResult? Function( Background value)?  background,TResult? Function( Suspended value)?  suspended,TResult? Function( Rebooting value)?  rebooting,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting(_that);case CheckingHardware() when checkingHardware != null:
return checkingHardware(_that);case NeedsOnboarding() when needsOnboarding != null:
return needsOnboarding(_that);case NoCamera() when noCamera != null:
return noCamera(_that);case Ready() when ready != null:
return ready(_that);case Background() when background != null:
return background(_that);case Suspended() when suspended != null:
return suspended(_that);case Rebooting() when rebooting != null:
return rebooting(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  booting,TResult Function()?  checkingHardware,TResult Function()?  needsOnboarding,TResult Function()?  noCamera,TResult Function()?  ready,TResult Function()?  background,TResult Function()?  suspended,TResult Function()?  rebooting,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting();case CheckingHardware() when checkingHardware != null:
return checkingHardware();case NeedsOnboarding() when needsOnboarding != null:
return needsOnboarding();case NoCamera() when noCamera != null:
return noCamera();case Ready() when ready != null:
return ready();case Background() when background != null:
return background();case Suspended() when suspended != null:
return suspended();case Rebooting() when rebooting != null:
return rebooting();case Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  booting,required TResult Function()  checkingHardware,required TResult Function()  needsOnboarding,required TResult Function()  noCamera,required TResult Function()  ready,required TResult Function()  background,required TResult Function()  suspended,required TResult Function()  rebooting,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case Booting():
return booting();case CheckingHardware():
return checkingHardware();case NeedsOnboarding():
return needsOnboarding();case NoCamera():
return noCamera();case Ready():
return ready();case Background():
return background();case Suspended():
return suspended();case Rebooting():
return rebooting();case Error():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  booting,TResult? Function()?  checkingHardware,TResult? Function()?  needsOnboarding,TResult? Function()?  noCamera,TResult? Function()?  ready,TResult? Function()?  background,TResult? Function()?  suspended,TResult? Function()?  rebooting,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case Booting() when booting != null:
return booting();case CheckingHardware() when checkingHardware != null:
return checkingHardware();case NeedsOnboarding() when needsOnboarding != null:
return needsOnboarding();case NoCamera() when noCamera != null:
return noCamera();case Ready() when ready != null:
return ready();case Background() when background != null:
return background();case Suspended() when suspended != null:
return suspended();case Rebooting() when rebooting != null:
return rebooting();case Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Booting implements Lifecycle {
  const Booting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.booting()';
}


}




/// @nodoc


class CheckingHardware implements Lifecycle {
  const CheckingHardware();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckingHardware);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.checkingHardware()';
}


}




/// @nodoc


class NeedsOnboarding implements Lifecycle {
  const NeedsOnboarding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NeedsOnboarding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.needsOnboarding()';
}


}




/// @nodoc


class NoCamera implements Lifecycle {
  const NoCamera();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoCamera);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.noCamera()';
}


}




/// @nodoc


class Ready implements Lifecycle {
  const Ready();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ready);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.ready()';
}


}




/// @nodoc


class Background implements Lifecycle {
  const Background();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Background);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.background()';
}


}




/// @nodoc


class Suspended implements Lifecycle {
  const Suspended();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Suspended);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.suspended()';
}


}




/// @nodoc


class Rebooting implements Lifecycle {
  const Rebooting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rebooting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Lifecycle.rebooting()';
}


}




/// @nodoc


class Error implements Lifecycle {
  const Error(this.message);
  

 final  String message;

/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Lifecycle.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $LifecycleCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
