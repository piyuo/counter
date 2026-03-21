import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_storage_service.g.dart';

abstract class AuthStorageService {
  /// Persists [token] to secure OS-backed storage (Keychain on iOS/macOS,
  /// EncryptedSharedPreferences/Keystore on Android).
  Future<void> saveToken(String token);

  /// Reads the stored token, or `null` if none exists.
  Future<String?> getToken();

  /// Removes the stored token (use on logout or token revocation).
  Future<void> clearToken();
}

@riverpod
AuthStorageService authStorageService(Ref ref) {
  throw UnimplementedError('authStorageServiceProvider must be overridden');
}
