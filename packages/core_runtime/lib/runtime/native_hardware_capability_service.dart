import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_macos/camera_macos.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:universal_platform/universal_platform.dart';

class NativeHardwareCapabilityService implements core_domain.HardwareCapabilityService {
  NativeHardwareCapabilityService(this._cameraDeviceController);

  final vision.CameraDeviceNotifier _cameraDeviceController;

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
    if (videoSource is core_domain.FileVideoSource) {
      try {
        return File(videoSource.path).existsSync();
      } catch (e) {
        return false;
      }
    }
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
    final cameras = await _cameraDeviceController.getCameraDevices();
    return cameras.isNotEmpty;
  }

  @override
  Future<List<core_domain.VideoSource>> getAvailableCameras() async {
    final cameraDevices = await _cameraDeviceController.getCameraDevices();
    return [for (var i = 0; i < cameraDevices.length; i++) cameraDeviceToVideoSource(cameraDevices[i], i)];
  }

  @override
  Future<core_domain.VideoSource?> getDefaultVideoSource() async {
    final videoSources = await getAvailableCameras();
    return videoSources.isNotEmpty ? videoSources.first : null;
  }
}

core_domain.VideoSource cameraDeviceToVideoSource(vision.CameraDevice cameraDevice, int index) {
  if (UniversalPlatform.isMobile) {
    return core_domain.VideoSource.camera(
      cameraIndex: index,
      isFaceFront: cameraDevice.cameraDirection == vision.CameraDirection.front,
    );
  }
  if (UniversalPlatform.isDesktop) {
    return core_domain.VideoSource.webcam(webcamIndex: index);
  }
  assert(false, 'Unsupported platform for camera device to video source conversion');
  return const core_domain.VideoSource.unspecified();
}
