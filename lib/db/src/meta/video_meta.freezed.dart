// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoMeta _$VideoMetaFromJson(Map<String, dynamic> json) {
  return _VideoMeta.fromJson(json);
}

/// @nodoc
mixin _$VideoMeta {
  int get videoId => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  String get videoName => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  CameraMeta? get camera => throw _privateConstructorUsedError;
  WebcamMeta? get webcam => throw _privateConstructorUsedError;
  double get zoom => throw _privateConstructorUsedError;
  List<ZoneMeta> get zones => throw _privateConstructorUsedError;

  /// Serializes this VideoMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoMetaCopyWith<VideoMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoMetaCopyWith<$Res> {
  factory $VideoMetaCopyWith(VideoMeta value, $Res Function(VideoMeta) then) =
      _$VideoMetaCopyWithImpl<$Res, VideoMeta>;
  @useResult
  $Res call(
      {int videoId,
      MediaType mediaType,
      String videoName,
      String? path,
      CameraMeta? camera,
      WebcamMeta? webcam,
      double zoom,
      List<ZoneMeta> zones});

  $CameraMetaCopyWith<$Res>? get camera;
  $WebcamMetaCopyWith<$Res>? get webcam;
}

/// @nodoc
class _$VideoMetaCopyWithImpl<$Res, $Val extends VideoMeta>
    implements $VideoMetaCopyWith<$Res> {
  _$VideoMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? mediaType = null,
    Object? videoName = null,
    Object? path = freezed,
    Object? camera = freezed,
    Object? webcam = freezed,
    Object? zoom = null,
    Object? zones = null,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      videoName: null == videoName
          ? _value.videoName
          : videoName // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      camera: freezed == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as CameraMeta?,
      webcam: freezed == webcam
          ? _value.webcam
          : webcam // ignore: cast_nullable_to_non_nullable
              as WebcamMeta?,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      zones: null == zones
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<ZoneMeta>,
    ) as $Val);
  }

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CameraMetaCopyWith<$Res>? get camera {
    if (_value.camera == null) {
      return null;
    }

    return $CameraMetaCopyWith<$Res>(_value.camera!, (value) {
      return _then(_value.copyWith(camera: value) as $Val);
    });
  }

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebcamMetaCopyWith<$Res>? get webcam {
    if (_value.webcam == null) {
      return null;
    }

    return $WebcamMetaCopyWith<$Res>(_value.webcam!, (value) {
      return _then(_value.copyWith(webcam: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VideoMetaImplCopyWith<$Res>
    implements $VideoMetaCopyWith<$Res> {
  factory _$$VideoMetaImplCopyWith(
          _$VideoMetaImpl value, $Res Function(_$VideoMetaImpl) then) =
      __$$VideoMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int videoId,
      MediaType mediaType,
      String videoName,
      String? path,
      CameraMeta? camera,
      WebcamMeta? webcam,
      double zoom,
      List<ZoneMeta> zones});

  @override
  $CameraMetaCopyWith<$Res>? get camera;
  @override
  $WebcamMetaCopyWith<$Res>? get webcam;
}

/// @nodoc
class __$$VideoMetaImplCopyWithImpl<$Res>
    extends _$VideoMetaCopyWithImpl<$Res, _$VideoMetaImpl>
    implements _$$VideoMetaImplCopyWith<$Res> {
  __$$VideoMetaImplCopyWithImpl(
      _$VideoMetaImpl _value, $Res Function(_$VideoMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? mediaType = null,
    Object? videoName = null,
    Object? path = freezed,
    Object? camera = freezed,
    Object? webcam = freezed,
    Object? zoom = null,
    Object? zones = null,
  }) {
    return _then(_$VideoMetaImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      videoName: null == videoName
          ? _value.videoName
          : videoName // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      camera: freezed == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as CameraMeta?,
      webcam: freezed == webcam
          ? _value.webcam
          : webcam // ignore: cast_nullable_to_non_nullable
              as WebcamMeta?,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      zones: null == zones
          ? _value._zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<ZoneMeta>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$VideoMetaImpl implements _VideoMeta {
  const _$VideoMetaImpl(
      {required this.videoId,
      required this.mediaType,
      required this.videoName,
      required this.path,
      required this.camera,
      required this.webcam,
      required this.zoom,
      required final List<ZoneMeta> zones})
      : _zones = zones;

  factory _$VideoMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoMetaImplFromJson(json);

  @override
  final int videoId;
  @override
  final MediaType mediaType;
  @override
  final String videoName;
  @override
  final String? path;
  @override
  final CameraMeta? camera;
  @override
  final WebcamMeta? webcam;
  @override
  final double zoom;
  final List<ZoneMeta> _zones;
  @override
  List<ZoneMeta> get zones {
    if (_zones is EqualUnmodifiableListView) return _zones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_zones);
  }

  @override
  String toString() {
    return 'VideoMeta(videoId: $videoId, mediaType: $mediaType, videoName: $videoName, path: $path, camera: $camera, webcam: $webcam, zoom: $zoom, zones: $zones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoMetaImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.videoName, videoName) ||
                other.videoName == videoName) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.camera, camera) || other.camera == camera) &&
            (identical(other.webcam, webcam) || other.webcam == webcam) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            const DeepCollectionEquality().equals(other._zones, _zones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, videoId, mediaType, videoName,
      path, camera, webcam, zoom, const DeepCollectionEquality().hash(_zones));

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoMetaImplCopyWith<_$VideoMetaImpl> get copyWith =>
      __$$VideoMetaImplCopyWithImpl<_$VideoMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoMetaImplToJson(
      this,
    );
  }
}

abstract class _VideoMeta implements VideoMeta {
  const factory _VideoMeta(
      {required final int videoId,
      required final MediaType mediaType,
      required final String videoName,
      required final String? path,
      required final CameraMeta? camera,
      required final WebcamMeta? webcam,
      required final double zoom,
      required final List<ZoneMeta> zones}) = _$VideoMetaImpl;

  factory _VideoMeta.fromJson(Map<String, dynamic> json) =
      _$VideoMetaImpl.fromJson;

  @override
  int get videoId;
  @override
  MediaType get mediaType;
  @override
  String get videoName;
  @override
  String? get path;
  @override
  CameraMeta? get camera;
  @override
  WebcamMeta? get webcam;
  @override
  double get zoom;
  @override
  List<ZoneMeta> get zones;

  /// Create a copy of VideoMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoMetaImplCopyWith<_$VideoMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
