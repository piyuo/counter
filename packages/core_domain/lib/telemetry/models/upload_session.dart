// TOC:
//  - UploadSession: resolved transport/auth context plus persisted upload tuning

import '../../state/models/data_server.dart';
import '../../state/models/upload_config.dart';

/// Runtime-only telemetry configuration assembled from persisted upload
/// tuning plus the currently active data server and optional business auth
/// token.
class UploadSession {
  const UploadSession({required this.config, required this.dataServer, required this.deviceId, this.bearerToken});

  final UploadConfig config;
  final DataServer dataServer;
  final String deviceId;
  final String? bearerToken;
}
