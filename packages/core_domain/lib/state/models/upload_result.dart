// Model: UploadResult
// Description: Server response after receiving a telemetry upload.
//   Indicates success/failure and optionally carries updated configuration
//   that the server wants to push to the client — eliminating the need for
//   the user to change Detection, DetectionParams, or UploadParams manually.
// Fields:
//   - isSuccess       : bool              — whether the server accepted the upload
//   - message         : String?           — optional human-readable info or error detail from the server
//   - detection       : Detection?        — if set, client should apply this detection type override
//   - detectionParams : DetectionParams?  — if set, client should apply these detection tuning params
//   - deliveryConfig  : UploadConfig? — if set, client should apply these upload pipeline params

import 'package:freezed_annotation/freezed_annotation.dart';

import 'detection_params.dart';
import 'detection_type.dart';
import 'upload_config.dart';

part 'upload_result.freezed.dart';
part 'upload_result.g.dart';

@freezed
abstract class UploadResult with _$UploadResult {
  const factory UploadResult({
    required bool isSuccess,
    String? message,
    DetectionType? detection,
    DetectionParams? detectionParams,
    UploadConfig? deliveryConfig,
  }) = _UploadResult;

  factory UploadResult.fromJson(Map<String, dynamic> json) => _$UploadResultFromJson(json);
}
