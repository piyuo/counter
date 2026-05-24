import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_storage_service.g.dart';

abstract class AuthStorageService {
  /// Persists [value] to secure OS-backed storage (Keychain on iOS/macOS,
  /// EncryptedSharedPreferences/Keystore on Android).
  Future<void> set(String key, String value);

  /// Reads the stored token, or `null` if none exists.
  Future<String> get(String key);

  /// Removes the stored token, if it exists.
  Future<void> remove(String key);

  /// Clears all stored tokens.
  Future<void> reset();
}

@riverpod
AuthStorageService authStorageService(Ref ref) {
  throw UnimplementedError('authStorageServiceProvider must be overridden');
}
