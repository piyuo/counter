// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SystemEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemEvent()';
}


}

/// @nodoc
class $SystemEventCopyWith<$Res>  {
$SystemEventCopyWith(SystemEvent _, $Res Function(SystemEvent) __);
}


/// Adds pattern-matching-related methods to [SystemEvent].
extension SystemEventPatterns on SystemEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HardwareCheckInitiated value)?  hardwareCheckInitiated,TResult Function( HardwareCheckPassed value)?  hardwareCheckPassed,TResult Function( DeviceNotSupported value)?  deviceNotSupported,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated(_that);case HardwareCheckPassed() when hardwareCheckPassed != null:
return hardwareCheckPassed(_that);case DeviceNotSupported() when deviceNotSupported != null:
return deviceNotSupported(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HardwareCheckInitiated value)  hardwareCheckInitiated,required TResult Function( HardwareCheckPassed value)  hardwareCheckPassed,required TResult Function( DeviceNotSupported value)  deviceNotSupported,}){
final _that = this;
switch (_that) {
case HardwareCheckInitiated():
return hardwareCheckInitiated(_that);case HardwareCheckPassed():
return hardwareCheckPassed(_that);case DeviceNotSupported():
return deviceNotSupported(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HardwareCheckInitiated value)?  hardwareCheckInitiated,TResult? Function( HardwareCheckPassed value)?  hardwareCheckPassed,TResult? Function( DeviceNotSupported value)?  deviceNotSupported,}){
final _that = this;
switch (_that) {
case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated(_that);case HardwareCheckPassed() when hardwareCheckPassed != null:
return hardwareCheckPassed(_that);case DeviceNotSupported() when deviceNotSupported != null:
return deviceNotSupported(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  hardwareCheckInitiated,TResult Function()?  hardwareCheckPassed,TResult Function()?  deviceNotSupported,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated();case HardwareCheckPassed() when hardwareCheckPassed != null:
return hardwareCheckPassed();case DeviceNotSupported() when deviceNotSupported != null:
return deviceNotSupported();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  hardwareCheckInitiated,required TResult Function()  hardwareCheckPassed,required TResult Function()  deviceNotSupported,}) {final _that = this;
switch (_that) {
case HardwareCheckInitiated():
return hardwareCheckInitiated();case HardwareCheckPassed():
return hardwareCheckPassed();case DeviceNotSupported():
return deviceNotSupported();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  hardwareCheckInitiated,TResult? Function()?  hardwareCheckPassed,TResult? Function()?  deviceNotSupported,}) {final _that = this;
switch (_that) {
case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated();case HardwareCheckPassed() when hardwareCheckPassed != null:
return hardwareCheckPassed();case DeviceNotSupported() when deviceNotSupported != null:
return deviceNotSupported();case _:
  return null;

}
}

}

/// @nodoc


class HardwareCheckInitiated implements SystemEvent {
  const HardwareCheckInitiated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HardwareCheckInitiated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemEvent.hardwareCheckInitiated()';
}


}




/// @nodoc


class HardwareCheckPassed implements SystemEvent {
  const HardwareCheckPassed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HardwareCheckPassed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemEvent.hardwareCheckPassed()';
}


}




/// @nodoc


class DeviceNotSupported implements SystemEvent {
  const DeviceNotSupported();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceNotSupported);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemEvent.deviceNotSupported()';
}


}




// dart format on
