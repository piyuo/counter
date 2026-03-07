import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:universal_platform/universal_platform.dart';

class VideoScreen extends ConsumerStatefulWidget {
  const VideoScreen({super.key});

  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  @override
  void initState() {
    super.initState();
    appkit.logInfo('[VideoScreen] initState - widget created');
    Future.microtask(() {
      final visionSourceSelection = ref.read(vision.visionSourceSelectionProvider.notifier);
      visionSourceSelection.setSource(vision.VisionSourceType.camera);
      initializeVisionSystem();
    });
  }

  @override
  Future<void> initializeVisionSystem() async {
    final visionSourceSelection = ref.read(vision.visionSourceSelectionProvider.notifier);
    if (UniversalPlatform.isMobile) {
      visionSourceSelection.setSource(vision.VisionSourceType.camera);
      final controller = ref.read(vision.cameraVisionNotifierProvider.notifier);
      await initializeCameraVision(controller);
      return;
    }
    if (UniversalPlatform.isMacOS || UniversalPlatform.isWindows) {
      visionSourceSelection.setSource(vision.VisionSourceType.webcam);
      // Keep the provider alive across async gaps to prevent ref-disposed errors.
      final controller = ref.read(vision.webcamVisionNotifierProvider.notifier);
      await initializeWebcamVision(controller);
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

  @override
  Widget build(BuildContext context) {
    final visionState = ref.watch(vision.activeVisionStateProvider);
    return Container(
      color: Colors.white,
      child: Center(child: vision.Preview()),
    );
  }
}
