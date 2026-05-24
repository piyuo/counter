// TOC:
//  - PayloadSerializer: abstract serialisation contract (JSON today, Protobuf later)
//  - payloadSerializerProvider: Riverpod provider (overridden in core_runtime)

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/telemetry_payload.dart';

part 'payload_serializer.g.dart';

/// Converts a batch of [TelemetryPayload]s to bytes for transmission.
/// The server always receives a batch (list), even when there is only one item.
abstract class PayloadSerializer {
  /// MIME type sent in the Content-Type header.
  String get contentType;

  /// Encodes payloads plus common envelope metadata shared by the whole batch.
  List<int> serialize(
    List<TelemetryPayload> payloads, {
    required int schemaVersion,
    required String deviceId,
    String? projectId,
    String? assignId,
  });
}

@riverpod
PayloadSerializer payloadSerializer(Ref ref) {
  throw UnimplementedError('payloadSerializerProvider must be overridden');
}
