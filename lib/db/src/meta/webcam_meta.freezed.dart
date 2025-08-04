// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webcam_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WebcamMeta _$WebcamMetaFromJson(Map<String, dynamic> json) {
  return _WebcamMeta.fromJson(json);
}

/// @nodoc
mixin _$WebcamMeta {
  int get index => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this WebcamMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebcamMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebcamMetaCopyWith<WebcamMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebcamMetaCopyWith<$Res> {
  factory $WebcamMetaCopyWith(
    WebcamMeta value,
    $Res Function(WebcamMeta) then,
  ) = _$WebcamMetaCopyWithImpl<$Res, WebcamMeta>;
  @useResult
  $Res call({int index, String name});
}

/// @nodoc
class _$WebcamMetaCopyWithImpl<$Res, $Val extends WebcamMeta>
    implements $WebcamMetaCopyWith<$Res> {
  _$WebcamMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebcamMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? index = null, Object? name = null}) {
    return _then(
      _value.copyWith(
            index: null == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebcamMetaImplCopyWith<$Res>
    implements $WebcamMetaCopyWith<$Res> {
  factory _$$WebcamMetaImplCopyWith(
    _$WebcamMetaImpl value,
    $Res Function(_$WebcamMetaImpl) then,
  ) = __$$WebcamMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, String name});
}

/// @nodoc
class __$$WebcamMetaImplCopyWithImpl<$Res>
    extends _$WebcamMetaCopyWithImpl<$Res, _$WebcamMetaImpl>
    implements _$$WebcamMetaImplCopyWith<$Res> {
  __$$WebcamMetaImplCopyWithImpl(
    _$WebcamMetaImpl _value,
    $Res Function(_$WebcamMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WebcamMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? index = null, Object? name = null}) {
    return _then(
      _$WebcamMetaImpl(
        index: null == index
            ? _value.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WebcamMetaImpl implements _WebcamMeta {
  const _$WebcamMetaImpl({required this.index, required this.name});

  factory _$WebcamMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebcamMetaImplFromJson(json);

  @override
  final int index;
  @override
  final String name;

  @override
  String toString() {
    return 'WebcamMeta(index: $index, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebcamMetaImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, name);

  /// Create a copy of WebcamMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebcamMetaImplCopyWith<_$WebcamMetaImpl> get copyWith =>
      __$$WebcamMetaImplCopyWithImpl<_$WebcamMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebcamMetaImplToJson(this);
  }
}

abstract class _WebcamMeta implements WebcamMeta {
  const factory _WebcamMeta({
    required final int index,
    required final String name,
  }) = _$WebcamMetaImpl;

  factory _WebcamMeta.fromJson(Map<String, dynamic> json) =
      _$WebcamMetaImpl.fromJson;

  @override
  int get index;
  @override
  String get name;

  /// Create a copy of WebcamMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebcamMetaImplCopyWith<_$WebcamMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
