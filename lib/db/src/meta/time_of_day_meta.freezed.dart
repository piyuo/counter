// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_of_day_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeOfDayMeta _$TimeOfDayMetaFromJson(Map<String, dynamic> json) {
  return _TimeOfDayMeta.fromJson(json);
}

/// @nodoc
mixin _$TimeOfDayMeta {
  int get hour => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;

  /// Serializes this TimeOfDayMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeOfDayMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeOfDayMetaCopyWith<TimeOfDayMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeOfDayMetaCopyWith<$Res> {
  factory $TimeOfDayMetaCopyWith(
          TimeOfDayMeta value, $Res Function(TimeOfDayMeta) then) =
      _$TimeOfDayMetaCopyWithImpl<$Res, TimeOfDayMeta>;
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class _$TimeOfDayMetaCopyWithImpl<$Res, $Val extends TimeOfDayMeta>
    implements $TimeOfDayMetaCopyWith<$Res> {
  _$TimeOfDayMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeOfDayMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeOfDayMetaImplCopyWith<$Res>
    implements $TimeOfDayMetaCopyWith<$Res> {
  factory _$$TimeOfDayMetaImplCopyWith(
          _$TimeOfDayMetaImpl value, $Res Function(_$TimeOfDayMetaImpl) then) =
      __$$TimeOfDayMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class __$$TimeOfDayMetaImplCopyWithImpl<$Res>
    extends _$TimeOfDayMetaCopyWithImpl<$Res, _$TimeOfDayMetaImpl>
    implements _$$TimeOfDayMetaImplCopyWith<$Res> {
  __$$TimeOfDayMetaImplCopyWithImpl(
      _$TimeOfDayMetaImpl _value, $Res Function(_$TimeOfDayMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeOfDayMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_$TimeOfDayMetaImpl(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeOfDayMetaImpl implements _TimeOfDayMeta {
  const _$TimeOfDayMetaImpl({required this.hour, required this.minute});

  factory _$TimeOfDayMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeOfDayMetaImplFromJson(json);

  @override
  final int hour;
  @override
  final int minute;

  @override
  String toString() {
    return 'TimeOfDayMeta(hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeOfDayMetaImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  /// Create a copy of TimeOfDayMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeOfDayMetaImplCopyWith<_$TimeOfDayMetaImpl> get copyWith =>
      __$$TimeOfDayMetaImplCopyWithImpl<_$TimeOfDayMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeOfDayMetaImplToJson(
      this,
    );
  }
}

abstract class _TimeOfDayMeta implements TimeOfDayMeta {
  const factory _TimeOfDayMeta(
      {required final int hour,
      required final int minute}) = _$TimeOfDayMetaImpl;

  factory _TimeOfDayMeta.fromJson(Map<String, dynamic> json) =
      _$TimeOfDayMetaImpl.fromJson;

  @override
  int get hour;
  @override
  int get minute;

  /// Create a copy of TimeOfDayMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeOfDayMetaImplCopyWith<_$TimeOfDayMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
