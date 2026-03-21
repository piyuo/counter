// TOC:
//  - ResponseWorker: interprets transport response envelopes and applies server config overrides

import '../state/models/detection_params.dart';
import '../state/models/detection_type.dart';
import '../state/models/upload_config.dart';
import 'models/telemetry_response.dart';

typedef ServerConfigOverrideApplier =
    Future<void> Function({DetectionType? detection, DetectionParams? detectionParams, UploadConfig? deliveryConfig});

/// Parses transport response objects and decides whether delivery succeeded.
///
/// Rules:
/// - Wrapped envelopes with `{ "ok": false }` are treated as failures.
/// - Wrapped envelopes with `{ "ok": true }` are treated as success.
/// - Missing `ok` is treated as success for forward compatibility.
class ResponseWorker {
  const ResponseWorker({this.onServerConfigOverride});

  final ServerConfigOverrideApplier? onServerConfigOverride;

  Future<void> process(TelemetryResponse response) async {
    if (response.ok) {
      final applier = onServerConfigOverride;
      if (applier == null) return;

      final payload = response.data;
      if (payload == null) return;

      final configOverride = payload.config;
      final detection = payload.detection;
      final detectionParams = payload.detectionParams ?? _parseDetectionParams(configOverride?.detectionParams);
      final deliveryConfig = payload.deliveryConfig ?? _parseDeliveryConfig(configOverride);
      if (detection == null && detectionParams == null && deliveryConfig == null) return;
      await applier(detection: detection, detectionParams: detectionParams, deliveryConfig: deliveryConfig);
    }
  }

  DetectionParams? _parseDetectionParams(Map<String, dynamic>? raw) {
    if (raw == null) return null;
    try {
      return DetectionParams.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  UploadConfig? _parseDeliveryConfig(ServerConfig? raw) {
    if (raw == null) return null;
    final uploadIntervalSec = raw.uploadIntervalSec;
    if (uploadIntervalSec == null) return null;
    final cadenceMin = uploadIntervalSec <= 0 ? 1 : (uploadIntervalSec / 60).ceil();
    return UploadConfig(wallClockCadenceMin: cadenceMin);
  }
}
