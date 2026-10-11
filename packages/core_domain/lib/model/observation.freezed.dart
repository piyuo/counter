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
  const _Observation({required this.granularity, required this.year, required this.month, required this.day, required this.hour, required this.minute, @RoundedDouble() required this.confidenceRatioSum, required this.confidenceSampleCount, @RoundedDouble() required this.confidenceRatio, required this.coveredSeconds, required this.expectedSeconds, @RoundedDouble() required this.coverageRatio, required  List<AreaMetrics> areas, required this.frameCount}): _areas = areas,super._();
  factory _Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);

/// Aggregation interval represented by this observation.
///
/// Determines which of [hour] and [minute] are used (see the table on
/// [year]).
@override final  ObservationGranularity granularity;
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


/// @nodoc
mixin _$AreaMetrics {

/// Index matching the configured interest-area ID.
///
/// [kGlobalAreaId] represents the global monitored scene.
 int get areaId;/// Name of the configured interest area.
 String get areaName;/// Number of unique tracks that made at least one in-area contact during
/// this observation.
///
/// A track is counted once per observation, on its first in-area contact.
///
/// This metric is additive. For example, summing the passBy values from
/// twelve 5-minute observations produces the hourly passBy count.
 int get passBy;/// Number of unique tracks that remained inside the area continuously for
/// at least the configured stagnant threshold.
///
/// Each qualifying track is counted once per observation.
///
/// This metric is additive across observations.
 int get stagnant;/// Number of tracks whose initial position was outside this area and were
/// later observed inside it.
///
/// This metric applies only to local interest areas. It is always zero
/// for the global area because the global scene has no useful entry
/// boundary.
///
/// Each track contributes at most one entry event per observation.
 int get entry;/// Number of tracks whose initial position was inside this area and were
/// later observed outside it.
///
/// This metric applies only to local interest areas. It is always zero
/// for the global area because the global scene has no useful exit
/// boundary.
///
/// Each track contributes at most one exit event per observation.
 int get exit;/// Number of objects first detected with their center position inside
/// this area.
///
/// Applies to both local areas and the global monitored scene.
/// Each track contributes at most one appear event per observation.
 int get appear;/// Number of unique tracks that were last seen inside the area and then
/// disappeared long enough to satisfy the configured disappear threshold.
///
/// Applies to both local areas and the global monitored scene.
///
/// For the global area, this means that the track was lost from scene
/// tracking; it does not mean that the object was confirmed to have
/// exited the camera view.
 int get disappear;/// Number of occupancy samples in this observation.
///
/// Occupancy is sampled once per frame, so this equals
/// [Observation.frameCount]. It is kept here for convenience so each area
/// can be read on its own.
///
/// Additive across child observations.
 int get occupancySampleCount;/// Sum of the object counts across all occupancy samples.
///
/// Example: samples of 2, 3, and 1 objects give a sum of 6 and a count
/// of 3.
///
/// Additive across child observations.
 int get occupancySampleSum;/// Mean number of objects in the area per sample, or 0 when there are no
/// samples.
///
/// occupancyAvg = occupancySampleSum / occupancySampleCount
///
/// This is an average over frames, not over time, so no time-weighting is
/// applied. The sum and count remain the source of truth; this field is
/// included for convenience.
@RoundedDouble() double get occupancyAvg;/// Maximum occupancy observed in any sample during this observation.
///
/// For an aggregated observation, this is the maximum value from its
/// child observations.
 int get occupancyMax;/// Most recent occupancy sample observed for this area.
///
/// This is state, not an additive metric; an aggregated observation
/// should retain the value from its latest child observation.
 int get occupancyLast;/// Sum of dwell durations, in whole seconds, across all dwell samples.
///
/// Each dwell sample is rounded to whole seconds before it is added.
///
/// Additive across child observations.
 int get dwellSumSeconds;/// Number of dwell samples included in this observation.
///
/// Additive across child observations.
 int get dwellSampleCount;/// Mean dwell time in seconds across all dwell samples, or 0 when there
/// are no samples.
///
/// dwellAvgSeconds = dwellSumSeconds / dwellSampleCount
///
/// No time-weighting is applied. The sum and count remain the source of
/// truth; this field is included for convenience.
@RoundedDouble() double get dwellAvgSeconds;/// Longest single dwell time, in whole seconds, observed during this
/// observation.
///
/// Each dwell time is rounded to whole seconds before it is compared.
///
/// For an aggregated observation, this is the maximum value from its
/// child observations.
 int get dwellMaxSeconds;
/// Create a copy of AreaMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaMetricsCopyWith<AreaMetrics> get copyWith => _$AreaMetricsCopyWithImpl<AreaMetrics>(this as AreaMetrics, _$identity);

  /// Serializes this AreaMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AreaMetrics;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaMetrics&&(identical(other.areaId, _this.areaId) || other.areaId == _this.areaId)&&(identical(other.areaName, _this.areaName) || other.areaName == _this.areaName)&&(identical(other.passBy, _this.passBy) || other.passBy == _this.passBy)&&(identical(other.stagnant, _this.stagnant) || other.stagnant == _this.stagnant)&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.exit, _this.exit) || other.exit == _this.exit)&&(identical(other.appear, _this.appear) || other.appear == _this.appear)&&(identical(other.disappear, _this.disappear) || other.disappear == _this.disappear)&&(identical(other.occupancySampleCount, _this.occupancySampleCount) || other.occupancySampleCount == _this.occupancySampleCount)&&(identical(other.occupancySampleSum, _this.occupancySampleSum) || other.occupancySampleSum == _this.occupancySampleSum)&&(identical(other.occupancyAvg, _this.occupancyAvg) || other.occupancyAvg == _this.occupancyAvg)&&(identical(other.occupancyMax, _this.occupancyMax) || other.occupancyMax == _this.occupancyMax)&&(identical(other.occupancyLast, _this.occupancyLast) || other.occupancyLast == _this.occupancyLast)&&(identical(other.dwellSumSeconds, _this.dwellSumSeconds) || other.dwellSumSeconds == _this.dwellSumSeconds)&&(identical(other.dwellSampleCount, _this.dwellSampleCount) || other.dwellSampleCount == _this.dwellSampleCount)&&(identical(other.dwellAvgSeconds, _this.dwellAvgSeconds) || other.dwellAvgSeconds == _this.dwellAvgSeconds)&&(identical(other.dwellMaxSeconds, _this.dwellMaxSeconds) || other.dwellMaxSeconds == _this.dwellMaxSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AreaMetrics;
  return Object.hash(runtimeType,_this.areaId,_this.areaName,_this.passBy,_this.stagnant,_this.entry,_this.exit,_this.appear,_this.disappear,_this.occupancySampleCount,_this.occupancySampleSum,_this.occupancyAvg,_this.occupancyMax,_this.occupancyLast,_this.dwellSumSeconds,_this.dwellSampleCount,_this.dwellAvgSeconds,_this.dwellMaxSeconds);
}



}

/// @nodoc
abstract mixin class $AreaMetricsCopyWith<$Res>  {
  factory $AreaMetricsCopyWith(AreaMetrics value, $Res Function(AreaMetrics) _then) = _$AreaMetricsCopyWithImpl;
@useResult
$Res call({
 int areaId, String areaName, int passBy, int stagnant, int entry, int exit, int appear, int disappear, int occupancySampleCount, int occupancySampleSum,@RoundedDouble() double occupancyAvg, int occupancyMax, int occupancyLast, int dwellSumSeconds, int dwellSampleCount,@RoundedDouble() double dwellAvgSeconds, int dwellMaxSeconds
});




}
/// @nodoc
class _$AreaMetricsCopyWithImpl<$Res>
    implements $AreaMetricsCopyWith<$Res> {
  _$AreaMetricsCopyWithImpl(this._self, this._then);

  final AreaMetrics _self;
  final $Res Function(AreaMetrics) _then;

/// Create a copy of AreaMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stagnant = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancySampleCount = null,Object? occupancySampleSum = null,Object? occupancyAvg = null,Object? occupancyMax = null,Object? occupancyLast = null,Object? dwellSumSeconds = null,Object? dwellSampleCount = null,Object? dwellAvgSeconds = null,Object? dwellMaxSeconds = null,}) {
  return _then(AreaMetrics(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stagnant: null == stagnant ? _self.stagnant : stagnant // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,occupancySampleCount: null == occupancySampleCount ? _self.occupancySampleCount : occupancySampleCount // ignore: cast_nullable_to_non_nullable
as int,occupancySampleSum: null == occupancySampleSum ? _self.occupancySampleSum : occupancySampleSum // ignore: cast_nullable_to_non_nullable
as int,occupancyAvg: null == occupancyAvg ? _self.occupancyAvg : occupancyAvg // ignore: cast_nullable_to_non_nullable
as double,occupancyMax: null == occupancyMax ? _self.occupancyMax : occupancyMax // ignore: cast_nullable_to_non_nullable
as int,occupancyLast: null == occupancyLast ? _self.occupancyLast : occupancyLast // ignore: cast_nullable_to_non_nullable
as int,dwellSumSeconds: null == dwellSumSeconds ? _self.dwellSumSeconds : dwellSumSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellSampleCount: null == dwellSampleCount ? _self.dwellSampleCount : dwellSampleCount // ignore: cast_nullable_to_non_nullable
as int,dwellAvgSeconds: null == dwellAvgSeconds ? _self.dwellAvgSeconds : dwellAvgSeconds // ignore: cast_nullable_to_non_nullable
as double,dwellMaxSeconds: null == dwellMaxSeconds ? _self.dwellMaxSeconds : dwellMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AreaMetrics].
extension AreaMetricsPatterns on AreaMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AreaMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AreaMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AreaMetrics value)  $default,){
final _that = this;
switch (_that) {
case _AreaMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AreaMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _AreaMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int areaId,  String areaName,  int passBy,  int stagnant,  int entry,  int exit,  int appear,  int disappear,  int occupancySampleCount,  int occupancySampleSum, @RoundedDouble()  double occupancyAvg,  int occupancyMax,  int occupancyLast,  int dwellSumSeconds,  int dwellSampleCount, @RoundedDouble()  double dwellAvgSeconds,  int dwellMaxSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaMetrics() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySampleSum,_that.occupancyAvg,_that.occupancyMax,_that.occupancyLast,_that.dwellSumSeconds,_that.dwellSampleCount,_that.dwellAvgSeconds,_that.dwellMaxSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int areaId,  String areaName,  int passBy,  int stagnant,  int entry,  int exit,  int appear,  int disappear,  int occupancySampleCount,  int occupancySampleSum, @RoundedDouble()  double occupancyAvg,  int occupancyMax,  int occupancyLast,  int dwellSumSeconds,  int dwellSampleCount, @RoundedDouble()  double dwellAvgSeconds,  int dwellMaxSeconds)  $default,) {final _that = this;
switch (_that) {
case _AreaMetrics():
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySampleSum,_that.occupancyAvg,_that.occupancyMax,_that.occupancyLast,_that.dwellSumSeconds,_that.dwellSampleCount,_that.dwellAvgSeconds,_that.dwellMaxSeconds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int areaId,  String areaName,  int passBy,  int stagnant,  int entry,  int exit,  int appear,  int disappear,  int occupancySampleCount,  int occupancySampleSum, @RoundedDouble()  double occupancyAvg,  int occupancyMax,  int occupancyLast,  int dwellSumSeconds,  int dwellSampleCount, @RoundedDouble()  double dwellAvgSeconds,  int dwellMaxSeconds)?  $default,) {final _that = this;
switch (_that) {
case _AreaMetrics() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySampleSum,_that.occupancyAvg,_that.occupancyMax,_that.occupancyLast,_that.dwellSumSeconds,_that.dwellSampleCount,_that.dwellAvgSeconds,_that.dwellMaxSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreaMetrics extends AreaMetrics {
  const _AreaMetrics({required this.areaId, required this.areaName, required this.passBy, required this.stagnant, required this.entry, required this.exit, required this.appear, required this.disappear, required this.occupancySampleCount, required this.occupancySampleSum, @RoundedDouble() required this.occupancyAvg, required this.occupancyMax, required this.occupancyLast, required this.dwellSumSeconds, required this.dwellSampleCount, @RoundedDouble() required this.dwellAvgSeconds, required this.dwellMaxSeconds}): super._();
  factory _AreaMetrics.fromJson(Map<String, dynamic> json) => _$AreaMetricsFromJson(json);

/// Index matching the configured interest-area ID.
///
/// [kGlobalAreaId] represents the global monitored scene.
@override final  int areaId;
/// Name of the configured interest area.
@override final  String areaName;
/// Number of unique tracks that made at least one in-area contact during
/// this observation.
///
/// A track is counted once per observation, on its first in-area contact.
///
/// This metric is additive. For example, summing the passBy values from
/// twelve 5-minute observations produces the hourly passBy count.
@override final  int passBy;
/// Number of unique tracks that remained inside the area continuously for
/// at least the configured stagnant threshold.
///
/// Each qualifying track is counted once per observation.
///
/// This metric is additive across observations.
@override final  int stagnant;
/// Number of tracks whose initial position was outside this area and were
/// later observed inside it.
///
/// This metric applies only to local interest areas. It is always zero
/// for the global area because the global scene has no useful entry
/// boundary.
///
/// Each track contributes at most one entry event per observation.
@override final  int entry;
/// Number of tracks whose initial position was inside this area and were
/// later observed outside it.
///
/// This metric applies only to local interest areas. It is always zero
/// for the global area because the global scene has no useful exit
/// boundary.
///
/// Each track contributes at most one exit event per observation.
@override final  int exit;
/// Number of objects first detected with their center position inside
/// this area.
///
/// Applies to both local areas and the global monitored scene.
/// Each track contributes at most one appear event per observation.
@override final  int appear;
/// Number of unique tracks that were last seen inside the area and then
/// disappeared long enough to satisfy the configured disappear threshold.
///
/// Applies to both local areas and the global monitored scene.
///
/// For the global area, this means that the track was lost from scene
/// tracking; it does not mean that the object was confirmed to have
/// exited the camera view.
@override final  int disappear;
/// Number of occupancy samples in this observation.
///
/// Occupancy is sampled once per frame, so this equals
/// [Observation.frameCount]. It is kept here for convenience so each area
/// can be read on its own.
///
/// Additive across child observations.
@override final  int occupancySampleCount;
/// Sum of the object counts across all occupancy samples.
///
/// Example: samples of 2, 3, and 1 objects give a sum of 6 and a count
/// of 3.
///
/// Additive across child observations.
@override final  int occupancySampleSum;
/// Mean number of objects in the area per sample, or 0 when there are no
/// samples.
///
/// occupancyAvg = occupancySampleSum / occupancySampleCount
///
/// This is an average over frames, not over time, so no time-weighting is
/// applied. The sum and count remain the source of truth; this field is
/// included for convenience.
@override@RoundedDouble() final  double occupancyAvg;
/// Maximum occupancy observed in any sample during this observation.
///
/// For an aggregated observation, this is the maximum value from its
/// child observations.
@override final  int occupancyMax;
/// Most recent occupancy sample observed for this area.
///
/// This is state, not an additive metric; an aggregated observation
/// should retain the value from its latest child observation.
@override final  int occupancyLast;
/// Sum of dwell durations, in whole seconds, across all dwell samples.
///
/// Each dwell sample is rounded to whole seconds before it is added.
///
/// Additive across child observations.
@override final  int dwellSumSeconds;
/// Number of dwell samples included in this observation.
///
/// Additive across child observations.
@override final  int dwellSampleCount;
/// Mean dwell time in seconds across all dwell samples, or 0 when there
/// are no samples.
///
/// dwellAvgSeconds = dwellSumSeconds / dwellSampleCount
///
/// No time-weighting is applied. The sum and count remain the source of
/// truth; this field is included for convenience.
@override@RoundedDouble() final  double dwellAvgSeconds;
/// Longest single dwell time, in whole seconds, observed during this
/// observation.
///
/// Each dwell time is rounded to whole seconds before it is compared.
///
/// For an aggregated observation, this is the maximum value from its
/// child observations.
@override final  int dwellMaxSeconds;

/// Create a copy of AreaMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaMetricsCopyWith<_AreaMetrics> get copyWith => __$AreaMetricsCopyWithImpl<_AreaMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaMetrics&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stagnant, stagnant) || other.stagnant == stagnant)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.occupancySampleCount, occupancySampleCount) || other.occupancySampleCount == occupancySampleCount)&&(identical(other.occupancySampleSum, occupancySampleSum) || other.occupancySampleSum == occupancySampleSum)&&(identical(other.occupancyAvg, occupancyAvg) || other.occupancyAvg == occupancyAvg)&&(identical(other.occupancyMax, occupancyMax) || other.occupancyMax == occupancyMax)&&(identical(other.occupancyLast, occupancyLast) || other.occupancyLast == occupancyLast)&&(identical(other.dwellSumSeconds, dwellSumSeconds) || other.dwellSumSeconds == dwellSumSeconds)&&(identical(other.dwellSampleCount, dwellSampleCount) || other.dwellSampleCount == dwellSampleCount)&&(identical(other.dwellAvgSeconds, dwellAvgSeconds) || other.dwellAvgSeconds == dwellAvgSeconds)&&(identical(other.dwellMaxSeconds, dwellMaxSeconds) || other.dwellMaxSeconds == dwellMaxSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,areaId,areaName,passBy,stagnant,entry,exit,appear,disappear,occupancySampleCount,occupancySampleSum,occupancyAvg,occupancyMax,occupancyLast,dwellSumSeconds,dwellSampleCount,dwellAvgSeconds,dwellMaxSeconds);
}



}

/// @nodoc
abstract mixin class _$AreaMetricsCopyWith<$Res> implements $AreaMetricsCopyWith<$Res> {
  factory _$AreaMetricsCopyWith(_AreaMetrics value, $Res Function(_AreaMetrics) _then) = __$AreaMetricsCopyWithImpl;
@override @useResult
$Res call({
 int areaId, String areaName, int passBy, int stagnant, int entry, int exit, int appear, int disappear, int occupancySampleCount, int occupancySampleSum,@RoundedDouble() double occupancyAvg, int occupancyMax, int occupancyLast, int dwellSumSeconds, int dwellSampleCount,@RoundedDouble() double dwellAvgSeconds, int dwellMaxSeconds
});




}
/// @nodoc
class __$AreaMetricsCopyWithImpl<$Res>
    implements _$AreaMetricsCopyWith<$Res> {
  __$AreaMetricsCopyWithImpl(this._self, this._then);

  final _AreaMetrics _self;
  final $Res Function(_AreaMetrics) _then;

/// Create a copy of AreaMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stagnant = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancySampleCount = null,Object? occupancySampleSum = null,Object? occupancyAvg = null,Object? occupancyMax = null,Object? occupancyLast = null,Object? dwellSumSeconds = null,Object? dwellSampleCount = null,Object? dwellAvgSeconds = null,Object? dwellMaxSeconds = null,}) {
  return _then(_AreaMetrics(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stagnant: null == stagnant ? _self.stagnant : stagnant // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,occupancySampleCount: null == occupancySampleCount ? _self.occupancySampleCount : occupancySampleCount // ignore: cast_nullable_to_non_nullable
as int,occupancySampleSum: null == occupancySampleSum ? _self.occupancySampleSum : occupancySampleSum // ignore: cast_nullable_to_non_nullable
as int,occupancyAvg: null == occupancyAvg ? _self.occupancyAvg : occupancyAvg // ignore: cast_nullable_to_non_nullable
as double,occupancyMax: null == occupancyMax ? _self.occupancyMax : occupancyMax // ignore: cast_nullable_to_non_nullable
as int,occupancyLast: null == occupancyLast ? _self.occupancyLast : occupancyLast // ignore: cast_nullable_to_non_nullable
as int,dwellSumSeconds: null == dwellSumSeconds ? _self.dwellSumSeconds : dwellSumSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellSampleCount: null == dwellSampleCount ? _self.dwellSampleCount : dwellSampleCount // ignore: cast_nullable_to_non_nullable
as int,dwellAvgSeconds: null == dwellAvgSeconds ? _self.dwellAvgSeconds : dwellAvgSeconds // ignore: cast_nullable_to_non_nullable
as double,dwellMaxSeconds: null == dwellMaxSeconds ? _self.dwellMaxSeconds : dwellMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
