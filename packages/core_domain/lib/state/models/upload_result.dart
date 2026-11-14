import 'package:freezed_annotation/freezed_annotation.dart';

import 'detection_params.dart';
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
