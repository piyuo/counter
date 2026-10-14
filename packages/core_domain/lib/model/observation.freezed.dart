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
 int get year; int get month; int get day; int get hour; int get minute;/// Sum of confidence ratios (0.0-1.0), one per tracked-object
/// confidence sample contributing to this observation.
///
/// Additive across child observations. there is no round when summing but will round when written to JSON to avoid 92.99999999 issue
@RoundedDouble() double get confidenceRatioSum;/// Number of tracked-object confidence samples contributing to this
/// observation.
///
/// Additive across child observations.
 int get confidenceSampleCount;/// Mean confidence as a ratio in the range 0.0-1.0, or 0 when there are
/// no samples.
///
/// confidenceRatio = confidenceRatioSum / confidenceSampleCount
///
/// The sum and count remain the source of truth; this field is included
/// for convenience.
@RoundedDouble() double get confidenceRatio;/// Number of seconds with valid detection data in this observation.
///
/// For example, a 5-minute window has a maximum of 300 covered seconds,
/// minus any time when detection data was missing.
///
/// Additive across child observations.
 int get coveredSeconds;/// Expected duration, in seconds, of this observation's period.
///
/// For example, a 5-minute window has 300 expected seconds.
///
/// Additive across child observations.
 int get expectedSeconds;/// Fraction of the observation period that contained valid detection
/// data, in the range 0.0-1.0, or 0 when [expectedSeconds] is 0.
///
/// coverageRatio = coveredSeconds / expectedSeconds
///
/// For aggregated observations, sum the seconds first, then divide.
/// Do not average the ratios of child observations. The seconds remain
/// the source of truth; this field is included for convenience.
@RoundedDouble() double get coverageRatio;/// Per-area analytics.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Observation&&(identical(other.granularity, _this.granularity) || other.granularity == _this.granularity)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute)&&(identical(other.confidenceRatioSum, _this.confidenceRatioSum) || other.confidenceRatioSum == _this.confidenceRatioSum)&&(identical(other.confidenceSampleCount, _this.confidenceSampleCount) || other.confidenceSampleCount == _this.confidenceSampleCount)&&(identical(other.confidenceRatio, _this.confidenceRatio) || other.confidenceRatio == _this.confidenceRatio)&&(identical(other.coveredSeconds, _this.coveredSeconds) || other.coveredSeconds == _this.coveredSeconds)&&(identical(other.expectedSeconds, _this.expectedSeconds) || other.expectedSeconds == _this.expectedSeconds)&&(identical(other.coverageRatio, _this.coverageRatio) || other.coverageRatio == _this.coverageRatio)&&const DeepCollectionEquality().equals(other.areas, _this.areas)&&(identical(other.frameCount, _this.frameCount) || other.frameCount == _this.frameCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Observation;
  return Object.hash(runtimeType,_this.granularity,_this.year,_this.month,_this.day,_this.hour,_this.minute,_this.confidenceRatioSum,_this.confidenceSampleCount,_this.confidenceRatio,_this.coveredSeconds,_this.expectedSeconds,_this.coverageRatio,const DeepCollectionEquality().hash(_this.areas),_this.frameCount);
}



}

/// @nodoc
abstract mixin class $ObservationCopyWith<$Res>  {
  factory $ObservationCopyWith(Observation value, $Res Function(Observation) _then) = _$ObservationCopyWithImpl;
@useResult
$Res call({
 ObservationGranularity granularity, int year, int month, int day, int hour, int minute,@RoundedDouble() double confidenceRatioSum, int confidenceSampleCount,@RoundedDouble() double confidenceRatio, int coveredSeconds, int expectedSeconds,@RoundedDouble() double coverageRatio, List<AreaMetrics> areas, int frameCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? granularity = null,Object? year = null,Object? month = null,Object? day = null,Object? hour = null,Object? minute = null,Object? confidenceRatioSum = null,Object? confidenceSampleCount = null,Object? confidenceRatio = null,Object? coveredSeconds = null,Object? expectedSeconds = null,Object? coverageRatio = null,Object? areas = null,Object? frameCount = null,}) {
  return _then(Observation(
granularity: null == granularity ? _self.granularity : granularity // ignore: cast_nullable_to_non_nullable
as ObservationGranularity,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,confidenceRatioSum: null == confidenceRatioSum ? _self.confidenceRatioSum : confidenceRatioSum // ignore: cast_nullable_to_non_nullable
as double,confidenceSampleCount: null == confidenceSampleCount ? _self.confidenceSampleCount : confidenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,confidenceRatio: null == confidenceRatio ? _self.confidenceRatio : confidenceRatio // ignore: cast_nullable_to_non_nullable
as double,coveredSeconds: null == coveredSeconds ? _self.coveredSeconds : coveredSeconds // ignore: cast_nullable_to_non_nullable
as int,expectedSeconds: null == expectedSeconds ? _self.expectedSeconds : expectedSeconds // ignore: cast_nullable_to_non_nullable
as int,coverageRatio: null == coverageRatio ? _self.coverageRatio : coverageRatio // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ObservationGranularity granularity,  int year,  int month,  int day,  int hour,  int minute, @RoundedDouble()  double confidenceRatioSum,  int confidenceSampleCount, @RoundedDouble()  double confidenceRatio,  int coveredSeconds,  int expectedSeconds, @RoundedDouble()  double coverageRatio,  List<AreaMetrics> areas,  int frameCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.confidenceRatioSum,_that.confidenceSampleCount,_that.confidenceRatio,_that.coveredSeconds,_that.expectedSeconds,_that.coverageRatio,_that.areas,_that.frameCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ObservationGranularity granularity,  int year,  int month,  int day,  int hour,  int minute, @RoundedDouble()  double confidenceRatioSum,  int confidenceSampleCount, @RoundedDouble()  double confidenceRatio,  int coveredSeconds,  int expectedSeconds, @RoundedDouble()  double coverageRatio,  List<AreaMetrics> areas,  int frameCount)  $default,) {final _that = this;
switch (_that) {
case _Observation():
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.confidenceRatioSum,_that.confidenceSampleCount,_that.confidenceRatio,_that.coveredSeconds,_that.expectedSeconds,_that.coverageRatio,_that.areas,_that.frameCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ObservationGranularity granularity,  int year,  int month,  int day,  int hour,  int minute, @RoundedDouble()  double confidenceRatioSum,  int confidenceSampleCount, @RoundedDouble()  double confidenceRatio,  int coveredSeconds,  int expectedSeconds, @RoundedDouble()  double coverageRatio,  List<AreaMetrics> areas,  int frameCount)?  $default,) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.granularity,_that.year,_that.month,_that.day,_that.hour,_that.minute,_that.confidenceRatioSum,_that.confidenceSampleCount,_that.confidenceRatio,_that.coveredSeconds,_that.expectedSeconds,_that.coverageRatio,_that.areas,_that.frameCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Observation extends Observation {
  const _Observation({this.granularity = ObservationGranularity.minutes5, required this.year, required this.month, required this.day, required this.hour, required this.minute, @RoundedDouble() required this.confidenceRatioSum, required this.confidenceSampleCount, @RoundedDouble() required this.confidenceRatio, required this.coveredSeconds, required this.expectedSeconds, @RoundedDouble() required this.coverageRatio, required  List<AreaMetrics> areas, required this.frameCount}): _areas = areas,super._();
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
/// Sum of confidence ratios (0.0-1.0), one per tracked-object
/// confidence sample contributing to this observation.
///
/// Additive across child observations. there is no round when summing but will round when written to JSON to avoid 92.99999999 issue
@override@RoundedDouble() final  double confidenceRatioSum;
/// Number of tracked-object confidence samples contributing to this
/// observation.
///
/// Additive across child observations.
@override final  int confidenceSampleCount;
/// Mean confidence as a ratio in the range 0.0-1.0, or 0 when there are
/// no samples.
///
/// confidenceRatio = confidenceRatioSum / confidenceSampleCount
///
/// The sum and count remain the source of truth; this field is included
/// for convenience.
@override@RoundedDouble() final  double confidenceRatio;
/// Number of seconds with valid detection data in this observation.
///
/// For example, a 5-minute window has a maximum of 300 covered seconds,
/// minus any time when detection data was missing.
///
/// Additive across child observations.
@override final  int coveredSeconds;
/// Expected duration, in seconds, of this observation's period.
///
/// For example, a 5-minute window has 300 expected seconds.
///
/// Additive across child observations.
@override final  int expectedSeconds;
/// Fraction of the observation period that contained valid detection
/// data, in the range 0.0-1.0, or 0 when [expectedSeconds] is 0.
///
/// coverageRatio = coveredSeconds / expectedSeconds
///
/// For aggregated observations, sum the seconds first, then divide.
/// Do not average the ratios of child observations. The seconds remain
/// the source of truth; this field is included for convenience.
@override@RoundedDouble() final  double coverageRatio;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Observation&&(identical(other.granularity, granularity) || other.granularity == granularity)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.confidenceRatioSum, confidenceRatioSum) || other.confidenceRatioSum == confidenceRatioSum)&&(identical(other.confidenceSampleCount, confidenceSampleCount) || other.confidenceSampleCount == confidenceSampleCount)&&(identical(other.confidenceRatio, confidenceRatio) || other.confidenceRatio == confidenceRatio)&&(identical(other.coveredSeconds, coveredSeconds) || other.coveredSeconds == coveredSeconds)&&(identical(other.expectedSeconds, expectedSeconds) || other.expectedSeconds == expectedSeconds)&&(identical(other.coverageRatio, coverageRatio) || other.coverageRatio == coverageRatio)&&const DeepCollectionEquality().equals(other.areas, _areas)&&(identical(other.frameCount, frameCount) || other.frameCount == frameCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,granularity,year,month,day,hour,minute,confidenceRatioSum,confidenceSampleCount,confidenceRatio,coveredSeconds,expectedSeconds,coverageRatio,const DeepCollectionEquality().hash(_areas),frameCount);
}



}

/// @nodoc
abstract mixin class _$ObservationCopyWith<$Res> implements $ObservationCopyWith<$Res> {
  factory _$ObservationCopyWith(_Observation value, $Res Function(_Observation) _then) = __$ObservationCopyWithImpl;
@override @useResult
$Res call({
 ObservationGranularity granularity, int year, int month, int day, int hour, int minute,@RoundedDouble() double confidenceRatioSum, int confidenceSampleCount,@RoundedDouble() double confidenceRatio, int coveredSeconds, int expectedSeconds,@RoundedDouble() double coverageRatio, List<AreaMetrics> areas, int frameCount
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
@override @pragma('vm:prefer-inline') $Res call({Object? granularity = null,Object? year = null,Object? month = null,Object? day = null,Object? hour = null,Object? minute = null,Object? confidenceRatioSum = null,Object? confidenceSampleCount = null,Object? confidenceRatio = null,Object? coveredSeconds = null,Object? expectedSeconds = null,Object? coverageRatio = null,Object? areas = null,Object? frameCount = null,}) {
  return _then(_Observation(
granularity: null == granularity ? _self.granularity : granularity // ignore: cast_nullable_to_non_nullable
as ObservationGranularity,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,confidenceRatioSum: null == confidenceRatioSum ? _self.confidenceRatioSum : confidenceRatioSum // ignore: cast_nullable_to_non_nullable
as double,confidenceSampleCount: null == confidenceSampleCount ? _self.confidenceSampleCount : confidenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,confidenceRatio: null == confidenceRatio ? _self.confidenceRatio : confidenceRatio // ignore: cast_nullable_to_non_nullable
as double,coveredSeconds: null == coveredSeconds ? _self.coveredSeconds : coveredSeconds // ignore: cast_nullable_to_non_nullable
as int,expectedSeconds: null == expectedSeconds ? _self.expectedSeconds : expectedSeconds // ignore: cast_nullable_to_non_nullable
as int,coverageRatio: null == coverageRatio ? _self.coverageRatio : coverageRatio // ignore: cast_nullable_to_non_nullable
as double,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaMetrics>,frameCount: null == frameCount ? _self.frameCount : frameCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
