import 'dart:async';
import 'dart:math';

import 'package:core_domain/services/token_generator_service.dart';
import 'package:core_domain/state/models/app_state.dart';
import 'package:core_domain/state/models/data_server.dart';
import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/upload_config.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:core_domain/state/providers/app_runtime_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'app_state_repository.dart';

part 'app_notifier.g.dart';

const _kPiyuoCloudUrl = 'https://piyuo.com/api/v1';

abstract class AppController {
  Future<void> setVideoSource(VideoSource videoSource);
  Future<void> setDetection(DetectionType detection);
  Future<void> setDetectionParams(DetectionParams detectionParams);
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
}

@Riverpod(keepAlive: true)
class AppNotifier extends _$AppNotifier implements AppController {
  late final AppStateRepository repo;

  @override
  Future<AppState> build() async {
    repo = ref.read(appStateRepositoryProvider);
    var loaded = await repo.load();
    // Auto-generate a stable device ID on first boot or after a data reset.
    if (loaded.deviceId.isEmpty) {
      // first boot or after a data reset
      loaded = loaded.copyWith();
      // random url for personal piyuo.com endpoint, setup by user
      final random = ref.read(tokenGeneratorServiceProvider).generate();
      // Auto-generate a stable per-device upload jitter (0–180 s) on first boot.
      // This spreads wall-clock-aligned uploads over a 3-minute window to prevent
      // thundering herd against the backend.
      final jitter = Random().nextInt(181); // 0–180 inclusive
      loaded = loaded.copyWith(
        deviceId: const Uuid().v4(),
        uploadJitterSec: jitter,
        personalPiyuoServer: PersonalPiyuoServer(url: '$_kPiyuoCloudUrl/$random'),
        personalCustomServer: PersonalCustomServer(url: 'http://localhost:3000'),
      );
      await repo.save(loaded);
    }
    await ref.read(appRuntimeProvider.notifier).loadBearerToken(loaded.dataServerSelection);
    return loaded;
  }

  @override
  Future<void> setVideoSource(VideoSource videoSource) async {
    final current = await future;
    final updated = current.copyWith(videoSource: videoSource);
    state = AsyncData(updated);
    await repo.save(updated);
  }

  @override
  Future<void> setDetection(DetectionType detectionType) async {
    final current = await future;
    final updated = current.copyWith(detectionType: detectionType);
    state = AsyncData(updated);
    await repo.save(updated);
  }

  @override
  Future<void> setDetectionParams(DetectionParams detectionParams) async {
    final current = await future;
    final updated = current.copyWith(detectionParams: detectionParams);
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
    final updated = current.copyWith(
      dataServerSelection: DataServerSelection.personalPiyuo,
      isOnboardingComplete: true,
    );
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
      isOnboardingComplete: true,
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
      isOnboardingComplete: true,
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
      isOnboardingComplete: true,
      businessCustomServer: server,
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> selectNoDataServer() async {
    final current = await future;
    final updated = current.copyWith(dataServerSelection: DataServerSelection.none);
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
}
