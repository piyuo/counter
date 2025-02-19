import 'package:vision/vision.dart' as vision;

/// video define the video source for the project, a project can have multiple video sources. like camera, video file, live stream.
class Video {
  Video({
    required this.id,
    required this.type,
    required this.name,
    this.path,
  });

  /// the video id
  final int id;

  /// the project type
  final vision.MediaType type;

  /// the project source name
  String name;

  /// the file path or live url
  String? path;

  // name for camera
  CameraDefine? camera;

  // zoom level for camera
  WebcamDefine? webcam;

  /// the zoom level for camera
  double zoom = 1;

  /// zones
  final List<vision.VideoZone> zones = [];
}

/// Define camera name and zoom level
class CameraDefine {
  const CameraDefine({
    required this.name,
    required this.title,
    required this.isFrontCamera,
  });

  /// name for camera, this will not be displayed in the UI only for identification
  final String name;

  /// title for camera, this will be displayed in the UI
  final String title;

  /// is front camera
  final bool isFrontCamera;

  /// override == operator
  @override
  bool operator ==(Object other) {
    if (other is CameraDefine) {
      return name == other.name;
    }
    return false;
  }

  /// override hashCode
  @override
  int get hashCode => name.hashCode;
}

/// Define webcam
class WebcamDefine {
  WebcamDefine({
    required this.index,
    required this.name,
  });

  /// the index of webcam, like 0,1,2
  final int index;

  /// the name for webcam, like 'webcam (0)'
  final String name;

  /// override == operator
  @override
  bool operator ==(Object other) {
    if (other is WebcamDefine) {
      return index == other.index;
    }
    return false;
  }

  /// override hashCode
  @override
  int get hashCode => index.hashCode;
}
