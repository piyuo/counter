import 'package:camera_macos/camera_macos.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:universal_platform/universal_platform.dart';

import 'model/video.dart';

/// Camera Manager manage the system webcam and provide the list of available webcams
class WebcamManager {
  /// the list of webcam index that is available
  List<WebcamDefine> webcamDefines = [];

  /// check if the webcams exist
  bool get hasWebcam => webcamDefines.isNotEmpty;

  /// init webcams
  Future<void> init() async {
    if (!UniversalPlatform.isMacOS && !UniversalPlatform.isWindows) {
      // webcam only support on desktop
      return;
    }

    if (UniversalPlatform.isMacOS) {
      List<CameraMacOSDevice> videoDevices =
          await CameraMacOS.instance.listDevices(deviceType: CameraMacOSDeviceType.video);
      for (int i = 0; i < videoDevices.length; i++) {
        // Note: camera indices from the `camera` package may not match
        // OpenCV's. We can determine the specific webcam for a given index
        // only by observing the output in the `vision preview` after opening it.
        webcamDefines.add(WebcamDefine(index: i, name: 'Webcam $i'));
      }
      return;
    }

    if (UniversalPlatform.isWindows) {
      CameraWindows cameraWindows = CameraWindows();
      final cameras = await cameraWindows.availableCameras();
      for (int i = 0; i < cameras.length; i++) {
        // Note: camera indices from the `camera` package may not match
        // OpenCV's. We can determine the specific webcam for a given index
        // only by observing the output in the `vision preview` after opening it.
        webcamDefines.add(WebcamDefine(index: i, name: 'Webcam $i'));
      }
      return;
    }
  }
}
