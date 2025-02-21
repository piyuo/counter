// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterMeta _$FilterMetaFromJson(Map<String, dynamic> json) {
  return _FilterMeta.fromJson(json);
}

/// @nodoc
mixin _$FilterMeta {
  FilterType get type => throw _privateConstructorUsedError;
  TimeOfDayMeta get start => throw _privateConstructorUsedError;
  TimeOfDayMeta get end => throw _privateConstructorUsedError;

  /// Serializes this FilterMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterMetaCopyWith<FilterMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterMetaCopyWith<$Res> {
  factory $FilterMetaCopyWith(
          FilterMeta value, $Res Function(FilterMeta) then) =
      _$FilterMetaCopyWithImpl<$Res, FilterMeta>;
  @useResult
  $Res call({FilterType type, TimeOfDayMeta start, TimeOfDayMeta end});

  $TimeOfDayMetaCopyWith<$Res> get start;
  $TimeOfDayMetaCopyWith<$Res> get end;
}

/// @nodoc
class _$FilterMetaCopyWithImpl<$Res, $Val extends FilterMeta>
    implements $FilterMetaCopyWith<$Res> {
  _$FilterMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDayMeta,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDayMeta,
    ) as $Val);
  }

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayMetaCopyWith<$Res> get start {
    return $TimeOfDayMetaCopyWith<$Res>(_value.start, (value) {
      return _then(_value.copyWith(start: value) as $Val);
    });
  }

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeOfDayMetaCopyWith<$Res> get end {
    return $TimeOfDayMetaCopyWith<$Res>(_value.end, (value) {
      return _then(_value.copyWith(end: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilterMetaImplCopyWith<$Res>
    implements $FilterMetaCopyWith<$Res> {
  factory _$$FilterMetaImplCopyWith(
          _$FilterMetaImpl value, $Res Function(_$FilterMetaImpl) then) =
      __$$FilterMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FilterType type, TimeOfDayMeta start, TimeOfDayMeta end});

  @override
  $TimeOfDayMetaCopyWith<$Res> get start;
  @override
  $TimeOfDayMetaCopyWith<$Res> get end;
}

/// @nodoc
class __$$FilterMetaImplCopyWithImpl<$Res>
    extends _$FilterMetaCopyWithImpl<$Res, _$FilterMetaImpl>
    implements _$$FilterMetaImplCopyWith<$Res> {
  __$$FilterMetaImplCopyWithImpl(
      _$FilterMetaImpl _value, $Res Function(_$FilterMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$FilterMetaImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterType,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as TimeOfDayMeta,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as TimeOfDayMeta,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FilterMetaImpl implements _FilterMeta {
  const _$FilterMetaImpl(
      {required this.type, required this.start, required this.end});

  factory _$FilterMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterMetaImplFromJson(json);

  @override
  final FilterType type;
  @override
  final TimeOfDayMeta start;
  @override
  final TimeOfDayMeta end;

  @override
  String toString() {
    return 'FilterMeta(type: $type, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterMetaImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, start, end);

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterMetaImplCopyWith<_$FilterMetaImpl> get copyWith =>
      __$$FilterMetaImplCopyWithImpl<_$FilterMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterMetaImplToJson(
      this,
    );
  }
}

abstract class _FilterMeta implements FilterMeta {
  const factory _FilterMeta(
      {required final FilterType type,
      required final TimeOfDayMeta start,
      required final TimeOfDayMeta end}) = _$FilterMetaImpl;

  factory _FilterMeta.fromJson(Map<String, dynamic> json) =
      _$FilterMetaImpl.fromJson;

  @override
  FilterType get type;
  @override
  TimeOfDayMeta get start;
  @override
  TimeOfDayMeta get end;

  /// Create a copy of FilterMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterMetaImplCopyWith<_$FilterMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
