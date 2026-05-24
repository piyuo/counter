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
                  case 'personalPiyuo':
          return PersonalPiyuoServer.fromJson(
            json
          );
                case 'businessPiyuo':
          return BusinessPiyuoServer.fromJson(
            json
          );
                case 'personalCustom':
          return PersonalCustomServer.fromJson(
            json
          );
                case 'businessCustom':
          return BusinessCustomServer.fromJson(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PersonalPiyuoServer value)?  personalPiyuo,TResult Function( BusinessPiyuoServer value)?  businessPiyuo,TResult Function( PersonalCustomServer value)?  personalCustom,TResult Function( BusinessCustomServer value)?  businessCustom,TResult Function( NoDataServer value)?  none,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PersonalPiyuoServer() when personalPiyuo != null:
return personalPiyuo(_that);case BusinessPiyuoServer() when businessPiyuo != null:
return businessPiyuo(_that);case PersonalCustomServer() when personalCustom != null:
return personalCustom(_that);case BusinessCustomServer() when businessCustom != null:
return businessCustom(_that);case NoDataServer() when none != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PersonalPiyuoServer value)  personalPiyuo,required TResult Function( BusinessPiyuoServer value)  businessPiyuo,required TResult Function( PersonalCustomServer value)  personalCustom,required TResult Function( BusinessCustomServer value)  businessCustom,required TResult Function( NoDataServer value)  none,}){
final _that = this;
switch (_that) {
case PersonalPiyuoServer():
return personalPiyuo(_that);case BusinessPiyuoServer():
return businessPiyuo(_that);case PersonalCustomServer():
return personalCustom(_that);case BusinessCustomServer():
return businessCustom(_that);case NoDataServer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PersonalPiyuoServer value)?  personalPiyuo,TResult? Function( BusinessPiyuoServer value)?  businessPiyuo,TResult? Function( PersonalCustomServer value)?  personalCustom,TResult? Function( BusinessCustomServer value)?  businessCustom,TResult? Function( NoDataServer value)?  none,}){
final _that = this;
switch (_that) {
case PersonalPiyuoServer() when personalPiyuo != null:
return personalPiyuo(_that);case BusinessPiyuoServer() when businessPiyuo != null:
return businessPiyuo(_that);case PersonalCustomServer() when personalCustom != null:
return personalCustom(_that);case BusinessCustomServer() when businessCustom != null:
return businessCustom(_that);case NoDataServer() when none != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String url)?  personalPiyuo,TResult Function( String url,  String projectId,  String projectName,  String assignedId,  String assignedName)?  businessPiyuo,TResult Function( String url)?  personalCustom,TResult Function( String url,  String projectId,  String projectName,  String assignedId,  String assignedName)?  businessCustom,TResult Function()?  none,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PersonalPiyuoServer() when personalPiyuo != null:
return personalPiyuo(_that.url);case BusinessPiyuoServer() when businessPiyuo != null:
return businessPiyuo(_that.url,_that.projectId,_that.projectName,_that.assignedId,_that.assignedName);case PersonalCustomServer() when personalCustom != null:
return personalCustom(_that.url);case BusinessCustomServer() when businessCustom != null:
return businessCustom(_that.url,_that.projectId,_that.projectName,_that.assignedId,_that.assignedName);case NoDataServer() when none != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String url)  personalPiyuo,required TResult Function( String url,  String projectId,  String projectName,  String assignedId,  String assignedName)  businessPiyuo,required TResult Function( String url)  personalCustom,required TResult Function( String url,  String projectId,  String projectName,  String assignedId,  String assignedName)  businessCustom,required TResult Function()  none,}) {final _that = this;
switch (_that) {
case PersonalPiyuoServer():
return personalPiyuo(_that.url);case BusinessPiyuoServer():
return businessPiyuo(_that.url,_that.projectId,_that.projectName,_that.assignedId,_that.assignedName);case PersonalCustomServer():
return personalCustom(_that.url);case BusinessCustomServer():
return businessCustom(_that.url,_that.projectId,_that.projectName,_that.assignedId,_that.assignedName);case NoDataServer():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String url)?  personalPiyuo,TResult? Function( String url,  String projectId,  String projectName,  String assignedId,  String assignedName)?  businessPiyuo,TResult? Function( String url)?  personalCustom,TResult? Function( String url,  String projectId,  String projectName,  String assignedId,  String assignedName)?  businessCustom,TResult? Function()?  none,}) {final _that = this;
switch (_that) {
case PersonalPiyuoServer() when personalPiyuo != null:
return personalPiyuo(_that.url);case BusinessPiyuoServer() when businessPiyuo != null:
return businessPiyuo(_that.url,_that.projectId,_that.projectName,_that.assignedId,_that.assignedName);case PersonalCustomServer() when personalCustom != null:
return personalCustom(_that.url);case BusinessCustomServer() when businessCustom != null:
return businessCustom(_that.url,_that.projectId,_that.projectName,_that.assignedId,_that.assignedName);case NoDataServer() when none != null:
return none();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PersonalPiyuoServer extends DataServer {
  const PersonalPiyuoServer({required this.url, final  String? $type}): $type = $type ?? 'personalPiyuo',super._();
  factory PersonalPiyuoServer.fromJson(Map<String, dynamic> json) => _$PersonalPiyuoServerFromJson(json);

 final  String url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalPiyuoServerCopyWith<PersonalPiyuoServer> get copyWith => _$PersonalPiyuoServerCopyWithImpl<PersonalPiyuoServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalPiyuoServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalPiyuoServer&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'DataServer.personalPiyuo(url: $url)';
}


}

/// @nodoc
abstract mixin class $PersonalPiyuoServerCopyWith<$Res> implements $DataServerCopyWith<$Res> {
  factory $PersonalPiyuoServerCopyWith(PersonalPiyuoServer value, $Res Function(PersonalPiyuoServer) _then) = _$PersonalPiyuoServerCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$PersonalPiyuoServerCopyWithImpl<$Res>
    implements $PersonalPiyuoServerCopyWith<$Res> {
  _$PersonalPiyuoServerCopyWithImpl(this._self, this._then);

  final PersonalPiyuoServer _self;
  final $Res Function(PersonalPiyuoServer) _then;

/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(PersonalPiyuoServer(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BusinessPiyuoServer extends DataServer {
  const BusinessPiyuoServer({required this.url, required this.projectId, required this.projectName, required this.assignedId, required this.assignedName, final  String? $type}): $type = $type ?? 'businessPiyuo',super._();
  factory BusinessPiyuoServer.fromJson(Map<String, dynamic> json) => _$BusinessPiyuoServerFromJson(json);

 final  String url;
// where to send data, e.g. https://piyuo.com/api/v1
 final  String projectId;
// for business Piyuo to identify the project, e.g. "1234-1234-1234-1234"
 final  String projectName;
// for display only, e.g. "My First Store"
 final  String assignedId;
// for business Piyuo to identify the device, e.g. "abcd-1234-abcd-5678"
 final  String assignedName;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessPiyuoServerCopyWith<BusinessPiyuoServer> get copyWith => _$BusinessPiyuoServerCopyWithImpl<BusinessPiyuoServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessPiyuoServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessPiyuoServer&&(identical(other.url, url) || other.url == url)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.assignedId, assignedId) || other.assignedId == assignedId)&&(identical(other.assignedName, assignedName) || other.assignedName == assignedName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,projectId,projectName,assignedId,assignedName);

@override
String toString() {
  return 'DataServer.businessPiyuo(url: $url, projectId: $projectId, projectName: $projectName, assignedId: $assignedId, assignedName: $assignedName)';
}


}

/// @nodoc
abstract mixin class $BusinessPiyuoServerCopyWith<$Res> implements $DataServerCopyWith<$Res> {
  factory $BusinessPiyuoServerCopyWith(BusinessPiyuoServer value, $Res Function(BusinessPiyuoServer) _then) = _$BusinessPiyuoServerCopyWithImpl;
@useResult
$Res call({
 String url, String projectId, String projectName, String assignedId, String assignedName
});




}
/// @nodoc
class _$BusinessPiyuoServerCopyWithImpl<$Res>
    implements $BusinessPiyuoServerCopyWith<$Res> {
  _$BusinessPiyuoServerCopyWithImpl(this._self, this._then);

  final BusinessPiyuoServer _self;
  final $Res Function(BusinessPiyuoServer) _then;

/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? projectId = null,Object? projectName = null,Object? assignedId = null,Object? assignedName = null,}) {
  return _then(BusinessPiyuoServer(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,assignedId: null == assignedId ? _self.assignedId : assignedId // ignore: cast_nullable_to_non_nullable
as String,assignedName: null == assignedName ? _self.assignedName : assignedName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PersonalCustomServer extends DataServer {
  const PersonalCustomServer({required this.url, final  String? $type}): $type = $type ?? 'personalCustom',super._();
  factory PersonalCustomServer.fromJson(Map<String, dynamic> json) => _$PersonalCustomServerFromJson(json);

 final  String url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalCustomServerCopyWith<PersonalCustomServer> get copyWith => _$PersonalCustomServerCopyWithImpl<PersonalCustomServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalCustomServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalCustomServer&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'DataServer.personalCustom(url: $url)';
}


}

/// @nodoc
abstract mixin class $PersonalCustomServerCopyWith<$Res> implements $DataServerCopyWith<$Res> {
  factory $PersonalCustomServerCopyWith(PersonalCustomServer value, $Res Function(PersonalCustomServer) _then) = _$PersonalCustomServerCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$PersonalCustomServerCopyWithImpl<$Res>
    implements $PersonalCustomServerCopyWith<$Res> {
  _$PersonalCustomServerCopyWithImpl(this._self, this._then);

  final PersonalCustomServer _self;
  final $Res Function(PersonalCustomServer) _then;

/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(PersonalCustomServer(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BusinessCustomServer extends DataServer {
  const BusinessCustomServer({required this.url, required this.projectId, required this.projectName, required this.assignedId, required this.assignedName, final  String? $type}): $type = $type ?? 'businessCustom',super._();
  factory BusinessCustomServer.fromJson(Map<String, dynamic> json) => _$BusinessCustomServerFromJson(json);

 final  String url;
// where to send data, e.g. https://piyuo.com/api/v1
 final  String projectId;
// for business Piyuo to identify the project, e.g. "1234-1234-1234-1234"
 final  String projectName;
// for display only, e.g. "My First Store"
 final  String assignedId;
// for business Piyuo to identify the device, e.g. "abcd-1234-abcd-5678"
 final  String assignedName;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessCustomServerCopyWith<BusinessCustomServer> get copyWith => _$BusinessCustomServerCopyWithImpl<BusinessCustomServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessCustomServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessCustomServer&&(identical(other.url, url) || other.url == url)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.assignedId, assignedId) || other.assignedId == assignedId)&&(identical(other.assignedName, assignedName) || other.assignedName == assignedName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,projectId,projectName,assignedId,assignedName);

@override
String toString() {
  return 'DataServer.businessCustom(url: $url, projectId: $projectId, projectName: $projectName, assignedId: $assignedId, assignedName: $assignedName)';
}


}

/// @nodoc
abstract mixin class $BusinessCustomServerCopyWith<$Res> implements $DataServerCopyWith<$Res> {
  factory $BusinessCustomServerCopyWith(BusinessCustomServer value, $Res Function(BusinessCustomServer) _then) = _$BusinessCustomServerCopyWithImpl;
@useResult
$Res call({
 String url, String projectId, String projectName, String assignedId, String assignedName
});




}
/// @nodoc
class _$BusinessCustomServerCopyWithImpl<$Res>
    implements $BusinessCustomServerCopyWith<$Res> {
  _$BusinessCustomServerCopyWithImpl(this._self, this._then);

  final BusinessCustomServer _self;
  final $Res Function(BusinessCustomServer) _then;

/// Create a copy of DataServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? projectId = null,Object? projectName = null,Object? assignedId = null,Object? assignedName = null,}) {
  return _then(BusinessCustomServer(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,assignedId: null == assignedId ? _self.assignedId : assignedId // ignore: cast_nullable_to_non_nullable
as String,assignedName: null == assignedName ? _self.assignedName : assignedName // ignore: cast_nullable_to_non_nullable
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
