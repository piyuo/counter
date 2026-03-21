// TOC:
// - FlutterVisionRuntimeSourceAdapter: source-specific controller bootstrap and source updates

import 'package:camera/camera.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

class FlutterVisionRuntimeSourceAdapter {
  const FlutterVisionRuntimeSourceAdapter(this._ref);

  final Ref _ref;

  Future<FlutterVisionRuntimeActiveController> start({
    required core_domain.VideoSource videoSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) {
    return switch (videoSource) {
      core_domain.CameraVideoSource cameraSource => _startCamera(
        cameraSource: cameraSource,
        visionParams: visionParams,
        detectionModel: detectionModel,
        reidModel: reidModel,
      ),
      core_domain.WebcamVideoSource webcamSource => _startWebcam(
        webcamSource: webcamSource,
        visionParams: visionParams,
        detectionModel: detectionModel,
        reidModel: reidModel,
      ),
      core_domain.FileVideoSource fileSource => _startFile(
        fileSource: fileSource,
        visionParams: visionParams,
        detectionModel: detectionModel,
        reidModel: reidModel,
      ),
      core_domain.LiveVideoSource liveSource => _startLive(
        liveSource: liveSource,
        visionParams: visionParams,
        detectionModel: detectionModel,
        reidModel: reidModel,
      ),
      core_domain.UnspecifiedVideoSource() => Future<FlutterVisionRuntimeActiveController>.error(
        StateError('Cannot start unspecified video source'),
      ),
    };
  }

  Future<CameraDescription> _resolveCameraDescription(int cameraIndex) async {
    final cameraDescriptions = await availableCameras();
    if (cameraDescriptions.isEmpty) {
      throw StateError('No camera found');
    }

    final descriptionIndex = cameraIndex >= 0 && cameraIndex < cameraDescriptions.length ? cameraIndex : 0;
    return cameraDescriptions[descriptionIndex];
  }

  Future<FlutterVisionRuntimeActiveController> _startCamera({
    required core_domain.CameraVideoSource cameraSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.cameraVisionNotifierProvider.notifier);
    try {
      final cameraDescription = await _resolveCameraDescription(cameraSource.cameraIndex);
      await controller.initialize(
        detectionModel: detectionModel,
        reidModel: reidModel,
        visionParams: visionParams,
        config: vision.CameraConfig(cameraDescription: cameraDescription),
      );
      return FlutterVisionRuntimeActiveController(
        shutdown: controller.shutdown,
        setParams: controller.setParams,
        updateSource: (videoSource) async {
          final nextSource = videoSource as core_domain.CameraVideoSource;
          final nextCameraDescription = await _resolveCameraDescription(nextSource.cameraIndex);
          await controller.changeCamera(nextCameraDescription);
        },
      );
    } catch (error, stackTrace) {
      appkit.logCritical('[VisionRuntime] Failed to initialize camera source: $error');
      controller.setAsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<FlutterVisionRuntimeActiveController> _startWebcam({
    required core_domain.WebcamVideoSource webcamSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.webcamVisionNotifierProvider.notifier);
    try {
      await controller.initialize(
        detectionModel: detectionModel,
        reidModel: reidModel,
        visionParams: visionParams,
        config: vision.WebcamSourceConfig(deviceId: webcamSource.webcamIndex),
      );
      return FlutterVisionRuntimeActiveController(
        shutdown: controller.shutdown,
        setParams: controller.setParams,
        updateSource: (videoSource) async {
          final nextSource = videoSource as core_domain.WebcamVideoSource;
          await controller.changeWebcam(nextSource.webcamIndex);
        },
      );
    } catch (error, stackTrace) {
      appkit.logCritical('[VisionRuntime] Failed to initialize webcam source: $error');
      controller.setAsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<FlutterVisionRuntimeActiveController> _startFile({
    required core_domain.FileVideoSource fileSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.fileVisionNotifierProvider.notifier);
    try {
      await controller.initialize(
        detectionModel: detectionModel,
        reidModel: reidModel,
        visionParams: visionParams,
        config: vision.FileSourceConfig(filePath: fileSource.path),
      );
      return FlutterVisionRuntimeActiveController(
        shutdown: controller.shutdown,
        setParams: controller.setParams,
        updateSource: (videoSource) async {
          final nextSource = videoSource as core_domain.FileVideoSource;
          await controller.changeFile(nextSource.path);
        },
      );
    } catch (error, stackTrace) {
      appkit.logCritical('[VisionRuntime] Failed to initialize file source: $error');
      controller.setAsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<FlutterVisionRuntimeActiveController> _startLive({
    required core_domain.LiveVideoSource liveSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.liveVisionNotifierProvider.notifier);
    try {
      await controller.initialize(
        detectionModel: detectionModel,
        reidModel: reidModel,
        visionParams: visionParams,
        config: vision.LivestreamSourceConfig(url: liveSource.url),
      );
      return FlutterVisionRuntimeActiveController(
        shutdown: controller.shutdown,
        setParams: controller.setParams,
        updateSource: (videoSource) async {
          final nextSource = videoSource as core_domain.LiveVideoSource;
          await controller.changeURL(nextSource.url);
        },
      );
    } catch (error, stackTrace) {
      appkit.logCritical('[VisionRuntime] Failed to initialize live source: $error');
      controller.setAsyncError(error, stackTrace);
      rethrow;
    }
  }
}

class FlutterVisionRuntimeActiveController {
  const FlutterVisionRuntimeActiveController({
    required this.shutdown,
    required this.setParams,
    required this.updateSource,
  });

  final Future<void> Function() shutdown;
  final Future<void> Function(vision.VisionParams params) setParams;
  final Future<void> Function(core_domain.VideoSource videoSource) updateSource;
}
