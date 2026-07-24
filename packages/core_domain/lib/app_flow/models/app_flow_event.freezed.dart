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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DataServerCheck value)?  dataServerCheck,TResult Function( OnboardingNeeded value)?  onboardingNeeded,TResult Function( InvitationClicked value)?  invitationClicked,TResult Function( StartSession value)?  startSession,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DataServerCheck() when dataServerCheck != null:
return dataServerCheck(_that);case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded(_that);case InvitationClicked() when invitationClicked != null:
return invitationClicked(_that);case StartSession() when startSession != null:
return startSession(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DataServerCheck value)  dataServerCheck,required TResult Function( OnboardingNeeded value)  onboardingNeeded,required TResult Function( InvitationClicked value)  invitationClicked,required TResult Function( StartSession value)  startSession,}){
final _that = this;
switch (_that) {
case DataServerCheck():
return dataServerCheck(_that);case OnboardingNeeded():
return onboardingNeeded(_that);case InvitationClicked():
return invitationClicked(_that);case StartSession():
return startSession(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DataServerCheck value)?  dataServerCheck,TResult? Function( OnboardingNeeded value)?  onboardingNeeded,TResult? Function( InvitationClicked value)?  invitationClicked,TResult? Function( StartSession value)?  startSession,}){
final _that = this;
switch (_that) {
case DataServerCheck() when dataServerCheck != null:
return dataServerCheck(_that);case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded(_that);case InvitationClicked() when invitationClicked != null:
return invitationClicked(_that);case StartSession() when startSession != null:
return startSession(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  dataServerCheck,TResult Function()?  onboardingNeeded,TResult Function()?  invitationClicked,TResult Function()?  startSession,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DataServerCheck() when dataServerCheck != null:
return dataServerCheck();case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded();case InvitationClicked() when invitationClicked != null:
return invitationClicked();case StartSession() when startSession != null:
return startSession();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  dataServerCheck,required TResult Function()  onboardingNeeded,required TResult Function()  invitationClicked,required TResult Function()  startSession,}) {final _that = this;
switch (_that) {
case DataServerCheck():
return dataServerCheck();case OnboardingNeeded():
return onboardingNeeded();case InvitationClicked():
return invitationClicked();case StartSession():
return startSession();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  dataServerCheck,TResult? Function()?  onboardingNeeded,TResult? Function()?  invitationClicked,TResult? Function()?  startSession,}) {final _that = this;
switch (_that) {
case DataServerCheck() when dataServerCheck != null:
return dataServerCheck();case OnboardingNeeded() when onboardingNeeded != null:
return onboardingNeeded();case InvitationClicked() when invitationClicked != null:
return invitationClicked();case StartSession() when startSession != null:
return startSession();case _:
  return null;

}
}

}

/// @nodoc


class DataServerCheck implements AppFlowEvent {
  const DataServerCheck();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataServerCheck);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent.dataServerCheck()';
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


class InvitationClicked implements AppFlowEvent {
  const InvitationClicked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationClicked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent.invitationClicked()';
}


}




/// @nodoc


class StartSession implements AppFlowEvent {
  const StartSession();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartSession);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppFlowEvent.startSession()';
}


}




// dart format on
