import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthStorageService implements core_domain.AuthStorageService {
  final FlutterSecureStorage _storage;

  SecureAuthStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> set(String key, String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: key);
      return;
    }
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String> get(String key) async {
    final result = await _storage.read(key: key);
    return result ?? '';
  }

  @override
  Future<void> remove(String key) async {
    String? exists = await _storage.read(key: key);
    if (exists != null) {
      await _storage.delete(key: key);
    }
  }

  @override
  Future<void> reset() async {
    await _storage.deleteAll();
  }
}
