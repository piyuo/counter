// TOC:
// - detectionParamsToVisionParams: converts persisted domain params to flutter_vision runtime params

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;

vision.VisionParams detectionParamsToVisionParams(core_domain.DetectionParams detectionParams) {
  return vision.VisionParams(
    trackHighThresh: detectionParams.trackHighThresh,
    trackLowThresh: detectionParams.trackLowThresh,
    newTrackThresh: detectionParams.newTrackThresh,
    trackBuffer: detectionParams.trackBuffer,
    maxMatchDistance: detectionParams.maxMatchDistance,
    proximityThresh: detectionParams.proximityThresh,
    appearanceThresh: detectionParams.appearanceThresh,
    frameRate: detectionParams.frameRate,
    lambda: detectionParams.lambda,
    softMotionGating: detectionParams.softMotionGating,
    preferAppearanceFallbackOnLowIou: detectionParams.preferAppearanceFallbackOnLowIou,
    trackletMinPresenceTimeSec: detectionParams.trackletMinPresenceTimeSec,
    trackletEdgeZoneRatio: detectionParams.trackletEdgeZoneRatio,
    trackletEdgeZoneMinPx: detectionParams.trackletEdgeZoneMinPx,
    trackletEdgeOverrideTimeSec: detectionParams.trackletEdgeOverrideTimeSec,
    stayThresholdSeconds: detectionParams.stayThresholdSeconds,
    disappearThresholdSeconds: detectionParams.disappearThresholdSeconds,
  );
}
