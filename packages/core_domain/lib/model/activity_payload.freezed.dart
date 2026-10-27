// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityPayload {

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
 int get passBy;/// Number of unique tracks that stayed inside the area continuously for at
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
 int get stagnant;/// Number of tracks whose initial position was outside this area and were
/// later observed inside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first enters.
/// This is additive across observations, subject to bounded history.
 int get entry;/// Number of tracks whose initial position was inside this area and were
/// later observed outside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first exits.
/// This is additive across observations, subject to bounded history.
 int get exit;/// Number of tracks first detected with their center position inside this
/// area.
///
/// Applies to both local areas and the global monitored scene.
/// Each track ID is counted once in the observation where it first appears.
/// This is additive across observations, subject to bounded history.
 int get appear;/// Number of tracks last seen inside the area and then absent long enough
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
 int get disappear;/// Number of occupancy samples in this observation.
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
 int get occupancySum;/// Mean number of objects in the area per sample, or 0 when there are no
/// samples.
///
/// occupancyMean = occupancySampleSum / occupancySampleCount
///
/// This is an average over frames, not over time, so no time-weighting is
/// applied. The sum and count remain the source of truth; this field is
/// included for convenience.
@RoundedDouble() double get occupancyMean;/// Sum of the squared object counts across all occupancy samples.
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
 int get occupancySumSquares;/// Variance of the number of objects in the area per sample, or 0 when there are no samples.
///
/// occupancyVariance = occupancySumSquares / occupancySampleCount - occupancyMean * occupancyMean
///
/// This is an average over frames, not over time, so no time-weighting is applied. The sum of squares and count remain the source of truth; this field is included for convenience.
@RoundedDouble() double get occupancyVariance;/// Mean number of objects in the area per sample, or 0 when there are no
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
 int get occupancyMax;/// Most recent occupancy sample observed for this area. Aggregates use -1
/// when no valid occupancy sample exists; use [occupancySampleCount] to
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
@RoundedDouble() double get dwellMeanSeconds;/// Mean dwell time in seconds across all dwell samples, or 0 when there
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
 int get presenceSumSeconds;/// Mean seconds each present track spent inside during this observation, or
/// 0 when there are no samples.
///
/// presenceMeanSeconds = presenceSumSeconds / presenceTrackCount
///
/// This is not visit length. The sums and count remain the source of truth;
/// this field is included for convenience.
@RoundedDouble() double get presenceMeanSeconds;
/// Create a copy of ActivityPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityPayloadCopyWith<ActivityPayload> get copyWith => _$ActivityPayloadCopyWithImpl<ActivityPayload>(this as ActivityPayload, _$identity);

  /// Serializes this ActivityPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityPayload&&(identical(other.areaId, _this.areaId) || other.areaId == _this.areaId)&&(identical(other.areaName, _this.areaName) || other.areaName == _this.areaName)&&(identical(other.passBy, _this.passBy) || other.passBy == _this.passBy)&&(identical(other.stagnant, _this.stagnant) || other.stagnant == _this.stagnant)&&(identical(other.entry, _this.entry) || other.entry == _this.entry)&&(identical(other.exit, _this.exit) || other.exit == _this.exit)&&(identical(other.appear, _this.appear) || other.appear == _this.appear)&&(identical(other.disappear, _this.disappear) || other.disappear == _this.disappear)&&(identical(other.occupancySampleCount, _this.occupancySampleCount) || other.occupancySampleCount == _this.occupancySampleCount)&&(identical(other.occupancySum, _this.occupancySum) || other.occupancySum == _this.occupancySum)&&(identical(other.occupancyMean, _this.occupancyMean) || other.occupancyMean == _this.occupancyMean)&&(identical(other.occupancySumSquares, _this.occupancySumSquares) || other.occupancySumSquares == _this.occupancySumSquares)&&(identical(other.occupancyVariance, _this.occupancyVariance) || other.occupancyVariance == _this.occupancyVariance)&&(identical(other.occupancyMax, _this.occupancyMax) || other.occupancyMax == _this.occupancyMax)&&(identical(other.occupancyLast, _this.occupancyLast) || other.occupancyLast == _this.occupancyLast)&&(identical(other.dwellSampleCount, _this.dwellSampleCount) || other.dwellSampleCount == _this.dwellSampleCount)&&(identical(other.dwellSumSeconds, _this.dwellSumSeconds) || other.dwellSumSeconds == _this.dwellSumSeconds)&&(identical(other.dwellMeanSeconds, _this.dwellMeanSeconds) || other.dwellMeanSeconds == _this.dwellMeanSeconds)&&(identical(other.dwellMaxSeconds, _this.dwellMaxSeconds) || other.dwellMaxSeconds == _this.dwellMaxSeconds)&&const DeepCollectionEquality().equals(other.dwellHistogram, _this.dwellHistogram)&&(identical(other.presenceSampleCount, _this.presenceSampleCount) || other.presenceSampleCount == _this.presenceSampleCount)&&(identical(other.presenceSumSeconds, _this.presenceSumSeconds) || other.presenceSumSeconds == _this.presenceSumSeconds)&&(identical(other.presenceMeanSeconds, _this.presenceMeanSeconds) || other.presenceMeanSeconds == _this.presenceMeanSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityPayload;
  return Object.hashAll([runtimeType,_this.areaId,_this.areaName,_this.passBy,_this.stagnant,_this.entry,_this.exit,_this.appear,_this.disappear,_this.occupancySampleCount,_this.occupancySum,_this.occupancyMean,_this.occupancySumSquares,_this.occupancyVariance,_this.occupancyMax,_this.occupancyLast,_this.dwellSampleCount,_this.dwellSumSeconds,_this.dwellMeanSeconds,_this.dwellMaxSeconds,const DeepCollectionEquality().hash(_this.dwellHistogram),_this.presenceSampleCount,_this.presenceSumSeconds,_this.presenceMeanSeconds]);
}

@override
String toString() {
  final _this = this as ActivityPayload;
  return 'ActivityPayload(areaId: ${_this.areaId}, areaName: ${_this.areaName}, passBy: ${_this.passBy}, stagnant: ${_this.stagnant}, entry: ${_this.entry}, exit: ${_this.exit}, appear: ${_this.appear}, disappear: ${_this.disappear}, occupancySampleCount: ${_this.occupancySampleCount}, occupancySum: ${_this.occupancySum}, occupancyMean: ${_this.occupancyMean}, occupancySumSquares: ${_this.occupancySumSquares}, occupancyVariance: ${_this.occupancyVariance}, occupancyMax: ${_this.occupancyMax}, occupancyLast: ${_this.occupancyLast}, dwellSampleCount: ${_this.dwellSampleCount}, dwellSumSeconds: ${_this.dwellSumSeconds}, dwellMeanSeconds: ${_this.dwellMeanSeconds}, dwellMaxSeconds: ${_this.dwellMaxSeconds}, dwellHistogram: ${_this.dwellHistogram}, presenceSampleCount: ${_this.presenceSampleCount}, presenceSumSeconds: ${_this.presenceSumSeconds}, presenceMeanSeconds: ${_this.presenceMeanSeconds})';
}


}

/// @nodoc
abstract mixin class $ActivityPayloadCopyWith<$Res>  {
  factory $ActivityPayloadCopyWith(ActivityPayload value, $Res Function(ActivityPayload) _then) = _$ActivityPayloadCopyWithImpl;
@useResult
$Res call({
 int areaId, String areaName, int passBy, int stagnant, int entry, int exit, int appear, int disappear, int occupancySampleCount, int occupancySum,@RoundedDouble() double occupancyMean, int occupancySumSquares,@RoundedDouble() double occupancyVariance, int occupancyMax, int occupancyLast, int dwellSampleCount, int dwellSumSeconds,@RoundedDouble() double dwellMeanSeconds, int dwellMaxSeconds, List<int> dwellHistogram, int presenceSampleCount, int presenceSumSeconds,@RoundedDouble() double presenceMeanSeconds
});




}
/// @nodoc
class _$ActivityPayloadCopyWithImpl<$Res>
    implements $ActivityPayloadCopyWith<$Res> {
  _$ActivityPayloadCopyWithImpl(this._self, this._then);

  final ActivityPayload _self;
  final $Res Function(ActivityPayload) _then;

/// Create a copy of ActivityPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stagnant = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancySampleCount = null,Object? occupancySum = null,Object? occupancyMean = null,Object? occupancySumSquares = null,Object? occupancyVariance = null,Object? occupancyMax = null,Object? occupancyLast = null,Object? dwellSampleCount = null,Object? dwellSumSeconds = null,Object? dwellMeanSeconds = null,Object? dwellMaxSeconds = null,Object? dwellHistogram = null,Object? presenceSampleCount = null,Object? presenceSumSeconds = null,Object? presenceMeanSeconds = null,}) {
  return _then(ActivityPayload(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stagnant: null == stagnant ? _self.stagnant : stagnant // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,occupancySampleCount: null == occupancySampleCount ? _self.occupancySampleCount : occupancySampleCount // ignore: cast_nullable_to_non_nullable
as int,occupancySum: null == occupancySum ? _self.occupancySum : occupancySum // ignore: cast_nullable_to_non_nullable
as int,occupancyMean: null == occupancyMean ? _self.occupancyMean : occupancyMean // ignore: cast_nullable_to_non_nullable
as double,occupancySumSquares: null == occupancySumSquares ? _self.occupancySumSquares : occupancySumSquares // ignore: cast_nullable_to_non_nullable
as int,occupancyVariance: null == occupancyVariance ? _self.occupancyVariance : occupancyVariance // ignore: cast_nullable_to_non_nullable
as double,occupancyMax: null == occupancyMax ? _self.occupancyMax : occupancyMax // ignore: cast_nullable_to_non_nullable
as int,occupancyLast: null == occupancyLast ? _self.occupancyLast : occupancyLast // ignore: cast_nullable_to_non_nullable
as int,dwellSampleCount: null == dwellSampleCount ? _self.dwellSampleCount : dwellSampleCount // ignore: cast_nullable_to_non_nullable
as int,dwellSumSeconds: null == dwellSumSeconds ? _self.dwellSumSeconds : dwellSumSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellMeanSeconds: null == dwellMeanSeconds ? _self.dwellMeanSeconds : dwellMeanSeconds // ignore: cast_nullable_to_non_nullable
as double,dwellMaxSeconds: null == dwellMaxSeconds ? _self.dwellMaxSeconds : dwellMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellHistogram: null == dwellHistogram ? _self.dwellHistogram : dwellHistogram // ignore: cast_nullable_to_non_nullable
as List<int>,presenceSampleCount: null == presenceSampleCount ? _self.presenceSampleCount : presenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,presenceSumSeconds: null == presenceSumSeconds ? _self.presenceSumSeconds : presenceSumSeconds // ignore: cast_nullable_to_non_nullable
as int,presenceMeanSeconds: null == presenceMeanSeconds ? _self.presenceMeanSeconds : presenceMeanSeconds // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityPayload].
extension ActivityPayloadPatterns on ActivityPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityPayload value)  $default,){
final _that = this;
switch (_that) {
case _ActivityPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityPayload value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int areaId,  String areaName,  int passBy,  int stagnant,  int entry,  int exit,  int appear,  int disappear,  int occupancySampleCount,  int occupancySum, @RoundedDouble()  double occupancyMean,  int occupancySumSquares, @RoundedDouble()  double occupancyVariance,  int occupancyMax,  int occupancyLast,  int dwellSampleCount,  int dwellSumSeconds, @RoundedDouble()  double dwellMeanSeconds,  int dwellMaxSeconds,  List<int> dwellHistogram,  int presenceSampleCount,  int presenceSumSeconds, @RoundedDouble()  double presenceMeanSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityPayload() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySum,_that.occupancyMean,_that.occupancySumSquares,_that.occupancyVariance,_that.occupancyMax,_that.occupancyLast,_that.dwellSampleCount,_that.dwellSumSeconds,_that.dwellMeanSeconds,_that.dwellMaxSeconds,_that.dwellHistogram,_that.presenceSampleCount,_that.presenceSumSeconds,_that.presenceMeanSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int areaId,  String areaName,  int passBy,  int stagnant,  int entry,  int exit,  int appear,  int disappear,  int occupancySampleCount,  int occupancySum, @RoundedDouble()  double occupancyMean,  int occupancySumSquares, @RoundedDouble()  double occupancyVariance,  int occupancyMax,  int occupancyLast,  int dwellSampleCount,  int dwellSumSeconds, @RoundedDouble()  double dwellMeanSeconds,  int dwellMaxSeconds,  List<int> dwellHistogram,  int presenceSampleCount,  int presenceSumSeconds, @RoundedDouble()  double presenceMeanSeconds)  $default,) {final _that = this;
switch (_that) {
case _ActivityPayload():
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySum,_that.occupancyMean,_that.occupancySumSquares,_that.occupancyVariance,_that.occupancyMax,_that.occupancyLast,_that.dwellSampleCount,_that.dwellSumSeconds,_that.dwellMeanSeconds,_that.dwellMaxSeconds,_that.dwellHistogram,_that.presenceSampleCount,_that.presenceSumSeconds,_that.presenceMeanSeconds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int areaId,  String areaName,  int passBy,  int stagnant,  int entry,  int exit,  int appear,  int disappear,  int occupancySampleCount,  int occupancySum, @RoundedDouble()  double occupancyMean,  int occupancySumSquares, @RoundedDouble()  double occupancyVariance,  int occupancyMax,  int occupancyLast,  int dwellSampleCount,  int dwellSumSeconds, @RoundedDouble()  double dwellMeanSeconds,  int dwellMaxSeconds,  List<int> dwellHistogram,  int presenceSampleCount,  int presenceSumSeconds, @RoundedDouble()  double presenceMeanSeconds)?  $default,) {final _that = this;
switch (_that) {
case _ActivityPayload() when $default != null:
return $default(_that.areaId,_that.areaName,_that.passBy,_that.stagnant,_that.entry,_that.exit,_that.appear,_that.disappear,_that.occupancySampleCount,_that.occupancySum,_that.occupancyMean,_that.occupancySumSquares,_that.occupancyVariance,_that.occupancyMax,_that.occupancyLast,_that.dwellSampleCount,_that.dwellSumSeconds,_that.dwellMeanSeconds,_that.dwellMaxSeconds,_that.dwellHistogram,_that.presenceSampleCount,_that.presenceSumSeconds,_that.presenceMeanSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityPayload extends ActivityPayload {
  const _ActivityPayload({required this.areaId, required this.areaName, this.passBy = 0, this.stagnant = 0, this.entry = 0, this.exit = 0, this.appear = 0, this.disappear = 0, this.occupancySampleCount = 0, this.occupancySum = 0, @RoundedDouble() this.occupancyMean = 0, this.occupancySumSquares = 0, @RoundedDouble() this.occupancyVariance = 0, this.occupancyMax = 0, this.occupancyLast = 0, this.dwellSampleCount = 0, this.dwellSumSeconds = 0, @RoundedDouble() required this.dwellMeanSeconds, this.dwellMaxSeconds = 0,  List<int> dwellHistogram = const [0, 0, 0, 0, 0, 0, 0, 0], this.presenceSampleCount = 0, this.presenceSumSeconds = 0, @RoundedDouble() this.presenceMeanSeconds = 0}): _dwellHistogram = dwellHistogram,super._();
  factory _ActivityPayload.fromJson(Map<String, dynamic> json) => _$ActivityPayloadFromJson(json);

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
@override@JsonKey() final  int passBy;
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
@override@JsonKey() final  int stagnant;
/// Number of tracks whose initial position was outside this area and were
/// later observed inside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first enters.
/// This is additive across observations, subject to bounded history.
@override@JsonKey() final  int entry;
/// Number of tracks whose initial position was inside this area and were
/// later observed outside it. Applies only to local areas; the global area
/// always reports zero.
///
/// Each track ID is counted once in the observation where it first exits.
/// This is additive across observations, subject to bounded history.
@override@JsonKey() final  int exit;
/// Number of tracks first detected with their center position inside this
/// area.
///
/// Applies to both local areas and the global monitored scene.
/// Each track ID is counted once in the observation where it first appears.
/// This is additive across observations, subject to bounded history.
@override@JsonKey() final  int appear;
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
@override@JsonKey() final  int disappear;
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
/// Mean number of objects in the area per sample, or 0 when there are no
/// samples.
///
/// occupancyMean = occupancySampleSum / occupancySampleCount
///
/// This is an average over frames, not over time, so no time-weighting is
/// applied. The sum and count remain the source of truth; this field is
/// included for convenience.
@override@JsonKey()@RoundedDouble() final  double occupancyMean;
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
/// Variance of the number of objects in the area per sample, or 0 when there are no samples.
///
/// occupancyVariance = occupancySumSquares / occupancySampleCount - occupancyMean * occupancyMean
///
/// This is an average over frames, not over time, so no time-weighting is applied. The sum of squares and count remain the source of truth; this field is included for convenience.
@override@JsonKey()@RoundedDouble() final  double occupancyVariance;
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
/// Most recent occupancy sample observed for this area. Aggregates use -1
/// when no valid occupancy sample exists; use [occupancySampleCount] to
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
@override@RoundedDouble() final  double dwellMeanSeconds;
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
/// Mean seconds each present track spent inside during this observation, or
/// 0 when there are no samples.
///
/// presenceMeanSeconds = presenceSumSeconds / presenceTrackCount
///
/// This is not visit length. The sums and count remain the source of truth;
/// this field is included for convenience.
@override@JsonKey()@RoundedDouble() final  double presenceMeanSeconds;

/// Create a copy of ActivityPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityPayloadCopyWith<_ActivityPayload> get copyWith => __$ActivityPayloadCopyWithImpl<_ActivityPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityPayload&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.areaName, areaName) || other.areaName == areaName)&&(identical(other.passBy, passBy) || other.passBy == passBy)&&(identical(other.stagnant, stagnant) || other.stagnant == stagnant)&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.appear, appear) || other.appear == appear)&&(identical(other.disappear, disappear) || other.disappear == disappear)&&(identical(other.occupancySampleCount, occupancySampleCount) || other.occupancySampleCount == occupancySampleCount)&&(identical(other.occupancySum, occupancySum) || other.occupancySum == occupancySum)&&(identical(other.occupancyMean, occupancyMean) || other.occupancyMean == occupancyMean)&&(identical(other.occupancySumSquares, occupancySumSquares) || other.occupancySumSquares == occupancySumSquares)&&(identical(other.occupancyVariance, occupancyVariance) || other.occupancyVariance == occupancyVariance)&&(identical(other.occupancyMax, occupancyMax) || other.occupancyMax == occupancyMax)&&(identical(other.occupancyLast, occupancyLast) || other.occupancyLast == occupancyLast)&&(identical(other.dwellSampleCount, dwellSampleCount) || other.dwellSampleCount == dwellSampleCount)&&(identical(other.dwellSumSeconds, dwellSumSeconds) || other.dwellSumSeconds == dwellSumSeconds)&&(identical(other.dwellMeanSeconds, dwellMeanSeconds) || other.dwellMeanSeconds == dwellMeanSeconds)&&(identical(other.dwellMaxSeconds, dwellMaxSeconds) || other.dwellMaxSeconds == dwellMaxSeconds)&&const DeepCollectionEquality().equals(other.dwellHistogram, _dwellHistogram)&&(identical(other.presenceSampleCount, presenceSampleCount) || other.presenceSampleCount == presenceSampleCount)&&(identical(other.presenceSumSeconds, presenceSumSeconds) || other.presenceSumSeconds == presenceSumSeconds)&&(identical(other.presenceMeanSeconds, presenceMeanSeconds) || other.presenceMeanSeconds == presenceMeanSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,areaId,areaName,passBy,stagnant,entry,exit,appear,disappear,occupancySampleCount,occupancySum,occupancyMean,occupancySumSquares,occupancyVariance,occupancyMax,occupancyLast,dwellSampleCount,dwellSumSeconds,dwellMeanSeconds,dwellMaxSeconds,const DeepCollectionEquality().hash(_dwellHistogram),presenceSampleCount,presenceSumSeconds,presenceMeanSeconds]);
}

@override
String toString() {
    return 'ActivityPayload(areaId: $areaId, areaName: $areaName, passBy: $passBy, stagnant: $stagnant, entry: $entry, exit: $exit, appear: $appear, disappear: $disappear, occupancySampleCount: $occupancySampleCount, occupancySum: $occupancySum, occupancyMean: $occupancyMean, occupancySumSquares: $occupancySumSquares, occupancyVariance: $occupancyVariance, occupancyMax: $occupancyMax, occupancyLast: $occupancyLast, dwellSampleCount: $dwellSampleCount, dwellSumSeconds: $dwellSumSeconds, dwellMeanSeconds: $dwellMeanSeconds, dwellMaxSeconds: $dwellMaxSeconds, dwellHistogram: $dwellHistogram, presenceSampleCount: $presenceSampleCount, presenceSumSeconds: $presenceSumSeconds, presenceMeanSeconds: $presenceMeanSeconds)';
}


}

/// @nodoc
abstract mixin class _$ActivityPayloadCopyWith<$Res> implements $ActivityPayloadCopyWith<$Res> {
  factory _$ActivityPayloadCopyWith(_ActivityPayload value, $Res Function(_ActivityPayload) _then) = __$ActivityPayloadCopyWithImpl;
@override @useResult
$Res call({
 int areaId, String areaName, int passBy, int stagnant, int entry, int exit, int appear, int disappear, int occupancySampleCount, int occupancySum,@RoundedDouble() double occupancyMean, int occupancySumSquares,@RoundedDouble() double occupancyVariance, int occupancyMax, int occupancyLast, int dwellSampleCount, int dwellSumSeconds,@RoundedDouble() double dwellMeanSeconds, int dwellMaxSeconds, List<int> dwellHistogram, int presenceSampleCount, int presenceSumSeconds,@RoundedDouble() double presenceMeanSeconds
});




}
/// @nodoc
class __$ActivityPayloadCopyWithImpl<$Res>
    implements _$ActivityPayloadCopyWith<$Res> {
  __$ActivityPayloadCopyWithImpl(this._self, this._then);

  final _ActivityPayload _self;
  final $Res Function(_ActivityPayload) _then;

/// Create a copy of ActivityPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaId = null,Object? areaName = null,Object? passBy = null,Object? stagnant = null,Object? entry = null,Object? exit = null,Object? appear = null,Object? disappear = null,Object? occupancySampleCount = null,Object? occupancySum = null,Object? occupancyMean = null,Object? occupancySumSquares = null,Object? occupancyVariance = null,Object? occupancyMax = null,Object? occupancyLast = null,Object? dwellSampleCount = null,Object? dwellSumSeconds = null,Object? dwellMeanSeconds = null,Object? dwellMaxSeconds = null,Object? dwellHistogram = null,Object? presenceSampleCount = null,Object? presenceSumSeconds = null,Object? presenceMeanSeconds = null,}) {
  return _then(_ActivityPayload(
areaId: null == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int,areaName: null == areaName ? _self.areaName : areaName // ignore: cast_nullable_to_non_nullable
as String,passBy: null == passBy ? _self.passBy : passBy // ignore: cast_nullable_to_non_nullable
as int,stagnant: null == stagnant ? _self.stagnant : stagnant // ignore: cast_nullable_to_non_nullable
as int,entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as int,exit: null == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as int,appear: null == appear ? _self.appear : appear // ignore: cast_nullable_to_non_nullable
as int,disappear: null == disappear ? _self.disappear : disappear // ignore: cast_nullable_to_non_nullable
as int,occupancySampleCount: null == occupancySampleCount ? _self.occupancySampleCount : occupancySampleCount // ignore: cast_nullable_to_non_nullable
as int,occupancySum: null == occupancySum ? _self.occupancySum : occupancySum // ignore: cast_nullable_to_non_nullable
as int,occupancyMean: null == occupancyMean ? _self.occupancyMean : occupancyMean // ignore: cast_nullable_to_non_nullable
as double,occupancySumSquares: null == occupancySumSquares ? _self.occupancySumSquares : occupancySumSquares // ignore: cast_nullable_to_non_nullable
as int,occupancyVariance: null == occupancyVariance ? _self.occupancyVariance : occupancyVariance // ignore: cast_nullable_to_non_nullable
as double,occupancyMax: null == occupancyMax ? _self.occupancyMax : occupancyMax // ignore: cast_nullable_to_non_nullable
as int,occupancyLast: null == occupancyLast ? _self.occupancyLast : occupancyLast // ignore: cast_nullable_to_non_nullable
as int,dwellSampleCount: null == dwellSampleCount ? _self.dwellSampleCount : dwellSampleCount // ignore: cast_nullable_to_non_nullable
as int,dwellSumSeconds: null == dwellSumSeconds ? _self.dwellSumSeconds : dwellSumSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellMeanSeconds: null == dwellMeanSeconds ? _self.dwellMeanSeconds : dwellMeanSeconds // ignore: cast_nullable_to_non_nullable
as double,dwellMaxSeconds: null == dwellMaxSeconds ? _self.dwellMaxSeconds : dwellMaxSeconds // ignore: cast_nullable_to_non_nullable
as int,dwellHistogram: null == dwellHistogram ? _self._dwellHistogram : dwellHistogram // ignore: cast_nullable_to_non_nullable
as List<int>,presenceSampleCount: null == presenceSampleCount ? _self.presenceSampleCount : presenceSampleCount // ignore: cast_nullable_to_non_nullable
as int,presenceSumSeconds: null == presenceSumSeconds ? _self.presenceSumSeconds : presenceSumSeconds // ignore: cast_nullable_to_non_nullable
as int,presenceMeanSeconds: null == presenceMeanSeconds ? _self.presenceMeanSeconds : presenceMeanSeconds // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
