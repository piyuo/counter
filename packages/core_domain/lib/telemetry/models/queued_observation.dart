// TOC:
//  - QueuedObservation: queue row wrapping an Observation with upload state

import 'package:core_domain/model/observation.dart';

class QueuedObservation {
  const QueuedObservation({required this.observation, required this.createdAtUtc, this.uploadedAtUtc});

  final Observation observation;

  /// UTC time when this observation was first enqueued; used for expiry pruning.
  final DateTime createdAtUtc;

  /// UTC time when this observation was uploaded successfully.
  /// Null means the observation is still pending.
  final DateTime? uploadedAtUtc;

  /// Whether this observation has already been uploaded successfully.
  bool get isUploaded => uploadedAtUtc != null;
}
