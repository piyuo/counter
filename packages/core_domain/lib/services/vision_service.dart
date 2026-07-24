// TOC:
// - VisionRuntimeService: boundary between app/domain orchestration and runtime engine
// - visionRuntimeServiceProvider: override point for runtime implementation

import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/interest_area_data.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class VisionService {
  Future<void> stop();

  Future<void> start({
    required VideoSource videoSource,
    required DetectionType detectionType,
    required DetectionParams detectionParams,
    required List<InterestAreaData> interestAreaDatas,
    required bool isTrackIdVisible,
  });

  Future<void> setVideoSource(VideoSource videoSource);

  Future<void> setParams(DetectionParams detectionParams);

  /// Sets the visibility of the track ID overlay in the video feed.
  void setTrackIdVisible(bool visible);
}

final visionRuntimeServiceProvider = Provider<VisionService>((ref) {
  throw UnimplementedError('visionServiceProvider must be overridden');
});
