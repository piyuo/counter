// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frontend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Frontend _$FrontendFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'empty':
          return EmptyFrontend.fromJson(
            json
          );
                case 'camera':
          return CameraFrontend.fromJson(
            json
          );
                case 'webcam':
          return WebcamFrontend.fromJson(
            json
          );
                case 'file':
          return FileFrontend.fromJson(
            json
          );
                case 'liveUrl':
          return LiveUrlFrontend.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Frontend',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Frontend {



  /// Serializes this Frontend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Frontend);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Frontend()';
}


}

/// @nodoc
class $FrontendCopyWith<$Res>  {
$FrontendCopyWith(Frontend _, $Res Function(Frontend) __);
}


/// Adds pattern-matching-related methods to [Frontend].
extension FrontendPatterns on Frontend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmptyFrontend value)?  empty,TResult Function( CameraFrontend value)?  camera,TResult Function( WebcamFrontend value)?  webcam,TResult Function( FileFrontend value)?  file,TResult Function( LiveUrlFrontend value)?  liveUrl,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmptyFrontend() when empty != null:
return empty(_that);case CameraFrontend() when camera != null:
return camera(_that);case WebcamFrontend() when webcam != null:
return webcam(_that);case FileFrontend() when file != null:
return file(_that);case LiveUrlFrontend() when liveUrl != null:
return liveUrl(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmptyFrontend value)  empty,required TResult Function( CameraFrontend value)  camera,required TResult Function( WebcamFrontend value)  webcam,required TResult Function( FileFrontend value)  file,required TResult Function( LiveUrlFrontend value)  liveUrl,}){
final _that = this;
switch (_that) {
case EmptyFrontend():
return empty(_that);case CameraFrontend():
return camera(_that);case WebcamFrontend():
return webcam(_that);case FileFrontend():
return file(_that);case LiveUrlFrontend():
return liveUrl(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmptyFrontend value)?  empty,TResult? Function( CameraFrontend value)?  camera,TResult? Function( WebcamFrontend value)?  webcam,TResult? Function( FileFrontend value)?  file,TResult? Function( LiveUrlFrontend value)?  liveUrl,}){
final _that = this;
switch (_that) {
case EmptyFrontend() when empty != null:
return empty(_that);case CameraFrontend() when camera != null:
return camera(_that);case WebcamFrontend() when webcam != null:
return webcam(_that);case FileFrontend() when file != null:
return file(_that);case LiveUrlFrontend() when liveUrl != null:
return liveUrl(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  empty,TResult Function( int cameraIndex)?  camera,TResult Function( int webcamIndex)?  webcam,TResult Function( String fileName)?  file,TResult Function( String url)?  liveUrl,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmptyFrontend() when empty != null:
return empty();case CameraFrontend() when camera != null:
return camera(_that.cameraIndex);case WebcamFrontend() when webcam != null:
return webcam(_that.webcamIndex);case FileFrontend() when file != null:
return file(_that.fileName);case LiveUrlFrontend() when liveUrl != null:
return liveUrl(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  empty,required TResult Function( int cameraIndex)  camera,required TResult Function( int webcamIndex)  webcam,required TResult Function( String fileName)  file,required TResult Function( String url)  liveUrl,}) {final _that = this;
switch (_that) {
case EmptyFrontend():
return empty();case CameraFrontend():
return camera(_that.cameraIndex);case WebcamFrontend():
return webcam(_that.webcamIndex);case FileFrontend():
return file(_that.fileName);case LiveUrlFrontend():
return liveUrl(_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  empty,TResult? Function( int cameraIndex)?  camera,TResult? Function( int webcamIndex)?  webcam,TResult? Function( String fileName)?  file,TResult? Function( String url)?  liveUrl,}) {final _that = this;
switch (_that) {
case EmptyFrontend() when empty != null:
return empty();case CameraFrontend() when camera != null:
return camera(_that.cameraIndex);case WebcamFrontend() when webcam != null:
return webcam(_that.webcamIndex);case FileFrontend() when file != null:
return file(_that.fileName);case LiveUrlFrontend() when liveUrl != null:
return liveUrl(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EmptyFrontend implements Frontend {
  const EmptyFrontend({final  String? $type}): $type = $type ?? 'empty';
  factory EmptyFrontend.fromJson(Map<String, dynamic> json) => _$EmptyFrontendFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$EmptyFrontendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyFrontend);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Frontend.empty()';
}


}




/// @nodoc
@JsonSerializable()

class CameraFrontend implements Frontend {
  const CameraFrontend({required this.cameraIndex, final  String? $type}): $type = $type ?? 'camera';
  factory CameraFrontend.fromJson(Map<String, dynamic> json) => _$CameraFrontendFromJson(json);

 final  int cameraIndex;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraFrontendCopyWith<CameraFrontend> get copyWith => _$CameraFrontendCopyWithImpl<CameraFrontend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CameraFrontendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraFrontend&&(identical(other.cameraIndex, cameraIndex) || other.cameraIndex == cameraIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cameraIndex);

@override
String toString() {
  return 'Frontend.camera(cameraIndex: $cameraIndex)';
}


}

/// @nodoc
abstract mixin class $CameraFrontendCopyWith<$Res> implements $FrontendCopyWith<$Res> {
  factory $CameraFrontendCopyWith(CameraFrontend value, $Res Function(CameraFrontend) _then) = _$CameraFrontendCopyWithImpl;
@useResult
$Res call({
 int cameraIndex
});




}
/// @nodoc
class _$CameraFrontendCopyWithImpl<$Res>
    implements $CameraFrontendCopyWith<$Res> {
  _$CameraFrontendCopyWithImpl(this._self, this._then);

  final CameraFrontend _self;
  final $Res Function(CameraFrontend) _then;

/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cameraIndex = null,}) {
  return _then(CameraFrontend(
cameraIndex: null == cameraIndex ? _self.cameraIndex : cameraIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WebcamFrontend implements Frontend {
  const WebcamFrontend({required this.webcamIndex, final  String? $type}): $type = $type ?? 'webcam';
  factory WebcamFrontend.fromJson(Map<String, dynamic> json) => _$WebcamFrontendFromJson(json);

 final  int webcamIndex;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebcamFrontendCopyWith<WebcamFrontend> get copyWith => _$WebcamFrontendCopyWithImpl<WebcamFrontend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebcamFrontendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebcamFrontend&&(identical(other.webcamIndex, webcamIndex) || other.webcamIndex == webcamIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,webcamIndex);

@override
String toString() {
  return 'Frontend.webcam(webcamIndex: $webcamIndex)';
}


}

/// @nodoc
abstract mixin class $WebcamFrontendCopyWith<$Res> implements $FrontendCopyWith<$Res> {
  factory $WebcamFrontendCopyWith(WebcamFrontend value, $Res Function(WebcamFrontend) _then) = _$WebcamFrontendCopyWithImpl;
@useResult
$Res call({
 int webcamIndex
});




}
/// @nodoc
class _$WebcamFrontendCopyWithImpl<$Res>
    implements $WebcamFrontendCopyWith<$Res> {
  _$WebcamFrontendCopyWithImpl(this._self, this._then);

  final WebcamFrontend _self;
  final $Res Function(WebcamFrontend) _then;

/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? webcamIndex = null,}) {
  return _then(WebcamFrontend(
webcamIndex: null == webcamIndex ? _self.webcamIndex : webcamIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FileFrontend implements Frontend {
  const FileFrontend({required this.fileName, final  String? $type}): $type = $type ?? 'file';
  factory FileFrontend.fromJson(Map<String, dynamic> json) => _$FileFrontendFromJson(json);

 final  String fileName;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileFrontendCopyWith<FileFrontend> get copyWith => _$FileFrontendCopyWithImpl<FileFrontend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileFrontendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileFrontend&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName);

@override
String toString() {
  return 'Frontend.file(fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class $FileFrontendCopyWith<$Res> implements $FrontendCopyWith<$Res> {
  factory $FileFrontendCopyWith(FileFrontend value, $Res Function(FileFrontend) _then) = _$FileFrontendCopyWithImpl;
@useResult
$Res call({
 String fileName
});




}
/// @nodoc
class _$FileFrontendCopyWithImpl<$Res>
    implements $FileFrontendCopyWith<$Res> {
  _$FileFrontendCopyWithImpl(this._self, this._then);

  final FileFrontend _self;
  final $Res Function(FileFrontend) _then;

/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fileName = null,}) {
  return _then(FileFrontend(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LiveUrlFrontend implements Frontend {
  const LiveUrlFrontend({required this.url, final  String? $type}): $type = $type ?? 'liveUrl';
  factory LiveUrlFrontend.fromJson(Map<String, dynamic> json) => _$LiveUrlFrontendFromJson(json);

 final  String url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveUrlFrontendCopyWith<LiveUrlFrontend> get copyWith => _$LiveUrlFrontendCopyWithImpl<LiveUrlFrontend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveUrlFrontendToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveUrlFrontend&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'Frontend.liveUrl(url: $url)';
}


}

/// @nodoc
abstract mixin class $LiveUrlFrontendCopyWith<$Res> implements $FrontendCopyWith<$Res> {
  factory $LiveUrlFrontendCopyWith(LiveUrlFrontend value, $Res Function(LiveUrlFrontend) _then) = _$LiveUrlFrontendCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$LiveUrlFrontendCopyWithImpl<$Res>
    implements $LiveUrlFrontendCopyWith<$Res> {
  _$LiveUrlFrontendCopyWithImpl(this._self, this._then);

  final LiveUrlFrontend _self;
  final $Res Function(LiveUrlFrontend) _then;

/// Create a copy of Frontend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(LiveUrlFrontend(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
