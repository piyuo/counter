// TOC:
//  - ensureBusinessBearerTokenLoaded() hydrates token from secure storage once
//  - setBusinessBearerToken() writes token to runtime state and secure storage

import 'package:core_domain/core_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRuntimeStateNotifier', () {
    test('loadBearerToken() hydrates token from secure storage', () async {
      final authStorage = _FakeAuthStorageService();
      authStorage.set(getKeyFromDataServerSelection(DataServerSelection.personalCustom), 'stored-token');
      final container = ProviderContainer(overrides: [authStorageServiceProvider.overrideWith((ref) => authStorage)]);
      addTearDown(container.dispose);

      final notifier = container.read(appRuntimeProvider.notifier);

      await notifier.loadBearerToken(DataServerSelection.personalCustom);
      final runtimeState = container.read(appRuntimeProvider);
      expect(runtimeState.bearerToken, 'stored-token');
    });

    test('setBusinessBearerToken() writes token to runtime state and secure storage', () async {
      final authStorage = _FakeAuthStorageService();
      final container = ProviderContainer(overrides: [authStorageServiceProvider.overrideWith((ref) => authStorage)]);
      addTearDown(container.dispose);

      final notifier = container.read(appRuntimeProvider.notifier);
      await notifier.saveBearerToken(DataServerSelection.personalCustom, 'fresh-token');
      final runtimeState = container.read(appRuntimeProvider);
      expect(runtimeState.bearerToken, 'fresh-token');
      final key = getKeyFromDataServerSelection(DataServerSelection.personalCustom);
      expect(authStorage.store[key], 'fresh-token');
    });
  });
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
