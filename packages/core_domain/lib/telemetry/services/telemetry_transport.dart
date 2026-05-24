// TOC:
//  - TelemetryTransport: abstract byte-delivery contract (HTTP today, gRPC later)
//  - telemetryTransportProvider: Riverpod provider (overridden in core_runtime)

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/telemetry_response.dart';

part 'telemetry_transport.g.dart';

/// Low-level transport that delivers serialized bytes to the backend.
/// Returns a typed envelope for both success and failure outcomes.
abstract class TelemetryTransport {
  Future<TelemetryResponse> send({
    required String url,
    required String bearerToken,
    required List<int> body,
    required String contentType,
  });
}

@riverpod
TelemetryTransport telemetryTransport(Ref ref) {
  throw UnimplementedError('telemetryTransportProvider must be overridden');
}
