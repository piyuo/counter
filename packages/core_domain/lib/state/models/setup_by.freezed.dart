// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_by.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SetupBy _$SetupByFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'empty':
          return SetupByEmpty.fromJson(
            json
          );
                case 'invitation':
          return SetupByInvitation.fromJson(
            json
          );
                case 'signUp':
          return SetupBySignUp.fromJson(
            json
          );
                case 'demo':
          return SetupByDemo.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SetupBy',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SetupBy {



  /// Serializes this SetupBy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupBy);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetupBy()';
}


}

/// @nodoc
class $SetupByCopyWith<$Res>  {
$SetupByCopyWith(SetupBy _, $Res Function(SetupBy) __);
}


/// Adds pattern-matching-related methods to [SetupBy].
extension SetupByPatterns on SetupBy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SetupByEmpty value)?  empty,TResult Function( SetupByInvitation value)?  invitation,TResult Function( SetupBySignUp value)?  signUp,TResult Function( SetupByDemo value)?  demo,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SetupByEmpty() when empty != null:
return empty(_that);case SetupByInvitation() when invitation != null:
return invitation(_that);case SetupBySignUp() when signUp != null:
return signUp(_that);case SetupByDemo() when demo != null:
return demo(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SetupByEmpty value)  empty,required TResult Function( SetupByInvitation value)  invitation,required TResult Function( SetupBySignUp value)  signUp,required TResult Function( SetupByDemo value)  demo,}){
final _that = this;
switch (_that) {
case SetupByEmpty():
return empty(_that);case SetupByInvitation():
return invitation(_that);case SetupBySignUp():
return signUp(_that);case SetupByDemo():
return demo(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SetupByEmpty value)?  empty,TResult? Function( SetupByInvitation value)?  invitation,TResult? Function( SetupBySignUp value)?  signUp,TResult? Function( SetupByDemo value)?  demo,}){
final _that = this;
switch (_that) {
case SetupByEmpty() when empty != null:
return empty(_that);case SetupByInvitation() when invitation != null:
return invitation(_that);case SetupBySignUp() when signUp != null:
return signUp(_that);case SetupByDemo() when demo != null:
return demo(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  empty,TResult Function()?  invitation,TResult Function()?  signUp,TResult Function()?  demo,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SetupByEmpty() when empty != null:
return empty();case SetupByInvitation() when invitation != null:
return invitation();case SetupBySignUp() when signUp != null:
return signUp();case SetupByDemo() when demo != null:
return demo();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  empty,required TResult Function()  invitation,required TResult Function()  signUp,required TResult Function()  demo,}) {final _that = this;
switch (_that) {
case SetupByEmpty():
return empty();case SetupByInvitation():
return invitation();case SetupBySignUp():
return signUp();case SetupByDemo():
return demo();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  empty,TResult? Function()?  invitation,TResult? Function()?  signUp,TResult? Function()?  demo,}) {final _that = this;
switch (_that) {
case SetupByEmpty() when empty != null:
return empty();case SetupByInvitation() when invitation != null:
return invitation();case SetupBySignUp() when signUp != null:
return signUp();case SetupByDemo() when demo != null:
return demo();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SetupByEmpty implements SetupBy {
  const SetupByEmpty({final  String? $type}): $type = $type ?? 'empty';
  factory SetupByEmpty.fromJson(Map<String, dynamic> json) => _$SetupByEmptyFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SetupByEmptyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupByEmpty);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetupBy.empty()';
}


}




/// @nodoc
@JsonSerializable()

class SetupByInvitation implements SetupBy {
  const SetupByInvitation({final  String? $type}): $type = $type ?? 'invitation';
  factory SetupByInvitation.fromJson(Map<String, dynamic> json) => _$SetupByInvitationFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SetupByInvitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupByInvitation);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetupBy.invitation()';
}


}




/// @nodoc
@JsonSerializable()

class SetupBySignUp implements SetupBy {
  const SetupBySignUp({final  String? $type}): $type = $type ?? 'signUp';
  factory SetupBySignUp.fromJson(Map<String, dynamic> json) => _$SetupBySignUpFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SetupBySignUpToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupBySignUp);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetupBy.signUp()';
}


}




/// @nodoc
@JsonSerializable()

class SetupByDemo implements SetupBy {
  const SetupByDemo({final  String? $type}): $type = $type ?? 'demo';
  factory SetupByDemo.fromJson(Map<String, dynamic> json) => _$SetupByDemoFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SetupByDemoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupByDemo);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SetupBy.demo()';
}


}




// dart format on
