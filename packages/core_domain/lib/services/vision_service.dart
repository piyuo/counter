// TOC:
// - VisionRuntimeService: boundary between app/domain orchestration and runtime engine
// - visionRuntimeServiceProvider: override point for runtime implementation

import 'package:core_domain/model/vision_state.dart';
import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/interest_area.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vision_service.g.dart';

abstract class VisionService {
  Future<void> stop();

  Future<void> start({
    required VideoSource videoSource,
    required DetectionType detectionType,
    required DetectionParams detectionParams,
    required List<InterestArea> interestAreaDatas,
    required bool isTrackIdVisible,
  });

  Future<void> setVideoSource(VideoSource videoSource);

  Future<bool> isVideoTypeChanged(VideoSource videoSource);

  Future<void> setParams(DetectionParams detectionParams);

  /// Sets the visibility of the track ID overlay in the video feed.
  void setTrackIdVisible(bool visible);
}

@riverpod
VisionService visionService(Ref ref) {
  throw UnimplementedError('visionServiceProvider must be overridden');
}

/// State
@riverpod
VisionState visionState(Ref ref) => throw UnimplementedError('visionStateProvider must be overridden');
