// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detection_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetectionParams {

/// Detection confidence required to enter the first, high-confidence
/// association pass.
 double get trackHighThresh;/// Minimum detection confidence required to be considered by the tracker at
/// all. Detections below this are ignored. Detections between this threshold
/// and [trackHighThresh] are only used in the second, low-confidence pass.
 double get trackLowThresh;/// Minimum confidence required to start a brand new track after association.
/// This is checked after all matching passes complete.
 double get newTrackThresh;// Seconds a track may stay Lost before removal, measured via steady_clock
 double get maxTimeLostSec;/// Maximum fused association cost accepted by linear assignment in the first
/// high-confidence association pass. Lower costs are better; larger values
/// make that pass more permissive. This does not affect the later
/// low-confidence and unconfirmed passes, which use fixed thresholds.
 double get maxMatchDistance;/// IoU-distance threshold used to mark a track/detection pair as spatially
/// poor during the high-confidence and unconfirmed association passes.
/// Native code uses IoU distance `(1 - IoU)`, so lower values mean better
/// overlap. This does not affect the second low-confidence pass, which uses
/// raw IoU distance without this mask.
 double get proximityThresh;/// Maximum embedding distance allowed before appearance matching is masked
/// out in the ReID-enabled high-confidence and unconfirmed association
/// passes. Lower values require closer visual similarity. If either side is
/// missing an embedding feature, native code treats that pair as max
/// distance and masks appearance matching for it as well.
 double get appearanceThresh;/// Blend factor used in the ReID-enabled motion-fusion step:
/// `fusedCost = lambda * appearanceCost + (1 - lambda) * motionDistance`.
/// Values closer to `1` keep appearance cost dominant; lower values
/// increase motion influence.
 double get lambda;/// When `true`, the ReID-enabled motion-fusion step always blends Kalman
/// gating distance into the embedding-cost matrix. When `false`, pairs
/// whose motion distance exceeds the chi-square gate are forcibly rejected
/// in that step before fusion.
 bool get softMotionGating;/// In the IoU/embedding fusion step, when `true`, poor-IoU pairs have their
/// IoU cue muted and may still match through appearance if their embedding
/// distance is good. When `false`, poor-IoU pairs instead have their
/// embedding cue muted, keeping association stricter and more spatially
/// conservative.
 bool get preferAppearanceFallbackOnLowIou;/// Minimum elapsed wall-clock time, in seconds, since the track started
/// before assigning a user-visible `trackletId`.
 double get trackletMinPresenceTimeSec;// Edge margin, in pixels. Objects detected within this distance from
// the frame boundary are not considered valid until they move away from
// the edge.
 int get trackletEdgeMargin;/// After the normal minimum-presence-time gate has been satisfied, allow
/// `trackletId` assignment even if the track center is still inside the
/// edge zone once elapsed time reaches this threshold. Set to `0` to
/// disable this edge-zone override.
 double get trackletEdgeOverrideTimeSec;/// Minimum continuous in-area duration, in seconds, before a track
/// contributes to `stayCount` in window counting.
 int get stayThresholdSeconds;// stay over ten minutes to count as a stay
/// Minimum continuous absence duration, in seconds, before a previously
/// in-area track contributes to `disappearCount` in window counting.
/// so a n object that made disappear must first pass the trackBuffer value to become lost then over disappearThresholdSeconds to count as a disappear to be disappear
 int get disappearThresholdSeconds;
/// Create a copy of DetectionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetectionParamsCopyWith<DetectionParams> get copyWith => _$DetectionParamsCopyWithImpl<DetectionParams>(this as DetectionParams, _$identity);

  /// Serializes this DetectionParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectionParams&&(identical(other.trackHighThresh, trackHighThresh) || other.trackHighThresh == trackHighThresh)&&(identical(other.trackLowThresh, trackLowThresh) || other.trackLowThresh == trackLowThresh)&&(identical(other.newTrackThresh, newTrackThresh) || other.newTrackThresh == newTrackThresh)&&(identical(other.maxTimeLostSec, maxTimeLostSec) || other.maxTimeLostSec == maxTimeLostSec)&&(identical(other.maxMatchDistance, maxMatchDistance) || other.maxMatchDistance == maxMatchDistance)&&(identical(other.proximityThresh, proximityThresh) || other.proximityThresh == proximityThresh)&&(identical(other.appearanceThresh, appearanceThresh) || other.appearanceThresh == appearanceThresh)&&(identical(other.lambda, lambda) || other.lambda == lambda)&&(identical(other.softMotionGating, softMotionGating) || other.softMotionGating == softMotionGating)&&(identical(other.preferAppearanceFallbackOnLowIou, preferAppearanceFallbackOnLowIou) || other.preferAppearanceFallbackOnLowIou == preferAppearanceFallbackOnLowIou)&&(identical(other.trackletMinPresenceTimeSec, trackletMinPresenceTimeSec) || other.trackletMinPresenceTimeSec == trackletMinPresenceTimeSec)&&(identical(other.trackletEdgeMargin, trackletEdgeMargin) || other.trackletEdgeMargin == trackletEdgeMargin)&&(identical(other.trackletEdgeOverrideTimeSec, trackletEdgeOverrideTimeSec) || other.trackletEdgeOverrideTimeSec == trackletEdgeOverrideTimeSec)&&(identical(other.stayThresholdSeconds, stayThresholdSeconds) || other.stayThresholdSeconds == stayThresholdSeconds)&&(identical(other.disappearThresholdSeconds, disappearThresholdSeconds) || other.disappearThresholdSeconds == disappearThresholdSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trackHighThresh,trackLowThresh,newTrackThresh,maxTimeLostSec,maxMatchDistance,proximityThresh,appearanceThresh,lambda,softMotionGating,preferAppearanceFallbackOnLowIou,trackletMinPresenceTimeSec,trackletEdgeMargin,trackletEdgeOverrideTimeSec,stayThresholdSeconds,disappearThresholdSeconds);

@override
String toString() {
  return 'DetectionParams(trackHighThresh: $trackHighThresh, trackLowThresh: $trackLowThresh, newTrackThresh: $newTrackThresh, maxTimeLostSec: $maxTimeLostSec, maxMatchDistance: $maxMatchDistance, proximityThresh: $proximityThresh, appearanceThresh: $appearanceThresh, lambda: $lambda, softMotionGating: $softMotionGating, preferAppearanceFallbackOnLowIou: $preferAppearanceFallbackOnLowIou, trackletMinPresenceTimeSec: $trackletMinPresenceTimeSec, trackletEdgeMargin: $trackletEdgeMargin, trackletEdgeOverrideTimeSec: $trackletEdgeOverrideTimeSec, stayThresholdSeconds: $stayThresholdSeconds, disappearThresholdSeconds: $disappearThresholdSeconds)';
}


}

/// @nodoc
abstract mixin class $DetectionParamsCopyWith<$Res>  {
  factory $DetectionParamsCopyWith(DetectionParams value, $Res Function(DetectionParams) _then) = _$DetectionParamsCopyWithImpl;
@useResult
$Res call({
 double trackHighThresh, double trackLowThresh, double newTrackThresh, double maxTimeLostSec, double maxMatchDistance, double proximityThresh, double appearanceThresh, double lambda, bool softMotionGating, bool preferAppearanceFallbackOnLowIou, double trackletMinPresenceTimeSec, int trackletEdgeMargin, double trackletEdgeOverrideTimeSec, int stayThresholdSeconds, int disappearThresholdSeconds
});




}
/// @nodoc
class _$DetectionParamsCopyWithImpl<$Res>
    implements $DetectionParamsCopyWith<$Res> {
  _$DetectionParamsCopyWithImpl(this._self, this._then);

  final DetectionParams _self;
  final $Res Function(DetectionParams) _then;

/// Create a copy of DetectionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trackHighThresh = null,Object? trackLowThresh = null,Object? newTrackThresh = null,Object? maxTimeLostSec = null,Object? maxMatchDistance = null,Object? proximityThresh = null,Object? appearanceThresh = null,Object? lambda = null,Object? softMotionGating = null,Object? preferAppearanceFallbackOnLowIou = null,Object? trackletMinPresenceTimeSec = null,Object? trackletEdgeMargin = null,Object? trackletEdgeOverrideTimeSec = null,Object? stayThresholdSeconds = null,Object? disappearThresholdSeconds = null,}) {
  return _then(_self.copyWith(
trackHighThresh: null == trackHighThresh ? _self.trackHighThresh : trackHighThresh // ignore: cast_nullable_to_non_nullable
as double,trackLowThresh: null == trackLowThresh ? _self.trackLowThresh : trackLowThresh // ignore: cast_nullable_to_non_nullable
as double,newTrackThresh: null == newTrackThresh ? _self.newTrackThresh : newTrackThresh // ignore: cast_nullable_to_non_nullable
as double,maxTimeLostSec: null == maxTimeLostSec ? _self.maxTimeLostSec : maxTimeLostSec // ignore: cast_nullable_to_non_nullable
as double,maxMatchDistance: null == maxMatchDistance ? _self.maxMatchDistance : maxMatchDistance // ignore: cast_nullable_to_non_nullable
as double,proximityThresh: null == proximityThresh ? _self.proximityThresh : proximityThresh // ignore: cast_nullable_to_non_nullable
as double,appearanceThresh: null == appearanceThresh ? _self.appearanceThresh : appearanceThresh // ignore: cast_nullable_to_non_nullable
as double,lambda: null == lambda ? _self.lambda : lambda // ignore: cast_nullable_to_non_nullable
as double,softMotionGating: null == softMotionGating ? _self.softMotionGating : softMotionGating // ignore: cast_nullable_to_non_nullable
as bool,preferAppearanceFallbackOnLowIou: null == preferAppearanceFallbackOnLowIou ? _self.preferAppearanceFallbackOnLowIou : preferAppearanceFallbackOnLowIou // ignore: cast_nullable_to_non_nullable
as bool,trackletMinPresenceTimeSec: null == trackletMinPresenceTimeSec ? _self.trackletMinPresenceTimeSec : trackletMinPresenceTimeSec // ignore: cast_nullable_to_non_nullable
as double,trackletEdgeMargin: null == trackletEdgeMargin ? _self.trackletEdgeMargin : trackletEdgeMargin // ignore: cast_nullable_to_non_nullable
as int,trackletEdgeOverrideTimeSec: null == trackletEdgeOverrideTimeSec ? _self.trackletEdgeOverrideTimeSec : trackletEdgeOverrideTimeSec // ignore: cast_nullable_to_non_nullable
as double,stayThresholdSeconds: null == stayThresholdSeconds ? _self.stayThresholdSeconds : stayThresholdSeconds // ignore: cast_nullable_to_non_nullable
as int,disappearThresholdSeconds: null == disappearThresholdSeconds ? _self.disappearThresholdSeconds : disappearThresholdSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DetectionParams].
extension DetectionParamsPatterns on DetectionParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetectionParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetectionParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetectionParams value)  $default,){
final _that = this;
switch (_that) {
case _DetectionParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetectionParams value)?  $default,){
final _that = this;
switch (_that) {
case _DetectionParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double trackHighThresh,  double trackLowThresh,  double newTrackThresh,  double maxTimeLostSec,  double maxMatchDistance,  double proximityThresh,  double appearanceThresh,  double lambda,  bool softMotionGating,  bool preferAppearanceFallbackOnLowIou,  double trackletMinPresenceTimeSec,  int trackletEdgeMargin,  double trackletEdgeOverrideTimeSec,  int stayThresholdSeconds,  int disappearThresholdSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetectionParams() when $default != null:
return $default(_that.trackHighThresh,_that.trackLowThresh,_that.newTrackThresh,_that.maxTimeLostSec,_that.maxMatchDistance,_that.proximityThresh,_that.appearanceThresh,_that.lambda,_that.softMotionGating,_that.preferAppearanceFallbackOnLowIou,_that.trackletMinPresenceTimeSec,_that.trackletEdgeMargin,_that.trackletEdgeOverrideTimeSec,_that.stayThresholdSeconds,_that.disappearThresholdSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double trackHighThresh,  double trackLowThresh,  double newTrackThresh,  double maxTimeLostSec,  double maxMatchDistance,  double proximityThresh,  double appearanceThresh,  double lambda,  bool softMotionGating,  bool preferAppearanceFallbackOnLowIou,  double trackletMinPresenceTimeSec,  int trackletEdgeMargin,  double trackletEdgeOverrideTimeSec,  int stayThresholdSeconds,  int disappearThresholdSeconds)  $default,) {final _that = this;
switch (_that) {
case _DetectionParams():
return $default(_that.trackHighThresh,_that.trackLowThresh,_that.newTrackThresh,_that.maxTimeLostSec,_that.maxMatchDistance,_that.proximityThresh,_that.appearanceThresh,_that.lambda,_that.softMotionGating,_that.preferAppearanceFallbackOnLowIou,_that.trackletMinPresenceTimeSec,_that.trackletEdgeMargin,_that.trackletEdgeOverrideTimeSec,_that.stayThresholdSeconds,_that.disappearThresholdSeconds);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double trackHighThresh,  double trackLowThresh,  double newTrackThresh,  double maxTimeLostSec,  double maxMatchDistance,  double proximityThresh,  double appearanceThresh,  double lambda,  bool softMotionGating,  bool preferAppearanceFallbackOnLowIou,  double trackletMinPresenceTimeSec,  int trackletEdgeMargin,  double trackletEdgeOverrideTimeSec,  int stayThresholdSeconds,  int disappearThresholdSeconds)?  $default,) {final _that = this;
switch (_that) {
case _DetectionParams() when $default != null:
return $default(_that.trackHighThresh,_that.trackLowThresh,_that.newTrackThresh,_that.maxTimeLostSec,_that.maxMatchDistance,_that.proximityThresh,_that.appearanceThresh,_that.lambda,_that.softMotionGating,_that.preferAppearanceFallbackOnLowIou,_that.trackletMinPresenceTimeSec,_that.trackletEdgeMargin,_that.trackletEdgeOverrideTimeSec,_that.stayThresholdSeconds,_that.disappearThresholdSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetectionParams extends DetectionParams {
  const _DetectionParams({this.trackHighThresh = 0.6, this.trackLowThresh = 0.05, this.newTrackThresh = 0.75, this.maxTimeLostSec = 3, this.maxMatchDistance = 0.9, this.proximityThresh = 0.95, this.appearanceThresh = 0.5, this.lambda = 0.990, this.softMotionGating = true, this.preferAppearanceFallbackOnLowIou = true, this.trackletMinPresenceTimeSec = 1, this.trackletEdgeMargin = 32, this.trackletEdgeOverrideTimeSec = 2.0, this.stayThresholdSeconds = 600, this.disappearThresholdSeconds = 7}): super._();
  factory _DetectionParams.fromJson(Map<String, dynamic> json) => _$DetectionParamsFromJson(json);

/// Detection confidence required to enter the first, high-confidence
/// association pass.
@override@JsonKey() final  double trackHighThresh;
/// Minimum detection confidence required to be considered by the tracker at
/// all. Detections below this are ignored. Detections between this threshold
/// and [trackHighThresh] are only used in the second, low-confidence pass.
@override@JsonKey() final  double trackLowThresh;
/// Minimum confidence required to start a brand new track after association.
/// This is checked after all matching passes complete.
@override@JsonKey() final  double newTrackThresh;
// Seconds a track may stay Lost before removal, measured via steady_clock
@override@JsonKey() final  double maxTimeLostSec;
/// Maximum fused association cost accepted by linear assignment in the first
/// high-confidence association pass. Lower costs are better; larger values
/// make that pass more permissive. This does not affect the later
/// low-confidence and unconfirmed passes, which use fixed thresholds.
@override@JsonKey() final  double maxMatchDistance;
/// IoU-distance threshold used to mark a track/detection pair as spatially
/// poor during the high-confidence and unconfirmed association passes.
/// Native code uses IoU distance `(1 - IoU)`, so lower values mean better
/// overlap. This does not affect the second low-confidence pass, which uses
/// raw IoU distance without this mask.
@override@JsonKey() final  double proximityThresh;
/// Maximum embedding distance allowed before appearance matching is masked
/// out in the ReID-enabled high-confidence and unconfirmed association
/// passes. Lower values require closer visual similarity. If either side is
/// missing an embedding feature, native code treats that pair as max
/// distance and masks appearance matching for it as well.
@override@JsonKey() final  double appearanceThresh;
/// Blend factor used in the ReID-enabled motion-fusion step:
/// `fusedCost = lambda * appearanceCost + (1 - lambda) * motionDistance`.
/// Values closer to `1` keep appearance cost dominant; lower values
/// increase motion influence.
@override@JsonKey() final  double lambda;
/// When `true`, the ReID-enabled motion-fusion step always blends Kalman
/// gating distance into the embedding-cost matrix. When `false`, pairs
/// whose motion distance exceeds the chi-square gate are forcibly rejected
/// in that step before fusion.
@override@JsonKey() final  bool softMotionGating;
/// In the IoU/embedding fusion step, when `true`, poor-IoU pairs have their
/// IoU cue muted and may still match through appearance if their embedding
/// distance is good. When `false`, poor-IoU pairs instead have their
/// embedding cue muted, keeping association stricter and more spatially
/// conservative.
@override@JsonKey() final  bool preferAppearanceFallbackOnLowIou;
/// Minimum elapsed wall-clock time, in seconds, since the track started
/// before assigning a user-visible `trackletId`.
@override@JsonKey() final  double trackletMinPresenceTimeSec;
// Edge margin, in pixels. Objects detected within this distance from
// the frame boundary are not considered valid until they move away from
// the edge.
@override@JsonKey() final  int trackletEdgeMargin;
/// After the normal minimum-presence-time gate has been satisfied, allow
/// `trackletId` assignment even if the track center is still inside the
/// edge zone once elapsed time reaches this threshold. Set to `0` to
/// disable this edge-zone override.
@override@JsonKey() final  double trackletEdgeOverrideTimeSec;
/// Minimum continuous in-area duration, in seconds, before a track
/// contributes to `stayCount` in window counting.
@override@JsonKey() final  int stayThresholdSeconds;
// stay over ten minutes to count as a stay
/// Minimum continuous absence duration, in seconds, before a previously
/// in-area track contributes to `disappearCount` in window counting.
/// so a n object that made disappear must first pass the trackBuffer value to become lost then over disappearThresholdSeconds to count as a disappear to be disappear
@override@JsonKey() final  int disappearThresholdSeconds;

/// Create a copy of DetectionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetectionParamsCopyWith<_DetectionParams> get copyWith => __$DetectionParamsCopyWithImpl<_DetectionParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetectionParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetectionParams&&(identical(other.trackHighThresh, trackHighThresh) || other.trackHighThresh == trackHighThresh)&&(identical(other.trackLowThresh, trackLowThresh) || other.trackLowThresh == trackLowThresh)&&(identical(other.newTrackThresh, newTrackThresh) || other.newTrackThresh == newTrackThresh)&&(identical(other.maxTimeLostSec, maxTimeLostSec) || other.maxTimeLostSec == maxTimeLostSec)&&(identical(other.maxMatchDistance, maxMatchDistance) || other.maxMatchDistance == maxMatchDistance)&&(identical(other.proximityThresh, proximityThresh) || other.proximityThresh == proximityThresh)&&(identical(other.appearanceThresh, appearanceThresh) || other.appearanceThresh == appearanceThresh)&&(identical(other.lambda, lambda) || other.lambda == lambda)&&(identical(other.softMotionGating, softMotionGating) || other.softMotionGating == softMotionGating)&&(identical(other.preferAppearanceFallbackOnLowIou, preferAppearanceFallbackOnLowIou) || other.preferAppearanceFallbackOnLowIou == preferAppearanceFallbackOnLowIou)&&(identical(other.trackletMinPresenceTimeSec, trackletMinPresenceTimeSec) || other.trackletMinPresenceTimeSec == trackletMinPresenceTimeSec)&&(identical(other.trackletEdgeMargin, trackletEdgeMargin) || other.trackletEdgeMargin == trackletEdgeMargin)&&(identical(other.trackletEdgeOverrideTimeSec, trackletEdgeOverrideTimeSec) || other.trackletEdgeOverrideTimeSec == trackletEdgeOverrideTimeSec)&&(identical(other.stayThresholdSeconds, stayThresholdSeconds) || other.stayThresholdSeconds == stayThresholdSeconds)&&(identical(other.disappearThresholdSeconds, disappearThresholdSeconds) || other.disappearThresholdSeconds == disappearThresholdSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trackHighThresh,trackLowThresh,newTrackThresh,maxTimeLostSec,maxMatchDistance,proximityThresh,appearanceThresh,lambda,softMotionGating,preferAppearanceFallbackOnLowIou,trackletMinPresenceTimeSec,trackletEdgeMargin,trackletEdgeOverrideTimeSec,stayThresholdSeconds,disappearThresholdSeconds);

@override
String toString() {
  return 'DetectionParams(trackHighThresh: $trackHighThresh, trackLowThresh: $trackLowThresh, newTrackThresh: $newTrackThresh, maxTimeLostSec: $maxTimeLostSec, maxMatchDistance: $maxMatchDistance, proximityThresh: $proximityThresh, appearanceThresh: $appearanceThresh, lambda: $lambda, softMotionGating: $softMotionGating, preferAppearanceFallbackOnLowIou: $preferAppearanceFallbackOnLowIou, trackletMinPresenceTimeSec: $trackletMinPresenceTimeSec, trackletEdgeMargin: $trackletEdgeMargin, trackletEdgeOverrideTimeSec: $trackletEdgeOverrideTimeSec, stayThresholdSeconds: $stayThresholdSeconds, disappearThresholdSeconds: $disappearThresholdSeconds)';
}


}

/// @nodoc
abstract mixin class _$DetectionParamsCopyWith<$Res> implements $DetectionParamsCopyWith<$Res> {
  factory _$DetectionParamsCopyWith(_DetectionParams value, $Res Function(_DetectionParams) _then) = __$DetectionParamsCopyWithImpl;
@override @useResult
$Res call({
 double trackHighThresh, double trackLowThresh, double newTrackThresh, double maxTimeLostSec, double maxMatchDistance, double proximityThresh, double appearanceThresh, double lambda, bool softMotionGating, bool preferAppearanceFallbackOnLowIou, double trackletMinPresenceTimeSec, int trackletEdgeMargin, double trackletEdgeOverrideTimeSec, int stayThresholdSeconds, int disappearThresholdSeconds
});




}
/// @nodoc
class __$DetectionParamsCopyWithImpl<$Res>
    implements _$DetectionParamsCopyWith<$Res> {
  __$DetectionParamsCopyWithImpl(this._self, this._then);

  final _DetectionParams _self;
  final $Res Function(_DetectionParams) _then;

/// Create a copy of DetectionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trackHighThresh = null,Object? trackLowThresh = null,Object? newTrackThresh = null,Object? maxTimeLostSec = null,Object? maxMatchDistance = null,Object? proximityThresh = null,Object? appearanceThresh = null,Object? lambda = null,Object? softMotionGating = null,Object? preferAppearanceFallbackOnLowIou = null,Object? trackletMinPresenceTimeSec = null,Object? trackletEdgeMargin = null,Object? trackletEdgeOverrideTimeSec = null,Object? stayThresholdSeconds = null,Object? disappearThresholdSeconds = null,}) {
  return _then(_DetectionParams(
trackHighThresh: null == trackHighThresh ? _self.trackHighThresh : trackHighThresh // ignore: cast_nullable_to_non_nullable
as double,trackLowThresh: null == trackLowThresh ? _self.trackLowThresh : trackLowThresh // ignore: cast_nullable_to_non_nullable
as double,newTrackThresh: null == newTrackThresh ? _self.newTrackThresh : newTrackThresh // ignore: cast_nullable_to_non_nullable
as double,maxTimeLostSec: null == maxTimeLostSec ? _self.maxTimeLostSec : maxTimeLostSec // ignore: cast_nullable_to_non_nullable
as double,maxMatchDistance: null == maxMatchDistance ? _self.maxMatchDistance : maxMatchDistance // ignore: cast_nullable_to_non_nullable
as double,proximityThresh: null == proximityThresh ? _self.proximityThresh : proximityThresh // ignore: cast_nullable_to_non_nullable
as double,appearanceThresh: null == appearanceThresh ? _self.appearanceThresh : appearanceThresh // ignore: cast_nullable_to_non_nullable
as double,lambda: null == lambda ? _self.lambda : lambda // ignore: cast_nullable_to_non_nullable
as double,softMotionGating: null == softMotionGating ? _self.softMotionGating : softMotionGating // ignore: cast_nullable_to_non_nullable
as bool,preferAppearanceFallbackOnLowIou: null == preferAppearanceFallbackOnLowIou ? _self.preferAppearanceFallbackOnLowIou : preferAppearanceFallbackOnLowIou // ignore: cast_nullable_to_non_nullable
as bool,trackletMinPresenceTimeSec: null == trackletMinPresenceTimeSec ? _self.trackletMinPresenceTimeSec : trackletMinPresenceTimeSec // ignore: cast_nullable_to_non_nullable
as double,trackletEdgeMargin: null == trackletEdgeMargin ? _self.trackletEdgeMargin : trackletEdgeMargin // ignore: cast_nullable_to_non_nullable
as int,trackletEdgeOverrideTimeSec: null == trackletEdgeOverrideTimeSec ? _self.trackletEdgeOverrideTimeSec : trackletEdgeOverrideTimeSec // ignore: cast_nullable_to_non_nullable
as double,stayThresholdSeconds: null == stayThresholdSeconds ? _self.stayThresholdSeconds : stayThresholdSeconds // ignore: cast_nullable_to_non_nullable
as int,disappearThresholdSeconds: null == disappearThresholdSeconds ? _self.disappearThresholdSeconds : disappearThresholdSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
