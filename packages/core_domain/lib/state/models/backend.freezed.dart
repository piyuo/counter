// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Backend _$BackendFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'empty':
          return EmptyBackend.fromJson(
            json
          );
                case 'piyuo':
          return PiyuoBackend.fromJson(
            json
          );
                case 'customServer':
          return CustomServerBackend.fromJson(
            json
          );
                case 'none':
          return NoBackend.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Backend',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Backend {



  /// Serializes this Backend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Backend);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Backend()';
}


}

/// @nodoc
class $BackendCopyWith<$Res>  {
$BackendCopyWith(Backend _, $Res Function(Backend) __);
}


/// Adds pattern-matching-related methods to [Backend].
extension BackendPatterns on Backend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmptyBackend value)?  empty,TResult Function( PiyuoBackend value)?  piyuo,TResult Function( CustomServerBackend value)?  customServer,TResult Function( NoBackend value)?  none,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmptyBackend() when empty != null:
return empty(_that);case PiyuoBackend() when piyuo != null:
return piyuo(_that);case CustomServerBackend() when customServer != null:
return customServer(_that);case NoBackend() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmptyBackend value)  empty,required TResult Function( PiyuoBackend value)  piyuo,required TResult Function( CustomServerBackend value)  customServer,required TResult Function( NoBackend value)  none,}){
final _that = this;
switch (_that) {
case EmptyBackend():
return empty(_that);case PiyuoBackend():
return piyuo(_that);case CustomServerBackend():
return customServer(_that);case NoBackend():
return none(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmptyBackend value)?  empty,TResult? Function( PiyuoBackend value)?  piyuo,TResult? Function( CustomServerBackend value)?  customServer,TResult? Function( NoBackend value)?  none,}){
final _that = this;
switch (_that) {
case EmptyBackend() when empty != null:
return empty(_that);case PiyuoBackend() when piyuo != null:
return piyuo(_that);case CustomServerBackend() when customServer != null:
return customServer(_that);case NoBackend() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  empty,TResult Function( String token)?  piyuo,TResult Function( String serverUrl,  String? token)?  customServer,TResult Function()?  none,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmptyBackend() when empty != null:
return empty();case PiyuoBackend() when piyuo != null:
return piyuo(_that.token);case CustomServerBackend() when customServer != null:
return customServer(_that.serverUrl,_that.token);case NoBackend() when none != null:
return none();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  empty,required TResult Function( String token)  piyuo,required TResult Function( String serverUrl,  String? token)  customServer,required TResult Function()  none,}) {final _that = this;
switch (_that) {
case EmptyBackend():
return empty();case PiyuoBackend():
return piyuo(_that.token);case CustomServerBackend():
return customServer(_that.serverUrl,_that.token);case NoBackend():
return none();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  empty,TResult? Function( String token)?  piyuo,TResult? Function( String serverUrl,  String? token)?  customServer,TResult? Function()?  none,}) {final _that = this;
switch (_that) {
case EmptyBackend() when empty != null:
return empty();case PiyuoBackend() when piyuo != null:
return piyuo(_that.token);case CustomServerBackend() when customServer != null:
return customServer(_that.serverUrl,_that.token);case NoBackend() when none != null:
return none();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EmptyBackend implements Backend {
  const EmptyBackend({final  String? $type}): $type = $type ?? 'empty';
  factory EmptyBackend.fromJson(Map<String, dynamic> json) => _$EmptyBackendFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EmptyBackendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyBackend);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Backend.empty()';
}


}




/// @nodoc
@JsonSerializable()

class PiyuoBackend implements Backend {
  const PiyuoBackend({required this.token, final  String? $type}): $type = $type ?? 'piyuo';
  factory PiyuoBackend.fromJson(Map<String, dynamic> json) => _$PiyuoBackendFromJson(json);

 final  String token;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Backend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PiyuoBackendCopyWith<PiyuoBackend> get copyWith => _$PiyuoBackendCopyWithImpl<PiyuoBackend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PiyuoBackendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PiyuoBackend&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'Backend.piyuo(token: $token)';
}


}

/// @nodoc
abstract mixin class $PiyuoBackendCopyWith<$Res> implements $BackendCopyWith<$Res> {
  factory $PiyuoBackendCopyWith(PiyuoBackend value, $Res Function(PiyuoBackend) _then) = _$PiyuoBackendCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$PiyuoBackendCopyWithImpl<$Res>
    implements $PiyuoBackendCopyWith<$Res> {
  _$PiyuoBackendCopyWithImpl(this._self, this._then);

  final PiyuoBackend _self;
  final $Res Function(PiyuoBackend) _then;

/// Create a copy of Backend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(PiyuoBackend(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CustomServerBackend implements Backend {
  const CustomServerBackend({required this.serverUrl, this.token, final  String? $type}): $type = $type ?? 'customServer';
  factory CustomServerBackend.fromJson(Map<String, dynamic> json) => _$CustomServerBackendFromJson(json);

 final  String serverUrl;
 final  String? token;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Backend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomServerBackendCopyWith<CustomServerBackend> get copyWith => _$CustomServerBackendCopyWithImpl<CustomServerBackend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomServerBackendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomServerBackend&&(identical(other.serverUrl, serverUrl) || other.serverUrl == serverUrl)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverUrl,token);

@override
String toString() {
  return 'Backend.customServer(serverUrl: $serverUrl, token: $token)';
}


}

/// @nodoc
abstract mixin class $CustomServerBackendCopyWith<$Res> implements $BackendCopyWith<$Res> {
  factory $CustomServerBackendCopyWith(CustomServerBackend value, $Res Function(CustomServerBackend) _then) = _$CustomServerBackendCopyWithImpl;
@useResult
$Res call({
 String serverUrl, String? token
});




}
/// @nodoc
class _$CustomServerBackendCopyWithImpl<$Res>
    implements $CustomServerBackendCopyWith<$Res> {
  _$CustomServerBackendCopyWithImpl(this._self, this._then);

  final CustomServerBackend _self;
  final $Res Function(CustomServerBackend) _then;

/// Create a copy of Backend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serverUrl = null,Object? token = freezed,}) {
  return _then(CustomServerBackend(
serverUrl: null == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NoBackend implements Backend {
  const NoBackend({final  String? $type}): $type = $type ?? 'none';
  factory NoBackend.fromJson(Map<String, dynamic> json) => _$NoBackendFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NoBackendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoBackend);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Backend.none()';
}


}




// dart format on
