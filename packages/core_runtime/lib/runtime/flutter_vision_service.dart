// TOC:
// - FlutterVisionRuntimeService: runtime adapter over flutter_vision controllers
// - start/stop: full session lifecycle
// - changeVideoSource/changeDetection/changeDetectionParams: explicit runtime transitions
// - telemetry bridge: finalized window snapshots -> TelemetryService queue

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_vision_service.g.dart';

@Riverpod(keepAlive: true)
class FlutterVisionService extends _$FlutterVisionService implements core_domain.VisionService {
  FlutterVisionService();

  vision.VisionController? _activeController;
  StreamSubscription<vision.WindowCountState>? _snapshotSubscription;
  bool _telemetryUploadStarted = false;
  ProviderSubscription<List<vision.InterestArea>>? _interestAreaSubscription;

  List<vision.InterestArea> _interestAreas = const [];

  @override
  void build() {
    ref.onDispose(() {
      stop();
      _interestAreaSubscription?.close();
      _interestAreaSubscription = null;
    });

    _interestAreaSubscription ??= ref.container.listen<List<vision.InterestArea>>(
      vision.interestAreaProvider.select((state) => state.activeAreas),
      (_, activeAreas) {
        if (_interestAreas == activeAreas) {
          return;
        }
        _interestAreas = activeAreas;

        if (_activeController != null) {
          final appController = ref.read(core_domain.appProvider.notifier);
          unawaited(appController.saveInterestAreaDatas(activeAreas.map((area) => area.toInterestAreaData()).toList()));
        }
      },
      fireImmediately: true,
    );
  }

  @override
  Future<void> stop() async {
    final controller = _activeController;
    _activeController = null;

    await _stopTelemetryBridge();
    await controller?.stop();
  }

  @override
  Future<void> start({
    required core_domain.VideoSource videoSource,
    required core_domain.DetectionType detectionType,
    required core_domain.DetectionParams detectionParams,
    required List<core_domain.InterestAreaData> interestAreaDatas,
    required bool isTrackIdVisible,
  }) async {
    _interestAreas = interestAreaDatas.map((data) => data.toInterestArea()).toList();
    await _restartWithConfig(
      videoSource: videoSource,
      detection: detectionType,
      detectionParams: detectionParams,
      isTrackIdVisible: isTrackIdVisible,
    );
  }

  Future<vision.VisionInput> _buildVisionInput(core_domain.VideoSource videoSource) async {
    return switch (videoSource) {
      core_domain.CameraVideoSource cameraSource => vision.CameraInput(
        description: await _resolveCameraDescription(cameraSource.cameraIndex),
      ),
      core_domain.WebcamVideoSource webcamSource => vision.WebcamInput(deviceId: webcamSource.webcamIndex),
      core_domain.FileVideoSource fileSource => vision.FileInput(filePath: fileSource.path),
      core_domain.LiveVideoSource liveSource => vision.LiveInput(url: liveSource.url),
      core_domain.UnspecifiedVideoSource() => throw StateError('Cannot build input for unspecified video source'),
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

  Future<void> _restartWithConfig({
    required core_domain.VideoSource videoSource,
    required core_domain.DetectionType detection,
    required core_domain.DetectionParams detectionParams,
    required bool isTrackIdVisible,
  }) async {
    await stop();

    final detectionModel = await _buildDetectionModel(detection);
    //    final reidModel = await _buildReidModel(detection);
    final visionParams = detectionParamsToVisionParams(detectionParams);

    _activeController = ref.read(vision.visionProvider.notifier);
    final visionInput = await _buildVisionInput(videoSource);
    await _activeController!.start(
      detectionModel: detectionModel,
      //reidModel: reidModel,
      params: visionParams,
      input: visionInput,
      interestAreas: _interestAreas,
      isTrackIdVisible: isTrackIdVisible,
    );

    try {
      await _ensureTelemetryBridgeStarted();
    } catch (error, stackTrace) {
      appkit.logWarning('[VisionRuntime] Failed to start telemetry bridge: $error');
      appkit.logDebug('[VisionRuntime] Telemetry bridge error stack trace: $stackTrace');
    }
  }

  @override
  Future<void> setVideoSource(core_domain.VideoSource videoSource) async {
    if (_activeController == null) {
      appkit.logDebug('[VisionRuntime] setVideoSource called before start()');
      return;
    }
    final newInput = await _buildVisionInput(videoSource);
    await _activeController!.setInput(newInput);
  }

  @override
  Future<void> setParams(core_domain.DetectionParams detectionParams) async {
    if (_activeController == null) {
      appkit.logDebug('[VisionRuntime] setVideoSource called before start()');
      return;
    }
    final newParams = detectionParamsToVisionParams(detectionParams);
    await _activeController!.setParams(newParams);
  }

  @override
  void setTrackIdVisible(bool visible) {
    if (_activeController == null) {
      appkit.logDebug('[VisionRuntime] setTrackIdVisible called before start()');
      return;
    }
    _activeController!.setTrackIdVisible(visible);
  }

  Future<vision.ModelDefine> _buildDetectionModel(core_domain.DetectionType detection) {
    return switch (detection) {
      core_domain.DetectionHuman() => vision.ModelDefine.human(),
      core_domain.DetectionVehicle() => vision.ModelDefine.vehicle(),
    };
  }

  /* disable for now, cause reid has privacy issue and performance issue, and we don't have a good reid model for vehicle yet
  Future<vision.ModelDefine?> _buildReidModel(core_domain.DetectionType detection) {
    return switch (detection) {
      core_domain.DetectionHuman() => vision.ModelDefine.humanReid(),
      core_domain.DetectionVehicle() => Future<vision.ModelDefine?>.value(null),
    };
  }
*/
  Future<void> _ensureTelemetryBridgeStarted() async {
    if (_snapshotSubscription != null) {
      return;
    }

    final appState = await ref.read(core_domain.appProvider.future);
    final mapper = WindowResultMapper(deviceId: appState.deviceId);

    _snapshotSubscription = ref.read(vision.windowCountProvider.notifier).snapshots.listen((snapshot) {
      unawaited(_enqueueWindowResult(snapshot, mapper));
    });

    if (!_telemetryUploadStarted) {
      ref.read(core_domain.telemetryServiceProvider).startPeriodicUpload();
      _telemetryUploadStarted = true;
    }
  }

  Future<void> _enqueueWindowResult(vision.WindowCountState snapshot, WindowResultMapper mapper) async {
    try {
      final payload = mapper.map(snapshot);
      await ref.read(core_domain.telemetryServiceProvider).enqueue(payload);
    } catch (error, stackTrace) {
      appkit.logDebug(
        '[VisionRuntime] Failed to enqueue telemetry payload from window result: $error, stack trace: $stackTrace',
      );
    }
  }

  Future<void> _stopTelemetryBridge() async {
    final subscription = _snapshotSubscription;
    _snapshotSubscription = null;
    await subscription?.cancel();

    if (_telemetryUploadStarted) {
      ref.read(core_domain.telemetryServiceProvider).stopPeriodicUpload();
      _telemetryUploadStarted = false;
    }
  }
}
