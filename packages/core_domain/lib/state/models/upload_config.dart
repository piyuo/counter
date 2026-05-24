// Model: UploadConfig
// Description: Unified upload configuration for the telemetry upload pipeline.
//   Persisted in AppState (JSON). This stores upload timing, batching,
//   and retention settings only. Endpoint URL and auth come from DataServer at
//   upload time via telemetry runtime wiring.
// Data rate assumption: 1 record per 5 minutes → 12 records/hour, small pedestrian-count payloads (~100–200 B each).
// Fields:
//   - wallClockCadenceMin : int — upload cadence in minutes aligned to local wall-clock boundaries (default: 60)
//   - maxBatchSize     : int    — max records per upload request; 1008 ≈ 3.5 days (default: 1008)
//   - payloadRetentionDays : int — prune queued payloads older than this many days (default: 7)
//   - uploadLogRetentionDays : int — prune upload logs older than this many days (default: 7)
//   - timeoutSec       : int    — HTTP timeout per request, in seconds (default: 30)

import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_config.freezed.dart';
part 'upload_config.g.dart';

@freezed
abstract class UploadConfig with _$UploadConfig {
  const UploadConfig._();

  const factory UploadConfig({
    /// Upload cadence in minutes, aligned to local wall-clock boundaries.
    ///
    /// Examples:
    /// - 60: 01:00, 02:00, 03:00...
    /// - 5: 01:00, 01:05, 01:10...
    @JsonKey(name: 'intervalMin') @Default(60) int wallClockCadenceMin,
  }) = _UploadConfig;

  factory UploadConfig.fromJson(Map<String, dynamic> json) => _$UploadConfigFromJson(json);
}
