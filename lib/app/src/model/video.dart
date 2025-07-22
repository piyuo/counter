import 'package:flutter_vision/flutter_vision.dart' as vision;

const _confidenceThreshold = 0.45; // pick object as many as possible
const _trackingThreshold = 0.55; // byte track will filter object by
const _nmsThreshold = 0.30;
const _matchThreshold = 0.15;
const _minLostSeconds = 0.5; // minium 0.5 seconds to consider object is lost
const _maxLostSeconds = 5.0; // maximum 5 seconds to consider object is lost
const _validThreshold = 900; // 900ms to consider object is valid

/// video define the video source for the project, a project can have multiple video sources. like camera, video file, live stream.
class Video {
  Video({
    required this.videoId,
    required this.sourceType,
    required this.videoName,
    this.camera,
    this.webcam,
    this.zoom = 1,
    this.path,
    List<vision.VideoZone> zones = const [],
    required this.model,
    required this.objectClasses,
    this.confidenceThreshold = _confidenceThreshold,
    this.nmsThreshold = _nmsThreshold,
    this.matchThreshold = _matchThreshold,
    this.minLostSeconds = _minLostSeconds,
    this.maxLostSeconds = _maxLostSeconds,
    this.validThreshold = _validThreshold,
    this.trackingThreshold = _trackingThreshold,
  }) {
    // if zones is not empty, add them to the video
    if (zones.isNotEmpty) {
      this.zones.addAll(zones);
    }
  }

  /// the video id
  final int videoId;

  /// the video source type
  final vision.SourceType sourceType;

  /// the project source name
  String videoName;

  /// the file path or live url
  String? path;

  // name for camera
  CameraDefine? camera;

  // zoom level for camera
  WebcamDefine? webcam;

  /// the zoom level for camera
  double zoom = 1;

  /// the object classes want to detect for the video
  final List<int> objectClasses;

  /// zones
  final List<vision.VideoZone> zones = [];

  /// the current model used by the controller
  vision.Models model;

  /// confidence threshold
  double confidenceThreshold;

  /// nms threshold
  double nmsThreshold;

  /// match threshold
  double matchThreshold;

  /// min allowed lost seconds
  double minLostSeconds;

  /// max allowed lost seconds
  double maxLostSeconds;

  /// valid threshold
  int validThreshold;

  /// tracking threshold
  double trackingThreshold;

  /// reset the detection settings
  void resetDetectionSettings() {
    confidenceThreshold = _confidenceThreshold; // pick object as many as possible
    trackingThreshold = _trackingThreshold; // byte track will filter object by
    nmsThreshold = _nmsThreshold;
    matchThreshold = _matchThreshold;
    minLostSeconds = _minLostSeconds;
    maxLostSeconds = _maxLostSeconds;
    validThreshold = _validThreshold;
  }
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
