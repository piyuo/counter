// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Observation {

/// Aggregation interval represented by this observation.
///
/// Determines which of [hour] and [minute] are used (see the table on
/// [year]).
 ObservationGranularity get granularity;/// Identifies the date represented by this observation.
///
/// Business (local wall-clock) date. See "Time basis and DST" at the top
/// of this file.
///
/// Components that do not apply to the [granularity] are -1:
///
/// - minutes5: year=2026, month=06, day=24, hour=23, minute=05
/// - hour:     year=2026, month=06, day=24, hour=23, minute=-1
/// - day:      year=2026, month=06, day=24, hour=-1, minute=-1
/// - month:    year=2026, month=06, day=-1, hour=-1, minute=-1
/// - year:     year=2026, month=-1, day=-1, hour=-1, minute=-1
 int get year; int get month; int get day; int get hour; int get minute;/// Sum of tracked-object confidence ratios, each in the range 0.0-1.0.
///
/// Additive across child observations. The sum is rounded to two decimal
/// places when serialized to JSON.
@RoundedDouble() double get confidenceSum;/// Number of tracked-object confidence samples contributing to this
/// observation.
///
/// Additive across child observations.
 int get confidenceSampleCount;/// Number of seconds with valid detection data in this observation.
///
/// For example, a 5-minute window has a maximum of 300 covered seconds,
/// minus any time when detection data was missing.
///
/// Additive across child observations.
/// Slots with few contributors look as strong as well-sampled ones.
/// A slot present in 1 of 30 days is averaged over that one day, with no signal that it’s thin.
/// You could weight by coveredSeconds to know how well-sampled a slot is.
 int get coveredSeconds;/// Per-area analytics.
///
/// One entry exists for each configured interest area, including the
/// global area.
 List<AreaMetrics> get areas;/// Total number of frames processed during this observation.
///
/// Additive across child observations.
 int get frameCount;
/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationCopyWith<Observation> get copyWith => _$ObservationCopyWithImpl<Observation>(this as Observation, _$identity);

  /// Serializes this Observation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Observation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Observation&&(identical(other.granularity, _this.granularity) || other.granularity == _this.granularity)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute)&&(identical(other.confidenceSum, _this.confidenceSum) || other.confidenceSum == _this.confidenceSum)&&(identical(other.confidenceSampleCount, _this.confidenceSampleCount) || other.confidenceSampleCount == _this.confidenceSampleCount)&&(identical(other.coveredSeconds, _this.coveredSeconds) || other.coveredSeconds == _this.coveredSeconds)&&const DeepCollectionEquality().equals(other.areas, _this.areas)&&(identical(other.frameCount, _this.frameCount) || other.frameCount == _this.frameCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Observation;
  return Object.hash(runtimeType,_this.granularity,_this.year,_this.month,_this.day,_this.hour,_this.minute,_this.confidenceSum,_this.confidenceSampleCount,_this.coveredSeconds,const DeepCollectionEquality().hash(_this.areas),_this.frameCount);
}

@override
String toString() {
  final _this = this as Observation;
  return 'Observation(granularity: ${_this.granularity}, year: ${_this.year}, month: ${_this.month}, day: ${_this.day}, hour: ${_this.hour}, minute: ${_this.minute}, confidenceSum: ${_this.confidenceSum}, confidenceSampleCount: ${_this.confidenceSampleCount}, coveredSeconds: ${_this.coveredSeconds}, areas: ${_this.areas}, frameCount: ${_this.frameCount})';
}


}

/// @nodoc
abstract mixin class $ObservationCopyWith<$Res>  {
  factory $ObservationCopyWith(Observation value, $Res Function(Observation) _then) = _$ObservationCopyWithImpl;
@useResult
$Res call({
 ObservationGranularity granularity, int year, int month, int day, int hour, int minute,@RoundedDouble() double confidenceSum, int confidenceSampleCount, int coveredSeconds, List<AreaMetrics> areas, int frameCount
});




}
/// @nodoc
class _$ObservationCopyWithImpl<$Res>
    implements $ObservationCopyWith<$Res> {
  _$ObservationCopyWithImpl(this._self, this._then);

  final Observation _self;
  final $Res Function(Observation) _then;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? granularity = null,Object? year = null,Object? month = null,Object? day = null,Object? hour = null,Object? minute = null,Object? confidenceSum = null,Object? confidenceSampleCount = null,Object? coveredSeconds = null,Object? areas = null,Object? frameCount = null,}) {
  return _then(Observation(
granularity: null == granularity ? _self.granularity : granularity // ignore: cast_nullable_to_non_nullable
as ObservationGranularity,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,confidenceSum: null == confidenceSum ? _self.confidenceSum : confidenceSum // ignore: cast_nullable_to_non_nullable
as double,confidenceSampleCount: null == confidenceSampleCount ? _self.confidenceSampleCount : confidenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,coveredSeconds: null == coveredSeconds ? _self.coveredSeconds : coveredSeconds // ignore: cast_nullable_to_non_nullable
as int,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaMetrics>,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Observation].
extension ObservationPatterns on Observation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Observation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Observation value)  $default,){
final _that = this;
switch (_that) {
case _Observation():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Observation value)?  $default,){
final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ObservationGranularity granularity,  int year,  int month,  int day,  int hour,  int minute, @RoundedDouble()  double confidenceSum,  int confidenceSampleCount,  int coveredSeconds,  List<AreaMetrics> areas,  int frameCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.confidenceSum,_that.confidenceSampleCount,_that.coveredSeconds,_that.areas,_that.frameCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ObservationGranularity granularity,  int year,  int month,  int day,  int hour,  int minute, @RoundedDouble()  double confidenceSum,  int confidenceSampleCount,  int coveredSeconds,  List<AreaMetrics> areas,  int frameCount)  $default,) {final _that = this;
switch (_that) {
case _Observation():
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.confidenceSum,_that.confidenceSampleCount,_that.coveredSeconds,_that.areas,_that.frameCount);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ObservationGranularity granularity,  int year,  int month,  int day,  int hour,  int minute, @RoundedDouble()  double confidenceSum,  int confidenceSampleCount,  int coveredSeconds,  List<AreaMetrics> areas,  int frameCount)?  $default,) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.confidenceSum,_that.confidenceSampleCount,_that.coveredSeconds,_that.areas,_that.frameCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Observation extends Observation {
  const _Observation({this.granularity = ObservationGranularity.minutes5, required this.year, required this.month, required this.day, required this.hour, required this.minute, @RoundedDouble() this.confidenceSum = 0, this.confidenceSampleCount = 0, this.coveredSeconds = 0, required  List<AreaMetrics> areas, required this.frameCount}): _areas = areas,super._();
  factory _Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);

/// Aggregation interval represented by this observation.
///
/// Determines which of [hour] and [minute] are used (see the table on
/// [year]).
@override@JsonKey() final  ObservationGranularity granularity;
/// Identifies the date represented by this observation.
///
/// Business (local wall-clock) date. See "Time basis and DST" at the top
/// of this file.
///
/// Components that do not apply to the [granularity] are -1:
///
/// - minutes5: year=2026, month=06, day=24, hour=23, minute=05
/// - hour:     year=2026, month=06, day=24, hour=23, minute=-1
/// - day:      year=2026, month=06, day=24, hour=-1, minute=-1
/// - month:    year=2026, month=06, day=-1, hour=-1, minute=-1
/// - year:     year=2026, month=-1, day=-1, hour=-1, minute=-1
@override final  int year;
@override final  int month;
@override final  int day;
@override final  int hour;
@override final  int minute;
/// Sum of tracked-object confidence ratios, each in the range 0.0-1.0.
///
/// Additive across child observations. The sum is rounded to two decimal
/// places when serialized to JSON.
@override@JsonKey()@RoundedDouble() final  double confidenceSum;
/// Number of tracked-object confidence samples contributing to this
/// observation.
///
/// Additive across child observations.
@override@JsonKey() final  int confidenceSampleCount;
/// Number of seconds with valid detection data in this observation.
///
/// For example, a 5-minute window has a maximum of 300 covered seconds,
/// minus any time when detection data was missing.
///
/// Additive across child observations.
/// Slots with few contributors look as strong as well-sampled ones.
/// A slot present in 1 of 30 days is averaged over that one day, with no signal that it’s thin.
/// You could weight by coveredSeconds to know how well-sampled a slot is.
@override@JsonKey() final  int coveredSeconds;
/// Per-area analytics.
///
/// One entry exists for each configured interest area, including the
/// global area.
 final  List<AreaMetrics> _areas;
/// Per-area analytics.
///
/// One entry exists for each configured interest area, including the
/// global area.
@override List<AreaMetrics> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

/// Total number of frames processed during this observation.
///
/// Additive across child observations.
@override final  int frameCount;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationCopyWith<_Observation> get copyWith => __$ObservationCopyWithImpl<_Observation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Observation&&(identical(other.granularity, granularity) || other.granularity == granularity)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.confidenceSum, confidenceSum) || other.confidenceSum == confidenceSum)&&(identical(other.confidenceSampleCount, confidenceSampleCount) || other.confidenceSampleCount == confidenceSampleCount)&&(identical(other.coveredSeconds, coveredSeconds) || other.coveredSeconds == coveredSeconds)&&const DeepCollectionEquality().equals(other.areas, _areas)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,granularity,year,month,day,hour,minute,confidenceSum,confidenceSampleCount,coveredSeconds,const DeepCollectionEquality().hash(_areas),frameCount);
}

@override
String toString() {
    return 'Observation(granularity: $granularity, year: $year, month: $month, day: $day, hour: $hour, minute: $minute, confidenceSum: $confidenceSum, confidenceSampleCount: $confidenceSampleCount, coveredSeconds: $coveredSeconds, areas: $areas, frameCount: $frameCount)';
}


}

/// @nodoc
abstract mixin class _$ObservationCopyWith<$Res> implements $ObservationCopyWith<$Res> {
  factory _$ObservationCopyWith(_Observation value, $Res Function(_Observation) _then) = __$ObservationCopyWithImpl;
@override @useResult
$Res call({
 ObservationGranularity granularity, int year, int month, int day, int hour, int minute,@RoundedDouble() double confidenceSum, int confidenceSampleCount, int coveredSeconds, List<AreaMetrics> areas, int frameCount
});




}
/// @nodoc
class __$ObservationCopyWithImpl<$Res>
    implements _$ObservationCopyWith<$Res> {
  __$ObservationCopyWithImpl(this._self, this._then);

  final _Observation _self;
  final $Res Function(_Observation) _then;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? granularity = null,Object? year = null,Object? month = null,Object? day = null,Object? hour = null,Object? minute = null,Object? confidenceSum = null,Object? confidenceSampleCount = null,Object? coveredSeconds = null,Object? areas = null,Object? frameCount = null,}) {
  return _then(_Observation(
granularity: null == granularity ? _self.granularity : granularity // ignore: cast_nullable_to_non_nullable
as ObservationGranularity,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,confidenceSum: null == confidenceSum ? _self.confidenceSum : confidenceSum // ignore: cast_nullable_to_non_nullable
as double,confidenceSampleCount: null == confidenceSampleCount ? _self.confidenceSampleCount : confidenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,coveredSeconds: null == coveredSeconds ? _self.coveredSeconds : coveredSeconds // ignore: cast_nullable_to_non_nullable
as int,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaMetrics>,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
