// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'annotation_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnnotationMeta _$AnnotationMetaFromJson(Map<String, dynamic> json) {
  return _AnnotationMeta.fromJson(json);
}

/// @nodoc
mixin _$AnnotationMeta {
  TallyType get type => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get prefix => throw _privateConstructorUsedError;
  String get suffix => throw _privateConstructorUsedError;

  /// Serializes this AnnotationMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnnotationMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnotationMetaCopyWith<AnnotationMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnotationMetaCopyWith<$Res> {
  factory $AnnotationMetaCopyWith(
    AnnotationMeta value,
    $Res Function(AnnotationMeta) then,
  ) = _$AnnotationMetaCopyWithImpl<$Res, AnnotationMeta>;
  @useResult
  $Res call({
    TallyType type,
    bool enabled,
    String title,
    String prefix,
    String suffix,
  });
}

/// @nodoc
class _$AnnotationMetaCopyWithImpl<$Res, $Val extends AnnotationMeta>
    implements $AnnotationMetaCopyWith<$Res> {
  _$AnnotationMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnotationMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? enabled = null,
    Object? title = null,
    Object? prefix = null,
    Object? suffix = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TallyType,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            prefix: null == prefix
                ? _value.prefix
                : prefix // ignore: cast_nullable_to_non_nullable
                      as String,
            suffix: null == suffix
                ? _value.suffix
                : suffix // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnnotationMetaImplCopyWith<$Res>
    implements $AnnotationMetaCopyWith<$Res> {
  factory _$$AnnotationMetaImplCopyWith(
    _$AnnotationMetaImpl value,
    $Res Function(_$AnnotationMetaImpl) then,
  ) = __$$AnnotationMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TallyType type,
    bool enabled,
    String title,
    String prefix,
    String suffix,
  });
}

/// @nodoc
class __$$AnnotationMetaImplCopyWithImpl<$Res>
    extends _$AnnotationMetaCopyWithImpl<$Res, _$AnnotationMetaImpl>
    implements _$$AnnotationMetaImplCopyWith<$Res> {
  __$$AnnotationMetaImplCopyWithImpl(
    _$AnnotationMetaImpl _value,
    $Res Function(_$AnnotationMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnnotationMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? enabled = null,
    Object? title = null,
    Object? prefix = null,
    Object? suffix = null,
  }) {
    return _then(
      _$AnnotationMetaImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TallyType,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        prefix: null == prefix
            ? _value.prefix
            : prefix // ignore: cast_nullable_to_non_nullable
                  as String,
        suffix: null == suffix
            ? _value.suffix
            : suffix // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnotationMetaImpl implements _AnnotationMeta {
  const _$AnnotationMetaImpl({
    required this.type,
    required this.enabled,
    required this.title,
    required this.prefix,
    required this.suffix,
  });

  factory _$AnnotationMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnotationMetaImplFromJson(json);

  @override
  final TallyType type;
  @override
  final bool enabled;
  @override
  final String title;
  @override
  final String prefix;
  @override
  final String suffix;

  @override
  String toString() {
    return 'AnnotationMeta(type: $type, enabled: $enabled, title: $title, prefix: $prefix, suffix: $suffix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnotationMetaImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.suffix, suffix) || other.suffix == suffix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, enabled, title, prefix, suffix);

  /// Create a copy of AnnotationMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnotationMetaImplCopyWith<_$AnnotationMetaImpl> get copyWith =>
      __$$AnnotationMetaImplCopyWithImpl<_$AnnotationMetaImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnotationMetaImplToJson(this);
  }
}

abstract class _AnnotationMeta implements AnnotationMeta {
  const factory _AnnotationMeta({
    required final TallyType type,
    required final bool enabled,
    required final String title,
    required final String prefix,
    required final String suffix,
  }) = _$AnnotationMetaImpl;

  factory _AnnotationMeta.fromJson(Map<String, dynamic> json) =
      _$AnnotationMetaImpl.fromJson;

  @override
  TallyType get type;
  @override
  bool get enabled;
  @override
  String get title;
  @override
  String get prefix;
  @override
  String get suffix;

  /// Create a copy of AnnotationMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnotationMetaImplCopyWith<_$AnnotationMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
