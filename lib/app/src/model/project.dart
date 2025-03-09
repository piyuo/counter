import 'package:vision/vision.dart' as vision;

import 'uuid.dart';
import 'video.dart';

const _confidenceThreshold = 0.35; // pick object as many as possible
const _trackingThreshold = 0.7; // byte track will filter object by
const _nmsThreshold = 0.65;
const _matchThreshold = 0.55;
const _maxLostSeconds = 60;
const _validThreshold = 800; // 800ms to consider object is valid

/// Project for object detection, support multiple video sources, and settings.
class Project {
  Project({
    required this.projectName,
    required this.model,
    required this.projectId,
    this.filter = const vision.Filter(vision.FilterType.pass1Hour),
    required List<Video> videos,
    this.confidenceThreshold = _confidenceThreshold,
    this.nmsThreshold = _nmsThreshold,
    this.matchThreshold = _matchThreshold,
    this.maxLostSeconds = _maxLostSeconds,
    this.validThreshold = _validThreshold,
    this.trackingThreshold = _trackingThreshold,
    this.isShowCenterRedDotOnTarget = false,
    this.isShowGhostTarget = false,
  }) {
    // if projectId is empty, generate a new one
    if (projectId.isEmpty) {
      projectId = uuid();
    }
    // if videos is not empty, add them to the project
    if (videos.isNotEmpty) {
      _videos.addAll(videos);
    }
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

  /// show red dot in the center of the target
  bool isShowCenterRedDotOnTarget;

  /// ghost target is a target we lost track
  bool isShowGhostTarget;

  /// reset the detection settings
  void resetDetectionSettings() {
    confidenceThreshold = _confidenceThreshold; // pick object as many as possible
    trackingThreshold = _trackingThreshold; // byte track will filter object by
    nmsThreshold = _nmsThreshold;
    matchThreshold = _matchThreshold;
    maxLostSeconds = _maxLostSeconds;
    validThreshold = _validThreshold;
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
