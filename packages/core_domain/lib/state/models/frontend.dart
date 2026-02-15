import 'package:freezed_annotation/freezed_annotation.dart';

part 'frontend.freezed.dart';
part 'frontend.g.dart';

@freezed
sealed class Frontend with _$Frontend {
  const factory Frontend.empty() = EmptyFrontend;

  const factory Frontend.camera({required int cameraIndex}) = CameraFrontend;

  const factory Frontend.webcam({required int webcamIndex}) = WebcamFrontend;

  const factory Frontend.file({required String fileName}) = FileFrontend;

  const factory Frontend.liveUrl({required String url}) = LiveUrlFrontend;

  factory Frontend.fromJson(Map<String, dynamic> json) => _$FrontendFromJson(json);
}
