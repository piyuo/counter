import 'package:camera/camera.dart';
import 'package:camera_macos/camera_macos.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:universal_platform/universal_platform.dart';

class NativeHardwareCapabilityService implements core_domain.HardwareCapabilityService {
  @override
  Future<List<core_domain.AvailableCamera>> listAvailableCameras() async {
    if (UniversalPlatform.isMobile) {
      try {
        final cameras = await availableCameras();
        return [
          for (var index = 0; index < cameras.length; index++)
            core_domain.AvailableCamera(
              videoSource: core_domain.VideoSource.camera(cameraIndex: index),
              displayName: _mobileCameraDisplayName(cameras[index], index),
            ),
        ];
      } catch (e) {
        return const [];
      }
    }

    if (UniversalPlatform.isMacOS) {
      final webcamCount = await availableMacosWebcamCount();
      return [
        for (var index = 0; index < webcamCount; index++)
          core_domain.AvailableCamera(
            videoSource: core_domain.VideoSource.webcam(webcamIndex: index),
            displayName: _webcamDisplayName(index),
          ),
      ];
    }

    if (UniversalPlatform.isWindows) {
      final webcamCount = await availableWindowsWebcamCount();
      return [
        for (var index = 0; index < webcamCount; index++)
          core_domain.AvailableCamera(
            videoSource: core_domain.VideoSource.webcam(webcamIndex: index),
            displayName: _webcamDisplayName(index),
          ),
      ];
    }

    return const [];
  }

  Future<int> availableCameraCount() async {
    try {
      final cameras = await availableCameras();
      return cameras.length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> availableMacosWebcamCount() async {
    if (!UniversalPlatform.isMacOS) {
      return 0;
    }

    try {
      final videoDevices = await CameraMacOS.instance.listDevices(deviceType: CameraMacOSDeviceType.video);
      return videoDevices.length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> availableWindowsWebcamCount() async {
    if (!UniversalPlatform.isWindows) {
      return 0;
    }

    try {
      final cameraWindows = CameraWindows();
      final videoDevices = await cameraWindows.availableCameras();
      return videoDevices.length;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<bool> isVideoSourceValid(core_domain.VideoSource videoSource) async {
    if (videoSource is core_domain.CameraVideoSource) {
      final cameraCount = await availableCameraCount();
      return cameraCount > videoSource.cameraIndex;
    } else if (videoSource is core_domain.WebcamVideoSource) {
      if (UniversalPlatform.isMacOS) {
        final webcamCount = await availableMacosWebcamCount();
        return webcamCount > videoSource.webcamIndex;
      }
      if (UniversalPlatform.isWindows) {
        final webcamCount = await availableWindowsWebcamCount();
        return webcamCount > videoSource.webcamIndex;
      }
    }
    return true;
  }

  @override
  Future<bool> hasCameraVideoSource() async {
    final cameras = await listAvailableCameras();
    return cameras.isNotEmpty;
  }

  @override
  Future<core_domain.VideoSource> getDefaultVideoSource() async {
    if (UniversalPlatform.isMobile) {
      return const core_domain.VideoSource.camera(cameraIndex: 0);
    }
    if (UniversalPlatform.isMacOS || UniversalPlatform.isWindows) {
      return const core_domain.VideoSource.webcam(webcamIndex: 0);
    }
    return const core_domain.VideoSource.unspecified();
  }

  String _mobileCameraDisplayName(CameraDescription camera, int index) {
    if (camera.name.isNotEmpty) {
      return camera.name;
    }

    final lensLabel = switch (camera.lensDirection) {
      CameraLensDirection.front => 'Front Camera',
      CameraLensDirection.back => 'Back Camera',
      CameraLensDirection.external => 'External Camera',
    };

    return '$lensLabel ${index + 1}';
  }

  String _webcamDisplayName(int index) => 'Webcam ${index + 1}';
}
