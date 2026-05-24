// TOC:
// - VisionSessionController: reconcile/stop commands for the runtime session
// - visionSessionProvider: shared session state for app and UI
// - VisionSessionNotifier: serialized reconcile loop over the runtime service

import 'dart:async';

import 'package:core_domain/services/vision_runtime_service.dart';
import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:core_domain/state/models/vision_session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class VisionSessionController {
  Future<void> reconcile({
    required VideoSource videoSource,
    required DetectionType detectionType,
    required DetectionParams detectionParams,
  });

  Future<void> stop();
}

final visionSessionProvider = NotifierProvider<VisionSessionNotifier, VisionSessionState>(VisionSessionNotifier.new);

// Serializes start/stop transitions so rapid app-state changes cannot overlap
// async runtime lifecycle operations against flutter_vision.
class VisionSessionNotifier extends Notifier<VisionSessionState> implements VisionSessionController {
  VideoSource? _activeVideoSource;
  DetectionType? _activeDetection;
  DetectionParams? _activeDetectionParams;
  Future<void> _queue = Future<void>.value();

  @override
  VisionSessionState build() {
    return const VisionSessionState.idle();
  }

  @override
  Future<void> reconcile({
    required VideoSource videoSource,
    required DetectionType detectionType,
    required DetectionParams detectionParams,
  }) {
    // Each reconcile waits for the previous runtime transition to finish.
    // Without this, quick successive changes could interleave start()/stop()
    // calls and leave the underlying vision runtime in an inconsistent state.
    final operation = _queue.then(
      (_) => _performReconcile(videoSource: videoSource, detection: detectionType, detectionParams: detectionParams),
    );
    _queue = operation.catchError((error, stackTrace) {});
    return operation;
  }

  @override
  Future<void> stop() {
    final operation = _queue.then((_) => _performStop());
    _queue = operation.catchError((error, stackTrace) {});
    return operation;
  }

  Future<void> _performReconcile({
    required VideoSource videoSource,
    required DetectionType detection,
    required DetectionParams detectionParams,
  }) async {
    if (!videoSource.hasMadeDecision) {
      await _performStop();
      return;
    }

    if (_hasSameActiveConfig(videoSource: videoSource, detection: detection, detectionParams: detectionParams) &&
        state.isRunning) {
      return;
    }

    final previousVideoSource = _activeVideoSource;
    final previousDetection = _activeDetection;
    final previousDetectionParams = _activeDetectionParams;
    final shouldUpdate =
        previousVideoSource != null && previousDetection != null && previousDetectionParams != null && state.isRunning;
    state = VisionSessionState.initializing(
      videoSource: videoSource,
      detection: detection,
      detectionParams: detectionParams,
    );
    try {
      final runtimeService = ref.read(visionRuntimeServiceProvider);
      if (!shouldUpdate) {
        await runtimeService.start(videoSource: videoSource, detection: detection, detectionParams: detectionParams);
      } else {
        final sourceChanged = previousVideoSource != videoSource;
        final detectionChanged = previousDetection != detection;
        final paramsChanged = previousDetectionParams != detectionParams;
        final changedCount = (sourceChanged ? 1 : 0) + (detectionChanged ? 1 : 0) + (paramsChanged ? 1 : 0);

        if (changedCount > 1) {
          // The runtime API keeps each change operation narrowly scoped. If multiple
          // attributes move in one reconcile, restart from the full target config.
          await runtimeService.start(videoSource: videoSource, detection: detection, detectionParams: detectionParams);
        } else if (sourceChanged) {
          await runtimeService.changeVideoSource(videoSource: videoSource);
        } else if (detectionChanged) {
          await runtimeService.changeDetection(detection: detection);
        } else if (paramsChanged) {
          await runtimeService.changeDetectionParams(detectionParams: detectionParams);
        }
      }
      _activeVideoSource = videoSource;
      _activeDetection = detection;
      _activeDetectionParams = detectionParams;
      state = VisionSessionState.running(
        videoSource: videoSource,
        detection: detection,
        detectionParams: detectionParams,
      );
    } catch (error, stackTrace) {
      _clearActiveConfig();
      state = VisionSessionState.error(
        videoSource: videoSource,
        detection: detection,
        detectionParams: detectionParams,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _performStop() async {
    if (_activeVideoSource == null && state.isIdle) {
      return;
    }

    try {
      await ref.read(visionRuntimeServiceProvider).stop();
      _clearActiveConfig();
      state = const VisionSessionState.idle();
    } catch (error, stackTrace) {
      _clearActiveConfig();
      state = VisionSessionState.error(
        videoSource: state.videoSource,
        detection: state.detection,
        detectionParams: state.detectionParams,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool _hasSameActiveConfig({
    required VideoSource videoSource,
    required DetectionType detection,
    required DetectionParams detectionParams,
  }) {
    return _activeVideoSource == videoSource &&
        _activeDetection == detection &&
        _activeDetectionParams == detectionParams;
  }

  void _clearActiveConfig() {
    _activeVideoSource = null;
    _activeDetection = null;
    _activeDetectionParams = null;
  }
}
