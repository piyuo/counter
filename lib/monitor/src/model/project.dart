import 'uuid.dart';
import 'video.dart';

/// Project for object detection, support multiple video sources, and settings.
class Project {
  Project({
    required this.projectName,
    required this.projectId,
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

  /// show red dot in the center of the target
  bool isShowCenterRedDotOnTarget;

  /// ghost target is a target we lost track
  bool isShowGhostTarget;

  /// check if project contain a camera video source
  bool get hasCameraInVideos {
    return false;
  }

  /// check if project contain only camera video source
  bool get isCameraOnly {
    return false;
  }

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
