// TOC:
//  - QueuedPayload: queue row wrapping a TelemetryPayload with upload state

import 'telemetry_payload.dart';

/// A [TelemetryPayload] held in the persistent queue, augmented with
/// persistence/upload state.
class QueuedPayload {
  const QueuedPayload({required this.id, required this.payload, required this.createdAtUtc, this.uploadedAtUtc});

  /// Matches [TelemetryPayload.payloadId]; used as the queue row primary key.
  final String id;

  final TelemetryPayload payload;

  /// UTC time when this payload was first enqueued; used for expiry pruning.
  final DateTime createdAtUtc;

  /// UTC time when this payload was uploaded successfully.
  /// Null means the payload is still pending.
  final DateTime? uploadedAtUtc;

  /// Whether this payload has already been uploaded successfully.
  bool get isUploaded => uploadedAtUtc != null;
}
