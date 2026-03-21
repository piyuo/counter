// TOC:
//  - HttpUrlValidatorService: validates URL format and reachability via HTTP HEAD request

import 'dart:async';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;

class HttpUrlValidatorService implements core_domain.UrlValidatorService {
  static const _timeout = Duration(seconds: 10);

  @override
  Future<String?> validate(String url) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return 'Please enter a URL.';
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null || uri.host.isEmpty) {
      return 'The URL format is invalid. Please enter a valid URL (e.g. https://example.com).';
    }

    if (!uri.isScheme('http') && !uri.isScheme('https')) {
      return 'The URL must start with http:// or https://.';
    }
    return null;
    /*
    HttpClient? client;
    try {
      client = HttpClient()..connectionTimeout = _timeout;
      final request = await client.headUrl(uri);
      final response = await request.close().timeout(_timeout);
      await response.drain<void>();
      return null; // success
    } on SocketException catch (e) {
      return _describeSocketError(uri.host, e);
    } on HandshakeException {
      return 'SSL/TLS error. The server certificate at "${uri.host}" is invalid or untrusted.';
    } on HttpException catch (e) {
      return 'HTTP error while connecting to "$trimmed": ${e.message}.';
    } on TimeoutException {
      return 'Connection timed out. "$trimmed" did not respond within 10 seconds.';
    } catch (e) {
      return 'Failed to connect to "$trimmed": $e';
    } finally {
      client?.close(force: true);
    }*/
  }

  static String _describeSocketError(String host, SocketException e) {
    final code = e.osError?.errorCode;
    if (code == 61 || code == 111) {
      return 'Connection refused. Make sure the server is running at "$host".';
    }
    if (code == 8 || code == -2 || code == 11001) {
      return 'Host not found. Check that "$host" is a valid hostname.';
    }
    if (code == 51 || code == 101) {
      return 'Network unreachable. Please check your internet connection.';
    }
    if (code == 60 || code == 110) {
      return 'Connection timed out. "$host" did not respond. Check that the host is reachable.';
    }
    final detail = e.osError?.message ?? e.message;
    return 'Could not connect to "$host": $detail.';
  }
}
