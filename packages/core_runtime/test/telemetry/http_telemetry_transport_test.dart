// TOC:
//  - HttpTelemetryTransport — send: posts to the configured URL
//  - HttpTelemetryTransport — send: includes Bearer token header
//  - HttpTelemetryTransport — send: omits Authorization when token is absent
//  - HttpTelemetryTransport — send: includes correct Content-Type header
//  - HttpTelemetryTransport — send: passes body bytes unchanged
//  - HttpTelemetryTransport — send: returns normalized TelemetryResponse on 2xx
//  - HttpTelemetryTransport — send: returns wrapped JSON error on non-2xx
//  - HttpTelemetryTransport — send: returns wrapped JSON error on client exception

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/http_telemetry_transport.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_telemetry_transport_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late HttpTelemetryTransport transport;

  const url = 'https://example.com/api/telemetry';
  const bearerToken = 'tok_test_bearer';
  const body = [1, 2, 3, 4];
  const contentType = 'application/json';

  setUp(() {
    mockClient = MockClient();
    transport = HttpTelemetryTransport(client: mockClient);
  });

  group('HttpTelemetryTransport', () {
    test('POSTs to the URL from DataServer', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('', 200));

      await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);

      final captured = verify(
        mockClient.post(captureAny, headers: anyNamed('headers'), body: anyNamed('body')),
      ).captured;
      expect(captured.first, Uri.parse(url));
    });

    test('includes Bearer token in Authorization header', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('', 200));

      await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);

      final headers =
          verify(mockClient.post(any, headers: captureAnyNamed('headers'), body: anyNamed('body'))).captured.first
              as Map<String, String>;
      expect(headers['Authorization'], 'Bearer $bearerToken');
    });

    test('omits Authorization header when bearer token is absent', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('', 200));

      await transport.send(url: url, bearerToken: '', body: body, contentType: contentType);

      final headers =
          verify(mockClient.post(any, headers: captureAnyNamed('headers'), body: anyNamed('body'))).captured.first
              as Map<String, String>;
      expect(headers.containsKey('Authorization'), isFalse);
    });

    test('sets Content-Type header from the serialiser', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('', 200));

      await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: 'application/x-protobuf');

      final headers =
          verify(mockClient.post(any, headers: captureAnyNamed('headers'), body: anyNamed('body'))).captured.first
              as Map<String, String>;
      expect(headers['Content-Type'], 'application/x-protobuf');
    });

    test('passes body bytes to the HTTP client unchanged', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('', 200));

      await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);

      final captured = verify(
        mockClient.post(any, headers: anyNamed('headers'), body: captureAnyNamed('body')),
      ).captured.first;
      expect(captured, body);
    });

    test('returns normalized success response on 200 OK', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('{"detection":{"runtimeType":"vehicle"}}', 200));

      final response = await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);
      expect(response.ok, isTrue);
      expect(response.v, 1);
      expect(response.data?.detection, const core_domain.DetectionType.vehicle());
    });

    test('returns wrapped JSON error on 400 Bad Request', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('bad request', 400));

      final response = await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);
      expect(response.v, 1);
      expect(response.ok, isFalse);
      expect(response.error, 'http_non_success');
    });

    test('returns wrapped JSON error on 500 Internal Server Error', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenAnswer((_) async => http.Response('error', 500));

      final response = await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);
      expect(response.ok, isFalse);
      expect(response.error, 'http_non_success');
    });

    test('returns wrapped JSON error when HTTP client throws', () async {
      when(
        mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).thenThrow(Exception('socket failed'));

      final response = await transport.send(url: url, bearerToken: bearerToken, body: body, contentType: contentType);
      expect(response.ok, isFalse);
      expect(response.error, 'transport_exception');
    });
  });
}
