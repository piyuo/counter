// TOC:
//  - TelemetryResponse: versioned envelope for telemetry upload responses
//  - ServerData: payload object for upload ack and optional server-side overrides
//  - ServerConfig: sparse config override payload from server

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../state/models/detection_params.dart';
import '../../state/models/detection_type.dart';
import '../../state/models/upload_config.dart';

part 'telemetry_response.freezed.dart';
part 'telemetry_response.g.dart';

@freezed
abstract class TelemetryResponse with _$TelemetryResponse {
  const factory TelemetryResponse({required int v, required bool ok, String? error, ServerData? data}) =
      _TelemetryResponse;

  factory TelemetryResponse.fromJson(Map<String, dynamic> json) => _$TelemetryResponseFromJson(json);
}

@freezed
abstract class ServerData with _$ServerData {
  const factory ServerData({
    DetectionType? detection,
    DetectionParams? detectionParams,
    UploadConfig? deliveryConfig,
    ServerConfig? config,
  }) = _ServerData;

  factory ServerData.fromJson(Map<String, dynamic> json) => _$ServerDataFromJson(json);
}

@freezed
abstract class ServerConfig with _$ServerConfig {
  const factory ServerConfig({int? uploadIntervalSec, Map<String, dynamic>? detectionParams}) = _ServerConfig;

  factory ServerConfig.fromJson(Map<String, dynamic> json) => _$ServerConfigFromJson(json);
}
