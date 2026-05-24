import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Invitation', () {
    test('constructs with required fields', () {
      const inv = core_domain.Invitation(
        businessCustomServer: core_domain.BusinessCustomServer(
          url: 'https://example.com',
          projectName: 'project123',
          projectId: 'project123',
          assignedId: 'assign123',
          assignedName: 'device',
        ),
        instruction: 'Test',
        bearerToken: 'token',
        detection: core_domain.DetectionType.human(),
        detectionParams: core_domain.DetectionParams(),
        uploadConfig: core_domain.UploadConfig(),
      );
      expect(inv.businessCustomServer!.url, 'https://example.com');
      expect(inv.businessCustomServer!.projectId, 'project123');
      expect(inv.instruction, 'Test');
      expect(inv.bearerToken, 'token');
      expect(inv.businessCustomServer!.assignedId, 'assign123');
      expect(inv.businessCustomServer!.assignedName, 'device');
      expect(inv.detectionParams, isA<core_domain.DetectionParams>());
      expect(inv.uploadConfig, isA<core_domain.UploadConfig>());
    });

    test('decodes backend invitation json via Invitation.fromJson', () {
      final inv = core_domain.Invitation.fromJson({
        'businessCustomServer': {
          'url': 'https://example.com',
          'projectName': 'project123',
          'projectId': 'project123',
          'assignedId': 'assign123',
          'assignedName': 'device',
        },
        'instruction': 'Test',
        'bearerToken': 'token',
        'deviceName': 'device',
        'detection': {'runtimeType': 'human'},
        'detectionParams': <String, dynamic>{},
        'deliveryConfig': <String, dynamic>{},
      });

      expect(inv.businessCustomServer!.url, 'https://example.com');
      expect(inv.businessCustomServer!.projectName, 'project123');
      expect(inv.businessCustomServer!.assignedId, 'assign123');
      expect(inv.bearerToken, 'token');
      expect(inv.instruction, 'Test');
      expect(inv.detectionParams!.stayThresholdSeconds, 15);
      expect(inv.detectionParams!.disappearThresholdSeconds, 7);
    });
  });

  group('RemoteInvitationService.isValidCode', () {
    final service = PiyuoInvitationService();

    test('returns true for a valid 10-char code', () {
      expect(service.isValidCode('2345678abc'), isTrue);
    });

    test('accepts uppercase input (case-insensitive)', () {
      expect(service.isValidCode('2345678ABC'), isTrue);
    });

    test('returns false when shorter than 10 chars', () {
      expect(service.isValidCode('2345678ab'), isFalse);
    });

    test('returns false when longer than 10 chars', () {
      expect(service.isValidCode('2345678abcd'), isFalse);
    });

    test('returns false for empty string', () {
      expect(service.isValidCode(''), isFalse);
    });

    test('returns false when code contains ambiguous chars (0, 1, i, l, o)', () {
      expect(service.isValidCode('0123456789'), isFalse);
      expect(service.isValidCode('1234567abc'), isFalse);
      expect(service.isValidCode('i234567abc'), isFalse);
      expect(service.isValidCode('l234567abc'), isFalse);
      expect(service.isValidCode('o234567abc'), isFalse);
    });

    test('returns false when code contains special characters', () {
      expect(service.isValidCode('2345678a!c'), isFalse);
      expect(service.isValidCode('2345678a c'), isFalse);
    });
  });
}
