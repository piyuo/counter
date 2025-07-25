// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zone_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ZoneMeta _$ZoneMetaFromJson(Map<String, dynamic> json) {
  return _ZoneMeta.fromJson(json);
}

/// @nodoc
mixin _$ZoneMeta {
  int get zoneId => throw _privateConstructorUsedError;
  bool get showSummaryOnScreen => throw _privateConstructorUsedError;
  List<AnnotationMeta> get annotations => throw _privateConstructorUsedError;
  String get zoneName => throw _privateConstructorUsedError;
  List<PointMeta> get points => throw _privateConstructorUsedError;
  int get pointIndex => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get color => throw _privateConstructorUsedError;
  int get stagnant => throw _privateConstructorUsedError;
  int get reentered => throw _privateConstructorUsedError;
  int get crossedZones => throw _privateConstructorUsedError;
  int get cooldown => throw _privateConstructorUsedError;
  bool get ignoreIfCounted => throw _privateConstructorUsedError;

  /// Serializes this ZoneMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ZoneMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ZoneMetaCopyWith<ZoneMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneMetaCopyWith<$Res> {
  factory $ZoneMetaCopyWith(ZoneMeta value, $Res Function(ZoneMeta) then) =
      _$ZoneMetaCopyWithImpl<$Res, ZoneMeta>;
  @useResult
  $Res call(
      {int zoneId,
      bool showSummaryOnScreen,
      List<AnnotationMeta> annotations,
      String zoneName,
      List<PointMeta> points,
      int pointIndex,
      @ColorConverter() Color color,
      int stagnant,
      int reentered,
      int crossedZones,
      int cooldown,
      bool ignoreIfCounted});
}

/// @nodoc
class _$ZoneMetaCopyWithImpl<$Res, $Val extends ZoneMeta>
    implements $ZoneMetaCopyWith<$Res> {
  _$ZoneMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ZoneMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zoneId = null,
    Object? showSummaryOnScreen = null,
    Object? annotations = null,
    Object? zoneName = null,
    Object? points = null,
    Object? pointIndex = null,
    Object? color = null,
    Object? stagnant = null,
    Object? reentered = null,
    Object? crossedZones = null,
    Object? cooldown = null,
    Object? ignoreIfCounted = null,
  }) {
    return _then(_value.copyWith(
      zoneId: null == zoneId
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
      showSummaryOnScreen: null == showSummaryOnScreen
          ? _value.showSummaryOnScreen
          : showSummaryOnScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      annotations: null == annotations
          ? _value.annotations
          : annotations // ignore: cast_nullable_to_non_nullable
              as List<AnnotationMeta>,
      zoneName: null == zoneName
          ? _value.zoneName
          : zoneName // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PointMeta>,
      pointIndex: null == pointIndex
          ? _value.pointIndex
          : pointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      stagnant: null == stagnant
          ? _value.stagnant
          : stagnant // ignore: cast_nullable_to_non_nullable
              as int,
      reentered: null == reentered
          ? _value.reentered
          : reentered // ignore: cast_nullable_to_non_nullable
              as int,
      crossedZones: null == crossedZones
          ? _value.crossedZones
          : crossedZones // ignore: cast_nullable_to_non_nullable
              as int,
      cooldown: null == cooldown
          ? _value.cooldown
          : cooldown // ignore: cast_nullable_to_non_nullable
              as int,
      ignoreIfCounted: null == ignoreIfCounted
          ? _value.ignoreIfCounted
          : ignoreIfCounted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ZoneMetaImplCopyWith<$Res>
    implements $ZoneMetaCopyWith<$Res> {
  factory _$$ZoneMetaImplCopyWith(
          _$ZoneMetaImpl value, $Res Function(_$ZoneMetaImpl) then) =
      __$$ZoneMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int zoneId,
      bool showSummaryOnScreen,
      List<AnnotationMeta> annotations,
      String zoneName,
      List<PointMeta> points,
      int pointIndex,
      @ColorConverter() Color color,
      int stagnant,
      int reentered,
      int crossedZones,
      int cooldown,
      bool ignoreIfCounted});
}

/// @nodoc
class __$$ZoneMetaImplCopyWithImpl<$Res>
    extends _$ZoneMetaCopyWithImpl<$Res, _$ZoneMetaImpl>
    implements _$$ZoneMetaImplCopyWith<$Res> {
  __$$ZoneMetaImplCopyWithImpl(
      _$ZoneMetaImpl _value, $Res Function(_$ZoneMetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of ZoneMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zoneId = null,
    Object? showSummaryOnScreen = null,
    Object? annotations = null,
    Object? zoneName = null,
    Object? points = null,
    Object? pointIndex = null,
    Object? color = null,
    Object? stagnant = null,
    Object? reentered = null,
    Object? crossedZones = null,
    Object? cooldown = null,
    Object? ignoreIfCounted = null,
  }) {
    return _then(_$ZoneMetaImpl(
      zoneId: null == zoneId
          ? _value.zoneId
          : zoneId // ignore: cast_nullable_to_non_nullable
              as int,
      showSummaryOnScreen: null == showSummaryOnScreen
          ? _value.showSummaryOnScreen
          : showSummaryOnScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      annotations: null == annotations
          ? _value._annotations
          : annotations // ignore: cast_nullable_to_non_nullable
              as List<AnnotationMeta>,
      zoneName: null == zoneName
          ? _value.zoneName
          : zoneName // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PointMeta>,
      pointIndex: null == pointIndex
          ? _value.pointIndex
          : pointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      stagnant: null == stagnant
          ? _value.stagnant
          : stagnant // ignore: cast_nullable_to_non_nullable
              as int,
      reentered: null == reentered
          ? _value.reentered
          : reentered // ignore: cast_nullable_to_non_nullable
              as int,
      crossedZones: null == crossedZones
          ? _value.crossedZones
          : crossedZones // ignore: cast_nullable_to_non_nullable
              as int,
      cooldown: null == cooldown
          ? _value.cooldown
          : cooldown // ignore: cast_nullable_to_non_nullable
              as int,
      ignoreIfCounted: null == ignoreIfCounted
          ? _value.ignoreIfCounted
          : ignoreIfCounted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ZoneMetaImpl implements _ZoneMeta {
  const _$ZoneMetaImpl(
      {required this.zoneId,
      required this.showSummaryOnScreen,
      required final List<AnnotationMeta> annotations,
      required this.zoneName,
      required final List<PointMeta> points,
      required this.pointIndex,
      @ColorConverter() required this.color,
      required this.stagnant,
      required this.reentered,
      required this.crossedZones,
      required this.cooldown,
      required this.ignoreIfCounted})
      : _annotations = annotations,
        _points = points;

  factory _$ZoneMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZoneMetaImplFromJson(json);

  @override
  final int zoneId;
  @override
  final bool showSummaryOnScreen;
  final List<AnnotationMeta> _annotations;
  @override
  List<AnnotationMeta> get annotations {
    if (_annotations is EqualUnmodifiableListView) return _annotations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_annotations);
  }

  @override
  final String zoneName;
  final List<PointMeta> _points;
  @override
  List<PointMeta> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final int pointIndex;
  @override
  @ColorConverter()
  final Color color;
  @override
  final int stagnant;
  @override
  final int reentered;
  @override
  final int crossedZones;
  @override
  final int cooldown;
  @override
  final bool ignoreIfCounted;

  @override
  String toString() {
    return 'ZoneMeta(zoneId: $zoneId, showSummaryOnScreen: $showSummaryOnScreen, annotations: $annotations, zoneName: $zoneName, points: $points, pointIndex: $pointIndex, color: $color, stagnant: $stagnant, reentered: $reentered, crossedZones: $crossedZones, cooldown: $cooldown, ignoreIfCounted: $ignoreIfCounted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoneMetaImpl &&
            (identical(other.zoneId, zoneId) || other.zoneId == zoneId) &&
            (identical(other.showSummaryOnScreen, showSummaryOnScreen) ||
                other.showSummaryOnScreen == showSummaryOnScreen) &&
            const DeepCollectionEquality()
                .equals(other._annotations, _annotations) &&
            (identical(other.zoneName, zoneName) ||
                other.zoneName == zoneName) &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.pointIndex, pointIndex) ||
                other.pointIndex == pointIndex) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.stagnant, stagnant) ||
                other.stagnant == stagnant) &&
            (identical(other.reentered, reentered) ||
                other.reentered == reentered) &&
            (identical(other.crossedZones, crossedZones) ||
                other.crossedZones == crossedZones) &&
            (identical(other.cooldown, cooldown) ||
                other.cooldown == cooldown) &&
            (identical(other.ignoreIfCounted, ignoreIfCounted) ||
                other.ignoreIfCounted == ignoreIfCounted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      zoneId,
      showSummaryOnScreen,
      const DeepCollectionEquality().hash(_annotations),
      zoneName,
      const DeepCollectionEquality().hash(_points),
      pointIndex,
      color,
      stagnant,
      reentered,
      crossedZones,
      cooldown,
      ignoreIfCounted);

  /// Create a copy of ZoneMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoneMetaImplCopyWith<_$ZoneMetaImpl> get copyWith =>
      __$$ZoneMetaImplCopyWithImpl<_$ZoneMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ZoneMetaImplToJson(
      this,
    );
  }
}

abstract class _ZoneMeta implements ZoneMeta {
  const factory _ZoneMeta(
      {required final int zoneId,
      required final bool showSummaryOnScreen,
      required final List<AnnotationMeta> annotations,
      required final String zoneName,
      required final List<PointMeta> points,
      required final int pointIndex,
      @ColorConverter() required final Color color,
      required final int stagnant,
      required final int reentered,
      required final int crossedZones,
      required final int cooldown,
      required final bool ignoreIfCounted}) = _$ZoneMetaImpl;

  factory _ZoneMeta.fromJson(Map<String, dynamic> json) =
      _$ZoneMetaImpl.fromJson;

  @override
  int get zoneId;
  @override
  bool get showSummaryOnScreen;
  @override
  List<AnnotationMeta> get annotations;
  @override
  String get zoneName;
  @override
  List<PointMeta> get points;
  @override
  int get pointIndex;
  @override
  @ColorConverter()
  Color get color;
  @override
  int get stagnant;
  @override
  int get reentered;
  @override
  int get crossedZones;
  @override
  int get cooldown;
  @override
  bool get ignoreIfCounted;

  /// Create a copy of ZoneMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ZoneMetaImplCopyWith<_$ZoneMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
