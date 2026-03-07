import 'package:camera/camera.dart';
import 'package:camera_macos/camera_macos.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
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

  @override
  Future<core_domain.Frontend> getDefaultFrontend() async {
    if (UniversalPlatform.isMobile) {
      return const core_domain.Frontend.camera(cameraIndex: 0);
    }
    if (UniversalPlatform.isMacOS || UniversalPlatform.isWindows) {
      return const core_domain.Frontend.webcam(webcamIndex: 0);
    }
    return const core_domain.Frontend.empty();
  }

  @override
  Future<void> initializeVisionSystem(Ref ref) async {
    final visionSourceSelection = ref.read(vision.visionSourceSelectionProvider.notifier);
    if (UniversalPlatform.isMobile) {
      visionSourceSelection.setSource(vision.VisionSourceType.camera);
      // Keep the provider alive across async gaps to prevent ref-disposed errors.
      final sub = ref.listen(vision.cameraVisionNotifierProvider, (_, __) {});
      try {
        final controller = ref.read(vision.cameraVisionNotifierProvider.notifier);
        await initializeCameraVision(controller);
      } finally {
        sub.close();
      }
      return;
    }
    if (UniversalPlatform.isMacOS || UniversalPlatform.isWindows) {
      visionSourceSelection.setSource(vision.VisionSourceType.webcam);
      // Keep the provider alive across async gaps to prevent ref-disposed errors.
      final sub = ref.listen(vision.webcamVisionNotifierProvider, (_, __) {});
      try {
        final controller = ref.read(vision.webcamVisionNotifierProvider.notifier);
        await initializeWebcamVision(controller);
      } finally {
        sub.close();
      }
      return;
    }
    throw Exception('Failed to initialize vision system: unsupported platform');
  }

  Future<void> initializeCameraVision(vision.CameraNotifier controller) async {
    final detectionModel = await vision.ModelDefine.human();
    final reidModel = await vision.ModelDefine.humanReid();
    try {
      final cameraDescriptions = await availableCameras();
      if (cameraDescriptions.isNotEmpty) {
        final currentCameraDesc = cameraDescriptions[0];
        await controller.initialize(
          detectionModel: detectionModel,
          reidModel: reidModel,
          visionParams: vision.VisionParams(),
          config: vision.CameraConfig(cameraDescription: currentCameraDesc),
        );
      }
    } catch (e, stack) {
      appkit.logCritical('no camera found: $e');
      controller.setAsyncError(e, stack);
      return;
    }
  }

  Future<void> initializeWebcamVision(vision.WebcamNotifier controller) async {
    final detectionModel = await vision.ModelDefine.human();
    final reidModel = await vision.ModelDefine.humanReid();
    try {
      await controller.initialize(
        detectionModel: detectionModel,
        reidModel: reidModel,
        visionParams: vision.VisionParams(),
        config: vision.WebcamSourceConfig(deviceId: 0),
      );
    } catch (e, stack) {
      appkit.logCritical('no webcam found: $e');
      controller.setAsyncError(e, stack);
      return;
    }
  }
}
