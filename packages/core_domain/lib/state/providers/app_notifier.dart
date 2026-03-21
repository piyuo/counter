import 'dart:async';
import 'dart:math';

import 'package:core_domain/services/token_generator_service.dart';
import 'package:core_domain/state/models/app_state.dart';
import 'package:core_domain/state/models/data_server.dart';
import 'package:core_domain/state/models/detection_params.dart';
import 'package:core_domain/state/models/detection_type.dart';
import 'package:core_domain/state/models/upload_config.dart';
import 'package:core_domain/state/models/video_source.dart';
import 'package:core_domain/state/providers/app_runtime_state_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'app_state_repository.dart';

part 'app_notifier.g.dart';

abstract class AppController {
  Future<void> setVideoSource(VideoSource videoSource);
  Future<void> setDetection(DetectionType detection);
  Future<void> setDetectionParams(DetectionParams detectionParams);
  Future<void> setBusinessDataServer(BusinessDataServer dataServer, String bearerToken);
  Future<void> setPersonalCustomDataServer(String url);
  Future<void> setPersonalPiyuoDataServer(String url);
  Future<void> setNoDataServer();
  Future<void> applyServerConfigOverrides({
    DetectionType? detection,
    DetectionParams? detectionParams,
    UploadConfig? deliveryConfig,
  });
  Future<void> setDeliveryWallClockCadenceMin(int cadenceMin);
  Future<void> setDeliveryIntervalMin(int intervalMin);
  Future<String> ensurePiyuoCloudUrl();
  Future<void> setPiyuoCloudUrl(String piyuoCloudUrl);
}

@Riverpod(keepAlive: true)
class AppNotifier extends _$AppNotifier implements AppController {
  static const _piyuoCloudBaseUrl = 'https://piyuo.com/api/';

  late final AppStateRepository repo;

  @override
  Future<AppState> build() async {
    repo = ref.read(appStateRepositoryProvider);
    var loaded = await repo.load();
    // Auto-generate a stable device ID on first boot or after a data reset.
    if (loaded.deviceId.isEmpty) {
      final id = const Uuid().v4();
      loaded = loaded.copyWith(deviceId: id);
      await repo.save(loaded);
    }
    // Auto-generate a stable per-device upload jitter (0–180 s) on first boot.
    // This spreads wall-clock-aligned uploads over a 3-minute window to prevent
    // thundering herd against the backend.
    if (loaded.uploadJitterSec == 0) {
      final jitter = Random().nextInt(181); // 0–180 inclusive
      loaded = loaded.copyWith(uploadJitterSec: jitter);
      await repo.save(loaded);
    }
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
  Future<void> setDetection(DetectionType detection) async {
    final current = await future;
    final updated = current.copyWith(detection: detection);
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
  Future<void> setBusinessDataServer(BusinessDataServer dataServer, String bearerToken) async {
    final current = await future;
    await ref.read(appRuntimeStateProvider.notifier).setBusinessBearerToken(bearerToken);
    final updated = current.copyWith(dataServerSelection: DataServerSelection.business, businessDataServer: dataServer);
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> setPersonalCustomDataServer(String url) async {
    final current = await future;
    final updated = current.copyWith(
      dataServerSelection: DataServerSelection.personalCustom,
      customPersonalDataServer: PersonalDataServer(url: url),
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> setPersonalPiyuoDataServer(String url) async {
    final current = await future;
    final updated = current.copyWith(
      dataServerSelection: DataServerSelection.personalPiyuo,
      piyuoPersonalDataServer: PersonalDataServer(url: url),
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> setNoDataServer() async {
    final current = await future;
    final updated = current.copyWith(dataServerSelection: DataServerSelection.none);
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> applyServerConfigOverrides({
    DetectionType? detection,
    DetectionParams? detectionParams,
    UploadConfig? deliveryConfig,
  }) async {
    if (detection == null && detectionParams == null && deliveryConfig == null) {
      return;
    }

    final current = await future;
    final updated = current.copyWith(
      detection: detection ?? current.detection,
      detectionParams: detectionParams ?? current.detectionParams,
      uploadConfig: deliveryConfig ?? current.uploadConfig,
    );
    await _saveUpdatedState(updated);
  }

  @override
  Future<void> setDeliveryWallClockCadenceMin(int cadenceMin) async {
    final current = await future;
    final updated = current.copyWith(uploadConfig: current.uploadConfig.copyWith(wallClockCadenceMin: cadenceMin));
    await _saveUpdatedState(updated);
  }

  @Deprecated('Use setDeliveryWallClockCadenceMin')
  @override
  Future<void> setDeliveryIntervalMin(int intervalMin) async {
    final current = await future;
    final updated = current.copyWith(uploadConfig: current.uploadConfig.copyWith(wallClockCadenceMin: intervalMin));
    await _saveUpdatedState(updated);
  }

  @override
  Future<String> ensurePiyuoCloudUrl() async {
    final current = await future;
    if (current.piyuoPersonalDataServer case final PersonalDataServer remembered) {
      return remembered.url;
    }

    final token = ref.read(tokenGeneratorServiceProvider).generate();
    final piyuoCloudUrl = '$_piyuoCloudBaseUrl$token';
    final updated = current.copyWith(piyuoPersonalDataServer: PersonalDataServer(url: piyuoCloudUrl));
    await _saveUpdatedState(updated);
    return piyuoCloudUrl;
  }

  @override
  Future<void> setPiyuoCloudUrl(String piyuoCloudUrl) async {
    final current = await future;
    final updated = current.copyWith(piyuoPersonalDataServer: PersonalDataServer(url: piyuoCloudUrl));
    await _saveUpdatedState(updated);
  }
}
