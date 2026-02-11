import 'package:camera/camera.dart';
import 'package:camera_macos/camera_macos.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_platform/universal_platform.dart';

import '../models/frontend.dart';

part 'hardware_capability_service.g.dart';

@riverpod
HardwareCapabilityService hardwareCapabilityService(Ref ref) {
  return HardwareCapabilityService();
}

class HardwareCapabilityService {
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

  Future<bool> isFrontendValid(Frontend frontend) async {
    if (frontend is CameraFrontend) {
      final cameraCount = await availableCameraCount();
      return cameraCount > frontend.cameraIndex;
    } else if (frontend is WebcamFrontend) {
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
