// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detection_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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
 double get newTrackThresh; double get maxTimeLostSeconds;/// Maximum fused association cost accepted by linear assignment in the first
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
 double get trackletMinPresenceTimeSeconds; int get trackletEdgeMargin;/// After the normal minimum-presence-time gate has been satisfied, allow
/// `trackletId` assignment even if the track center is still inside the
/// edge zone once elapsed time reaches this threshold. Set to `0` to
/// disable this edge-zone override.
 double get trackletEdgeOverrideTimeSeconds;/// Minimum continuous in-area duration, in seconds, before a track
/// contributes to `stagnant` in observation. default change to 300 seconds to reflect some one stop and buy things
 int get stagnantThresholdSeconds;/// Minimum continuous absence duration, in seconds, before a previously
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
  final _this = this as DetectionParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectionParams&&(identical(other.trackHighThresh, _this.trackHighThresh) || other.trackHighThresh == _this.trackHighThresh)&&(identical(other.trackLowThresh, _this.trackLowThresh) || other.trackLowThresh == _this.trackLowThresh)&&(identical(other.newTrackThresh, _this.newTrackThresh) || other.newTrackThresh == _this.newTrackThresh)&&(identical(other.maxTimeLostSeconds, _this.maxTimeLostSeconds) || other.maxTimeLostSeconds == _this.maxTimeLostSeconds)&&(identical(other.maxMatchDistance, _this.maxMatchDistance) || other.maxMatchDistance == _this.maxMatchDistance)&&(identical(other.proximityThresh, _this.proximityThresh) || other.proximityThresh == _this.proximityThresh)&&(identical(other.appearanceThresh, _this.appearanceThresh) || other.appearanceThresh == _this.appearanceThresh)&&(identical(other.lambda, _this.lambda) || other.lambda == _this.lambda)&&(identical(other.softMotionGating, _this.softMotionGating) || other.softMotionGating == _this.softMotionGating)&&(identical(other.preferAppearanceFallbackOnLowIou, _this.preferAppearanceFallbackOnLowIou) || other.preferAppearanceFallbackOnLowIou == _this.preferAppearanceFallbackOnLowIou)&&(identical(other.trackletMinPresenceTimeSeconds, _this.trackletMinPresenceTimeSeconds) || other.trackletMinPresenceTimeSeconds == _this.trackletMinPresenceTimeSeconds)&&(identical(other.trackletEdgeMargin, _this.trackletEdgeMargin) || other.trackletEdgeMargin == _this.trackletEdgeMargin)&&(identical(other.trackletEdgeOverrideTimeSeconds, _this.trackletEdgeOverrideTimeSeconds) || other.trackletEdgeOverrideTimeSeconds == _this.trackletEdgeOverrideTimeSeconds)&&(identical(other.stagnantThresholdSeconds, _this.stagnantThresholdSeconds) || other.stagnantThresholdSeconds == _this.stagnantThresholdSeconds)&&(identical(other.disappearThresholdSeconds, _this.disappearThresholdSeconds) || other.disappearThresholdSeconds == _this.disappearThresholdSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DetectionParams;
  return Object.hash(runtimeType,_this.trackHighThresh,_this.trackLowThresh,_this.newTrackThresh,_this.maxTimeLostSeconds,_this.maxMatchDistance,_this.proximityThresh,_this.appearanceThresh,_this.lambda,_this.softMotionGating,_this.preferAppearanceFallbackOnLowIou,_this.trackletMinPresenceTimeSeconds,_this.trackletEdgeMargin,_this.trackletEdgeOverrideTimeSeconds,_this.stagnantThresholdSeconds,_this.disappearThresholdSeconds);
}

@override
String toString() {
  final _this = this as DetectionParams;
  return 'DetectionParams(trackHighThresh: ${_this.trackHighThresh}, trackLowThresh: ${_this.trackLowThresh}, newTrackThresh: ${_this.newTrackThresh}, maxTimeLostSeconds: ${_this.maxTimeLostSeconds}, maxMatchDistance: ${_this.maxMatchDistance}, proximityThresh: ${_this.proximityThresh}, appearanceThresh: ${_this.appearanceThresh}, lambda: ${_this.lambda}, softMotionGating: ${_this.softMotionGating}, preferAppearanceFallbackOnLowIou: ${_this.preferAppearanceFallbackOnLowIou}, trackletMinPresenceTimeSeconds: ${_this.trackletMinPresenceTimeSeconds}, trackletEdgeMargin: ${_this.trackletEdgeMargin}, trackletEdgeOverrideTimeSeconds: ${_this.trackletEdgeOverrideTimeSeconds}, stagnantThresholdSeconds: ${_this.stagnantThresholdSeconds}, disappearThresholdSeconds: ${_this.disappearThresholdSeconds})';
}


}

/// @nodoc
abstract mixin class $DetectionParamsCopyWith<$Res>  {
  factory $DetectionParamsCopyWith(DetectionParams value, $Res Function(DetectionParams) _then) = _$DetectionParamsCopyWithImpl;
@useResult
$Res call({
 double trackHighThresh, double trackLowThresh, double newTrackThresh, double maxTimeLostSeconds, double maxMatchDistance, double proximityThresh, double appearanceThresh, double lambda, bool softMotionGating, bool preferAppearanceFallbackOnLowIou, double trackletMinPresenceTimeSeconds, int trackletEdgeMargin, double trackletEdgeOverrideTimeSeconds, int stagnantThresholdSeconds, int disappearThresholdSeconds
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
@pragma('vm:prefer-inline') @override $Res call({Object? trackHighThresh = null,Object? trackLowThresh = null,Object? newTrackThresh = null,Object? maxTimeLostSeconds = null,Object? maxMatchDistance = null,Object? proximityThresh = null,Object? appearanceThresh = null,Object? lambda = null,Object? softMotionGating = null,Object? preferAppearanceFallbackOnLowIou = null,Object? trackletMinPresenceTimeSeconds = null,Object? trackletEdgeMargin = null,Object? trackletEdgeOverrideTimeSeconds = null,Object? stagnantThresholdSeconds = null,Object? disappearThresholdSeconds = null,}) {
  return _then(DetectionParams(
trackHighThresh: null == trackHighThresh ? _self.trackHighThresh : trackHighThresh // ignore: cast_nullable_to_non_nullable
as double,trackLowThresh: null == trackLowThresh ? _self.trackLowThresh : trackLowThresh // ignore: cast_nullable_to_non_nullable
as double,newTrackThresh: null == newTrackThresh ? _self.newTrackThresh : newTrackThresh // ignore: cast_nullable_to_non_nullable
as double,maxTimeLostSeconds: null == maxTimeLostSeconds ? _self.maxTimeLostSeconds : maxTimeLostSeconds // ignore: cast_nullable_to_non_nullable
as double,maxMatchDistance: null == maxMatchDistance ? _self.maxMatchDistance : maxMatchDistance // ignore: cast_nullable_to_non_nullable
as double,proximityThresh: null == proximityThresh ? _self.proximityThresh : proximityThresh // ignore: cast_nullable_to_non_nullable
as double,appearanceThresh: null == appearanceThresh ? _self.appearanceThresh : appearanceThresh // ignore: cast_nullable_to_non_nullable
as double,lambda: null == lambda ? _self.lambda : lambda // ignore: cast_nullable_to_non_nullable
as double,softMotionGating: null == softMotionGating ? _self.softMotionGating : softMotionGating // ignore: cast_nullable_to_non_nullable
as bool,preferAppearanceFallbackOnLowIou: null == preferAppearanceFallbackOnLowIou ? _self.preferAppearanceFallbackOnLowIou : preferAppearanceFallbackOnLowIou // ignore: cast_nullable_to_non_nullable
as bool,trackletMinPresenceTimeSeconds: null == trackletMinPresenceTimeSeconds ? _self.trackletMinPresenceTimeSeconds : trackletMinPresenceTimeSeconds // ignore: cast_nullable_to_non_nullable
as double,trackletEdgeMargin: null == trackletEdgeMargin ? _self.trackletEdgeMargin : trackletEdgeMargin // ignore: cast_nullable_to_non_nullable
as int,trackletEdgeOverrideTimeSeconds: null == trackletEdgeOverrideTimeSeconds ? _self.trackletEdgeOverrideTimeSeconds : trackletEdgeOverrideTimeSeconds // ignore: cast_nullable_to_non_nullable
as double,stagnantThresholdSeconds: null == stagnantThresholdSeconds ? _self.stagnantThresholdSeconds : stagnantThresholdSeconds // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double trackHighThresh,  double trackLowThresh,  double newTrackThresh,  double maxTimeLostSeconds,  double maxMatchDistance,  double proximityThresh,  double appearanceThresh,  double lambda,  bool softMotionGating,  bool preferAppearanceFallbackOnLowIou,  double trackletMinPresenceTimeSeconds,  int trackletEdgeMargin,  double trackletEdgeOverrideTimeSeconds,  int stagnantThresholdSeconds,  int disappearThresholdSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetectionParams() when $default != null:
return $default(_that.trackHighThresh,_that.trackLowThresh,_that.newTrackThresh,_that.maxTimeLostSeconds,_that.maxMatchDistance,_that.proximityThresh,_that.appearanceThresh,_that.lambda,_that.softMotionGating,_that.preferAppearanceFallbackOnLowIou,_that.trackletMinPresenceTimeSeconds,_that.trackletEdgeMargin,_that.trackletEdgeOverrideTimeSeconds,_that.stagnantThresholdSeconds,_that.disappearThresholdSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double trackHighThresh,  double trackLowThresh,  double newTrackThresh,  double maxTimeLostSeconds,  double maxMatchDistance,  double proximityThresh,  double appearanceThresh,  double lambda,  bool softMotionGating,  bool preferAppearanceFallbackOnLowIou,  double trackletMinPresenceTimeSeconds,  int trackletEdgeMargin,  double trackletEdgeOverrideTimeSeconds,  int stagnantThresholdSeconds,  int disappearThresholdSeconds)  $default,) {final _that = this;
switch (_that) {
case _DetectionParams():
return $default(_that.trackHighThresh,_that.trackLowThresh,_that.newTrackThresh,_that.maxTimeLostSeconds,_that.maxMatchDistance,_that.proximityThresh,_that.appearanceThresh,_that.lambda,_that.softMotionGating,_that.preferAppearanceFallbackOnLowIou,_that.trackletMinPresenceTimeSeconds,_that.trackletEdgeMargin,_that.trackletEdgeOverrideTimeSeconds,_that.stagnantThresholdSeconds,_that.disappearThresholdSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double trackHighThresh,  double trackLowThresh,  double newTrackThresh,  double maxTimeLostSeconds,  double maxMatchDistance,  double proximityThresh,  double appearanceThresh,  double lambda,  bool softMotionGating,  bool preferAppearanceFallbackOnLowIou,  double trackletMinPresenceTimeSeconds,  int trackletEdgeMargin,  double trackletEdgeOverrideTimeSeconds,  int stagnantThresholdSeconds,  int disappearThresholdSeconds)?  $default,) {final _that = this;
switch (_that) {
case _DetectionParams() when $default != null:
return $default(_that.trackHighThresh,_that.trackLowThresh,_that.newTrackThresh,_that.maxTimeLostSeconds,_that.maxMatchDistance,_that.proximityThresh,_that.appearanceThresh,_that.lambda,_that.softMotionGating,_that.preferAppearanceFallbackOnLowIou,_that.trackletMinPresenceTimeSeconds,_that.trackletEdgeMargin,_that.trackletEdgeOverrideTimeSeconds,_that.stagnantThresholdSeconds,_that.disappearThresholdSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetectionParams extends DetectionParams {
  const _DetectionParams({this.trackHighThresh = 0.6, this.trackLowThresh = 0.05, this.newTrackThresh = 0.75, this.maxTimeLostSeconds = 3, this.maxMatchDistance = 0.9, this.proximityThresh = 0.95, this.appearanceThresh = 0.5, this.lambda = 0.990, this.softMotionGating = true, this.preferAppearanceFallbackOnLowIou = true, this.trackletMinPresenceTimeSeconds = 1, this.trackletEdgeMargin = 32, this.trackletEdgeOverrideTimeSeconds = 2.0, this.stagnantThresholdSeconds = 300, this.disappearThresholdSeconds = 7}): super._();
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
@override@JsonKey() final  double maxTimeLostSeconds;
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
@override@JsonKey() final  double trackletMinPresenceTimeSeconds;
@override@JsonKey() final  int trackletEdgeMargin;
/// After the normal minimum-presence-time gate has been satisfied, allow
/// `trackletId` assignment even if the track center is still inside the
/// edge zone once elapsed time reaches this threshold. Set to `0` to
/// disable this edge-zone override.
@override@JsonKey() final  double trackletEdgeOverrideTimeSeconds;
/// Minimum continuous in-area duration, in seconds, before a track
/// contributes to `stagnant` in observation. default change to 300 seconds to reflect some one stop and buy things
@override@JsonKey() final  int stagnantThresholdSeconds;
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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetectionParams&&(identical(other.trackHighThresh, trackHighThresh) || other.trackHighThresh == trackHighThresh)&&(identical(other.trackLowThresh, trackLowThresh) || other.trackLowThresh == trackLowThresh)&&(identical(other.newTrackThresh, newTrackThresh) || other.newTrackThresh == newTrackThresh)&&(identical(other.maxTimeLostSeconds, maxTimeLostSeconds) || other.maxTimeLostSeconds == maxTimeLostSeconds)&&(identical(other.maxMatchDistance, maxMatchDistance) || other.maxMatchDistance == maxMatchDistance)&&(identical(other.proximityThresh, proximityThresh) || other.proximityThresh == proximityThresh)&&(identical(other.appearanceThresh, appearanceThresh) || other.appearanceThresh == appearanceThresh)&&(identical(other.lambda, lambda) || other.lambda == lambda)&&(identical(other.softMotionGating, softMotionGating) || other.softMotionGating == softMotionGating)&&(identical(other.preferAppearanceFallbackOnLowIou, preferAppearanceFallbackOnLowIou) || other.preferAppearanceFallbackOnLowIou == preferAppearanceFallbackOnLowIou)&&(identical(other.trackletMinPresenceTimeSeconds, trackletMinPresenceTimeSeconds) || other.trackletMinPresenceTimeSeconds == trackletMinPresenceTimeSeconds)&&(identical(other.trackletEdgeMargin, trackletEdgeMargin) || other.trackletEdgeMargin == trackletEdgeMargin)&&(identical(other.trackletEdgeOverrideTimeSeconds, trackletEdgeOverrideTimeSeconds) || other.trackletEdgeOverrideTimeSeconds == trackletEdgeOverrideTimeSeconds)&&(identical(other.stagnantThresholdSeconds, stagnantThresholdSeconds) || other.stagnantThresholdSeconds == stagnantThresholdSeconds)&&(identical(other.disappearThresholdSeconds, disappearThresholdSeconds) || other.disappearThresholdSeconds == disappearThresholdSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,trackHighThresh,trackLowThresh,newTrackThresh,maxTimeLostSeconds,maxMatchDistance,proximityThresh,appearanceThresh,lambda,softMotionGating,preferAppearanceFallbackOnLowIou,trackletMinPresenceTimeSeconds,trackletEdgeMargin,trackletEdgeOverrideTimeSeconds,stagnantThresholdSeconds,disappearThresholdSeconds);
}

@override
String toString() {
    return 'DetectionParams(trackHighThresh: $trackHighThresh, trackLowThresh: $trackLowThresh, newTrackThresh: $newTrackThresh, maxTimeLostSeconds: $maxTimeLostSeconds, maxMatchDistance: $maxMatchDistance, proximityThresh: $proximityThresh, appearanceThresh: $appearanceThresh, lambda: $lambda, softMotionGating: $softMotionGating, preferAppearanceFallbackOnLowIou: $preferAppearanceFallbackOnLowIou, trackletMinPresenceTimeSeconds: $trackletMinPresenceTimeSeconds, trackletEdgeMargin: $trackletEdgeMargin, trackletEdgeOverrideTimeSeconds: $trackletEdgeOverrideTimeSeconds, stagnantThresholdSeconds: $stagnantThresholdSeconds, disappearThresholdSeconds: $disappearThresholdSeconds)';
}


}

/// @nodoc
abstract mixin class _$DetectionParamsCopyWith<$Res> implements $DetectionParamsCopyWith<$Res> {
  factory _$DetectionParamsCopyWith(_DetectionParams value, $Res Function(_DetectionParams) _then) = __$DetectionParamsCopyWithImpl;
@override @useResult
$Res call({
 double trackHighThresh, double trackLowThresh, double newTrackThresh, double maxTimeLostSeconds, double maxMatchDistance, double proximityThresh, double appearanceThresh, double lambda, bool softMotionGating, bool preferAppearanceFallbackOnLowIou, double trackletMinPresenceTimeSeconds, int trackletEdgeMargin, double trackletEdgeOverrideTimeSeconds, int stagnantThresholdSeconds, int disappearThresholdSeconds
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
@override @pragma('vm:prefer-inline') $Res call({Object? trackHighThresh = null,Object? trackLowThresh = null,Object? newTrackThresh = null,Object? maxTimeLostSeconds = null,Object? maxMatchDistance = null,Object? proximityThresh = null,Object? appearanceThresh = null,Object? lambda = null,Object? softMotionGating = null,Object? preferAppearanceFallbackOnLowIou = null,Object? trackletMinPresenceTimeSeconds = null,Object? trackletEdgeMargin = null,Object? trackletEdgeOverrideTimeSeconds = null,Object? stagnantThresholdSeconds = null,Object? disappearThresholdSeconds = null,}) {
  return _then(_DetectionParams(
trackHighThresh: null == trackHighThresh ? _self.trackHighThresh : trackHighThresh // ignore: cast_nullable_to_non_nullable
as double,trackLowThresh: null == trackLowThresh ? _self.trackLowThresh : trackLowThresh // ignore: cast_nullable_to_non_nullable
as double,newTrackThresh: null == newTrackThresh ? _self.newTrackThresh : newTrackThresh // ignore: cast_nullable_to_non_nullable
as double,maxTimeLostSeconds: null == maxTimeLostSeconds ? _self.maxTimeLostSeconds : maxTimeLostSeconds // ignore: cast_nullable_to_non_nullable
as double,maxMatchDistance: null == maxMatchDistance ? _self.maxMatchDistance : maxMatchDistance // ignore: cast_nullable_to_non_nullable
as double,proximityThresh: null == proximityThresh ? _self.proximityThresh : proximityThresh // ignore: cast_nullable_to_non_nullable
as double,appearanceThresh: null == appearanceThresh ? _self.appearanceThresh : appearanceThresh // ignore: cast_nullable_to_non_nullable
as double,lambda: null == lambda ? _self.lambda : lambda // ignore: cast_nullable_to_non_nullable
as double,softMotionGating: null == softMotionGating ? _self.softMotionGating : softMotionGating // ignore: cast_nullable_to_non_nullable
as bool,preferAppearanceFallbackOnLowIou: null == preferAppearanceFallbackOnLowIou ? _self.preferAppearanceFallbackOnLowIou : preferAppearanceFallbackOnLowIou // ignore: cast_nullable_to_non_nullable
as bool,trackletMinPresenceTimeSeconds: null == trackletMinPresenceTimeSeconds ? _self.trackletMinPresenceTimeSeconds : trackletMinPresenceTimeSeconds // ignore: cast_nullable_to_non_nullable
as double,trackletEdgeMargin: null == trackletEdgeMargin ? _self.trackletEdgeMargin : trackletEdgeMargin // ignore: cast_nullable_to_non_nullable
as int,trackletEdgeOverrideTimeSeconds: null == trackletEdgeOverrideTimeSeconds ? _self.trackletEdgeOverrideTimeSeconds : trackletEdgeOverrideTimeSeconds // ignore: cast_nullable_to_non_nullable
as double,stagnantThresholdSeconds: null == stagnantThresholdSeconds ? _self.stagnantThresholdSeconds : stagnantThresholdSeconds // ignore: cast_nullable_to_non_nullable
as int,disappearThresholdSeconds: null == disappearThresholdSeconds ? _self.disappearThresholdSeconds : disappearThresholdSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
