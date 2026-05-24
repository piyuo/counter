// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
VideoSource _$VideoSourceFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'unspecified':
          return UnspecifiedVideoSource.fromJson(
            json
          );
                case 'camera':
          return CameraVideoSource.fromJson(
            json
          );
                case 'webcam':
          return WebcamVideoSource.fromJson(
            json
          );
                case 'file':
          return FileVideoSource.fromJson(
            json
          );
                case 'live':
          return LiveVideoSource.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'VideoSource',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$VideoSource {



  /// Serializes this VideoSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoSource);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VideoSource()';
}


}

/// @nodoc
class $VideoSourceCopyWith<$Res>  {
$VideoSourceCopyWith(VideoSource _, $Res Function(VideoSource) __);
}


/// Adds pattern-matching-related methods to [VideoSource].
extension VideoSourcePatterns on VideoSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UnspecifiedVideoSource value)?  unspecified,TResult Function( CameraVideoSource value)?  camera,TResult Function( WebcamVideoSource value)?  webcam,TResult Function( FileVideoSource value)?  file,TResult Function( LiveVideoSource value)?  live,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UnspecifiedVideoSource() when unspecified != null:
return unspecified(_that);case CameraVideoSource() when camera != null:
return camera(_that);case WebcamVideoSource() when webcam != null:
return webcam(_that);case FileVideoSource() when file != null:
return file(_that);case LiveVideoSource() when live != null:
return live(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UnspecifiedVideoSource value)  unspecified,required TResult Function( CameraVideoSource value)  camera,required TResult Function( WebcamVideoSource value)  webcam,required TResult Function( FileVideoSource value)  file,required TResult Function( LiveVideoSource value)  live,}){
final _that = this;
switch (_that) {
case UnspecifiedVideoSource():
return unspecified(_that);case CameraVideoSource():
return camera(_that);case WebcamVideoSource():
return webcam(_that);case FileVideoSource():
return file(_that);case LiveVideoSource():
return live(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UnspecifiedVideoSource value)?  unspecified,TResult? Function( CameraVideoSource value)?  camera,TResult? Function( WebcamVideoSource value)?  webcam,TResult? Function( FileVideoSource value)?  file,TResult? Function( LiveVideoSource value)?  live,}){
final _that = this;
switch (_that) {
case UnspecifiedVideoSource() when unspecified != null:
return unspecified(_that);case CameraVideoSource() when camera != null:
return camera(_that);case WebcamVideoSource() when webcam != null:
return webcam(_that);case FileVideoSource() when file != null:
return file(_that);case LiveVideoSource() when live != null:
return live(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unspecified,TResult Function( int cameraIndex,  bool isFaceFront)?  camera,TResult Function( int webcamIndex)?  webcam,TResult Function( String path)?  file,TResult Function( String url)?  live,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UnspecifiedVideoSource() when unspecified != null:
return unspecified();case CameraVideoSource() when camera != null:
return camera(_that.cameraIndex,_that.isFaceFront);case WebcamVideoSource() when webcam != null:
return webcam(_that.webcamIndex);case FileVideoSource() when file != null:
return file(_that.path);case LiveVideoSource() when live != null:
return live(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unspecified,required TResult Function( int cameraIndex,  bool isFaceFront)  camera,required TResult Function( int webcamIndex)  webcam,required TResult Function( String path)  file,required TResult Function( String url)  live,}) {final _that = this;
switch (_that) {
case UnspecifiedVideoSource():
return unspecified();case CameraVideoSource():
return camera(_that.cameraIndex,_that.isFaceFront);case WebcamVideoSource():
return webcam(_that.webcamIndex);case FileVideoSource():
return file(_that.path);case LiveVideoSource():
return live(_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unspecified,TResult? Function( int cameraIndex,  bool isFaceFront)?  camera,TResult? Function( int webcamIndex)?  webcam,TResult? Function( String path)?  file,TResult? Function( String url)?  live,}) {final _that = this;
switch (_that) {
case UnspecifiedVideoSource() when unspecified != null:
return unspecified();case CameraVideoSource() when camera != null:
return camera(_that.cameraIndex,_that.isFaceFront);case WebcamVideoSource() when webcam != null:
return webcam(_that.webcamIndex);case FileVideoSource() when file != null:
return file(_that.path);case LiveVideoSource() when live != null:
return live(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UnspecifiedVideoSource extends VideoSource {
  const UnspecifiedVideoSource({final  String? $type}): $type = $type ?? 'unspecified',super._();
  factory UnspecifiedVideoSource.fromJson(Map<String, dynamic> json) => _$UnspecifiedVideoSourceFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnspecifiedVideoSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnspecifiedVideoSource);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VideoSource.unspecified()';
}


}




/// @nodoc
@JsonSerializable()

class CameraVideoSource extends VideoSource {
  const CameraVideoSource({required this.cameraIndex, required this.isFaceFront, final  String? $type}): $type = $type ?? 'camera',super._();
  factory CameraVideoSource.fromJson(Map<String, dynamic> json) => _$CameraVideoSourceFromJson(json);

 final  int cameraIndex;
 final  bool isFaceFront;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraVideoSourceCopyWith<CameraVideoSource> get copyWith => _$CameraVideoSourceCopyWithImpl<CameraVideoSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CameraVideoSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraVideoSource&&(identical(other.cameraIndex, cameraIndex) || other.cameraIndex == cameraIndex)&&(identical(other.isFaceFront, isFaceFront) || other.isFaceFront == isFaceFront));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cameraIndex,isFaceFront);

@override
String toString() {
  return 'VideoSource.camera(cameraIndex: $cameraIndex, isFaceFront: $isFaceFront)';
}


}

/// @nodoc
abstract mixin class $CameraVideoSourceCopyWith<$Res> implements $VideoSourceCopyWith<$Res> {
  factory $CameraVideoSourceCopyWith(CameraVideoSource value, $Res Function(CameraVideoSource) _then) = _$CameraVideoSourceCopyWithImpl;
@useResult
$Res call({
 int cameraIndex, bool isFaceFront
});




}
/// @nodoc
class _$CameraVideoSourceCopyWithImpl<$Res>
    implements $CameraVideoSourceCopyWith<$Res> {
  _$CameraVideoSourceCopyWithImpl(this._self, this._then);

  final CameraVideoSource _self;
  final $Res Function(CameraVideoSource) _then;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cameraIndex = null,Object? isFaceFront = null,}) {
  return _then(CameraVideoSource(
cameraIndex: null == cameraIndex ? _self.cameraIndex : cameraIndex // ignore: cast_nullable_to_non_nullable
as int,isFaceFront: null == isFaceFront ? _self.isFaceFront : isFaceFront // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WebcamVideoSource extends VideoSource {
  const WebcamVideoSource({required this.webcamIndex, final  String? $type}): $type = $type ?? 'webcam',super._();
  factory WebcamVideoSource.fromJson(Map<String, dynamic> json) => _$WebcamVideoSourceFromJson(json);

 final  int webcamIndex;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebcamVideoSourceCopyWith<WebcamVideoSource> get copyWith => _$WebcamVideoSourceCopyWithImpl<WebcamVideoSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebcamVideoSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebcamVideoSource&&(identical(other.webcamIndex, webcamIndex) || other.webcamIndex == webcamIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,webcamIndex);

@override
String toString() {
  return 'VideoSource.webcam(webcamIndex: $webcamIndex)';
}


}

/// @nodoc
abstract mixin class $WebcamVideoSourceCopyWith<$Res> implements $VideoSourceCopyWith<$Res> {
  factory $WebcamVideoSourceCopyWith(WebcamVideoSource value, $Res Function(WebcamVideoSource) _then) = _$WebcamVideoSourceCopyWithImpl;
@useResult
$Res call({
 int webcamIndex
});




}
/// @nodoc
class _$WebcamVideoSourceCopyWithImpl<$Res>
    implements $WebcamVideoSourceCopyWith<$Res> {
  _$WebcamVideoSourceCopyWithImpl(this._self, this._then);

  final WebcamVideoSource _self;
  final $Res Function(WebcamVideoSource) _then;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? webcamIndex = null,}) {
  return _then(WebcamVideoSource(
webcamIndex: null == webcamIndex ? _self.webcamIndex : webcamIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FileVideoSource extends VideoSource {
  const FileVideoSource({required this.path, final  String? $type}): $type = $type ?? 'file',super._();
  factory FileVideoSource.fromJson(Map<String, dynamic> json) => _$FileVideoSourceFromJson(json);

 final  String path;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileVideoSourceCopyWith<FileVideoSource> get copyWith => _$FileVideoSourceCopyWithImpl<FileVideoSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileVideoSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileVideoSource&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'VideoSource.file(path: $path)';
}


}

/// @nodoc
abstract mixin class $FileVideoSourceCopyWith<$Res> implements $VideoSourceCopyWith<$Res> {
  factory $FileVideoSourceCopyWith(FileVideoSource value, $Res Function(FileVideoSource) _then) = _$FileVideoSourceCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$FileVideoSourceCopyWithImpl<$Res>
    implements $FileVideoSourceCopyWith<$Res> {
  _$FileVideoSourceCopyWithImpl(this._self, this._then);

  final FileVideoSource _self;
  final $Res Function(FileVideoSource) _then;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(FileVideoSource(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LiveVideoSource extends VideoSource {
  const LiveVideoSource({required this.url, final  String? $type}): $type = $type ?? 'live',super._();
  factory LiveVideoSource.fromJson(Map<String, dynamic> json) => _$LiveVideoSourceFromJson(json);

 final  String url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveVideoSourceCopyWith<LiveVideoSource> get copyWith => _$LiveVideoSourceCopyWithImpl<LiveVideoSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveVideoSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveVideoSource&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'VideoSource.live(url: $url)';
}


}

/// @nodoc
abstract mixin class $LiveVideoSourceCopyWith<$Res> implements $VideoSourceCopyWith<$Res> {
  factory $LiveVideoSourceCopyWith(LiveVideoSource value, $Res Function(LiveVideoSource) _then) = _$LiveVideoSourceCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$LiveVideoSourceCopyWithImpl<$Res>
    implements $LiveVideoSourceCopyWith<$Res> {
  _$LiveVideoSourceCopyWithImpl(this._self, this._then);

  final LiveVideoSource _self;
  final $Res Function(LiveVideoSource) _then;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(LiveVideoSource(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
