import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthStorageService implements core_domain.AuthStorageService {
  static const _tokenKey = 'device_token';

  final FlutterSecureStorage _storage;

  SecureAuthStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
