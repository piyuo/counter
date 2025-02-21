// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'annotation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Annotation _$AnnotationFromJson(Map<String, dynamic> json) {
  return _Annotation.fromJson(json);
}

/// @nodoc
mixin _$Annotation {
  TallyType get type => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get prefix => throw _privateConstructorUsedError;
  String get suffix => throw _privateConstructorUsedError;

  /// Serializes this Annotation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Annotation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnotationCopyWith<Annotation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnotationCopyWith<$Res> {
  factory $AnnotationCopyWith(
          Annotation value, $Res Function(Annotation) then) =
      _$AnnotationCopyWithImpl<$Res, Annotation>;
  @useResult
  $Res call(
      {TallyType type,
      bool enabled,
      String title,
      String prefix,
      String suffix});
}

/// @nodoc
class _$AnnotationCopyWithImpl<$Res, $Val extends Annotation>
    implements $AnnotationCopyWith<$Res> {
  _$AnnotationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Annotation
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
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnnotationImplCopyWith<$Res>
    implements $AnnotationCopyWith<$Res> {
  factory _$$AnnotationImplCopyWith(
          _$AnnotationImpl value, $Res Function(_$AnnotationImpl) then) =
      __$$AnnotationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TallyType type,
      bool enabled,
      String title,
      String prefix,
      String suffix});
}

/// @nodoc
class __$$AnnotationImplCopyWithImpl<$Res>
    extends _$AnnotationCopyWithImpl<$Res, _$AnnotationImpl>
    implements _$$AnnotationImplCopyWith<$Res> {
  __$$AnnotationImplCopyWithImpl(
      _$AnnotationImpl _value, $Res Function(_$AnnotationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Annotation
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
    return _then(_$AnnotationImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnotationImpl implements _Annotation {
  const _$AnnotationImpl(
      {required this.type,
      required this.enabled,
      required this.title,
      required this.prefix,
      required this.suffix});

  factory _$AnnotationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnotationImplFromJson(json);

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
    return 'Annotation(type: $type, enabled: $enabled, title: $title, prefix: $prefix, suffix: $suffix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnotationImpl &&
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

  /// Create a copy of Annotation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnotationImplCopyWith<_$AnnotationImpl> get copyWith =>
      __$$AnnotationImplCopyWithImpl<_$AnnotationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnotationImplToJson(
      this,
    );
  }
}

abstract class _Annotation implements Annotation {
  const factory _Annotation(
      {required final TallyType type,
      required final bool enabled,
      required final String title,
      required final String prefix,
      required final String suffix}) = _$AnnotationImpl;

  factory _Annotation.fromJson(Map<String, dynamic> json) =
      _$AnnotationImpl.fromJson;

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

  /// Create a copy of Annotation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnotationImplCopyWith<_$AnnotationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
