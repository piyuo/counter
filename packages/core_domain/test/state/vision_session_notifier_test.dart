// TOC:
// - VisionSessionNotifier start behavior
// - VisionSessionNotifier update diffing
// - VisionSessionNotifier stop behavior

import 'package:core_domain/services/vision_runtime_service.dart';
import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:core_domain/state/models/vision_session_state.dart';
import 'package:core_domain/state/providers/vision_session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VisionSessionNotifier', () {
    test('first configured reconcile starts the runtime', () async {
      final runtime = _RecordingVisionRuntimeService();
      final container = ProviderContainer(overrides: [visionRuntimeServiceProvider.overrideWith((ref) => runtime)]);
      addTearDown(container.dispose);

      final config = _config();

      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: config.videoSource,
            detectionType: config.detection,
            detectionParams: config.detectionParams,
          );

      expect(runtime.startCalls, hasLength(1));
      expect(runtime.startCalls.single.videoSource, config.videoSource);
      expect(runtime.startCalls.single.detection, config.detection);
      expect(runtime.startCalls.single.detectionParams, config.detectionParams);
      expect(runtime.changeVideoSourceCalls, isEmpty);
      expect(runtime.changeDetectionCalls, isEmpty);
      expect(runtime.changeDetectionParamsCalls, isEmpty);
      final state = container.read(visionSessionProvider);
      expect(state.status, VisionSessionStatus.running);
      expect(state.videoSource, config.videoSource);
      expect(state.detection, config.detection);
      expect(state.detectionParams, config.detectionParams);
    });

    test('changing only detection params uses the low-cost runtime path', () async {
      final runtime = _RecordingVisionRuntimeService();
      final container = ProviderContainer(overrides: [visionRuntimeServiceProvider.overrideWith((ref) => runtime)]);
      addTearDown(container.dispose);

      final initialConfig = _config();
      final updatedConfig = initialConfig.copyWith(
        detectionParams: initialConfig.detectionParams.copyWith(trackHighThresh: 0.72),
      );

      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: initialConfig.videoSource,
            detectionType: initialConfig.detection,
            detectionParams: initialConfig.detectionParams,
          );
      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: updatedConfig.videoSource,
            detectionType: updatedConfig.detection,
            detectionParams: updatedConfig.detectionParams,
          );

      expect(runtime.startCalls, hasLength(1));
      expect(runtime.changeVideoSourceCalls, isEmpty);
      expect(runtime.changeDetectionCalls, isEmpty);
      expect(runtime.changeDetectionParamsCalls, [updatedConfig.detectionParams]);
      final state = container.read(visionSessionProvider);
      expect(state.status, VisionSessionStatus.running);
      expect(state.videoSource, updatedConfig.videoSource);
      expect(state.detection, updatedConfig.detection);
      expect(state.detectionParams, updatedConfig.detectionParams);
    });

    test('changing detection uses the dedicated runtime path', () async {
      final runtime = _RecordingVisionRuntimeService();
      final container = ProviderContainer(overrides: [visionRuntimeServiceProvider.overrideWith((ref) => runtime)]);
      addTearDown(container.dispose);

      final initialConfig = _config();
      final updatedConfig = initialConfig.copyWith(detection: const DetectionType.vehicle());

      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: initialConfig.videoSource,
            detectionType: initialConfig.detection,
            detectionParams: initialConfig.detectionParams,
          );
      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: updatedConfig.videoSource,
            detectionType: updatedConfig.detection,
            detectionParams: updatedConfig.detectionParams,
          );

      expect(runtime.startCalls, hasLength(1));
      expect(runtime.changeVideoSourceCalls, isEmpty);
      expect(runtime.changeDetectionCalls, [updatedConfig.detection]);
      expect(runtime.changeDetectionParamsCalls, isEmpty);
      final state = container.read(visionSessionProvider);
      expect(state.status, VisionSessionStatus.running);
      expect(state.videoSource, updatedConfig.videoSource);
      expect(state.detection, updatedConfig.detection);
      expect(state.detectionParams, updatedConfig.detectionParams);
    });

    test('changing video source uses the dedicated runtime path', () async {
      final runtime = _RecordingVisionRuntimeService();
      final container = ProviderContainer(overrides: [visionRuntimeServiceProvider.overrideWith((ref) => runtime)]);
      addTearDown(container.dispose);

      final initialConfig = _config();
      final updatedConfig = initialConfig.copyWith(
        videoSource: const VideoSource.live(url: 'https://example.com/live'),
      );

      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: initialConfig.videoSource,
            detectionType: initialConfig.detection,
            detectionParams: initialConfig.detectionParams,
          );
      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: updatedConfig.videoSource,
            detectionType: updatedConfig.detection,
            detectionParams: updatedConfig.detectionParams,
          );

      expect(runtime.startCalls, hasLength(1));
      expect(runtime.changeVideoSourceCalls, [updatedConfig.videoSource]);
      expect(runtime.changeDetectionCalls, isEmpty);
      expect(runtime.changeDetectionParamsCalls, isEmpty);
      final state = container.read(visionSessionProvider);
      expect(state.status, VisionSessionStatus.running);
      expect(state.videoSource, updatedConfig.videoSource);
      expect(state.detection, updatedConfig.detection);
      expect(state.detectionParams, updatedConfig.detectionParams);
    });

    test('changing multiple attributes falls back to full start', () async {
      final runtime = _RecordingVisionRuntimeService();
      final container = ProviderContainer(overrides: [visionRuntimeServiceProvider.overrideWith((ref) => runtime)]);
      addTearDown(container.dispose);

      final initialConfig = _config();
      final updatedConfig = initialConfig.copyWith(
        detection: const DetectionType.vehicle(),
        detectionParams: initialConfig.detectionParams.copyWith(trackHighThresh: 0.72),
      );

      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: initialConfig.videoSource,
            detectionType: initialConfig.detection,
            detectionParams: initialConfig.detectionParams,
          );
      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: updatedConfig.videoSource,
            detectionType: updatedConfig.detection,
            detectionParams: updatedConfig.detectionParams,
          );

      expect(runtime.startCalls, hasLength(2));
      expect(runtime.startCalls.last.videoSource, updatedConfig.videoSource);
      expect(runtime.startCalls.last.detection, updatedConfig.detection);
      expect(runtime.startCalls.last.detectionParams, updatedConfig.detectionParams);
      expect(runtime.changeVideoSourceCalls, isEmpty);
      expect(runtime.changeDetectionCalls, isEmpty);
      expect(runtime.changeDetectionParamsCalls, isEmpty);
    });

    test('reconciling null stops the runtime and returns idle', () async {
      final runtime = _RecordingVisionRuntimeService();
      final container = ProviderContainer(overrides: [visionRuntimeServiceProvider.overrideWith((ref) => runtime)]);
      addTearDown(container.dispose);

      final config = _config();
      await container
          .read(visionSessionProvider.notifier)
          .reconcile(
            videoSource: config.videoSource,
            detectionType: config.detection,
            detectionParams: config.detectionParams,
          );
      await container.read(visionSessionProvider.notifier).stop();

      expect(runtime.stopCalls, 1);
      expect(container.read(visionSessionProvider), const VisionSessionState.idle());
    });
  });
}

_VisionConfig _config() {
  return const _VisionConfig(
    videoSource: const VideoSource.camera(cameraIndex: 0, isFaceFront: true),
    detection: const DetectionType.human(),
    detectionParams: const DetectionParams(),
  );
}

class _VisionConfig {
  const _VisionConfig({required this.videoSource, required this.detection, required this.detectionParams});

  final VideoSource videoSource;
  final DetectionType detection;
  final DetectionParams detectionParams;

  _VisionConfig copyWith({VideoSource? videoSource, DetectionType? detection, DetectionParams? detectionParams}) {
    return _VisionConfig(
      videoSource: videoSource ?? this.videoSource,
      detection: detection ?? this.detection,
      detectionParams: detectionParams ?? this.detectionParams,
    );
  }
}

class _RecordingVisionRuntimeService implements VisionRuntimeService {
  final List<_StartCall> startCalls = [];
  final List<VideoSource> changeVideoSourceCalls = [];
  final List<DetectionType> changeDetectionCalls = [];
  final List<DetectionParams> changeDetectionParamsCalls = [];
  int stopCalls = 0;

  @override
  Future<void> start({
    required VideoSource videoSource,
    required DetectionType detection,
    required DetectionParams detectionParams,
  }) async {
    startCalls.add(_StartCall(videoSource: videoSource, detection: detection, detectionParams: detectionParams));
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }

  @override
  Future<void> changeVideoSource({required VideoSource videoSource}) async {
    changeVideoSourceCalls.add(videoSource);
  }

  @override
  Future<void> changeDetection({required DetectionType detection}) async {
    changeDetectionCalls.add(detection);
  }

  @override
  Future<void> changeDetectionParams({required DetectionParams detectionParams}) async {
    changeDetectionParamsCalls.add(detectionParams);
  }
}

class _StartCall {
  const _StartCall({required this.videoSource, required this.detection, required this.detectionParams});

  final VideoSource videoSource;
  final DetectionType detection;
  final DetectionParams detectionParams;
}
