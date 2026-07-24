import 'package:core_domain/services/auth_storage_service.dart';
import 'package:core_domain/state/models/app_runtime_state.dart';
import 'package:core_domain/state/models/data_server.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_runtime_notifier.g.dart';

abstract class AppRuntimeController {
  void setDevelopMode(bool value);
  void setIsVisionRunning(bool value);
  Future<void> saveBearerToken(DataServerSelection selection, String token);
  Future<void> clearBearerToken();
  Future<void> loadBearerToken(DataServerSelection selection);
  Future<void> reset();
}

@Riverpod(keepAlive: true)
class AppRuntimeNotifier extends _$AppRuntimeNotifier implements AppRuntimeController {
  @override
  AppRuntimeState build() {
    return const AppRuntimeState();
  }

  @override
  void setDevelopMode(bool value) {
    state = state.copyWith(developMode: value);
  }

  @override
  void setIsVisionRunning(bool value) {
    state = state.copyWith(isVisionRunning: value);
  }

  @override
  Future<void> saveBearerToken(DataServerSelection selection, String token) async {
    if (selection == DataServerSelection.noDataServer || selection == DataServerSelection.personalPiyuo) {
      appkit.logDebug(
        'Cannot save bearer token for DataServerSelection.none or piyuo, they should not have bearer tokens.',
      );
      state = state.copyWith(bearerToken: '');
      return;
    }

    await ref.read(authStorageServiceProvider).set(getKeyFromDataServerSelection(selection), token);
    state = state.copyWith(bearerToken: token);
  }

  @override
  Future<void> clearBearerToken() async {
    state = state.copyWith(bearerToken: '');
  }

  /// call by appNotifier when the app state is loaded
  @override
  Future<void> loadBearerToken(DataServerSelection selection) async {
    if (selection == DataServerSelection.noDataServer || selection == DataServerSelection.personalPiyuo) {
      state = state.copyWith(bearerToken: '');
      return;
    }

    final storedToken = await ref.read(authStorageServiceProvider).get(getKeyFromDataServerSelection(selection));
    state = state.copyWith(bearerToken: storedToken);
  }

  @override
  Future<void> reset() async {
    state = const AppRuntimeState();
  }
}
