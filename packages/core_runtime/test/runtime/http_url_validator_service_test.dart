// ===============================================
// Test Suite: http_url_validator_service_test.dart
// Description: Unit tests for HttpUrlValidatorService format and connectivity checks.
//
// Test Groups:
//   - Format validation (empty, whitespace, bad scheme, no host, plain text, edge cases)
//   - Connectivity — success (local HttpServer returning 200)
//   - Connectivity — server errors (local HttpServer returning 4xx/5xx)
//   - Connectivity — unreachable (closed port → connection refused)
//   - Connectivity — unknown host (.invalid TLD)
// ===============================================

import 'dart:io';

import 'package:core_runtime/core_runtime.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Starts a temporary [HttpServer] on localhost, runs [callback] with its
/// address, then shuts the server down.
Future<void> _withServer(Future<void> Function(String baseUrl) callback, {int statusCode = HttpStatus.ok}) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  server.listen((req) async {
    req.response.statusCode = statusCode;
    await req.response.close();
  });
  try {
    await callback('http://127.0.0.1:${server.port}');
  } finally {
    await server.close(force: true);
  }
}

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
      if (result != null) {
        expect(result, isNot(contains('invalid')));
        expect(result, isNot(contains('Please enter a URL')));
        expect(result, isNot(contains('must start with')));
      }
    }, timeout: const Timeout(Duration(seconds: 15)));

    test('accepts URL with path and query string', () async {
      final result = await service.validate('http://127.0.0.1:19998/api/v1?foo=bar');
      if (result != null) {
        expect(result, isNot(contains('invalid')));
        expect(result, isNot(contains('must start with')));
      }
    }, timeout: const Timeout(Duration(seconds: 15)));

    test('trims surrounding whitespace before validating', () async {
      final result = await service.validate('  http://127.0.0.1:19998  ');
      if (result != null) {
        expect(result, isNot(contains('Please enter a URL')));
        expect(result, isNot(contains('invalid')));
      }
    }, timeout: const Timeout(Duration(seconds: 15)));
  });

  // ── Connectivity — success ───────────────────────────────────────────────

  group('HttpUrlValidatorService.validate — connectivity success', () {
    test('returns null when server responds with 200', () async {
      await _withServer((url) async {
        final result = await service.validate(url);
        expect(result, isNull);
      });
    });

    test('returns null when server responds with 404 (reachable, page missing)', () async {
      await _withServer((url) async {
        final result = await service.validate(url);
        expect(result, isNull);
      }, statusCode: HttpStatus.notFound);
    });

    test('returns null when server responds with 500 (reachable, server error)', () async {
      await _withServer((url) async {
        final result = await service.validate(url);
        expect(result, isNull);
      }, statusCode: HttpStatus.internalServerError);
    });
  });

  // ── Connectivity — unreachable ───────────────────────────────────────────

  group('HttpUrlValidatorService.validate — connectivity failure', () {
    test('returns connection-refused error for a closed localhost port', () async {
      final probe = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final port = probe.port;
      await probe.close();

      final result = await service.validate('http://127.0.0.1:$port');
      expect(result, isNotNull);
      expect(result!.toLowerCase(), anyOf(contains('refused'), contains('connect'), contains('timed out')));
    }, timeout: const Timeout(Duration(seconds: 15)));

    test('returns error for an unknown host (.invalid TLD)', () async {
      final result = await service.validate('https://this-host-does-not-exist.invalid');
      expect(result, isNotNull);
    }, timeout: const Timeout(Duration(seconds: 15)));
  });
}
