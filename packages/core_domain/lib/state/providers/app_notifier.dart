import 'dart:async';
import 'dart:math';

import 'package:core_domain/app_flow/models/app_flow.dart';
import 'package:core_domain/app_flow/models/app_flow_event.dart';
import 'package:core_domain/app_flow/providers/app_flow_notifier.dart';
import 'package:core_domain/services/hardware_capability_service.dart';
import 'package:core_domain/services/token_generator_service.dart';
import 'package:core_domain/services/vision_service.dart';
import 'package:core_domain/state/models/app_state.dart';
import 'package:core_domain/state/models/data_server.dart';
import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/interest_area_data.dart';
import 'package:core_domain/state/models/upload_config.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:core_domain/state/providers/app_runtime_notifier.dart';
import 'package:core_domain/system_lifecycle/models/system_event.dart';
import 'package:core_domain/system_lifecycle/providers/system_lifecycle_notifier.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'app_state_repository.dart';

part 'app_notifier.g.dart';

const _kPiyuoCloudUrl = 'https://piyuo.com/api/v1';

abstract class AppController {
  Future<void> boot();
  Future<void> clearInterestAreas();
  Future<void> setVideoSource(VideoSource videoSource);
  Future<void> setDetectionType(DetectionType detectionType);
  Future<void> setDetectionParams(DetectionParams detectionParams);
  Future<void> saveInterestAreaDatas(List<InterestAreaData> areas);
  Future<void> selectPersonalPiyuoServer();
  Future<void> selectPersonalCustomServer(String url, String token);
  Future<void> selectBusinessPiyuoServer(BusinessPiyuoServer server, String token);
  Future<void> selectBusinessCustomServer(BusinessCustomServer server, String token);
  Future<void> selectNoDataServer();
  Future<void> applyServerConfigOverrides({
    DetectionType? detectionType,
    DetectionParams? detectionParams,
    UploadConfig? deliveryConfig,
  });
  Future<void> reset();
}

@Riverpod(keepAlive: true)
class AppNotifier extends _$AppNotifier implements AppController {
  late final AppStateRepository repo;

  @override
  Future<AppState> build() async {
    ref.listen(appFlowProvider, (previous, next) => _scheduleReconcile());

    repo = ref.read(appStateRepositoryProvider);
    var loadedState = await repo.load();
    final persistedState = loadedState;
    // Auto-generate a stable device ID on first boot or after a data reset.
    if (loadedState.deviceId.isEmpty) {
      // first boot or after a data reset
      loadedState = loadedState.copyWith();
      // random url for personal piyuo.com endpoint, setup by user
      final random = ref.read(tokenGeneratorServiceProvider).generate();
      // Auto-generate a stable per-device upload jitter (0–180 s) on first boot.
      // This spreads wall-clock-aligned uploads over a 3-minute window to prevent
      // thundering herd against the backend.
      final jitter = Random().nextInt(181); // 0–180 inclusive
      loadedState = loadedState.copyWith(
        deviceId: const Uuid().v4(),
        uploadJitterSec: jitter,
        personalPiyuoServer: PersonalPiyuoServer(url: '$_kPiyuoCloudUrl/$random'),
        personalCustomServer: PersonalCustomServer(url: 'http://localhost:3000'),
      );
    }
    loadedState = await _prepareDefaultVideoSource(loadedState);
    if (loadedState != persistedState) {
      await repo.save(loadedState);
    }

    await ref.read(appRuntimeProvider.notifier).loadBearerToken(loadedState.dataServerSelection);
    return loadedState;
  }

  // Reconcile the runtime session start/stop with the current app state.
  Future<void> _scheduleReconcile() async {
    final appFlow = ref.read(appFlowProvider);
    if (appFlow is! SessionRunning || !state.hasValue) {
      await ref.read(visionRuntimeServiceProvider).stop();
      ref.read(appRuntimeProvider.notifier).setIsVisionRunning(false);
      return;
    }

    await _startVision();
    ref.read(appRuntimeProvider.notifier).setIsVisionRunning(true);
  }

  Future<AppState> _prepareDefaultVideoSource(AppState appState) async {
    final hardwareService = ref.read(hardwareCapabilityServiceProvider);
    final defaultVideoSource = await hardwareService.getDefaultVideoSource();

    if (appState.videoSource.hasMadeDecision) {
      // video source was set, check if it still available (e.g. camera index out of range)
      final hasValidSource = await hardwareService.isVideoSourceValid(appState.videoSource);
      if (hasValidSource) {
        return appState;
      }
    }

    if (defaultVideoSource != null) {
      return appState.copyWith(videoSource: defaultVideoSource);
    }
    return appState.copyWith(videoSource: VideoSource.unspecified());
  }

  @override
  Future<void> boot() async {
    final lifecycleController = ref.read(systemLifecycleProvider.notifier);
    lifecycleController.dispatch(const SystemEvent.hardwareCheckInitiated());
    // hardware checking, start from app state creation

    final appState = await future;
    if (!appState.hasVideoSource) {
      lifecycleController.dispatch(const SystemEvent.deviceNotSupported());
      return;
    }
    lifecycleController.dispatch(const SystemEvent.hardwareCheckPassed());

    // now run app flow check
    final appFlowController = ref.read(appFlowProvider.notifier);
    // data server check
    appFlowController.dispatch(const AppFlowEvent.dataServerCheck());
    if (!appState.hasDataServerSelectionMade) {
      // todo: remove this debug code , that will set 123456 to invitationCodeProvider
      //if (kDebugMode) {
      //  ref.read(invitationCodeProvider.notifier).setCode('223456789X');
      //}

      // data server not configured, need onboarding to set up data server.
      // Scenario 1: invitation code present — start onboarding with invitation flow.
      // Scenario 2: no code — standard onboarding.
      //final hasInvitation = ref.read(core_domain.invitationCodeProvider) != null;
      //final hasInvitation = false;
      //hasInvitation
      //    ? const AppFlowEvent.invitationClicked()
      appFlowController.dispatch(const AppFlowEvent.onboardingNeeded());
      return;
    }

    // app flow check passed, can start session.
    appFlowController.dispatch(AppFlowEvent.startSession());
  }

  @override
  Future<bool> reset() async {
    await ref.read(visionRuntimeServiceProvider).stop();
    final hardwareService = ref.read(hardwareCapabilityServiceProvider);
    final defaultVideoSource = await hardwareService.getDefaultVideoSource();
    final freshState = AppState(videoSource: defaultVideoSource ?? VideoSource.unspecified());
    state = AsyncData(freshState);
    await repo.reset();
    if (defaultVideoSource == null) {
      final lifecycleController = ref.read(systemLifecycleProvider.notifier);
      lifecycleController.dispatch(const SystemEvent.deviceNotSupported());
      return false;
    }
    return true;
  }

  @override
  Future<void> clearInterestAreas() async {
    final current = await future;
    final updated = current.copyWith(interestAreas: []);
    state = AsyncData(updated);
    await repo.save(updated);
  }

  @override
  Future<void> setVideoSource(VideoSource videoSource) async {
    final current = await future;
    final updated = current.copyWith(
      videoSource: videoSource,
      interestAreas: [], // reset interest areas when changing video source
    );
    state = AsyncData(updated);
    await repo.save(updated);

    final appRuntimeState = ref.read(appRuntimeProvider);
    if (!appRuntimeState.isVisionRunning) {
      return;
    }
    final visionRuntimeService = ref.read(visionRuntimeServiceProvider);
    final isVideoTypeChanged = await visionRuntimeService.isVideoTypeChanged(videoSource);
    if (isVideoTypeChanged == false) {
      appkit.logInfo('[AppNotifier] Video source type unchanged, current: ${current.videoSource}, new: $videoSource');
      // If the source type is the same, we can change the input without restarting the runtime
      await visionRuntimeService.setVideoSource(videoSource);
      return;
    }
    appkit.logInfo('[AppNotifier] Video source type changed, current: ${current.videoSource}, new: $videoSource');
    await _startVision();
  }

  Future<void> _startVision() async {
    final currentState = await future;

    if (!currentState.hasVideoSource) {
      final lifecycleController = ref.read(systemLifecycleProvider.notifier);
      lifecycleController.dispatch(const SystemEvent.deviceNotSupported());
      return;
    }

    appkit.logInfo('[AppNotifier] Starting vision runtime with video source: ${currentState.videoSource}');
    await ref.read(visionRuntimeServiceProvider).stop();
    await ref
        .read(visionRuntimeServiceProvider)
        .start(
          videoSource: currentState.videoSource,
          detectionType: currentState.detectionType,
          detectionParams: currentState.detectionParams,
          interestAreaDatas: currentState.interestAreas,
          isTrackIdVisible: currentState.isTrackIdVisible,
        );
  }

  @override
  Future<void> setDetectionType(DetectionType detectionType) async {
    final current = await future;
    final updated = current.copyWith(
      detectionType: detectionType,
      detectionParams: detectionType is DetectionHuman ? DetectionParams() : DetectionParams.vehicle(),
    ); // reset detection params when changing type
    state = AsyncData(updated);
    await repo.save(updated);

    final appRuntimeState = ref.read(appRuntimeProvider);
    if (!appRuntimeState.isVisionRunning) {
      return;
    }
    await _startVision();
  }

  @override
  Future<void> setDetectionParams(DetectionParams detectionParams) async {
    final current = await future;
    final updated = current.copyWith(detectionParams: detectionParams);
    state = AsyncData(updated);
    await repo.save(updated);
    final appRuntimeState = ref.read(appRuntimeProvider);
    if (!appRuntimeState.isVisionRunning) {
      return;
    }
    await ref.read(visionRuntimeServiceProvider).setParams(detectionParams);
  }

  @override
  Future<void> saveInterestAreaDatas(List<InterestAreaData> areas) async {
    final current = await future;
    final updated = current.copyWith(interestAreas: areas);
    state = AsyncData(updated);
    await repo.save(updated);
  }

  Future<void> _saveUpdatedState(AppState updated) async {
    state = AsyncData(updated);
    await repo.save(updated);
  }

  @override
  Future<void> selectPersonalPiyuoServer() async {
    final current = await future;
    if (current.dataServerSelection == DataServerSelection.personalPiyuo) {
      return;
    }

    final updated = current.copyWith(dataServerSelection: DataServerSelection.personalPiyuo);
    await ref.read(appRuntimeProvider.notifier).clearBearerToken(); // no bearer token for personal piyuo server
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> selectPersonalCustomServer(String url, String token) async {
    final current = await future;
    await ref
        .read(appRuntimeProvider.notifier)
        .saveBearerToken(DataServerSelection.personalCustom, token); // no bearer token for personal piyuo server
    final updated = current.copyWith(
      dataServerSelection: DataServerSelection.personalCustom,
      personalCustomServer: PersonalCustomServer(url: url),
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> selectBusinessPiyuoServer(BusinessPiyuoServer server, String token) async {
    final current = await future;
    await ref
        .read(appRuntimeProvider.notifier)
        .saveBearerToken(DataServerSelection.businessPiyuo, token); // no bearer token for personal piyuo server

    final updated = current.copyWith(
      dataServerSelection: DataServerSelection.businessPiyuo,
      businessPiyuoServer: server,
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> selectBusinessCustomServer(BusinessCustomServer server, String token) async {
    final current = await future;
    await ref
        .read(appRuntimeProvider.notifier)
        .saveBearerToken(DataServerSelection.businessCustom, token); // no bearer token for personal piyuo server

    final updated = current.copyWith(
      dataServerSelection: DataServerSelection.businessCustom,
      businessCustomServer: server,
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> selectNoDataServer() async {
    final current = await future;
    if (current.dataServerSelection == DataServerSelection.noDataServer) {
      return;
    }
    final updated = current.copyWith(dataServerSelection: DataServerSelection.noDataServer);
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> applyServerConfigOverrides({
    DetectionType? detectionType,
    DetectionParams? detectionParams,
    UploadConfig? deliveryConfig,
  }) async {
    if (detectionType == null && detectionParams == null && deliveryConfig == null) {
      return;
    }

    final current = await future;
    final updated = current.copyWith(
      detectionType: detectionType ?? current.detectionType,
      detectionParams: detectionParams ?? current.detectionParams,
      uploadConfig: deliveryConfig ?? current.uploadConfig,
    );
    await _saveUpdatedState(updated);
  }

  /// Sets the visibility of track IDs in the detection output.
  void setTrackIdVisible(bool isVisible) {
    final current = state.requireValue;
    final updated = current.copyWith(isTrackIdVisible: isVisible);
    state = AsyncData(updated);
    repo.save(updated);
    ref.read(visionRuntimeServiceProvider).setTrackIdVisible(isVisible);
  }
}
