// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AreaMetrics {

/// Index matching the configured interest-area ID.
///
/// [kGlobalAreaId] represents the global monitored scene.
 int get areaId;/// Name of the configured interest area.
 String get areaName;/// Number of unique tracks that touched this area for the first time.
///
/// Each track is counted ONLY ONCE (subject to bounded track history), in
/// the observation where it first makes contact. It is not
/// counted again if it stays in the area or leaves and re-enters.
///
/// Example: a track first touches the area at 12:03. passBy increases by 1 in
/// the 12:00-12:05 observation only. If the same track stays there all day,
/// passBy stays unchanged in every later observation.
///
/// Because of this, the metric is additive: summing passBy over 5-minute
/// observations gives the hourly value, and so on up to the year. The result
/// is the number of new tracks first seen in that period.
///
/// Limitation: a new track ID (for example after a tracking ID switch or an
/// app restart) is a new track and is counted again.
@RoundedDouble() double get passBy;/// Number of unique tracks that stayed inside the area continuously for at
/// least the configured stagnant threshold. Absences shorter than the
/// disappear threshold do not restart the clock.
///
/// Each track is counted ONLY ONCE (subject to bounded track history), in
/// the observation where it reaches the threshold.
///
/// Example: the threshold is 30 seconds and a track enters at 12:04:50. It
/// reaches 30 seconds at 12:05:20, so stagnant increases by 1 in the
/// 12:05-12:10 observation (not in 12:00-12:05, where the stay started).
///
/// This metric is additive across observations.
///
/// Limitation: a new track ID is a new track and is counted again.
@RoundedDouble() double get stagnant;/// Number of tracks whose initial position was outside this area and were
/// later observed inside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first enters.
/// This is additive across observations, subject to bounded history.
@RoundedDouble() double get entry;/// Number of tracks whose initial position was inside this area and were
/// later observed outside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first exits.
/// This is additive across observations, subject to bounded history.
@RoundedDouble() double get exit;/// Number of tracks first detected with their center position inside this
/// area.
///
/// Applies to both local areas and the global monitored scene.
/// Each track ID is counted once in the observation where it first appears.
/// This is additive across observations, subject to bounded history.
@RoundedDouble() double get appear;/// Number of tracks last seen inside the area and then absent long enough
/// to satisfy the configured disappear threshold.
///
/// Applies to both local areas and the global monitored scene.
///
/// For the global area, this means that the track was lost from scene
/// tracking; it does not mean that the object was confirmed to have
/// exited the camera view.
///
/// Each track ID is counted once while retained in tracker history. A
/// returning track may add another dwell sample but no second disappear.
/// Visits closed by source dropout, pause, clock jump, or stop do not count
/// as disappear. For a local area, this also fires when the track leaves
/// the area but remains visible elsewhere.
@RoundedDouble() double get disappear;/// Number of occupancy samples in this observation.
///
/// Occupancy is sampled once per frame, so this equals
/// [Observation.frameCount]. It is kept here for convenience so each area
/// can be read on its own.
///
/// Its sum and sample count are additive across child observations.
 int get occupancySampleCount;/// Sum of the object counts across all occupancy samples.
///
/// Example: samples of 2, 3, and 1 objects give a sum of 6 and a count
/// of 3.
///
/// Additive across child observations.
 int get occupancySum;/// Sum of the squared object counts across all occupancy samples.
///
/// Example: samples of 2, 3, and 1 objects give 4 + 9 + 1 = 14.
///
/// Additive across child observations. Together with
/// [occupancySum] and [occupancySampleCount] it gives the variance:
///
/// variance = occupancySumSquares / occupancySampleCount - mean²
///
/// The sum, sum of squares, and count remain the source of truth; the mean
/// and variance are derived from them.
 int get occupancySumSquares;/// Mean number of objects in the area per sample, or 0 when there are no
/// samples.
///
/// occupancyMean = occupancySum / occupancySampleCount
///
/// This is an average over frames, not over time, so no time-weighting is
/// applied. The sum and count remain the source of truth; this field is
/// included for convenience.
/// Maximum occupancy observed in any sample during this observation.
///
/// For an aggregated observation, this is the maximum value from its
/// child observations.
 int get occupancyMax;/// Most recent occupancy sample observed for this area. When no valid
/// occupancy sample exists, this is zero; use [occupancySampleCount] to
/// distinguish this from a measured zero.
///
/// This is state, not an additive metric; an aggregated observation
/// should retain the value from its latest child observation.
 int get occupancyLast;/// Number of finished visits recorded in this observation.
///
/// A visit is finished when the track has been gone from the area for the
/// disappear threshold. The whole visit is recorded ONCE, in the observation
/// where it is confirmed finished (not where it started).
///
/// Example: a visit from 12:03 to 12:13 adds one sample of 600 s to the
/// 12:10-12:15 observation and nothing to the earlier ones.
///
/// A visit that spans midnight is recorded in the day it finishes. Visits
/// still open when the source drops out, monitoring pauses, the clock
/// jumps, or monitoring stops are discarded without a dwell sample because
/// the interruption does not establish when the track actually left.
/// Resetting or changing interest areas also discards open visits.
///
/// Additive across child observations.
 int get dwellSampleCount;/// Sum of dwell durations, in whole seconds, across all dwell samples.
///
/// Each dwell sample is rounded to whole seconds before it is added.
///
/// Additive across child observations.
 int get dwellSumSeconds;/// Mean dwell time in seconds across all dwell samples, or 0 when there
/// are no samples.
///
/// dwellMeanSeconds = dwellSumSeconds / dwellSampleCount
///
/// No time-weighting is applied. The sum and count remain the source of
/// truth; this field is included for convenience.
/// Longest finished visit recorded in this observation, in whole seconds.
///
/// Attributed to the observation where the visit finished. For an aggregated
/// observation, this is the maximum of its child observations.
 int get dwellMaxSeconds;/// Number of finished visits in each duration bucket, in order:
/// `<5s, 5-15s, 15-60s, 1-5min, 5-10min, 10-30min, 30-60min, >=60min`.
///
/// Each bucket includes its lower edge and excludes its upper edge (a 300 s
/// visit is in 5-10min, and a 3600 s visit is in >=60min). The edges are
/// fixed by [kDwellBucketEdgesSeconds]; the list always has [kDwellBucketCount]
/// Additive across child observations: add the lists element by element.
 List<int> get dwellHistogram;/// Number of tracks present for a positive amount of time during this
/// observation. Each present track is one sample.
///
/// A track that stays across several observations is a separate sample in
/// each one, so at hour, day or longer levels this is a count of
/// track-observation pairs, not of distinct tracks (use passBy for that).
///
/// Additive across child observations.
 int get presenceSampleCount;/// Total seconds that tracks spent inside the area during this observation
/// (track-seconds, rounded to whole seconds per observation).
///
/// Example: a track inside from 12:03 to 12:13 adds 120 s to 12:00-12:05,
/// 300 s to 12:05-12:10 and 180 s to 12:10-12:15.
///
/// When `Observation.coveredSeconds` is positive,
/// presenceSumSeconds / coveredSeconds is the time-weighted average number
/// of tracks in the area while detection data was valid. Unlike
/// [occupancyMean], it does not depend on frame rate.
///
/// Additive across child observations.
 int get presenceSumSeconds;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaMetrics&&(identical(other.areaId, _this.areaId) || other.areaId == _this.areaId)&&(identical(other.areaName, _this.areaName) || other.areaName == _this.areaName)&&(identical(other.passBy, _this.passBy) || other.passBy == _this.passBy)&&(identical(other.stagnant, _this.stagnant) || other.stagnant == _this.stagnant)&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.exit, _this.exit) || other.exit == _this.exit)&&(identical(other.appear, _this.appear) || other.appear == _this.appear)&&(identical(other.disappear, _this.disappear) || other.disappear == _this.disappear)&&(identical(other.occupancySampleCount, _this.occupancySampleCount) || other.occupancySampleCount == _this.occupancySampleCount)&&(identical(other.occupancySum, _this.occupancySum) || other.occupancySum == _this.occupancySum)&&(identical(other.occupancySumSquares, _this.occupancySumSquares) || other.occupancySumSquares == _this.occupancySumSquares)&&(identical(other.occupancyMax, _this.occupancyMax) || other.occupancyMax == _this.occupancyMax)&&(identical(other.occupancyLast, _this.occupancyLast) || other.occupancyLast == _this.occupancyLast)&&(identical(other.dwellSampleCount, _this.dwellSampleCount) || other.dwellSampleCount == _this.dwellSampleCount)&&(identical(other.dwellSumSeconds, _this.dwellSumSeconds) || other.dwellSumSeconds == _this.dwellSumSeconds)&&(identical(other.dwellMaxSeconds, _this.dwellMaxSeconds) || other.dwellMaxSeconds == _this.dwellMaxSeconds)&&const DeepCollectionEquality().equals(other.dwellHistogram, _this.dwellHistogram)&&(identical(other.presenceSampleCount, _this.presenceSampleCount) || other.presenceSampleCount == _this.presenceSampleCount)&&(identical(other.presenceSumSeconds, _this.presenceSumSeconds) || other.presenceSumSeconds == _this.presenceSumSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AreaMetrics;
  return Object.hashAll([runtimeType,_this.areaId,_this.areaName,_this.passBy,_this.stagnant,_this.entry,_this.exit,_this.appear,_this.disappear,_this.occupancySampleCount,_this.occupancySum,_this.occupancySumSquares,_this.occupancyMax,_this.occupancyLast,_this.dwellSampleCount,_this.dwellSumSeconds,_this.dwellMaxSeconds,const DeepCollectionEquality().hash(_this.dwellHistogram),_this.presenceSampleCount,_this.presenceSumSeconds]);
}

@override
String toString() {
  final _this = this as AreaMetrics;
  return 'AreaMetrics(areaId: ${_this.areaId}, areaName: ${_this.areaName}, passBy: ${_this.passBy}, stagnant: ${_this.stagnant}, entry: ${_this.entry}, exit: ${_this.exit}, appear: ${_this.appear}, disappear: ${_this.disappear}, occupancySampleCount: ${_this.occupancySampleCount}, occupancySum: ${_this.occupancySum}, occupancySumSquares: ${_this.occupancySumSquares}, occupancyMax: ${_this.occupancyMax}, occupancyLast: ${_this.occupancyLast}, dwellSampleCount: ${_this.dwellSampleCount}, dwellSumSeconds: ${_this.dwellSumSeconds}, dwellMaxSeconds: ${_this.dwellMaxSeconds}, dwellHistogram: ${_this.dwellHistogram}, presenceSampleCount: ${_this.presenceSampleCount}, presenceSumSeconds: ${_this.presenceSumSeconds})';
}


}

/// @nodoc
abstract mixin class $AreaMetricsCopyWith<$Res>  {
  factory $AreaMetricsCopyWith(AreaMetrics value, $Res Function(AreaMetrics) _then) = _$AreaMetricsCopyWithImpl;
@useResult
$Res call({
 int areaId, String areaName,@RoundedDouble() double passBy,@RoundedDouble() double stagnant,@RoundedDouble() double entry,@RoundedDouble() double exit,@RoundedDouble() double appear,@RoundedDouble() double disappear, int occupancySampleCount, int occupancySum, int occupancySumSquares, int occupancyMax, int occupancyLast, int dwellSampleCount, int dwellSumSeconds, int dwellMaxSeconds, List<int> dwellHistogram, int presenceSampleCount, int presenceSumSeconds
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
@pragma('vm:prefer-inline') @override $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stagnant = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancySampleCount = null,Object? occupancySum = null,Object? occupancySumSquares = null,Object? occupancyMax = null,Object? occupancyLast = null,Object? dwellSampleCount = null,Object? dwellSumSeconds = null,Object? dwellMaxSeconds = null,Object? dwellHistogram = null,Object? presenceSampleCount = null,Object? presenceSumSeconds = null,}) {
  return _then(AreaMetrics(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as double,stagnant: null == stagnant ? _self.stagnant : stagnant // ignore: cast_nullable_to_non_nullable
as double,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as double,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as double,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as double,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as double,occupancySampleCount: null == occupancySampleCount ? _self.occupancySampleCount : occupancySampleCount // ignore: cast_nullable_to_non_nullable
as int,occupancySum: null == occupancySum ? _self.occupancySum : occupancySum // ignore: cast_nullable_to_non_nullable
as int,occupancySumSquares: null == occupancySumSquares ? _self.occupancySumSquares : occupancySumSquares // ignore: cast_nullable_to_non_nullable
as int,occupancyMax: null == occupancyMax ? _self.occupancyMax : occupancyMax // ignore: cast_nullable_to_non_nullable
as int,occupancyLast: null == occupancyLast ? _self.occupancyLast : occupancyLast // ignore: cast_nullable_to_non_nullable
as int,dwellSampleCount: null == dwellSampleCount ? _self.dwellSampleCount : dwellSampleCount // ignore: cast_nullable_to_non_nullable
as int,dwellSumSeconds: null == dwellSumSeconds ? _self.dwellSumSeconds : dwellSumSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellMaxSeconds: null == dwellMaxSeconds ? _self.dwellMaxSeconds : dwellMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellHistogram: null == dwellHistogram ? _self.dwellHistogram : dwellHistogram // ignore: cast_nullable_to_non_nullable
as List<int>,presenceSampleCount: null == presenceSampleCount ? _self.presenceSampleCount : presenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,presenceSumSeconds: null == presenceSumSeconds ? _self.presenceSumSeconds : presenceSumSeconds // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int areaId,  String areaName, @RoundedDouble()  double passBy, @RoundedDouble()  double stagnant, @RoundedDouble()  double entry, @RoundedDouble()  double exit, @RoundedDouble()  double appear, @RoundedDouble()  double disappear,  int occupancySampleCount,  int occupancySum,  int occupancySumSquares,  int occupancyMax,  int occupancyLast,  int dwellSampleCount,  int dwellSumSeconds,  int dwellMaxSeconds,  List<int> dwellHistogram,  int presenceSampleCount,  int presenceSumSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AreaMetrics() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySum,_that.occupancySumSquares,_that.occupancyMax,_that.occupancyLast,_that.dwellSampleCount,_that.dwellSumSeconds,_that.dwellMaxSeconds,_that.dwellHistogram,_that.presenceSampleCount,_that.presenceSumSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int areaId,  String areaName, @RoundedDouble()  double passBy, @RoundedDouble()  double stagnant, @RoundedDouble()  double entry, @RoundedDouble()  double exit, @RoundedDouble()  double appear, @RoundedDouble()  double disappear,  int occupancySampleCount,  int occupancySum,  int occupancySumSquares,  int occupancyMax,  int occupancyLast,  int dwellSampleCount,  int dwellSumSeconds,  int dwellMaxSeconds,  List<int> dwellHistogram,  int presenceSampleCount,  int presenceSumSeconds)  $default,) {final _that = this;
switch (_that) {
case _AreaMetrics():
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySum,_that.occupancySumSquares,_that.occupancyMax,_that.occupancyLast,_that.dwellSampleCount,_that.dwellSumSeconds,_that.dwellMaxSeconds,_that.dwellHistogram,_that.presenceSampleCount,_that.presenceSumSeconds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int areaId,  String areaName, @RoundedDouble()  double passBy, @RoundedDouble()  double stagnant, @RoundedDouble()  double entry, @RoundedDouble()  double exit, @RoundedDouble()  double appear, @RoundedDouble()  double disappear,  int occupancySampleCount,  int occupancySum,  int occupancySumSquares,  int occupancyMax,  int occupancyLast,  int dwellSampleCount,  int dwellSumSeconds,  int dwellMaxSeconds,  List<int> dwellHistogram,  int presenceSampleCount,  int presenceSumSeconds)?  $default,) {final _that = this;
switch (_that) {
case _AreaMetrics() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySum,_that.occupancySumSquares,_that.occupancyMax,_that.occupancyLast,_that.dwellSampleCount,_that.dwellSumSeconds,_that.dwellMaxSeconds,_that.dwellHistogram,_that.presenceSampleCount,_that.presenceSumSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AreaMetrics extends AreaMetrics {
  const _AreaMetrics({required this.areaId, required this.areaName, @RoundedDouble() this.passBy = 0, @RoundedDouble() this.stagnant = 0, @RoundedDouble() this.entry = 0, @RoundedDouble() this.exit = 0, @RoundedDouble() this.appear = 0, @RoundedDouble() this.disappear = 0, this.occupancySampleCount = 0, this.occupancySum = 0, this.occupancySumSquares = 0, this.occupancyMax = 0, this.occupancyLast = 0, this.dwellSampleCount = 0, this.dwellSumSeconds = 0, this.dwellMaxSeconds = 0,  List<int> dwellHistogram = const [0, 0, 0, 0, 0, 0, 0, 0], this.presenceSampleCount = 0, this.presenceSumSeconds = 0}): _dwellHistogram = dwellHistogram,super._();
  factory _AreaMetrics.fromJson(Map<String, dynamic> json) => _$AreaMetricsFromJson(json);

/// Index matching the configured interest-area ID.
///
/// [kGlobalAreaId] represents the global monitored scene.
@override final  int areaId;
/// Name of the configured interest area.
@override final  String areaName;
/// Number of unique tracks that touched this area for the first time.
///
/// Each track is counted ONLY ONCE (subject to bounded track history), in
/// the observation where it first makes contact. It is not
/// counted again if it stays in the area or leaves and re-enters.
///
/// Example: a track first touches the area at 12:03. passBy increases by 1 in
/// the 12:00-12:05 observation only. If the same track stays there all day,
/// passBy stays unchanged in every later observation.
///
/// Because of this, the metric is additive: summing passBy over 5-minute
/// observations gives the hourly value, and so on up to the year. The result
/// is the number of new tracks first seen in that period.
///
/// Limitation: a new track ID (for example after a tracking ID switch or an
/// app restart) is a new track and is counted again.
@override@JsonKey()@RoundedDouble() final  double passBy;
/// Number of unique tracks that stayed inside the area continuously for at
/// least the configured stagnant threshold. Absences shorter than the
/// disappear threshold do not restart the clock.
///
/// Each track is counted ONLY ONCE (subject to bounded track history), in
/// the observation where it reaches the threshold.
///
/// Example: the threshold is 30 seconds and a track enters at 12:04:50. It
/// reaches 30 seconds at 12:05:20, so stagnant increases by 1 in the
/// 12:05-12:10 observation (not in 12:00-12:05, where the stay started).
///
/// This metric is additive across observations.
///
/// Limitation: a new track ID is a new track and is counted again.
@override@JsonKey()@RoundedDouble() final  double stagnant;
/// Number of tracks whose initial position was outside this area and were
/// later observed inside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first enters.
/// This is additive across observations, subject to bounded history.
@override@JsonKey()@RoundedDouble() final  double entry;
/// Number of tracks whose initial position was inside this area and were
/// later observed outside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first exits.
/// This is additive across observations, subject to bounded history.
@override@JsonKey()@RoundedDouble() final  double exit;
/// Number of tracks first detected with their center position inside this
/// area.
///
/// Applies to both local areas and the global monitored scene.
/// Each track ID is counted once in the observation where it first appears.
/// This is additive across observations, subject to bounded history.
@override@JsonKey()@RoundedDouble() final  double appear;
/// Number of tracks last seen inside the area and then absent long enough
/// to satisfy the configured disappear threshold.
///
/// Applies to both local areas and the global monitored scene.
///
/// For the global area, this means that the track was lost from scene
/// tracking; it does not mean that the object was confirmed to have
/// exited the camera view.
///
/// Each track ID is counted once while retained in tracker history. A
/// returning track may add another dwell sample but no second disappear.
/// Visits closed by source dropout, pause, clock jump, or stop do not count
/// as disappear. For a local area, this also fires when the track leaves
/// the area but remains visible elsewhere.
@override@JsonKey()@RoundedDouble() final  double disappear;
/// Number of occupancy samples in this observation.
///
/// Occupancy is sampled once per frame, so this equals
/// [Observation.frameCount]. It is kept here for convenience so each area
/// can be read on its own.
///
/// Its sum and sample count are additive across child observations.
@override@JsonKey() final  int occupancySampleCount;
/// Sum of the object counts across all occupancy samples.
///
/// Example: samples of 2, 3, and 1 objects give a sum of 6 and a count
/// of 3.
///
/// Additive across child observations.
@override@JsonKey() final  int occupancySum;
/// Sum of the squared object counts across all occupancy samples.
///
/// Example: samples of 2, 3, and 1 objects give 4 + 9 + 1 = 14.
///
/// Additive across child observations. Together with
/// [occupancySum] and [occupancySampleCount] it gives the variance:
///
/// variance = occupancySumSquares / occupancySampleCount - mean²
///
/// The sum, sum of squares, and count remain the source of truth; the mean
/// and variance are derived from them.
@override@JsonKey() final  int occupancySumSquares;
/// Mean number of objects in the area per sample, or 0 when there are no
/// samples.
///
/// occupancyMean = occupancySum / occupancySampleCount
///
/// This is an average over frames, not over time, so no time-weighting is
/// applied. The sum and count remain the source of truth; this field is
/// included for convenience.
/// Maximum occupancy observed in any sample during this observation.
///
/// For an aggregated observation, this is the maximum value from its
/// child observations.
@override@JsonKey() final  int occupancyMax;
/// Most recent occupancy sample observed for this area. When no valid
/// occupancy sample exists, this is zero; use [occupancySampleCount] to
/// distinguish this from a measured zero.
///
/// This is state, not an additive metric; an aggregated observation
/// should retain the value from its latest child observation.
@override@JsonKey() final  int occupancyLast;
/// Number of finished visits recorded in this observation.
///
/// A visit is finished when the track has been gone from the area for the
/// disappear threshold. The whole visit is recorded ONCE, in the observation
/// where it is confirmed finished (not where it started).
///
/// Example: a visit from 12:03 to 12:13 adds one sample of 600 s to the
/// 12:10-12:15 observation and nothing to the earlier ones.
///
/// A visit that spans midnight is recorded in the day it finishes. Visits
/// still open when the source drops out, monitoring pauses, the clock
/// jumps, or monitoring stops are discarded without a dwell sample because
/// the interruption does not establish when the track actually left.
/// Resetting or changing interest areas also discards open visits.
///
/// Additive across child observations.
@override@JsonKey() final  int dwellSampleCount;
/// Sum of dwell durations, in whole seconds, across all dwell samples.
///
/// Each dwell sample is rounded to whole seconds before it is added.
///
/// Additive across child observations.
@override@JsonKey() final  int dwellSumSeconds;
/// Mean dwell time in seconds across all dwell samples, or 0 when there
/// are no samples.
///
/// dwellMeanSeconds = dwellSumSeconds / dwellSampleCount
///
/// No time-weighting is applied. The sum and count remain the source of
/// truth; this field is included for convenience.
/// Longest finished visit recorded in this observation, in whole seconds.
///
/// Attributed to the observation where the visit finished. For an aggregated
/// observation, this is the maximum of its child observations.
@override@JsonKey() final  int dwellMaxSeconds;
/// Number of finished visits in each duration bucket, in order:
/// `<5s, 5-15s, 15-60s, 1-5min, 5-10min, 10-30min, 30-60min, >=60min`.
///
/// Each bucket includes its lower edge and excludes its upper edge (a 300 s
/// visit is in 5-10min, and a 3600 s visit is in >=60min). The edges are
/// fixed by [kDwellBucketEdgesSeconds]; the list always has [kDwellBucketCount]
/// Additive across child observations: add the lists element by element.
 final  List<int> _dwellHistogram;
/// Number of finished visits in each duration bucket, in order:
/// `<5s, 5-15s, 15-60s, 1-5min, 5-10min, 10-30min, 30-60min, >=60min`.
///
/// Each bucket includes its lower edge and excludes its upper edge (a 300 s
/// visit is in 5-10min, and a 3600 s visit is in >=60min). The edges are
/// fixed by [kDwellBucketEdgesSeconds]; the list always has [kDwellBucketCount]
/// Additive across child observations: add the lists element by element.
@override@JsonKey() List<int> get dwellHistogram {
  if (_dwellHistogram is EqualUnmodifiableListView) return _dwellHistogram;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dwellHistogram);
}

/// Number of tracks present for a positive amount of time during this
/// observation. Each present track is one sample.
///
/// A track that stays across several observations is a separate sample in
/// each one, so at hour, day or longer levels this is a count of
/// track-observation pairs, not of distinct tracks (use passBy for that).
///
/// Additive across child observations.
@override@JsonKey() final  int presenceSampleCount;
/// Total seconds that tracks spent inside the area during this observation
/// (track-seconds, rounded to whole seconds per observation).
///
/// Example: a track inside from 12:03 to 12:13 adds 120 s to 12:00-12:05,
/// 300 s to 12:05-12:10 and 180 s to 12:10-12:15.
///
/// When `Observation.coveredSeconds` is positive,
/// presenceSumSeconds / coveredSeconds is the time-weighted average number
/// of tracks in the area while detection data was valid. Unlike
/// [occupancyMean], it does not depend on frame rate.
///
/// Additive across child observations.
@override@JsonKey() final  int presenceSumSeconds;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaMetrics&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stagnant, stagnant) || other.stagnant == stagnant)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.occupancySampleCount, occupancySampleCount) || other.occupancySampleCount == occupancySampleCount)&&(identical(other.occupancySum, occupancySum) || other.occupancySum == occupancySum)&&(identical(other.occupancySumSquares, occupancySumSquares) || other.occupancySumSquares == occupancySumSquares)&&(identical(other.occupancyMax, occupancyMax) || other.occupancyMax == occupancyMax)&&(identical(other.occupancyLast, occupancyLast) || other.occupancyLast == occupancyLast)&&(identical(other.dwellSampleCount, dwellSampleCount) || other.dwellSampleCount == dwellSampleCount)&&(identical(other.dwellSumSeconds, dwellSumSeconds) || other.dwellSumSeconds == dwellSumSeconds)&&(identical(other.dwellMaxSeconds, dwellMaxSeconds) || other.dwellMaxSeconds == dwellMaxSeconds)&&const DeepCollectionEquality().equals(other.dwellHistogram, _dwellHistogram)&&(identical(other.presenceSampleCount, presenceSampleCount) || other.presenceSampleCount == presenceSampleCount)&&(identical(other.presenceSumSeconds, presenceSumSeconds) || other.presenceSumSeconds == presenceSumSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,areaId,areaName,passBy,stagnant,entry,exit,appear,disappear,occupancySampleCount,occupancySum,occupancySumSquares,occupancyMax,occupancyLast,dwellSampleCount,dwellSumSeconds,dwellMaxSeconds,const DeepCollectionEquality().hash(_dwellHistogram),presenceSampleCount,presenceSumSeconds]);
}

@override
String toString() {
    return 'AreaMetrics(areaId: $areaId, areaName: $areaName, passBy: $passBy, stagnant: $stagnant, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, occupancySampleCount: $occupancySampleCount, occupancySum: $occupancySum, occupancySumSquares: $occupancySumSquares, occupancyMax: $occupancyMax, occupancyLast: $occupancyLast, dwellSampleCount: $dwellSampleCount, dwellSumSeconds: $dwellSumSeconds, dwellMaxSeconds: $dwellMaxSeconds, dwellHistogram: $dwellHistogram, presenceSampleCount: $presenceSampleCount, presenceSumSeconds: $presenceSumSeconds)';
}


}

/// @nodoc
abstract mixin class _$AreaMetricsCopyWith<$Res> implements $AreaMetricsCopyWith<$Res> {
  factory _$AreaMetricsCopyWith(_AreaMetrics value, $Res Function(_AreaMetrics) _then) = __$AreaMetricsCopyWithImpl;
@override @useResult
$Res call({
 int areaId, String areaName,@RoundedDouble() double passBy,@RoundedDouble() double stagnant,@RoundedDouble() double entry,@RoundedDouble() double exit,@RoundedDouble() double appear,@RoundedDouble() double disappear, int occupancySampleCount, int occupancySum, int occupancySumSquares, int occupancyMax, int occupancyLast, int dwellSampleCount, int dwellSumSeconds, int dwellMaxSeconds, List<int> dwellHistogram, int presenceSampleCount, int presenceSumSeconds
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
@override @pragma('vm:prefer-inline') $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stagnant = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancySampleCount = null,Object? occupancySum = null,Object? occupancySumSquares = null,Object? occupancyMax = null,Object? occupancyLast = null,Object? dwellSampleCount = null,Object? dwellSumSeconds = null,Object? dwellMaxSeconds = null,Object? dwellHistogram = null,Object? presenceSampleCount = null,Object? presenceSumSeconds = null,}) {
  return _then(_AreaMetrics(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as double,stagnant: null == stagnant ? _self.stagnant : stagnant // ignore: cast_nullable_to_non_nullable
as double,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as double,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as double,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as double,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as double,occupancySampleCount: null == occupancySampleCount ? _self.occupancySampleCount : occupancySampleCount // ignore: cast_nullable_to_non_nullable
as int,occupancySum: null == occupancySum ? _self.occupancySum : occupancySum // ignore: cast_nullable_to_non_nullable
as int,occupancySumSquares: null == occupancySumSquares ? _self.occupancySumSquares : occupancySumSquares // ignore: cast_nullable_to_non_nullable
as int,occupancyMax: null == occupancyMax ? _self.occupancyMax : occupancyMax // ignore: cast_nullable_to_non_nullable
as int,occupancyLast: null == occupancyLast ? _self.occupancyLast : occupancyLast // ignore: cast_nullable_to_non_nullable
as int,dwellSampleCount: null == dwellSampleCount ? _self.dwellSampleCount : dwellSampleCount // ignore: cast_nullable_to_non_nullable
as int,dwellSumSeconds: null == dwellSumSeconds ? _self.dwellSumSeconds : dwellSumSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellMaxSeconds: null == dwellMaxSeconds ? _self.dwellMaxSeconds : dwellMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellHistogram: null == dwellHistogram ? _self._dwellHistogram : dwellHistogram // ignore: cast_nullable_to_non_nullable
as List<int>,presenceSampleCount: null == presenceSampleCount ? _self.presenceSampleCount : presenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,presenceSumSeconds: null == presenceSumSeconds ? _self.presenceSumSeconds : presenceSumSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
