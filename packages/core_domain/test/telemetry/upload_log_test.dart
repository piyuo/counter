import 'package:core_domain/core_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UploadLog', () {
    test('keeps provided success id unchanged', () {
      final utc = DateTime.utc(2026, 5, 18, 13, 45, 12);
      final log = UploadLog(id: 20260518131, attemptedAtUtc: utc, success: true, payloadSizeKb: 1);

      expect(log.id, 20260518131);
    });

    test('keeps provided failed id unchanged', () {
      final utc = DateTime.utc(2026, 5, 18, 13, 45, 12);
      final log = UploadLog(id: 20260518130, attemptedAtUtc: utc, success: false, payloadSizeKb: 1);

      expect(log.id, 20260518130);
    });

    test('keeps explicit id when provided', () {
      final log = UploadLog(
        id: 2020010100,
        attemptedAtUtc: DateTime.utc(2026, 5, 18, 13),
        success: true,
        payloadSizeKb: 1,
      );

      expect(log.id, 2020010100);
    });

    test('generateIdFromUtcTime encodes yyyyMMddHH + success digit', () {
      final successId = UploadLog.generateIdFromUtcTime(DateTime.utc(2026, 12, 3, 4, 59, 59), success: true);
      final failedId = UploadLog.generateIdFromUtcTime(DateTime.utc(2026, 12, 3, 4, 59, 59), success: false);

      expect(successId, 20261203041);
      expect(failedId, 20261203040);
    });

    test('generateIdFromUtcTime normalizes non-UTC input before encoding', () {
      final localTime = DateTime.parse('2026-05-18T13:45:12-07:00');

      expect(UploadLog.generateIdFromUtcTime(localTime, success: true), 20260518201);
    });
  });
}
