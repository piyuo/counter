import 'package:camera/camera.dart';
import 'package:universal_platform/universal_platform.dart';

import 'model/video.dart';

/// Camera Manager manage the system camera and provide the list of available cameras
class CameraManager {
  /// the list of cameras
  final List<CameraDefine> cameraDefines = [];

  /// is camera exist
  bool get hasCamera => cameraDefines.isNotEmpty;

  /// initialize the provider
  Future<void> init() async {
    if (!UniversalPlatform.isIOS && !UniversalPlatform.isAndroid) {
      // camera only support on mobile
      return;
    }
    final cameras = await availableCameras();
    int backCameraIndex = 1;
    int frontCameraIndex = 1;

    final defines = cameras.map((e) {
      if (e.lensDirection == CameraLensDirection.back) {
        return CameraDefine(name: e.name, title: '${backCameraIndex++}', isFrontCamera: false);
      } else {
        return CameraDefine(name: e.name, title: '${frontCameraIndex++}', isFrontCamera: true);
      }
    }).toList();
    cameraDefines.addAll(defines);
  }
}
