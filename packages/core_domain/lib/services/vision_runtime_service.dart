// TOC:
// - VisionRuntimeService: boundary between app/domain orchestration and runtime engine
// - visionRuntimeServiceProvider: override point for runtime implementation

import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class VisionRuntimeService {
  Future<void> start({
    required VideoSource videoSource,
    required DetectionType detection,
    required DetectionParams detectionParams,
  });

  Future<void> changeVideoSource({required VideoSource videoSource});

  Future<void> changeDetection({required DetectionType detection});

  Future<void> changeDetectionParams({required DetectionParams detectionParams});

  Future<void> stop();
}

final visionRuntimeServiceProvider = Provider<VisionRuntimeService>((ref) {
  throw UnimplementedError('visionRuntimeServiceProvider must be overridden');
});
