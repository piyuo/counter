// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectMeta _$ProjectMetaFromJson(Map<String, dynamic> json) {
  return _ProjectMeta.fromJson(json);
}

/// @nodoc
mixin _$ProjectMeta {
  String get projectId => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  List<VideoMeta> get videos => throw _privateConstructorUsedError;
  FilterMeta get filter => throw _privateConstructorUsedError;
  bool get isShowCenterRedDotOnTarget => throw _privateConstructorUsedError;
  bool get isShowGhostTarget => throw _privateConstructorUsedError;

  /// Serializes this ProjectMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectMetaCopyWith<ProjectMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectMetaCopyWith<$Res> {
  factory $ProjectMetaCopyWith(
    ProjectMeta value,
    $Res Function(ProjectMeta) then,
  ) = _$ProjectMetaCopyWithImpl<$Res, ProjectMeta>;
  @useResult
  $Res call({
    String projectId,
    String projectName,
    List<VideoMeta> videos,
    FilterMeta filter,
    bool isShowCenterRedDotOnTarget,
    bool isShowGhostTarget,
  });

  $FilterMetaCopyWith<$Res> get filter;
}

/// @nodoc
class _$ProjectMetaCopyWithImpl<$Res, $Val extends ProjectMeta>
    implements $ProjectMetaCopyWith<$Res> {
  _$ProjectMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectName = null,
    Object? videos = null,
    Object? filter = null,
    Object? isShowCenterRedDotOnTarget = null,
    Object? isShowGhostTarget = null,
  }) {
    return _then(
      _value.copyWith(
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            projectName: null == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String,
            videos: null == videos
                ? _value.videos
                : videos // ignore: cast_nullable_to_non_nullable
                      as List<VideoMeta>,
            filter: null == filter
                ? _value.filter
                : filter // ignore: cast_nullable_to_non_nullable
                      as FilterMeta,
            isShowCenterRedDotOnTarget: null == isShowCenterRedDotOnTarget
                ? _value.isShowCenterRedDotOnTarget
                : isShowCenterRedDotOnTarget // ignore: cast_nullable_to_non_nullable
                      as bool,
            isShowGhostTarget: null == isShowGhostTarget
                ? _value.isShowGhostTarget
                : isShowGhostTarget // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of ProjectMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterMetaCopyWith<$Res> get filter {
    return $FilterMetaCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectMetaImplCopyWith<$Res>
    implements $ProjectMetaCopyWith<$Res> {
  factory _$$ProjectMetaImplCopyWith(
    _$ProjectMetaImpl value,
    $Res Function(_$ProjectMetaImpl) then,
  ) = __$$ProjectMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String projectId,
    String projectName,
    List<VideoMeta> videos,
    FilterMeta filter,
    bool isShowCenterRedDotOnTarget,
    bool isShowGhostTarget,
  });

  @override
  $FilterMetaCopyWith<$Res> get filter;
}

/// @nodoc
class __$$ProjectMetaImplCopyWithImpl<$Res>
    extends _$ProjectMetaCopyWithImpl<$Res, _$ProjectMetaImpl>
    implements _$$ProjectMetaImplCopyWith<$Res> {
  __$$ProjectMetaImplCopyWithImpl(
    _$ProjectMetaImpl _value,
    $Res Function(_$ProjectMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectName = null,
    Object? videos = null,
    Object? filter = null,
    Object? isShowCenterRedDotOnTarget = null,
    Object? isShowGhostTarget = null,
  }) {
    return _then(
      _$ProjectMetaImpl(
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        projectName: null == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String,
        videos: null == videos
            ? _value._videos
            : videos // ignore: cast_nullable_to_non_nullable
                  as List<VideoMeta>,
        filter: null == filter
            ? _value.filter
            : filter // ignore: cast_nullable_to_non_nullable
                  as FilterMeta,
        isShowCenterRedDotOnTarget: null == isShowCenterRedDotOnTarget
            ? _value.isShowCenterRedDotOnTarget
            : isShowCenterRedDotOnTarget // ignore: cast_nullable_to_non_nullable
                  as bool,
        isShowGhostTarget: null == isShowGhostTarget
            ? _value.isShowGhostTarget
            : isShowGhostTarget // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProjectMetaImpl implements _ProjectMeta {
  const _$ProjectMetaImpl({
    required this.projectId,
    required this.projectName,
    required final List<VideoMeta> videos,
    required this.filter,
    required this.isShowCenterRedDotOnTarget,
    required this.isShowGhostTarget,
  }) : _videos = videos;

  factory _$ProjectMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectMetaImplFromJson(json);

  @override
  final String projectId;
  @override
  final String projectName;
  final List<VideoMeta> _videos;
  @override
  List<VideoMeta> get videos {
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  @override
  final FilterMeta filter;
  @override
  final bool isShowCenterRedDotOnTarget;
  @override
  final bool isShowGhostTarget;

  @override
  String toString() {
    return 'ProjectMeta(projectId: $projectId, projectName: $projectName, videos: $videos, filter: $filter, isShowCenterRedDotOnTarget: $isShowCenterRedDotOnTarget, isShowGhostTarget: $isShowGhostTarget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectMetaImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(
                  other.isShowCenterRedDotOnTarget,
                  isShowCenterRedDotOnTarget,
                ) ||
                other.isShowCenterRedDotOnTarget ==
                    isShowCenterRedDotOnTarget) &&
            (identical(other.isShowGhostTarget, isShowGhostTarget) ||
                other.isShowGhostTarget == isShowGhostTarget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    projectId,
    projectName,
    const DeepCollectionEquality().hash(_videos),
    filter,
    isShowCenterRedDotOnTarget,
    isShowGhostTarget,
  );

  /// Create a copy of ProjectMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectMetaImplCopyWith<_$ProjectMetaImpl> get copyWith =>
      __$$ProjectMetaImplCopyWithImpl<_$ProjectMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectMetaImplToJson(this);
  }
}

abstract class _ProjectMeta implements ProjectMeta {
  const factory _ProjectMeta({
    required final String projectId,
    required final String projectName,
    required final List<VideoMeta> videos,
    required final FilterMeta filter,
    required final bool isShowCenterRedDotOnTarget,
    required final bool isShowGhostTarget,
  }) = _$ProjectMetaImpl;

  factory _ProjectMeta.fromJson(Map<String, dynamic> json) =
      _$ProjectMetaImpl.fromJson;

  @override
  String get projectId;
  @override
  String get projectName;
  @override
  List<VideoMeta> get videos;
  @override
  FilterMeta get filter;
  @override
  bool get isShowCenterRedDotOnTarget;
  @override
  bool get isShowGhostTarget;

  /// Create a copy of ProjectMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectMetaImplCopyWith<_$ProjectMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
