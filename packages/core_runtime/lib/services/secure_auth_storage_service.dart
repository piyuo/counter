import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:cryptography/cryptography.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores authentication credentials encrypted in SharedPreferences.
///
/// Security model:
/// - Credentials are never stored as plaintext.
/// - AES-256-GCM provides confidentiality and tamper detection.
/// - The encryption key is embedded in the application.
///
/// This is application-level encryption, not OS-backed secure storage.
/// A determined attacker who can reverse engineer the application may be
/// able to recover the embedded encryption key and decrypt stored credentials.
class SecureAuthStorageService implements core_domain.AuthStorageService {
  // Replace this with a unique, randomly generated 256-bit key before release.
  //
  // Generate one with:
  //   openssl rand -base64 32
  //
  // Do not reuse this key in another application.
  static const _encryptionKeyBase64 = 'u5O6y9rNZ0hY6KldPlWBfHCpxUvc+cFuqMARt64Q4/Q=';

  final SharedPreferencesAsync _preferences;
  final AesGcm _algorithm;

  SecureAuthStorageService({SharedPreferencesAsync? preferences, AesGcm? algorithm})
    : _preferences = preferences ?? SharedPreferencesAsync(),
      _algorithm = algorithm ?? AesGcm.with256bits();

  SecretKey get _encryptionKey {
    final keyBytes = base64.decode(_encryptionKeyBase64);

    if (keyBytes.length != 32) {
      throw StateError('EncryptedAuthStorageService requires a 256-bit encryption key.');
    }

    return SecretKey(keyBytes);
  }

  @override
  Future<void> set(String key, String value) async {
    if (value.isEmpty) {
      await remove(key);
      return;
    }

    final secretBox = await _algorithm.encryptString(value, secretKey: _encryptionKey);

    await _preferences.setString(_storageKeyFor(key), base64UrlEncode(secretBox.concatenation()));
  }

  @override
  Future<String> get(String key) async {
    final encryptedValue = await _preferences.getString(_storageKeyFor(key));

    if (encryptedValue == null || encryptedValue.isEmpty) {
      return '';
    }

    try {
      final secretBox = SecretBox.fromConcatenation(
        base64Url.decode(encryptedValue),
        nonceLength: _algorithm.nonceLength,
        macLength: _algorithm.macAlgorithm.macLength,
      );

      return await _algorithm.decryptString(secretBox, secretKey: _encryptionKey);
    } on FormatException {
      // Stored data is malformed.
      return '';
    } on SecretBoxAuthenticationError {
      // Stored data was modified or encrypted with a different key.
      return '';
    }
  }

  /// Returns whether a value is currently stored for [key].
  @override
  Future<bool> isExists(String key) async {
    return _preferences.containsKey(_storageKeyFor(key));
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(_storageKeyFor(key));
  }

  @override
  Future<void> reset() async {
    await _preferences.remove(_storageKeyFor('customServerApiKey'));
  }

  String _storageKeyFor(String key) {
    // AuthStorageService supports arbitrary keys, so preserve that contract
    // while keeping the actual SharedPreferences key private to this service.
    return 'auth_$key';
  }
}
