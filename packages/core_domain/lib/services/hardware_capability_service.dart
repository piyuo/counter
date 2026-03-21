import 'package:core_domain/state/models/available_camera.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hardware_capability_service.g.dart';

abstract class HardwareCapabilityService {
  Future<List<AvailableCamera>> listAvailableCameras();
  Future<bool> isVideoSourceValid(VideoSource videoSource);
  Future<bool> hasCameraVideoSource();

  /// Returns a default [VideoSource] at index 0 based on current platform.
  /// Caller must have already confirmed [hasCameraVideoSource] is true.
  Future<VideoSource> getDefaultVideoSource();
}

@riverpod
HardwareCapabilityService hardwareCapabilityService(Ref ref) {
  throw UnimplementedError('appStateRepositoryProvider must be overridden');
}
