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
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_vision_service.g.dart';

@Riverpod(keepAlive: true)
class FlutterVisionService extends _$FlutterVisionService implements core_domain.VisionService {
  FlutterVisionService();

  vision.VisionController? _activeController;
  StreamSubscription<core_domain.ObservationState>? _snapshotSubscription;
  bool _telemetryUploadStarted = false;

  List<core_domain.InterestArea> _interestAreas = const [];
  DateTime? _startTime;

  @override
  void build() {
    ref.onDispose(() {
      stop();
    });
  }

  @override
  Future<void> stop() async {
    final controller = _activeController;
    _activeController = null;
    ref.read(observationProvider.notifier).stop();
    ref.read(interestAreaProvider.notifier).stop();
    // Calculate and log usage duration
    if (_startTime != null) {
      final lastUsageDuration = DateTime.now().difference(_startTime!);
      ref
          .read(core_domain.usageServiceProvider)
          .logEvent(core_domain.VisionStopEvent(usageDuration: lastUsageDuration));
      _startTime = null;
    }
    await _stopTelemetryBridge();
    await controller?.stop();
  }

  @override
  Future<void> start({
    required core_domain.VideoSource videoSource,
    required core_domain.DetectionType detectionType,
    required core_domain.DetectionParams detectionParams,
    required List<core_domain.InterestArea> interestAreaDatas,
    required bool isTrackIdVisible,
  }) async {
    _interestAreas = interestAreaDatas;
    _startTime = DateTime.now();
    appkit.logDebug('[VisionRuntime] Vision service started');

    await _restartWithConfig(
      videoSource: videoSource,
      detection: detectionType,
      detectionParams: detectionParams,
      isTrackIdVisible: isTrackIdVisible,
    );
    ref
        .read(core_domain.usageServiceProvider)
        .logEvent(core_domain.VisionStartEvent(source: core_domain.getVideoSourceName(videoSource)));
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
    final observationService = ref.read(core_domain.observationServiceProvider);
    observationService.setThresholdSeconds(
      stayThresholdSeconds: detectionParams.stayThresholdSeconds,
      disappearThresholdSeconds: detectionParams.disappearThresholdSeconds,
    );
    observationService.start();

    ref
        .read(interestAreaProvider.notifier)
        .start(
          _interestAreas,
          onPersist: (List<core_domain.InterestArea> activeAreas) {
            if (_interestAreas == activeAreas) {
              return;
            }
            _interestAreas = activeAreas;

            if (_activeController != null) {
              final appController = ref.read(core_domain.appProvider.notifier);
              unawaited(appController.saveInterestAreaDatas(activeAreas));
            }
          },
        );

    final detectionModel = await _buildDetectionModel(detection);
    //    final reidModel = await _buildReidModel(detection);
    final visionParams = detectionParamsToVisionParams(detectionParams);

    _activeController = ref.read(vision.visionProvider.notifier);
    final visionInput = await _buildVisionInput(videoSource);
    _activeController!.setEventCallback((event) {
      if (event is vision.VisionStarted || event is vision.VisionRecovered || event is vision.VisionAlert) {
        observationService.resume();
      }
      if (event is vision.VisionStopped || event is vision.VisionFailure || event is vision.VisionIssue) {
        observationService.pause();
      }
    });
    _activeController!.setTrackedObjectsCallback((List<vision.TrackedObject> trackedObjects, double rotationDegrees) {
      observationService.processFrame(trackedObjects, rotationDegrees);
    });

    await _activeController!.start(
      detectionModel: detectionModel,
      //reidModel: reidModel,
      params: visionParams,
      input: visionInput,
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
  Future<bool> isVideoTypeChanged(core_domain.VideoSource videoSource) async {
    if (_activeController == null) {
      appkit.logDebug('[VisionRuntime] isVideoTypeChanged called before start()');
      return false;
    }
    final currentInput = _activeController!.getInput();
    if (currentInput == null) {
      return false;
    }

    final newInput = await _buildVisionInput(videoSource);
    if (currentInput.getInputType() != newInput.getInputType()) {
      return true;
    }
    return false;
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

    final countController = ref.read(observationProvider.notifier);
    countController.setThresholdSeconds(
      stayThresholdSeconds: detectionParams.stayThresholdSeconds,
      disappearThresholdSeconds: detectionParams.disappearThresholdSeconds,
    );
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

    _snapshotSubscription = ref.read(observationProvider.notifier).snapshots.listen((snapshot) {
      unawaited(_enqueueWindowResult(snapshot, mapper));
    });

    if (!_telemetryUploadStarted) {
      ref.read(core_domain.telemetryServiceProvider).startPeriodicUpload();
      _telemetryUploadStarted = true;
    }
  }

  Future<void> _enqueueWindowResult(core_domain.ObservationState snapshot, WindowResultMapper mapper) async {
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
