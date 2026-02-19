// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_flow_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppFlowEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFlowEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent()';
}


}

/// @nodoc
class $AppFlowEventCopyWith<$Res>  {
$AppFlowEventCopyWith(AppFlowEvent _, $Res Function(AppFlowEvent) __);
}


/// Adds pattern-matching-related methods to [AppFlowEvent].
extension AppFlowEventPatterns on AppFlowEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StartRequested value)?  startRequested,TResult Function( OnboardingNeeded value)?  onboardingNeeded,TResult Function( OnboardingCompleted value)?  onboardingCompleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StartRequested() when startRequested != null:
return startRequested(_that);case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded(_that);case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StartRequested value)  startRequested,required TResult Function( OnboardingNeeded value)  onboardingNeeded,required TResult Function( OnboardingCompleted value)  onboardingCompleted,}){
final _that = this;
switch (_that) {
case StartRequested():
return startRequested(_that);case OnboardingNeeded():
return onboardingNeeded(_that);case OnboardingCompleted():
return onboardingCompleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StartRequested value)?  startRequested,TResult? Function( OnboardingNeeded value)?  onboardingNeeded,TResult? Function( OnboardingCompleted value)?  onboardingCompleted,}){
final _that = this;
switch (_that) {
case StartRequested() when startRequested != null:
return startRequested(_that);case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded(_that);case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  startRequested,TResult Function()?  onboardingNeeded,TResult Function()?  onboardingCompleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StartRequested() when startRequested != null:
return startRequested();case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded();case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  startRequested,required TResult Function()  onboardingNeeded,required TResult Function()  onboardingCompleted,}) {final _that = this;
switch (_that) {
case StartRequested():
return startRequested();case OnboardingNeeded():
return onboardingNeeded();case OnboardingCompleted():
return onboardingCompleted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  startRequested,TResult? Function()?  onboardingNeeded,TResult? Function()?  onboardingCompleted,}) {final _that = this;
switch (_that) {
case StartRequested() when startRequested != null:
return startRequested();case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded();case OnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case _:
  return null;

}
}

}

/// @nodoc


class StartRequested implements AppFlowEvent {
  const StartRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent.startRequested()';
}


}




/// @nodoc


class OnboardingNeeded implements AppFlowEvent {
  const OnboardingNeeded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingNeeded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent.onboardingNeeded()';
}


}




/// @nodoc


class OnboardingCompleted implements AppFlowEvent {
  const OnboardingCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent.onboardingCompleted()';
}


}




// dart format on
