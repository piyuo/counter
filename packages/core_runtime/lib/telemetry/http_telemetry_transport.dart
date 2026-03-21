// TOC:
//  - HttpTelemetryTransport: HTTP POST implementation of TelemetryTransport
//
// Security: uses an optional Bearer token; token is never logged.
// Errors: any transport/HTTP failure is returned as a wrapped JSON error string.

import 'dart:convert';
import 'dart:io'; // needed for SocketException

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:http/http.dart' as http;

/// HTTP POST transport that never throws; failures are returned as wrapped
/// JSON envelopes so [UploadWorker] can apply retry logic.
class HttpTelemetryTransport implements core_domain.TelemetryTransport {
  HttpTelemetryTransport({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<core_domain.TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    final headers = <String, String>{'Content-Type': contentType};
    if (bearerToken != null && bearerToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    try {
      final response = await _client.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        appkit.logError(
          '[HttpTelemetryTransport] '
          '${response.statusCode} (${response.reasonPhrase ?? 'Unknown error'}) ',
        );
        return _errorEnvelope(error: 'http_non_success');
      }

      return _successEnvelope(response.body);
    } catch (error) {
      final classified = _classifyException(error);
      appkit.logError('[HttpTelemetryTransport] $classified ($error)');
      return _errorEnvelope(error: classified);
    }
  }

  String _classifyException(Object error) {
    if (error is SocketException) {
      // error 61 = ECONNREFUSED (wrong host/port or server not running)
      if (error.osError?.errorCode == 61) return 'connection_refused';
      // error 8 = NODENAME (DNS lookup failed — bad hostname)
      if (error.osError?.errorCode == 8) return 'dns_lookup_failed';
      return 'socket_error';
    }
    // http package wraps SocketException in ClientException
    if (error is http.ClientException) {
      final msg = error.message.toLowerCase();
      if (msg.contains('connection refused')) return 'connection_refused';
      if (msg.contains('failed host lookup') || msg.contains('no address associated')) return 'dns_lookup_failed';
      if (msg.contains('connection timed out') || msg.contains('timed out')) return 'connection_timeout';
      if (msg.contains('software caused') || msg.contains('connection reset')) return 'connection_reset';
      return 'network_error';
    }
    if (error is FormatException) return 'invalid_url';
    return 'transport_exception'; // fallback — keeps old behaviour
  }

  core_domain.TelemetryResponse _errorEnvelope({required String error}) {
    return core_domain.TelemetryResponse(v: 1, ok: false, error: error, data: null);
  }

  core_domain.TelemetryResponse _successEnvelope(String rawBody) {
    final body = rawBody.trim();
    if (body.isEmpty) {
      return const core_domain.TelemetryResponse(v: 1, ok: true, data: null);
    }

    final decoded = _tryDecodeJson(body);
    if (decoded is Map<String, dynamic>) {
      if (decoded['ok'] is bool && decoded.containsKey('v')) {
        try {
          return core_domain.TelemetryResponse.fromJson(decoded);
        } catch (_) {
          return core_domain.TelemetryResponse(v: 1, ok: true, data: _tryParseServerData(decoded));
        }
      }
      return core_domain.TelemetryResponse(v: 1, ok: true, data: _tryParseServerData(decoded));
    }
    if (decoded is Map) {
      final normalized = decoded.map((key, value) => MapEntry(key.toString(), value));
      return core_domain.TelemetryResponse(v: 1, ok: true, data: _tryParseServerData(normalized));
    }

    return const core_domain.TelemetryResponse(v: 1, ok: true, data: null);
  }

  core_domain.ServerData? _tryParseServerData(Map<String, dynamic> json) {
    try {
      return core_domain.ServerData.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  dynamic _tryDecodeJson(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }
}
