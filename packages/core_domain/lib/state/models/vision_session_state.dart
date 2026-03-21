// TOC:
// - VisionSessionStatus: high-level lifecycle for the active vision runtime
// - VisionSessionState: state exposed to app and UI layers

import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/video_source.dart';

enum VisionSessionStatus { idle, initializing, running, error }

class VisionSessionState {
  const VisionSessionState({
    required this.status,
    this.videoSource,
    this.detection,
    this.detectionParams,
    this.error,
    this.stackTrace,
  });

  const VisionSessionState.idle() : this(status: VisionSessionStatus.idle);

  const VisionSessionState.initializing({
    required VideoSource videoSource,
    required DetectionType detection,
    required DetectionParams detectionParams,
  }) : this(
         status: VisionSessionStatus.initializing,
         videoSource: videoSource,
         detection: detection,
         detectionParams: detectionParams,
       );

  const VisionSessionState.running({
    required VideoSource videoSource,
    required DetectionType detection,
    required DetectionParams detectionParams,
  }) : this(
         status: VisionSessionStatus.running,
         videoSource: videoSource,
         detection: detection,
         detectionParams: detectionParams,
       );

  const VisionSessionState.error({
    required VideoSource? videoSource,
    required DetectionType? detection,
    required DetectionParams? detectionParams,
    required Object error,
    required StackTrace stackTrace,
  }) : this(
         status: VisionSessionStatus.error,
         videoSource: videoSource,
         detection: detection,
         detectionParams: detectionParams,
         error: error,
         stackTrace: stackTrace,
       );

  final VisionSessionStatus status;
  final VideoSource? videoSource;
  final DetectionType? detection;
  final DetectionParams? detectionParams;
  final Object? error;
  final StackTrace? stackTrace;

  bool get isIdle => status == VisionSessionStatus.idle;
  bool get isInitializing => status == VisionSessionStatus.initializing;
  bool get isRunning => status == VisionSessionStatus.running;
  bool get hasError => status == VisionSessionStatus.error;
}
