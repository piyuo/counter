import 'package:core_domain/services/auth_storage_service.dart';
import 'package:core_domain/state/models/app_runtime_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_runtime_state_notifier.g.dart';

abstract class AppRuntimeStateController {
  void setDevelopMode(bool value);
  Future<void> setBusinessBearerToken(String token);
  Future<void> clearBusinessBearerToken();
  Future<String?> ensureBusinessBearerTokenLoaded();
}

@Riverpod(keepAlive: true)
class AppRuntimeStateNotifier extends _$AppRuntimeStateNotifier implements AppRuntimeStateController {
  @override
  AppRuntimeState build() {
    return const AppRuntimeState();
  }

  @override
  void setDevelopMode(bool value) {
    state = state.copyWith(developMode: value);
  }

  @override
  Future<void> setBusinessBearerToken(String token) async {
    await ref.read(authStorageServiceProvider).saveToken(token);
    state = state.copyWith(businessBearerToken: token);
  }

  @override
  Future<void> clearBusinessBearerToken() async {
    await ref.read(authStorageServiceProvider).clearToken();
    state = state.copyWith(businessBearerToken: null);
  }

  @override
  Future<String?> ensureBusinessBearerTokenLoaded() async {
    final currentToken = state.businessBearerToken;
    if (currentToken != null && currentToken.isNotEmpty) {
      return currentToken;
    }

    final storedToken = await ref.read(authStorageServiceProvider).getToken();
    if (storedToken == null || storedToken.isEmpty) {
      return null;
    }

    state = state.copyWith(businessBearerToken: storedToken);
    return storedToken;
  }
}
