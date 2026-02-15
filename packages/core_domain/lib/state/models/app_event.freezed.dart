// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent()';
}


}

/// @nodoc
class $AppEventCopyWith<$Res>  {
$AppEventCopyWith(AppEvent _, $Res Function(AppEvent) __);
}


/// Adds pattern-matching-related methods to [AppEvent].
extension AppEventPatterns on AppEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppStarted value)?  appStarted,TResult Function( HardwareCheckInitiated value)?  hardwareCheckInitiated,TResult Function( CameraUnavailable value)?  cameraUnavailable,TResult Function( BackendCheckFailed value)?  backendCheckFailed,TResult Function( OnboardingCompleted value)?  onboardingCompleted,TResult Function( AppBackgrounded value)?  appBackgrounded,TResult Function( AppForegrounded value)?  appForegrounded,TResult Function( AppRebootRequested value)?  appRebootRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppStarted() when appStarted != null:
return appStarted(_that);case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated(_that);case CameraUnavailable() when cameraUnavailable != null:
return cameraUnavailable(_that);case BackendCheckFailed() when backendCheckFailed != null:
return backendCheckFailed(_that);case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case AppRebootRequested() when appRebootRequested != null:
return appRebootRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppStarted value)  appStarted,required TResult Function( HardwareCheckInitiated value)  hardwareCheckInitiated,required TResult Function( CameraUnavailable value)  cameraUnavailable,required TResult Function( BackendCheckFailed value)  backendCheckFailed,required TResult Function( OnboardingCompleted value)  onboardingCompleted,required TResult Function( AppBackgrounded value)  appBackgrounded,required TResult Function( AppForegrounded value)  appForegrounded,required TResult Function( AppRebootRequested value)  appRebootRequested,}){
final _that = this;
switch (_that) {
case AppStarted():
return appStarted(_that);case HardwareCheckInitiated():
return hardwareCheckInitiated(_that);case CameraUnavailable():
return cameraUnavailable(_that);case BackendCheckFailed():
return backendCheckFailed(_that);case OnboardingCompleted():
return onboardingCompleted(_that);case AppBackgrounded():
return appBackgrounded(_that);case AppForegrounded():
return appForegrounded(_that);case AppRebootRequested():
return appRebootRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppStarted value)?  appStarted,TResult? Function( HardwareCheckInitiated value)?  hardwareCheckInitiated,TResult? Function( CameraUnavailable value)?  cameraUnavailable,TResult? Function( BackendCheckFailed value)?  backendCheckFailed,TResult? Function( OnboardingCompleted value)?  onboardingCompleted,TResult? Function( AppBackgrounded value)?  appBackgrounded,TResult? Function( AppForegrounded value)?  appForegrounded,TResult? Function( AppRebootRequested value)?  appRebootRequested,}){
final _that = this;
switch (_that) {
case AppStarted() when appStarted != null:
return appStarted(_that);case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated(_that);case CameraUnavailable() when cameraUnavailable != null:
return cameraUnavailable(_that);case BackendCheckFailed() when backendCheckFailed != null:
return backendCheckFailed(_that);case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted(_that);case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded(_that);case AppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case AppRebootRequested() when appRebootRequested != null:
return appRebootRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  appStarted,TResult Function()?  hardwareCheckInitiated,TResult Function()?  cameraUnavailable,TResult Function()?  backendCheckFailed,TResult Function()?  onboardingCompleted,TResult Function()?  appBackgrounded,TResult Function()?  appForegrounded,TResult Function()?  appRebootRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppStarted() when appStarted != null:
return appStarted();case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated();case CameraUnavailable() when cameraUnavailable != null:
return cameraUnavailable();case BackendCheckFailed() when backendCheckFailed != null:
return backendCheckFailed();case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case AppRebootRequested() when appRebootRequested != null:
return appRebootRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  appStarted,required TResult Function()  hardwareCheckInitiated,required TResult Function()  cameraUnavailable,required TResult Function()  backendCheckFailed,required TResult Function()  onboardingCompleted,required TResult Function()  appBackgrounded,required TResult Function()  appForegrounded,required TResult Function()  appRebootRequested,}) {final _that = this;
switch (_that) {
case AppStarted():
return appStarted();case HardwareCheckInitiated():
return hardwareCheckInitiated();case CameraUnavailable():
return cameraUnavailable();case BackendCheckFailed():
return backendCheckFailed();case OnboardingCompleted():
return onboardingCompleted();case AppBackgrounded():
return appBackgrounded();case AppForegrounded():
return appForegrounded();case AppRebootRequested():
return appRebootRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  appStarted,TResult? Function()?  hardwareCheckInitiated,TResult? Function()?  cameraUnavailable,TResult? Function()?  backendCheckFailed,TResult? Function()?  onboardingCompleted,TResult? Function()?  appBackgrounded,TResult? Function()?  appForegrounded,TResult? Function()?  appRebootRequested,}) {final _that = this;
switch (_that) {
case AppStarted() when appStarted != null:
return appStarted();case HardwareCheckInitiated() when hardwareCheckInitiated != null:
return hardwareCheckInitiated();case CameraUnavailable() when cameraUnavailable != null:
return cameraUnavailable();case BackendCheckFailed() when backendCheckFailed != null:
return backendCheckFailed();case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case AppBackgrounded() when appBackgrounded != null:
return appBackgrounded();case AppForegrounded() when appForegrounded != null:
return appForegrounded();case AppRebootRequested() when appRebootRequested != null:
return appRebootRequested();case _:
  return null;

}
}

}

/// @nodoc


class AppStarted implements AppEvent {
  const AppStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.appStarted()';
}


}




/// @nodoc


class HardwareCheckInitiated implements AppEvent {
  const HardwareCheckInitiated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HardwareCheckInitiated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.hardwareCheckInitiated()';
}


}




/// @nodoc


class CameraUnavailable implements AppEvent {
  const CameraUnavailable();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraUnavailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.cameraUnavailable()';
}


}




/// @nodoc


class BackendCheckFailed implements AppEvent {
  const BackendCheckFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackendCheckFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.backendCheckFailed()';
}


}




/// @nodoc


class OnboardingCompleted implements AppEvent {
  const OnboardingCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.onboardingCompleted()';
}


}




/// @nodoc


class AppBackgrounded implements AppEvent {
  const AppBackgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBackgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.appBackgrounded()';
}


}




/// @nodoc


class AppForegrounded implements AppEvent {
  const AppForegrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.appForegrounded()';
}


}




/// @nodoc


class AppRebootRequested implements AppEvent {
  const AppRebootRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRebootRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.appRebootRequested()';
}


}




// dart format on
