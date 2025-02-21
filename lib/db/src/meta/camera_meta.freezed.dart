// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CameraMeta _$CameraMetaFromJson(Map<String, dynamic> json) {
  return _CameraMeta.fromJson(json);
}

/// @nodoc
mixin _$CameraMeta {
  String get name => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isFront => throw _privateConstructorUsedError;

  /// Serializes this CameraMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CameraMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CameraMetaCopyWith<CameraMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraMetaCopyWith<$Res> {
  factory $CameraMetaCopyWith(
          CameraMeta value, $Res Function(CameraMeta) then) =
      _$CameraMetaCopyWithImpl<$Res, CameraMeta>;
  @useResult
  $Res call({String name, String title, bool isFront});
}

/// @nodoc
class _$CameraMetaCopyWithImpl<$Res, $Val extends CameraMeta>
    implements $CameraMetaCopyWith<$Res> {
  _$CameraMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CameraMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? title = null,
    Object? isFront = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isFront: null == isFront
          ? _value.isFront
          : isFront // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CameraMetaImplCopyWith<$Res>
    implements $CameraMetaCopyWith<$Res> {
  factory _$$CameraMetaImplCopyWith(
          _$CameraMetaImpl value, $Res Function(_$CameraMetaImpl) then) =
      __$$CameraMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String title, bool isFront});
}

/// @nodoc
class __$$CameraMetaImplCopyWithImpl<$Res>
    extends _$CameraMetaCopyWithImpl<$Res, _$CameraMetaImpl>
    implements _$$CameraMetaImplCopyWith<$Res> {
  __$$CameraMetaImplCopyWithImpl(
      _$CameraMetaImpl _value, $Res Function(_$CameraMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? title = null,
    Object? isFront = null,
  }) {
    return _then(_$CameraMetaImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isFront: null == isFront
          ? _value.isFront
          : isFront // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CameraMetaImpl implements _CameraMeta {
  const _$CameraMetaImpl(
      {required this.name, required this.title, required this.isFront});

  factory _$CameraMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CameraMetaImplFromJson(json);

  @override
  final String name;
  @override
  final String title;
  @override
  final bool isFront;

  @override
  String toString() {
    return 'CameraMeta(name: $name, title: $title, isFront: $isFront)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraMetaImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isFront, isFront) || other.isFront == isFront));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, title, isFront);

  /// Create a copy of CameraMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraMetaImplCopyWith<_$CameraMetaImpl> get copyWith =>
      __$$CameraMetaImplCopyWithImpl<_$CameraMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CameraMetaImplToJson(
      this,
    );
  }
}

abstract class _CameraMeta implements CameraMeta {
  const factory _CameraMeta(
      {required final String name,
      required final String title,
      required final bool isFront}) = _$CameraMetaImpl;

  factory _CameraMeta.fromJson(Map<String, dynamic> json) =
      _$CameraMetaImpl.fromJson;

  @override
  String get name;
  @override
  String get title;
  @override
  bool get isFront;

  /// Create a copy of CameraMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraMetaImplCopyWith<_$CameraMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
