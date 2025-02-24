import 'package:vision/vision.dart' as vision;

import 'uuid.dart';
import 'video.dart';

/// Project for object detection, support multiple video sources, and settings.
class Project {
  Project({
    required this.projectName,
    required this.model,
    required this.projectId,
    this.filter = const vision.Filter(vision.FilterType.pass1Hour),
    required List<Video> videos,
    this.confidenceThreshold = 0.35,
    this.nmsThreshold = 0.65,
    this.matchThreshold = 0.55,
    this.maxLostSeconds = 1,
    this.validThreshold = 2,
    this.trackingThreshold = 0.7,
  }) {
    // if projectId is empty, generate a new one
    if (projectId.isEmpty) {
      projectId = uuid();
    }
    // if videos is not empty, add them to the project
    if (videos.isNotEmpty) {
      _videos.addAll(videos);
    }
    resetDetectionSettings();
  }

  /// the unique identifier of the project.
  String projectId;

  /// the project name
  String projectName;

  /// this video sources that can be used in the project
  final List<Video> _videos = [];

  /// get video sources
  List<Video> get videos => _videos;

  /// current filter
  vision.Filter filter;

  /// get first video source, null if no video source
  Video get firstVideo {
    assert(_videos.isNotEmpty, 'project must have a default video source');
    return _videos[0];
  }

  /// check if video name exists
  bool isVideoNameExists(String newName) {
    for (final video in _videos) {
      if (video.videoName == newName) {
        return true;
      }
    }
    return false;
  }

  /// confidence threshold
  double confidenceThreshold;

  /// nms threshold
  double nmsThreshold;

  /// match threshold
  double matchThreshold;

  /// max allowed lost frames
  int maxLostSeconds;

  /// valid threshold
  int validThreshold;

  /// tracking threshold
  double trackingThreshold;

  /// the current model used by the controller
  vision.Models model;

  /// reset the detection settings
  void resetDetectionSettings() {
    confidenceThreshold = 0.35; // pick object as many as possible
    trackingThreshold = 0.7; // byte track will filter object by
    nmsThreshold = 0.65;
    matchThreshold = 0.55;
    maxLostSeconds = 1;
    validThreshold = 2;
  }

  /// check if project contain a camera video source
  bool get hasCameraInVideos {
    for (final video in _videos) {
      if (video.mediaType == vision.MediaType.camera) {
        return true;
      }
    }
    return false;
  }

  /// check if project contain only camera video source
  bool get isCameraOnly {
    if (_videos.length != 1) {
      return false;
    }
    return _videos[0].mediaType == vision.MediaType.camera;
  }

  /// return current webcam video source count
  int get webcamsCount => _videos.where((video) => video.mediaType == vision.MediaType.webcam).length;

  /// check to see if a webcam define is used in the project
  bool isWebcamDefineExists(WebcamDefine webcamDefine) {
    for (final video in _videos) {
      if (video.webcam == webcamDefine) {
        return true;
      }
    }
    return false;
  }
}
