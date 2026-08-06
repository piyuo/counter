// ===============================================
// Test Suite: http_url_validator_service_test.dart
// Description: Unit tests for HttpUrlValidatorService format checks.
//
// Test Groups:
//   - Format validation (empty, whitespace, bad scheme, no host, plain text, edge cases)
// ===============================================

import 'package:core_runtime/core_runtime.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  final service = HttpUrlValidatorService();

  // ── Format validation ────────────────────────────────────────────────────

  group('HttpUrlValidatorService.validate — format checks', () {
    test('returns error for empty string', () async {
      final result = await service.validate('');
      expect(result, isNotNull);
      expect(result, contains('Please enter a URL'));
    });

    test('returns error for whitespace-only string', () async {
      final result = await service.validate('   ');
      expect(result, isNotNull);
      expect(result, contains('Please enter a URL'));
    });

    test('returns error for non-http scheme (ftp)', () async {
      final result = await service.validate('ftp://example.com');
      expect(result, isNotNull);
      expect(result, contains('http'));
    });

    test('returns error for URL with no host (bare https://)', () async {
      final result = await service.validate('https://');
      expect(result, isNotNull);
      expect(result, contains('invalid'));
    });

    test('returns error for plain text without scheme', () async {
      final result = await service.validate('not-a-url');
      expect(result, isNotNull);
    });

    test('accepts http scheme', () async {
      final result = await service.validate('http://127.0.0.1:19998');
      expect(result, isNull);
    });

    test('accepts URL with path and query string', () async {
      final result = await service.validate('http://127.0.0.1:19998/api/v1?foo=bar');
      expect(result, isNull);
    });

    test('trims surrounding whitespace before validating', () async {
      final result = await service.validate('  http://127.0.0.1:19998  ');
      expect(result, isNull);
    });
  });
}
