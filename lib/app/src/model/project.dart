import 'package:vision/vision.dart' as vision;

import 'uuid.dart';
import 'video.dart';

/// Project for object detection, support multiple video sources, and settings.
class Project {
  Project({
    required Video video,
    required this.name,
    required this.model,
  }) : projectId = uuid() {
    resetDetectionSettings();
    addVideoSource(video);
  }

  /// the unique identifier of the project.
  String projectId;

  /// the project name
  String name;

  /// this video sources that can be used in the project
  final List<Video> _videos = [];

  /// get video sources
  List<Video> get videos => _videos;

  /// current filter
  vision.Filter filter = const vision.Filter(vision.FilterType.pass1Hour);

  /// add video source
  void addVideoSource(Video media) {
    _videos.add(media);
  }

  /// get first video source, null if no video source
  Video get firstVideo {
    assert(_videos.isNotEmpty, 'project must have a default video source');
    return _videos[0];
  }

  /// check if video name exists
  bool isVideoNameExists(String newName) {
    for (final video in _videos) {
      if (video.name == newName) {
        return true;
      }
    }
    return false;
  }

  /// confidence threshold
  double confidenceThreshold = 0;

  /// nms threshold
  double nmsThreshold = 0;

  /// match threshold
  double matchThreshold = 0;

  /// max allowed lost frames
  int maxLostSeconds = 0;

  /// valid threshold
  int validThreshold = 0;

  /// tracking threshold
  double trackingThreshold = 0;

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
      if (video.type == vision.MediaType.camera) {
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
    return _videos[0].type == vision.MediaType.camera;
  }

  /// return current webcam video source count
  int get webcamsCount => _videos.where((video) => video.type == vision.MediaType.webcam).length;

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
