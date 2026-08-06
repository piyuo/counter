// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DetectionParams _$DetectionParamsFromJson(Map<String, dynamic> json) => _DetectionParams(
  trackHighThresh: (json['trackHighThresh'] as num?)?.toDouble() ?? 0.6,
  trackLowThresh: (json['trackLowThresh'] as num?)?.toDouble() ?? 0.05,
  newTrackThresh: (json['newTrackThresh'] as num?)?.toDouble() ?? 0.75,
  maxTimeLostSec: (json['maxTimeLostSec'] as num?)?.toDouble() ?? 3,
  maxMatchDistance: (json['maxMatchDistance'] as num?)?.toDouble() ?? 0.9,
  proximityThresh: (json['proximityThresh'] as num?)?.toDouble() ?? 0.95,
  appearanceThresh: (json['appearanceThresh'] as num?)?.toDouble() ?? 0.5,
  lambda: (json['lambda'] as num?)?.toDouble() ?? 0.990,
  softMotionGating: json['softMotionGating'] as bool? ?? true,
  preferAppearanceFallbackOnLowIou: json['preferAppearanceFallbackOnLowIou'] as bool? ?? true,
  trackletMinPresenceTimeSec: (json['trackletMinPresenceTimeSec'] as num?)?.toDouble() ?? 1,
  trackletEdgeMargin: (json['trackletEdgeMargin'] as num?)?.toInt() ?? 32,
  trackletEdgeOverrideTimeSec: (json['trackletEdgeOverrideTimeSec'] as num?)?.toDouble() ?? 2.0,
  stayThresholdSeconds: (json['stayThresholdSeconds'] as num?)?.toInt() ?? 15,
  disappearThresholdSeconds: (json['disappearThresholdSeconds'] as num?)?.toInt() ?? 7,
);

Map<String, dynamic> _$DetectionParamsToJson(_DetectionParams instance) => <String, dynamic>{
  'trackHighThresh': instance.trackHighThresh,
  'trackLowThresh': instance.trackLowThresh,
  'newTrackThresh': instance.newTrackThresh,
  'maxTimeLostSec': instance.maxTimeLostSec,
  'maxMatchDistance': instance.maxMatchDistance,
  'proximityThresh': instance.proximityThresh,
  'appearanceThresh': instance.appearanceThresh,
  'lambda': instance.lambda,
  'softMotionGating': instance.softMotionGating,
  'preferAppearanceFallbackOnLowIou': instance.preferAppearanceFallbackOnLowIou,
  'trackletMinPresenceTimeSec': instance.trackletMinPresenceTimeSec,
  'trackletEdgeMargin': instance.trackletEdgeMargin,
  'trackletEdgeOverrideTimeSec': instance.trackletEdgeOverrideTimeSec,
  'stayThresholdSeconds': instance.stayThresholdSeconds,
  'disappearThresholdSeconds': instance.disappearThresholdSeconds,
};
