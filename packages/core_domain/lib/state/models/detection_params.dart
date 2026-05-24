// Model: DetectionParams
// Description: Domain-level tracker configuration that mirrors the native VisionParams struct
//   used by the vision C API. Lives in core_domain so the rest of the system never depends on
//   flutter_vision directly. Serialised to/from JSON (persisted inside AppState) and converted
//   to VisionParams only at the runtime boundary where the vision engine is configured.
// Presets:
//   - DetectionParams() — general-purpose defaults

import 'package:freezed_annotation/freezed_annotation.dart';

part 'detection_params.freezed.dart';
part 'detection_params.g.dart';

@freezed
abstract class DetectionParams with _$DetectionParams {
  const DetectionParams._();

  const factory DetectionParams({
    /// Detection confidence required to enter the first, high-confidence
    /// association pass.
    @Default(0.6) double trackHighThresh,

    /// Minimum detection confidence required to be considered by the tracker at
    /// all. Detections below this are ignored. Detections between this threshold
    /// and [trackHighThresh] are only used in the second, low-confidence pass.
    @Default(0.05) double trackLowThresh,

    /// Minimum confidence required to start a brand new track after association.
    /// This is checked after all matching passes complete.
    @Default(0.75) double newTrackThresh,

    /// Base lost-track retention window, expressed in 30-FPS-equivalent frames.
    /// Native code scales this by `frameRate / 30` to compute how long a lost
    /// track remains eligible for re-activation before it is removed.
    @Default(180) int trackBuffer,

    /// Maximum fused association cost accepted by linear assignment in the first
    /// high-confidence association pass. Lower costs are better; larger values
    /// make that pass more permissive. This does not affect the later
    /// low-confidence and unconfirmed passes, which use fixed thresholds.
    @Default(0.8) double maxMatchDistance,

    /// IoU-distance threshold used to mark a track/detection pair as spatially
    /// poor during the high-confidence and unconfirmed association passes.
    /// Native code uses IoU distance `(1 - IoU)`, so lower values mean better
    /// overlap. This does not affect the second low-confidence pass, which uses
    /// raw IoU distance without this mask.
    @Default(0.9) double proximityThresh,

    /// Maximum embedding distance allowed before appearance matching is masked
    /// out in the ReID-enabled high-confidence and unconfirmed association
    /// passes. Lower values require closer visual similarity. If either side is
    /// missing an embedding feature, native code treats that pair as max
    /// distance and masks appearance matching for it as well.
    @Default(0.5) double appearanceThresh,

    /// Blend factor used in the ReID-enabled motion-fusion step:
    /// `fusedCost = lambda * appearanceCost + (1 - lambda) * motionDistance`.
    /// Values closer to `1` keep appearance cost dominant; lower values
    /// increase motion influence.
    @Default(0.990) double lambda,

    /// When `true`, the ReID-enabled motion-fusion step always blends Kalman
    /// gating distance into the embedding-cost matrix. When `false`, pairs
    /// whose motion distance exceeds the chi-square gate are forcibly rejected
    /// in that step before fusion.
    @Default(true) bool softMotionGating,

    /// In the IoU/embedding fusion step, when `true`, poor-IoU pairs have their
    /// IoU cue muted and may still match through appearance if their embedding
    /// distance is good. When `false`, poor-IoU pairs instead have their
    /// embedding cue muted, keeping association stricter and more spatially
    /// conservative.
    @Default(true) bool preferAppearanceFallbackOnLowIou,

    /// Minimum elapsed wall-clock time, in seconds, since the track started
    /// before assigning a user-visible `trackletId`.
    @Default(1.2) double trackletMinPresenceTimeSec,

    // Edge margin, in pixels. Objects detected within this distance from
    // the frame boundary are not considered valid until they move away from
    // the edge.
    @Default(32) int trackletEdgeMargin,

    /// After the normal minimum-presence-time gate has been satisfied, allow
    /// `trackletId` assignment even if the track center is still inside the
    /// edge zone once elapsed time reaches this threshold. Set to `0` to
    /// disable this edge-zone override.
    @Default(2.0) double trackletEdgeOverrideTimeSec,

    /// Minimum continuous in-area duration, in seconds, before a track
    /// contributes to `stayCount` in window counting.
    @Default(15) int stayThresholdSeconds,

    /// Minimum continuous absence duration, in seconds, before a previously
    /// in-area track contributes to `disappearCount` in window counting.
    @Default(7) int disappearThresholdSeconds,
  }) = _DetectionParams;

  factory DetectionParams.fromJson(Map<String, dynamic> json) => _$DetectionParamsFromJson(json);
}
