// TOC:
//  - setBusinessDataServer() persists business server details and stores token in runtime+secure state
//  - ensurePiyuoCloudUrl() generates and persists a stable URL when missing
//  - ensurePiyuoCloudUrl() returns the existing URL without regenerating it
//  - setPiyuoCloudUrl() persists a user-supplied legacy URL
//  - setPersonalCustomDataServer() stores a custom personal server URL for reuse later
//  - setNoDataServer() keeps the stored custom server URL when switching away
//  - setDeliveryWallClockCadenceMin() persists the wall-clock upload cadence in deliveryConfig
//  - applyServerConfigOverrides() applies non-null server fields atomically

import 'package:core_domain/core_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppNotifier', () {
    test('setBusinessDataServer() persists business server details and stores token in runtime+secure state', () async {
      const businessServer = BusinessDataServer(
        url: 'https://piyuo.com/api/v1',
        projectName: 'Store One',
        projectId: 'project-id',
        assignedId: 'assigned-id',
      );
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final authStorage = _FakeAuthStorageService();
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
          authStorageServiceProvider.overrideWith((ref) => authStorage),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.setBusinessDataServer(businessServer, 'secure-token');
      final appState = await container.read(appProvider.future);
      final runtimeState = container.read(appRuntimeStateProvider);

      expect(appState.dataServer, businessServer);
      expect(runtimeState.businessBearerToken, 'secure-token');
      expect(authStorage.savedTokens, ['secure-token']);
      expect(repo.saveCalls, 1);
      expect(tokenService.callCount, 0);
    });

    test('ensurePiyuoCloudUrl() generates and persists a stable URL when missing', () async {
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('stable-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      final cloudUrl = await notifier.ensurePiyuoCloudUrl();
      final state = await container.read(appProvider.future);

      expect(cloudUrl, 'https://piyuo.com/api/stable-token');
      expect(state.piyuoCloudUrl, cloudUrl);
      expect(repo.saveCalls, 1);
      expect(repo.savedStates.last.piyuoCloudUrl, cloudUrl);
      expect(tokenService.callCount, 1);
    });

    test('ensurePiyuoCloudUrl() returns the existing URL without regenerating it', () async {
      const existingUrl = 'https://piyuo.com/api/existing-token';
      final repo = _FakeAppStateRepository(
        const AppState(
          deviceId: 'device-id',
          piyuoPersonalDataServer: PersonalDataServer(url: existingUrl),
        ),
      );
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      final cloudUrl = await notifier.ensurePiyuoCloudUrl();

      expect(cloudUrl, existingUrl);
      expect(repo.saveCalls, 0);
      expect(tokenService.callCount, 0);
    });

    test('setPiyuoCloudUrl() persists a user-supplied legacy URL', () async {
      const pastedUrl = 'https://piyuo.com/api/legacy-token';
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.setPiyuoCloudUrl(pastedUrl);
      final state = await container.read(appProvider.future);

      expect(state.piyuoCloudUrl, pastedUrl);
      expect(repo.saveCalls, 1);
      expect(repo.savedStates.last.piyuoCloudUrl, pastedUrl);
      expect(tokenService.callCount, 0);
    });

    test('setPersonalCustomDataServer() stores a custom personal server URL for reuse later', () async {
      const customUrl = 'https://example.com/counter';
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.setPersonalCustomDataServer(customUrl);
      final state = await container.read(appProvider.future);

      expect(state.dataServer, const DataServer.personal(url: customUrl));
      expect(state.customServerUrl, customUrl);
      expect(repo.saveCalls, 1);
      expect(repo.savedStates.last.customServerUrl, customUrl);
      expect(tokenService.callCount, 0);
    });

    test('setNoDataServer() keeps the stored custom server URL when switching away', () async {
      const customUrl = 'https://example.com/counter';
      final repo = _FakeAppStateRepository(
        const AppState(
          deviceId: 'device-id',
          dataServerSelection: DataServerSelection.personalCustom,
          customPersonalDataServer: PersonalDataServer(url: customUrl),
        ),
      );
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.setNoDataServer();
      final state = await container.read(appProvider.future);

      expect(state.dataServer, const DataServer.none());
      expect(state.customServerUrl, customUrl);
      expect(repo.saveCalls, 1);
      expect(repo.savedStates.last.customServerUrl, customUrl);
      expect(tokenService.callCount, 0);
    });

    test('setDeliveryWallClockCadenceMin() persists wall-clock upload cadence in deliveryConfig', () async {
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.setDeliveryWallClockCadenceMin(240);
      final state = await container.read(appProvider.future);

      expect(state.uploadConfig.wallClockCadenceMin, 240);
      expect(repo.saveCalls, 1);
      expect(repo.savedStates.last.uploadConfig.wallClockCadenceMin, 240);
      expect(tokenService.callCount, 0);
    });

    test('applyServerConfigOverrides() applies only non-null fields in one save', () async {
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.applyServerConfigOverrides(
        detection: const DetectionType.vehicle(),
        deliveryConfig: const UploadConfig(wallClockCadenceMin: 15),
      );
      final state = await container.read(appProvider.future);

      expect(state.detection, const DetectionType.vehicle());
      expect(state.uploadConfig.wallClockCadenceMin, 15);
      expect(state.detectionParams, const DetectionParams());
      expect(repo.saveCalls, 1);
      expect(tokenService.callCount, 0);
    });
  });
}

class _FakeAppStateRepository implements AppStateRepository {
  _FakeAppStateRepository(this._state);

  AppState _state;
  int saveCalls = 0;
  final List<AppState> savedStates = [];

  @override
  Future<AppState> load() async => _state;

  @override
  Future<void> reset() async {
    _state = const AppState();
  }

  @override
  Future<void> save(AppState state) async {
    _state = state;
    saveCalls += 1;
    savedStates.add(state);
  }
}

class _FakeTokenGeneratorService implements TokenGeneratorService {
  _FakeTokenGeneratorService(this.token);

  final String token;
  int callCount = 0;

  @override
  String generate({int length = 12}) {
    callCount += 1;
    return token;
  }
}

class _FakeAuthStorageService implements AuthStorageService {
  final List<String> savedTokens = [];

  @override
  Future<void> clearToken() async {}

  @override
  Future<String?> getToken() async => savedTokens.isEmpty ? null : savedTokens.last;

  @override
  Future<void> saveToken(String token) async {
    savedTokens.add(token);
  }
}
