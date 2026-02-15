import 'package:camera/camera.dart';
import 'package:camera_macos/camera_macos.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:universal_platform/universal_platform.dart';

class HardwareCapabilityService implements core_domain.HardwareCapabilityService {
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
  Future<bool> isFrontendValid(core_domain.Frontend frontend) async {
    if (frontend is core_domain.CameraFrontend) {
      final cameraCount = await availableCameraCount();
      return cameraCount > frontend.cameraIndex;
    } else if (frontend is core_domain.WebcamFrontend) {
      if (UniversalPlatform.isMacOS) {
        final webcamCount = await availableMacosWebcamCount();
        return webcamCount > frontend.webcamIndex;
      }
      if (UniversalPlatform.isWindows) {
        final webcamCount = await availableWindowsWebcamCount();
        return webcamCount > frontend.webcamIndex;
      }
    }
    return true;
  }

  @override
  Future<bool> hasCamFrontend() async {
    if (UniversalPlatform.isMobile) {
      final cameraCount = await availableCameraCount();
      if (cameraCount > 0) {
        return true;
      }
    }
    if (UniversalPlatform.isMacOS) {
      final webcamCount = await availableMacosWebcamCount();
      if (webcamCount > 0) {
        return true;
      }
    }
    if (UniversalPlatform.isWindows) {
      final webcamCount = await availableWindowsWebcamCount();
      if (webcamCount > 0) {
        return true;
      }
    }
    return false;
  }
}
