// TOC:
//  - ensureBusinessBearerTokenLoaded() hydrates token from secure storage once
//  - setBusinessBearerToken() writes token to runtime state and secure storage

import 'package:core_domain/core_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRuntimeStateNotifier', () {
    test('ensureBusinessBearerTokenLoaded() hydrates token from secure storage once', () async {
      final authStorage = _FakeAuthStorageService(initialToken: 'stored-token');
      final container = ProviderContainer(overrides: [authStorageServiceProvider.overrideWith((ref) => authStorage)]);
      addTearDown(container.dispose);

      final notifier = container.read(appRuntimeStateProvider.notifier);

      final first = await notifier.ensureBusinessBearerTokenLoaded();
      final second = await notifier.ensureBusinessBearerTokenLoaded();
      final runtimeState = container.read(appRuntimeStateProvider);

      expect(first, 'stored-token');
      expect(second, 'stored-token');
      expect(runtimeState.businessBearerToken, 'stored-token');
      expect(authStorage.getTokenCalls, 1);
    });

    test('setBusinessBearerToken() writes token to runtime state and secure storage', () async {
      final authStorage = _FakeAuthStorageService();
      final container = ProviderContainer(overrides: [authStorageServiceProvider.overrideWith((ref) => authStorage)]);
      addTearDown(container.dispose);

      final notifier = container.read(appRuntimeStateProvider.notifier);

      await notifier.setBusinessBearerToken('fresh-token');
      final runtimeState = container.read(appRuntimeStateProvider);

      expect(runtimeState.businessBearerToken, 'fresh-token');
      expect(authStorage.savedTokens, ['fresh-token']);
    });
  });
}

class _FakeAuthStorageService implements AuthStorageService {
  _FakeAuthStorageService({this.initialToken});

  final String? initialToken;
  final List<String> savedTokens = [];
  int getTokenCalls = 0;
  bool didClear = false;

  @override
  Future<void> clearToken() async {
    didClear = true;
  }

  @override
  Future<String?> getToken() async {
    getTokenCalls += 1;
    return savedTokens.isNotEmpty ? savedTokens.last : initialToken;
  }

  @override
  Future<void> saveToken(String token) async {
    savedTokens.add(token);
  }
}
