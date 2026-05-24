// TOC:
// - FlutterVisionRuntimeSourceAdapter: source-specific controller bootstrap and source updates

import 'package:camera/camera.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
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
    final controller = _ref.read(vision.visionProvider.notifier);
    final cameraDescription = await _resolveCameraDescription(cameraSource.cameraIndex);
    await controller.start(
      detectionModel: detectionModel,
      reidModel: reidModel,
      params: visionParams,
      input: vision.CameraInput(description: cameraDescription),
    );
    return FlutterVisionRuntimeActiveController(
      stop: controller.stop,
      setParams: controller.setParams,
      updateSource: (videoSource) async {
        final nextSource = videoSource as core_domain.CameraVideoSource;
        final nextCameraDescription = await _resolveCameraDescription(nextSource.cameraIndex);
        await controller.changeCamera(nextCameraDescription);
      },
    );
  }

  Future<FlutterVisionRuntimeActiveController> _startWebcam({
    required core_domain.WebcamVideoSource webcamSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.visionProvider.notifier);
    await controller.start(
      detectionModel: detectionModel,
      reidModel: reidModel,
      params: visionParams,
      input: vision.WebcamInput(deviceId: webcamSource.webcamIndex),
    );
    return FlutterVisionRuntimeActiveController(
      stop: controller.stop,
      setParams: controller.setParams,
      updateSource: (videoSource) async {
        final nextSource = videoSource as core_domain.WebcamVideoSource;
        final newInput = vision.WebcamInput(deviceId: nextSource.webcamIndex);
        await controller.setInput(newInput);
      },
    );
  }

  Future<FlutterVisionRuntimeActiveController> _startFile({
    required core_domain.FileVideoSource fileSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.visionProvider.notifier);
    await controller.start(
      detectionModel: detectionModel,
      reidModel: reidModel,
      params: visionParams,
      input: vision.FileInput(filePath: fileSource.path),
    );
    return FlutterVisionRuntimeActiveController(
      stop: controller.stop,
      setParams: controller.setParams,
      updateSource: (videoSource) async {
        final nextSource = videoSource as core_domain.FileVideoSource;
        await controller.setInput(vision.FileInput(filePath: nextSource.path));
      },
    );
  }

  Future<FlutterVisionRuntimeActiveController> _startLive({
    required core_domain.LiveVideoSource liveSource,
    required vision.VisionParams visionParams,
    required vision.ModelDefine detectionModel,
    required vision.ModelDefine? reidModel,
  }) async {
    final controller = _ref.read(vision.visionProvider.notifier);
    await controller.start(
      detectionModel: detectionModel,
      reidModel: reidModel,
      params: visionParams,
      input: vision.LiveInput(url: liveSource.url),
    );
    return FlutterVisionRuntimeActiveController(
      stop: controller.stop,
      setParams: controller.setParams,
      updateSource: (videoSource) async {
        final nextSource = videoSource as core_domain.LiveVideoSource;
        final newInput = vision.LiveInput(url: nextSource.url);
        await controller.setInput(newInput);
      },
    );
  }
}

class FlutterVisionRuntimeActiveController {
  const FlutterVisionRuntimeActiveController({required this.stop, required this.setParams, required this.updateSource});

  final Future<void> Function() stop;
  final Future<void> Function(vision.VisionParams params) setParams;
  final Future<void> Function(core_domain.VideoSource videoSource) updateSource;
}
