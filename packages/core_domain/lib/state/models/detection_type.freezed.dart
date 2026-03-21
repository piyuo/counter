// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detection_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DetectionType _$DetectionTypeFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'human':
          return DetectionHuman.fromJson(
            json
          );
                case 'vehicle':
          return DetectionVehicle.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'DetectionType',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$DetectionType {



  /// Serializes this DetectionType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectionType);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetectionType()';
}


}

/// @nodoc
class $DetectionTypeCopyWith<$Res>  {
$DetectionTypeCopyWith(DetectionType _, $Res Function(DetectionType) __);
}


/// Adds pattern-matching-related methods to [DetectionType].
extension DetectionTypePatterns on DetectionType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DetectionHuman value)?  human,TResult Function( DetectionVehicle value)?  vehicle,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DetectionHuman() when human != null:
return human(_that);case DetectionVehicle() when vehicle != null:
return vehicle(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DetectionHuman value)  human,required TResult Function( DetectionVehicle value)  vehicle,}){
final _that = this;
switch (_that) {
case DetectionHuman():
return human(_that);case DetectionVehicle():
return vehicle(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DetectionHuman value)?  human,TResult? Function( DetectionVehicle value)?  vehicle,}){
final _that = this;
switch (_that) {
case DetectionHuman() when human != null:
return human(_that);case DetectionVehicle() when vehicle != null:
return vehicle(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  human,TResult Function()?  vehicle,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DetectionHuman() when human != null:
return human();case DetectionVehicle() when vehicle != null:
return vehicle();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  human,required TResult Function()  vehicle,}) {final _that = this;
switch (_that) {
case DetectionHuman():
return human();case DetectionVehicle():
return vehicle();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  human,TResult? Function()?  vehicle,}) {final _that = this;
switch (_that) {
case DetectionHuman() when human != null:
return human();case DetectionVehicle() when vehicle != null:
return vehicle();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class DetectionHuman extends DetectionType {
  const DetectionHuman({final  String? $type}): $type = $type ?? 'human',super._();
  factory DetectionHuman.fromJson(Map<String, dynamic> json) => _$DetectionHumanFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DetectionHumanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectionHuman);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetectionType.human()';
}


}




/// @nodoc
@JsonSerializable()

class DetectionVehicle extends DetectionType {
  const DetectionVehicle({final  String? $type}): $type = $type ?? 'vehicle',super._();
  factory DetectionVehicle.fromJson(Map<String, dynamic> json) => _$DetectionVehicleFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DetectionVehicleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectionVehicle);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DetectionType.vehicle()';
}


}




// dart format on
