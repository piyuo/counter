// TOC:
//  - saveToken writes the token to secure storage
//  - getToken returns null when no token has been saved
//  - getToken returns the saved token
//  - clearToken removes the stored token
//  - saveToken overwrites an existing token

import 'package:core_runtime/runtime/secure_auth_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'secure_auth_storage_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureAuthStorageService service;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = SecureAuthStorageService(storage: mockStorage);
  });

  group('SecureAuthStorageService', () {
    test('saveToken writes the token to secure storage', () async {
      when(mockStorage.write(key: 'device_token', value: 'tok_abc')).thenAnswer((_) async {});

      await service.set('device_token', 'tok_abc');

      verify(mockStorage.write(key: 'device_token', value: 'tok_abc')).called(1);
    });

    test('getToken returns empty when no token has been saved', () async {
      when(mockStorage.read(key: 'device_token')).thenAnswer((_) async => null);
      final result = await service.get('device_token');
      expect(result, isEmpty);
    });

    test('getToken returns the saved token', () async {
      when(mockStorage.read(key: 'device_token')).thenAnswer((_) async => 'tok_abc');
      final result = await service.get('device_token');
      expect(result, 'tok_abc');
    });

    test('remove the stored token', () async {
      when(mockStorage.delete(key: 'device_token')).thenAnswer((_) async {});
      when(mockStorage.read(key: 'device_token')).thenAnswer((_) async => 'tok_abc');
      await service.remove('device_token');
      verify(mockStorage.delete(key: 'device_token')).called(1);
    });

    test('saveToken overwrites an existing token', () async {
      when(mockStorage.write(key: 'device_token', value: anyNamed('value'))).thenAnswer((_) async {});
      when(mockStorage.read(key: 'device_token')).thenAnswer((_) async => 'tok_new');

      await service.set('device_token', 'tok_old');
      await service.set('device_token', 'tok_new');

      final result = await service.get('device_token');
      expect(result, 'tok_new');
      verify(mockStorage.write(key: 'device_token', value: anyNamed('value'))).called(2);
    });
  });
}
