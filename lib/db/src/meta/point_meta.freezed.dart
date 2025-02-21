// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PointMeta _$PointMetaFromJson(Map<String, dynamic> json) {
  return _PointMeta.fromJson(json);
}

/// @nodoc
mixin _$PointMeta {
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;

  /// Serializes this PointMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointMetaCopyWith<PointMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointMetaCopyWith<$Res> {
  factory $PointMetaCopyWith(PointMeta value, $Res Function(PointMeta) then) =
      _$PointMetaCopyWithImpl<$Res, PointMeta>;
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class _$PointMetaCopyWithImpl<$Res, $Val extends PointMeta>
    implements $PointMetaCopyWith<$Res> {
  _$PointMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointMetaImplCopyWith<$Res>
    implements $PointMetaCopyWith<$Res> {
  factory _$$PointMetaImplCopyWith(
          _$PointMetaImpl value, $Res Function(_$PointMetaImpl) then) =
      __$$PointMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int x, int y});
}

/// @nodoc
class __$$PointMetaImplCopyWithImpl<$Res>
    extends _$PointMetaCopyWithImpl<$Res, _$PointMetaImpl>
    implements _$$PointMetaImplCopyWith<$Res> {
  __$$PointMetaImplCopyWithImpl(
      _$PointMetaImpl _value, $Res Function(_$PointMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of PointMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$PointMetaImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointMetaImpl implements _PointMeta {
  const _$PointMetaImpl({required this.x, required this.y});

  factory _$PointMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointMetaImplFromJson(json);

  @override
  final int x;
  @override
  final int y;

  @override
  String toString() {
    return 'PointMeta(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointMetaImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  /// Create a copy of PointMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointMetaImplCopyWith<_$PointMetaImpl> get copyWith =>
      __$$PointMetaImplCopyWithImpl<_$PointMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointMetaImplToJson(
      this,
    );
  }
}

abstract class _PointMeta implements PointMeta {
  const factory _PointMeta({required final int x, required final int y}) =
      _$PointMetaImpl;

  factory _PointMeta.fromJson(Map<String, dynamic> json) =
      _$PointMetaImpl.fromJson;

  @override
  int get x;
  @override
  int get y;

  /// Create a copy of PointMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointMetaImplCopyWith<_$PointMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
