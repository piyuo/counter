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
  SourceType get mediaType => throw _privateConstructorUsedError;
  String get videoName => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  CameraMeta? get camera => throw _privateConstructorUsedError;
  WebcamMeta? get webcam => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  double get nms => throw _privateConstructorUsedError;
  double get match => throw _privateConstructorUsedError;
  double get minLostSeconds => throw _privateConstructorUsedError;
  double get maxLostSeconds => throw _privateConstructorUsedError;
  int get valid => throw _privateConstructorUsedError;
  double get tracking => throw _privateConstructorUsedError;
  Models get model => throw _privateConstructorUsedError;
  List<int> get objectClasses => throw _privateConstructorUsedError;
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
      SourceType mediaType,
      String videoName,
      String? path,
      CameraMeta? camera,
      WebcamMeta? webcam,
      double confidence,
      double nms,
      double match,
      double minLostSeconds,
      double maxLostSeconds,
      int valid,
      double tracking,
      Models model,
      List<int> objectClasses,
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
    Object? confidence = null,
    Object? nms = null,
    Object? match = null,
    Object? minLostSeconds = null,
    Object? maxLostSeconds = null,
    Object? valid = null,
    Object? tracking = null,
    Object? model = null,
    Object? objectClasses = null,
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
              as SourceType,
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
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      nms: null == nms
          ? _value.nms
          : nms // ignore: cast_nullable_to_non_nullable
              as double,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as double,
      minLostSeconds: null == minLostSeconds
          ? _value.minLostSeconds
          : minLostSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      maxLostSeconds: null == maxLostSeconds
          ? _value.maxLostSeconds
          : maxLostSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as int,
      tracking: null == tracking
          ? _value.tracking
          : tracking // ignore: cast_nullable_to_non_nullable
              as double,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Models,
      objectClasses: null == objectClasses
          ? _value.objectClasses
          : objectClasses // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
      SourceType mediaType,
      String videoName,
      String? path,
      CameraMeta? camera,
      WebcamMeta? webcam,
      double confidence,
      double nms,
      double match,
      double minLostSeconds,
      double maxLostSeconds,
      int valid,
      double tracking,
      Models model,
      List<int> objectClasses,
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
    Object? confidence = null,
    Object? nms = null,
    Object? match = null,
    Object? minLostSeconds = null,
    Object? maxLostSeconds = null,
    Object? valid = null,
    Object? tracking = null,
    Object? model = null,
    Object? objectClasses = null,
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
              as SourceType,
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
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      nms: null == nms
          ? _value.nms
          : nms // ignore: cast_nullable_to_non_nullable
              as double,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as double,
      minLostSeconds: null == minLostSeconds
          ? _value.minLostSeconds
          : minLostSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      maxLostSeconds: null == maxLostSeconds
          ? _value.maxLostSeconds
          : maxLostSeconds // ignore: cast_nullable_to_non_nullable
              as double,
      valid: null == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as int,
      tracking: null == tracking
          ? _value.tracking
          : tracking // ignore: cast_nullable_to_non_nullable
              as double,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Models,
      objectClasses: null == objectClasses
          ? _value._objectClasses
          : objectClasses // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
      required this.confidence,
      required this.nms,
      required this.match,
      this.minLostSeconds = 0.0,
      required this.maxLostSeconds,
      required this.valid,
      required this.tracking,
      required this.model,
      required final List<int> objectClasses,
      required this.zoom,
      required final List<ZoneMeta> zones})
      : _objectClasses = objectClasses,
        _zones = zones;

  factory _$VideoMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoMetaImplFromJson(json);

  @override
  final int videoId;
  @override
  final SourceType mediaType;
  @override
  final String videoName;
  @override
  final String? path;
  @override
  final CameraMeta? camera;
  @override
  final WebcamMeta? webcam;
  @override
  final double confidence;
  @override
  final double nms;
  @override
  final double match;
  @override
  @JsonKey()
  final double minLostSeconds;
  @override
  final double maxLostSeconds;
  @override
  final int valid;
  @override
  final double tracking;
  @override
  final Models model;
  final List<int> _objectClasses;
  @override
  List<int> get objectClasses {
    if (_objectClasses is EqualUnmodifiableListView) return _objectClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectClasses);
  }

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
    return 'VideoMeta(videoId: $videoId, mediaType: $mediaType, videoName: $videoName, path: $path, camera: $camera, webcam: $webcam, confidence: $confidence, nms: $nms, match: $match, minLostSeconds: $minLostSeconds, maxLostSeconds: $maxLostSeconds, valid: $valid, tracking: $tracking, model: $model, objectClasses: $objectClasses, zoom: $zoom, zones: $zones)';
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
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.nms, nms) || other.nms == nms) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(other.minLostSeconds, minLostSeconds) ||
                other.minLostSeconds == minLostSeconds) &&
            (identical(other.maxLostSeconds, maxLostSeconds) ||
                other.maxLostSeconds == maxLostSeconds) &&
            (identical(other.valid, valid) || other.valid == valid) &&
            (identical(other.tracking, tracking) ||
                other.tracking == tracking) &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality()
                .equals(other._objectClasses, _objectClasses) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            const DeepCollectionEquality().equals(other._zones, _zones));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      videoId,
      mediaType,
      videoName,
      path,
      camera,
      webcam,
      confidence,
      nms,
      match,
      minLostSeconds,
      maxLostSeconds,
      valid,
      tracking,
      model,
      const DeepCollectionEquality().hash(_objectClasses),
      zoom,
      const DeepCollectionEquality().hash(_zones));

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
      required final SourceType mediaType,
      required final String videoName,
      required final String? path,
      required final CameraMeta? camera,
      required final WebcamMeta? webcam,
      required final double confidence,
      required final double nms,
      required final double match,
      final double minLostSeconds,
      required final double maxLostSeconds,
      required final int valid,
      required final double tracking,
      required final Models model,
      required final List<int> objectClasses,
      required final double zoom,
      required final List<ZoneMeta> zones}) = _$VideoMetaImpl;

  factory _VideoMeta.fromJson(Map<String, dynamic> json) =
      _$VideoMetaImpl.fromJson;

  @override
  int get videoId;
  @override
  SourceType get mediaType;
  @override
  String get videoName;
  @override
  String? get path;
  @override
  CameraMeta? get camera;
  @override
  WebcamMeta? get webcam;
  @override
  double get confidence;
  @override
  double get nms;
  @override
  double get match;
  @override
  double get minLostSeconds;
  @override
  double get maxLostSeconds;
  @override
  int get valid;
  @override
  double get tracking;
  @override
  Models get model;
  @override
  List<int> get objectClasses;
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
