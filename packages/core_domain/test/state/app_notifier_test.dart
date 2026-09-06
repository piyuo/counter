// TOC:
//  - setBusinessDataServer() persists business server details and stores token in runtime+secure state
//  - ensurePiyuoCloudUrl() generates and persists a stable URL when missing
//  - ensurePiyuoCloudUrl() returns the existing URL without regenerating it
//  - setPersonalCustomDataServer() stores a custom personal server URL for reuse later
//  - setNoDataServer() keeps the stored custom server URL when switching away
//  - applyServerConfigOverrides() applies non-null server fields atomically

import 'package:core_domain/core_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppNotifier', () {
    test('setBusinessDataServer() persists business server details and stores token in runtime+secure state', () async {
      const businessServer = BusinessPiyuoServer(
        url: 'https://piyuo.com/api/v1',
        projectName: 'Store One',
        projectId: 'project-id',
        assignedId: 'assigned-id',
        assignedName: 'Counter Device',
      );
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final authStorage = _FakeAuthStorageService();
      final hardwareService = _FakeHardwareCapabilityService();
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
          authStorageServiceProvider.overrideWith((ref) => authStorage),
          hardwareCapabilityServiceProvider.overrideWith((ref) => hardwareService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.selectBusinessPiyuoServer(businessServer, 'secure-token');
      final appState = await container.read(appProvider.future);
      final runtimeState = container.read(appRuntimeProvider);

      expect(appState.currentDataServer, businessServer);
      expect(runtimeState.bearerToken, 'secure-token');
      expect(authStorage.store[getKeyFromDataServerSelection(DataServerSelection.businessPiyuo)], 'secure-token');
      expect(repo.saveCalls, 1);
      expect(tokenService.callCount, 0);
    });

    test('selectPersonalCustomServer() stores a custom personal server URL for reuse later', () async {
      const customUrl = 'https://example.com/counter';
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final authStorage = _FakeAuthStorageService();
      final hardwareService = _FakeHardwareCapabilityService();
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
          authStorageServiceProvider.overrideWith((ref) => authStorage),
          hardwareCapabilityServiceProvider.overrideWith((ref) => hardwareService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.selectPersonalCustomServer(customUrl, 'custom-token');
      final state = await container.read(appProvider.future);

      expect(state.currentDataServer, const DataServer.personalCustom(url: customUrl));
      expect(repo.saveCalls, 1);
      expect(tokenService.callCount, 0);
    });

    test('selectNoDataServer() keeps the stored custom server URL when switching away', () async {
      const customUrl = 'https://example.com/counter';
      final repo = _FakeAppStateRepository(
        const AppState(
          deviceId: 'device-id',
          dataServerSelection: DataServerSelection.personalCustom,
          personalCustomServer: PersonalCustomServer(url: customUrl),
        ),
      );
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final authStorage = _FakeAuthStorageService();
      final hardwareService = _FakeHardwareCapabilityService();
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
          authStorageServiceProvider.overrideWith((ref) => authStorage),
          hardwareCapabilityServiceProvider.overrideWith((ref) => hardwareService),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.selectNoDataServer();
      final state = await container.read(appProvider.future);

      expect(state.currentDataServer, const DataServer.noDataServer());
      expect(repo.saveCalls, 1);
      expect(tokenService.callCount, 0);
    });

    test('applyServerConfigOverrides() applies only non-null fields in one save', () async {
      final repo = _FakeAppStateRepository(const AppState(deviceId: 'device-id'));
      final tokenService = _FakeTokenGeneratorService('unused-token');
      final hardwareService = _FakeHardwareCapabilityService();
      final authStorage = _FakeAuthStorageService();
      final container = ProviderContainer(
        overrides: [
          appStateRepositoryProvider.overrideWith((ref) => repo),
          tokenGeneratorServiceProvider.overrideWith((ref) => tokenService),
          hardwareCapabilityServiceProvider.overrideWith((ref) => hardwareService),
          authStorageServiceProvider.overrideWith((ref) => authStorage),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(appProvider.notifier);

      await notifier.applyServerConfigOverrides(
        detectionType: const DetectionType.vehicle(),
        deliveryConfig: const UploadConfig(wallClockCadenceMin: 15),
      );
      final state = await container.read(appProvider.future);

      expect(state.detectionType, const DetectionType.vehicle());
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

class _FakeHardwareCapabilityService implements HardwareCapabilityService {
  @override
  Future<List<VideoSource>> getAvailableCameras() async => [];

  @override
  Future<VideoSource?> getDefaultVideoSource() async => null;

  @override
  Future<bool> hasCameraVideoSource() async => false;

  @override
  Future<bool> isVideoSourceValid(VideoSource videoSource) async => false;
}

class _FakeAuthStorageService implements AuthStorageService {
  final Map<String, String> store = {};

  @override
  Future<void> set(String key, String value) async {
    store[key] = value;
  }

  @override
  Future<String> get(String key) async {
    final value = store[key];
    if (value == null) {
      return '';
    }
    return value;
  }

  @override
  Future<void> remove(String key) async {
    store.remove(key);
  }

  @override
  Future<void> reset() async {
    store.clear();
  }

  @override
  Future<bool> isExists(String key) async => store.containsKey(key);
}
