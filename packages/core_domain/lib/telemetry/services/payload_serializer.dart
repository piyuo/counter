// TOC:
//  - PayloadSerializer: abstract serialization contract (JSON today, Protobuf later)
//  - payloadSerializerProvider: Riverpod provider (overridden in core_runtime)

import 'package:core_domain/model/observation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payload_serializer.g.dart';

/// Schema version written by this build.
///
/// v2 uses date/time components and names the per-area event count `stagnant`.
/// Increment this version for breaking changes to the upload contract.
const int kSchemaVersion = 2;

/// Converts a batch of [Observation]s to bytes for transmission.
/// The server always receives a batch (list), even when there is only one item.
abstract class PayloadSerializer {
  /// MIME type sent in the Content-Type header.
  String get contentType;

  /// Encodes payloads plus common envelope metadata shared by the whole batch.
  List<int> serialize(List<Observation> observations, {required String deviceId, String? projectId, String? assignId});
}

@riverpod
PayloadSerializer payloadSerializer(Ref ref) {
  throw UnimplementedError('payloadSerializerProvider must be overridden');
}
