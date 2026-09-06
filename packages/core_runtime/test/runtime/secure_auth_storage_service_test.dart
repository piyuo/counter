// TOC:
//  - set stores an encrypted value that round-trips through get
//  - get returns empty when no value has been saved
//  - set with an empty value removes any existing entry
//  - remove removes the stored value
//  - set overwrites an existing value
//  - isExists reflects whether a value is stored
//  - get returns empty when stored data is malformed
//  - get returns empty when stored data was encrypted with a different key
//  - reset removes the customServerApiKey entry

import 'dart:convert';

import 'package:core_runtime/runtime/secure_auth_storage_service.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  late SecureAuthStorageService service;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    service = SecureAuthStorageService();
  });

  group('EncryptedAuthStorageService', () {
    test('set stores an encrypted value that round-trips through get', () async {
      await service.set('device_token', 'tok_abc');

      final result = await service.get('device_token');

      expect(result, 'tok_abc');
    });

    test('get returns empty when no value has been saved', () async {
      final result = await service.get('device_token');

      expect(result, isEmpty);
    });

    test('set with an empty value removes any existing entry', () async {
      await service.set('device_token', 'tok_abc');

      await service.set('device_token', '');

      expect(await service.get('device_token'), isEmpty);
    });

    test('remove removes the stored value', () async {
      await service.set('device_token', 'tok_abc');

      await service.remove('device_token');

      expect(await service.get('device_token'), isEmpty);
    });

    test('set overwrites an existing value', () async {
      await service.set('device_token', 'tok_old');
      await service.set('device_token', 'tok_new');

      expect(await service.get('device_token'), 'tok_new');
    });

    test('isExists reflects whether a value is stored', () async {
      expect(await service.isExists('device_token'), isFalse);

      await service.set('device_token', 'tok_abc');
      expect(await service.isExists('device_token'), isTrue);

      await service.remove('device_token');
      expect(await service.isExists('device_token'), isFalse);
    });

    test('get returns empty when stored data is malformed', () async {
      final preferences = SharedPreferencesAsync();
      await preferences.setString('auth_device_token', 'not-valid-base64!!');

      final result = await service.get('device_token');

      expect(result, isEmpty);
    });

    test('get returns empty when stored data was encrypted with a different key', () async {
      final otherAlgorithm = AesGcm.with256bits();
      final otherKey = await otherAlgorithm.newSecretKey();
      final secretBox = await otherAlgorithm.encryptString('tok_abc', secretKey: otherKey);
      final preferences = SharedPreferencesAsync();
      await preferences.setString('auth_device_token', base64UrlEncode(secretBox.concatenation()));

      final result = await service.get('device_token');

      expect(result, isEmpty);
    });

    test('reset removes the customServerApiKey entry', () async {
      await service.set('customServerApiKey', 'server_key');

      await service.reset();

      expect(await service.get('customServerApiKey'), isEmpty);
    });
  });
}
