// TOC:
// - FlutterVisionRuntimeService: runtime adapter over flutter_vision controllers
// - start/stop: full session lifecycle
// - changeVideoSource/changeDetection/changeDetectionParams: explicit runtime transitions
// - telemetry bridge: finalized window snapshots -> TelemetryService queue

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

import '../telemetry/window_result_mapper.dart';
import 'detection_params_to_vision_params.dart';
import 'flutter_vision_runtime_source_adapter.dart';

class FlutterVisionRuntimeService implements core_domain.VisionRuntimeService {
  FlutterVisionRuntimeService(this._ref);

  final Ref _ref;
  FlutterVisionRuntimeSourceAdapter get _sourceAdapter => FlutterVisionRuntimeSourceAdapter(_ref);

  FlutterVisionRuntimeActiveController? _activeController;
  core_domain.VideoSource? _activeVideoSource;
  core_domain.DetectionType? _activeDetection;
  core_domain.DetectionParams? _activeDetectionParams;
  StreamSubscription<vision.WindowCountState>? _finalizedSnapshotSubscription;
  bool _telemetryUploadStarted = false;

  @override
  Future<void> start({
    required core_domain.VideoSource videoSource,
    required core_domain.DetectionType detection,
    required core_domain.DetectionParams detectionParams,
  }) async {
    await _restartWithConfig(videoSource: videoSource, detection: detection, detectionParams: detectionParams);
  }

  Future<void> _restartWithConfig({
    required core_domain.VideoSource videoSource,
    required core_domain.DetectionType detection,
    required core_domain.DetectionParams detectionParams,
  }) async {
    await stop();

    final sourceType = _mapSourceType(videoSource);
    if (sourceType == null) {
      appkit.logWarning('[VisionRuntime] No configured source, skipping startup');
      _setActiveConfig(videoSource: videoSource, detection: detection, detectionParams: detectionParams);
      return;
    }

    _ref.read(vision.activeVisionSourceProvider.notifier).setSource(sourceType);

    final detectionModel = await _buildDetectionModel(detection);
    final reidModel = await _buildReidModel(detection);
    final visionParams = detectionParamsToVisionParams(detectionParams);

    _activeController = await _sourceAdapter.start(
      videoSource: videoSource,
      visionParams: visionParams,
      detectionModel: detectionModel,
      reidModel: reidModel,
    );

    _setActiveConfig(videoSource: videoSource, detection: detection, detectionParams: detectionParams);

    try {
      await _ensureTelemetryBridgeStarted();
    } catch (error, stackTrace) {
      appkit.logWarning('[VisionRuntime] Failed to start telemetry bridge: $error');
      appkit.logDebug('[VisionRuntime] Telemetry bridge error stack trace: $stackTrace');
    }
  }

  @override
  Future<void> changeVideoSource({required core_domain.VideoSource videoSource}) async {
    final currentVideoSource = _activeVideoSource;
    final currentDetection = _activeDetection;
    final currentDetectionParams = _activeDetectionParams;
    if (currentVideoSource == null || currentDetection == null || currentDetectionParams == null) {
      throw StateError('Cannot change video source before start()');
    }

    if (currentVideoSource == videoSource) {
      return;
    }

    if (!videoSource.hasMadeDecision) {
      await stop();
      _setActiveConfig(videoSource: videoSource, detection: currentDetection, detectionParams: currentDetectionParams);
      return;
    }

    final sourceTypeChanged = _mapSourceType(currentVideoSource) != _mapSourceType(videoSource);
    if (sourceTypeChanged || _activeController == null) {
      await _restartWithConfig(
        videoSource: videoSource,
        detection: currentDetection,
        detectionParams: currentDetectionParams,
      );
      return;
    }

    final sourceType = _mapSourceType(videoSource);
    if (sourceType != null) {
      _ref.read(vision.activeVisionSourceProvider.notifier).setSource(sourceType);
    }
    await _activeController!.updateSource(videoSource);

    _setActiveConfig(videoSource: videoSource, detection: currentDetection, detectionParams: currentDetectionParams);
  }

  @override
  Future<void> changeDetection({required core_domain.DetectionType detection}) async {
    final currentVideoSource = _activeVideoSource;
    final currentDetection = _activeDetection;
    final currentDetectionParams = _activeDetectionParams;
    if (currentVideoSource == null || currentDetection == null || currentDetectionParams == null) {
      throw StateError('Cannot change detection before start()');
    }

    if (currentDetection == detection) {
      return;
    }

    // flutter_vision only applies model changes during initialize(), so a
    // detection change must restart the active source with the new model.
    await _restartWithConfig(
      videoSource: currentVideoSource,
      detection: detection,
      detectionParams: currentDetectionParams,
    );
  }

  @override
  Future<void> changeDetectionParams({required core_domain.DetectionParams detectionParams}) async {
    final currentVideoSource = _activeVideoSource;
    final currentDetection = _activeDetection;
    if (currentVideoSource == null || currentDetection == null) {
      throw StateError('Cannot change detection params before start()');
    }

    if (_activeDetectionParams == detectionParams) {
      return;
    }

    if (_activeController == null) {
      await _restartWithConfig(
        videoSource: currentVideoSource,
        detection: currentDetection,
        detectionParams: detectionParams,
      );
      return;
    }

    await _activeController!.setParams(detectionParamsToVisionParams(detectionParams));
    _setActiveConfig(videoSource: currentVideoSource, detection: currentDetection, detectionParams: detectionParams);
  }

  @override
  Future<void> stop() async {
    final controller = _activeController;
    _activeController = null;
    _clearActiveConfig();

    await _stopTelemetryBridge();

    if (controller == null) {
      _ref.read(vision.activeVisionSourceProvider.notifier).clearSource();
      return;
    }

    try {
      await controller.shutdown();
    } finally {
      _ref.read(vision.activeVisionSourceProvider.notifier).clearSource();
    }
  }

  vision.VisionSourceType? _mapSourceType(core_domain.VideoSource videoSource) {
    return switch (videoSource) {
      core_domain.UnspecifiedVideoSource() => null,
      core_domain.CameraVideoSource() => vision.VisionSourceType.camera,
      core_domain.WebcamVideoSource() => vision.VisionSourceType.webcam,
      core_domain.FileVideoSource() => vision.VisionSourceType.file,
      core_domain.LiveVideoSource() => vision.VisionSourceType.livestream,
    };
  }

  Future<vision.ModelDefine> _buildDetectionModel(core_domain.DetectionType detection) {
    return switch (detection) {
      core_domain.DetectionHuman() => vision.ModelDefine.human(),
      core_domain.DetectionVehicle() => vision.ModelDefine.vehicle(),
    };
  }

  Future<vision.ModelDefine?> _buildReidModel(core_domain.DetectionType detection) {
    return switch (detection) {
      core_domain.DetectionHuman() => vision.ModelDefine.humanReid(),
      core_domain.DetectionVehicle() => Future<vision.ModelDefine?>.value(null),
    };
  }

  void _setActiveConfig({
    required core_domain.VideoSource videoSource,
    required core_domain.DetectionType detection,
    required core_domain.DetectionParams detectionParams,
  }) {
    _activeVideoSource = videoSource;
    _activeDetection = detection;
    _activeDetectionParams = detectionParams;
  }

  void _clearActiveConfig() {
    _activeVideoSource = null;
    _activeDetection = null;
    _activeDetectionParams = null;
  }

  Future<void> _ensureTelemetryBridgeStarted() async {
    if (_finalizedSnapshotSubscription != null) {
      return;
    }

    final appState = await _ref.read(core_domain.appProvider.future);
    final mapper = WindowResultMapper(deviceId: appState.deviceId);

    _finalizedSnapshotSubscription = _ref.read(vision.windowCountProvider.notifier).finalizedSnapshots.listen((
      snapshot,
    ) {
      unawaited(_enqueueWindowResult(snapshot, mapper));
    });

    if (!_telemetryUploadStarted) {
      _ref.read(core_domain.telemetryServiceProvider).startPeriodicUpload();
      _telemetryUploadStarted = true;
    }
  }

  Future<void> _enqueueWindowResult(vision.WindowCountState snapshot, WindowResultMapper mapper) async {
    try {
      final payload = mapper.map(snapshot);
      await _ref.read(core_domain.telemetryServiceProvider).enqueue(payload);
    } catch (error, stackTrace) {
      appkit.logWarning('[VisionRuntime] Failed to enqueue telemetry payload from window result: $error');
      appkit.logDebug('[VisionRuntime] Enqueue error stack trace: $stackTrace');
    }
  }

  Future<void> _stopTelemetryBridge() async {
    final subscription = _finalizedSnapshotSubscription;
    _finalizedSnapshotSubscription = null;
    await subscription?.cancel();

    if (_telemetryUploadStarted) {
      _ref.read(core_domain.telemetryServiceProvider).stopPeriodicUpload();
      _telemetryUploadStarted = false;
    }
  }
}
