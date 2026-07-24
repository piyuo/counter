// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_flow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFlow {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFlow);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlow()';
}


}

/// @nodoc
class $AppFlowCopyWith<$Res>  {
$AppFlowCopyWith(AppFlow _, $Res Function(AppFlow) __);
}


/// Adds pattern-matching-related methods to [AppFlow].
extension AppFlowPatterns on AppFlow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WaitingForStart value)?  waitingForStart,TResult Function( CheckingDataServer value)?  checkingDataServer,TResult Function( OnboardingBegin value)?  onboardingBegin,TResult Function( OnboardingByInvitation value)?  onboardingByInvitation,TResult Function( SessionRunning value)?  sessionRunning,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WaitingForStart() when waitingForStart != null:
return waitingForStart(_that);case CheckingDataServer() when checkingDataServer != null:
return checkingDataServer(_that);case OnboardingBegin() when onboardingBegin != null:
return onboardingBegin(_that);case OnboardingByInvitation() when onboardingByInvitation != null:
return onboardingByInvitation(_that);case SessionRunning() when sessionRunning != null:
return sessionRunning(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WaitingForStart value)  waitingForStart,required TResult Function( CheckingDataServer value)  checkingDataServer,required TResult Function( OnboardingBegin value)  onboardingBegin,required TResult Function( OnboardingByInvitation value)  onboardingByInvitation,required TResult Function( SessionRunning value)  sessionRunning,}){
final _that = this;
switch (_that) {
case WaitingForStart():
return waitingForStart(_that);case CheckingDataServer():
return checkingDataServer(_that);case OnboardingBegin():
return onboardingBegin(_that);case OnboardingByInvitation():
return onboardingByInvitation(_that);case SessionRunning():
return sessionRunning(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WaitingForStart value)?  waitingForStart,TResult? Function( CheckingDataServer value)?  checkingDataServer,TResult? Function( OnboardingBegin value)?  onboardingBegin,TResult? Function( OnboardingByInvitation value)?  onboardingByInvitation,TResult? Function( SessionRunning value)?  sessionRunning,}){
final _that = this;
switch (_that) {
case WaitingForStart() when waitingForStart != null:
return waitingForStart(_that);case CheckingDataServer() when checkingDataServer != null:
return checkingDataServer(_that);case OnboardingBegin() when onboardingBegin != null:
return onboardingBegin(_that);case OnboardingByInvitation() when onboardingByInvitation != null:
return onboardingByInvitation(_that);case SessionRunning() when sessionRunning != null:
return sessionRunning(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  waitingForStart,TResult Function()?  checkingDataServer,TResult Function()?  onboardingBegin,TResult Function()?  onboardingByInvitation,TResult Function()?  sessionRunning,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WaitingForStart() when waitingForStart != null:
return waitingForStart();case CheckingDataServer() when checkingDataServer != null:
return checkingDataServer();case OnboardingBegin() when onboardingBegin != null:
return onboardingBegin();case OnboardingByInvitation() when onboardingByInvitation != null:
return onboardingByInvitation();case SessionRunning() when sessionRunning != null:
return sessionRunning();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  waitingForStart,required TResult Function()  checkingDataServer,required TResult Function()  onboardingBegin,required TResult Function()  onboardingByInvitation,required TResult Function()  sessionRunning,}) {final _that = this;
switch (_that) {
case WaitingForStart():
return waitingForStart();case CheckingDataServer():
return checkingDataServer();case OnboardingBegin():
return onboardingBegin();case OnboardingByInvitation():
return onboardingByInvitation();case SessionRunning():
return sessionRunning();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  waitingForStart,TResult? Function()?  checkingDataServer,TResult? Function()?  onboardingBegin,TResult? Function()?  onboardingByInvitation,TResult? Function()?  sessionRunning,}) {final _that = this;
switch (_that) {
case WaitingForStart() when waitingForStart != null:
return waitingForStart();case CheckingDataServer() when checkingDataServer != null:
return checkingDataServer();case OnboardingBegin() when onboardingBegin != null:
return onboardingBegin();case OnboardingByInvitation() when onboardingByInvitation != null:
return onboardingByInvitation();case SessionRunning() when sessionRunning != null:
return sessionRunning();case _:
  return null;

}
}

}

/// @nodoc


class WaitingForStart implements AppFlow {
  const WaitingForStart();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitingForStart);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlow.waitingForStart()';
}


}




/// @nodoc


class CheckingDataServer implements AppFlow {
  const CheckingDataServer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckingDataServer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlow.checkingDataServer()';
}


}




/// @nodoc


class OnboardingBegin implements AppFlow {
  const OnboardingBegin();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingBegin);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlow.onboardingBegin()';
}


}




/// @nodoc


class OnboardingByInvitation implements AppFlow {
  const OnboardingByInvitation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingByInvitation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlow.onboardingByInvitation()';
}


}




/// @nodoc


class SessionRunning implements AppFlow {
  const SessionRunning();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRunning);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlow.sessionRunning()';
}


}




// dart format on
