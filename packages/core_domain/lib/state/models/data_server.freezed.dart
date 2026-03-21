// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DataServer _$DataServerFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'unspecified':
          return UnspecifiedDataServer.fromJson(
            json
          );
                case 'business':
          return BusinessDataServer.fromJson(
            json
          );
                case 'personal':
          return PersonalDataServer.fromJson(
            json
          );
                case 'none':
          return NoDataServer.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'DataServer',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$DataServer {



  /// Serializes this DataServer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataServer);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DataServer()';
}


}

/// @nodoc
class $DataServerCopyWith<$Res>  {
$DataServerCopyWith(DataServer _, $Res Function(DataServer) __);
}


/// Adds pattern-matching-related methods to [DataServer].
extension DataServerPatterns on DataServer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UnspecifiedDataServer value)?  unspecified,TResult Function( BusinessDataServer value)?  business,TResult Function( PersonalDataServer value)?  personal,TResult Function( NoDataServer value)?  none,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UnspecifiedDataServer() when unspecified != null:
return unspecified(_that);case BusinessDataServer() when business != null:
return business(_that);case PersonalDataServer() when personal != null:
return personal(_that);case NoDataServer() when none != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UnspecifiedDataServer value)  unspecified,required TResult Function( BusinessDataServer value)  business,required TResult Function( PersonalDataServer value)  personal,required TResult Function( NoDataServer value)  none,}){
final _that = this;
switch (_that) {
case UnspecifiedDataServer():
return unspecified(_that);case BusinessDataServer():
return business(_that);case PersonalDataServer():
return personal(_that);case NoDataServer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UnspecifiedDataServer value)?  unspecified,TResult? Function( BusinessDataServer value)?  business,TResult? Function( PersonalDataServer value)?  personal,TResult? Function( NoDataServer value)?  none,}){
final _that = this;
switch (_that) {
case UnspecifiedDataServer() when unspecified != null:
return unspecified(_that);case BusinessDataServer() when business != null:
return business(_that);case PersonalDataServer() when personal != null:
return personal(_that);case NoDataServer() when none != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unspecified,TResult Function( String url,  String projectName,  String projectId,  String assignedId)?  business,TResult Function( String url)?  personal,TResult Function()?  none,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UnspecifiedDataServer() when unspecified != null:
return unspecified();case BusinessDataServer() when business != null:
return business(_that.url,_that.projectName,_that.projectId,_that.assignedId);case PersonalDataServer() when personal != null:
return personal(_that.url);case NoDataServer() when none != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unspecified,required TResult Function( String url,  String projectName,  String projectId,  String assignedId)  business,required TResult Function( String url)  personal,required TResult Function()  none,}) {final _that = this;
switch (_that) {
case UnspecifiedDataServer():
return unspecified();case BusinessDataServer():
return business(_that.url,_that.projectName,_that.projectId,_that.assignedId);case PersonalDataServer():
return personal(_that.url);case NoDataServer():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unspecified,TResult? Function( String url,  String projectName,  String projectId,  String assignedId)?  business,TResult? Function( String url)?  personal,TResult? Function()?  none,}) {final _that = this;
switch (_that) {
case UnspecifiedDataServer() when unspecified != null:
return unspecified();case BusinessDataServer() when business != null:
return business(_that.url,_that.projectName,_that.projectId,_that.assignedId);case PersonalDataServer() when personal != null:
return personal(_that.url);case NoDataServer() when none != null:
return none();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UnspecifiedDataServer extends DataServer {
  const UnspecifiedDataServer({final  String? $type}): $type = $type ?? 'unspecified',super._();
  factory UnspecifiedDataServer.fromJson(Map<String, dynamic> json) => _$UnspecifiedDataServerFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnspecifiedDataServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnspecifiedDataServer);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DataServer.unspecified()';
}


}




/// @nodoc
@JsonSerializable()

class BusinessDataServer extends DataServer {
  const BusinessDataServer({required this.url, required this.projectName, required this.projectId, required this.assignedId, final  String? $type}): $type = $type ?? 'business',super._();
  factory BusinessDataServer.fromJson(Map<String, dynamic> json) => _$BusinessDataServerFromJson(json);

 final  String url;
// where to send data, e.g. https://piyuo.com/api/v1
 final  String projectName;
// for display only, e.g. "My First Store"
 final  String projectId;
// for business Piyuo to identify the project, e.g. "1234-1234-1234-1234"
 final  String assignedId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessDataServerCopyWith<BusinessDataServer> get copyWith => _$BusinessDataServerCopyWithImpl<BusinessDataServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessDataServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessDataServer&&(identical(other.url, url) || other.url == url)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.assignedId, assignedId) || other.assignedId == assignedId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,projectName,projectId,assignedId);

@override
String toString() {
  return 'DataServer.business(url: $url, projectName: $projectName, projectId: $projectId, assignedId: $assignedId)';
}


}

/// @nodoc
abstract mixin class $BusinessDataServerCopyWith<$Res> implements $DataServerCopyWith<$Res> {
  factory $BusinessDataServerCopyWith(BusinessDataServer value, $Res Function(BusinessDataServer) _then) = _$BusinessDataServerCopyWithImpl;
@useResult
$Res call({
 String url, String projectName, String projectId, String assignedId
});




}
/// @nodoc
class _$BusinessDataServerCopyWithImpl<$Res>
    implements $BusinessDataServerCopyWith<$Res> {
  _$BusinessDataServerCopyWithImpl(this._self, this._then);

  final BusinessDataServer _self;
  final $Res Function(BusinessDataServer) _then;

/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? projectName = null,Object? projectId = null,Object? assignedId = null,}) {
  return _then(BusinessDataServer(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,assignedId: null == assignedId ? _self.assignedId : assignedId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PersonalDataServer extends DataServer {
  const PersonalDataServer({required this.url, final  String? $type}): $type = $type ?? 'personal',super._();
  factory PersonalDataServer.fromJson(Map<String, dynamic> json) => _$PersonalDataServerFromJson(json);

 final  String url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDataServerCopyWith<PersonalDataServer> get copyWith => _$PersonalDataServerCopyWithImpl<PersonalDataServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalDataServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDataServer&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'DataServer.personal(url: $url)';
}


}

/// @nodoc
abstract mixin class $PersonalDataServerCopyWith<$Res> implements $DataServerCopyWith<$Res> {
  factory $PersonalDataServerCopyWith(PersonalDataServer value, $Res Function(PersonalDataServer) _then) = _$PersonalDataServerCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$PersonalDataServerCopyWithImpl<$Res>
    implements $PersonalDataServerCopyWith<$Res> {
  _$PersonalDataServerCopyWithImpl(this._self, this._then);

  final PersonalDataServer _self;
  final $Res Function(PersonalDataServer) _then;

/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(PersonalDataServer(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NoDataServer extends DataServer {
  const NoDataServer({final  String? $type}): $type = $type ?? 'none',super._();
  factory NoDataServer.fromJson(Map<String, dynamic> json) => _$NoDataServerFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NoDataServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoDataServer);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DataServer.none()';
}


}




// dart format on
