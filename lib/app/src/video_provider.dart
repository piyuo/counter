import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

import 'model/project.dart';
import 'model/video.dart';
import 'project_provider.dart';

/// Video provider for manage video source and controller.
class VideoProvider with ChangeNotifier {
  VideoProvider({required this.video, required ProjectProvider projectProvider}) : _projectProvider = projectProvider {
    // pass sampler to vision controller, project keep counting through sampler in each vision controller
  }

  /// project provider for notify the project change. don't dispose it.
  ProjectProvider? _projectProvider;

  /// the video source to be edited
  final Video video;

  /// the controllers for each video source
  late final vision.VisionController visionController;

  /// true to show zoom level tool on the camera screen
  bool isZoomToolEnabled = false;

  /// the min zoom level
  double minZoom = 1;

  /// the max zoom level
  double maxZoom = 1;

  /// get the current zoom level
  double get zoom => video.zoom;

  /// used to delay the detection threshold setting
  Timer? _detectionThresholdTimer;

  /// used to delay the NMS threshold setting
  Timer? _nmsThresholdTimer;

  /// used to delay the match threshold setting
  Timer? _matchThresholdTimer;

  /// used to delay the max lost seconds setting
  Timer? _maxLostSecondsTimer;

  /// used to delay the min lost seconds setting
  Timer? _minLostSecondsTimer;

  /// used to delay the valid threshold setting
  Timer? _validThresholdTimer;

  /// used to delay the model setting
  Timer? _modelChangedTimer;

  /// init the video provider and load initial video source
  Future<void> init(Project project) async {
    isZoomToolEnabled = false;
    await reload(project);
  }

  /// shutdown the server prepare for dispose.
  Future<void> shutdown() async {}

  /// dispose multi view provider
  @override
  void dispose() {
    _projectProvider = null;
    _detectionThresholdTimer?.cancel();
    _nmsThresholdTimer?.cancel();
    _matchThresholdTimer?.cancel();
    _maxLostSecondsTimer?.cancel();
    _minLostSecondsTimer?.cancel();
    _validThresholdTimer?.cancel();
    _modelChangedTimer?.cancel();
    super.dispose();
  }

  /// set the show center red dot on target
  void setShowCenterRedDotOnTarget(bool value) {}

  /// set the show ghost target
  void setShowGhostTarget(bool value) {}

  /// update the sampling
  void updateSample(DateTime now) {}

  /// set classes to recognition
  Future<void> setObjectClassesToRecognition() async {
    // change object classes must set zone also
  }

  /// reload the video source, if project not null mean need setRecognition
  Future<void> reload(Project project) async {
    video.zoom = 1;

    notifyListeners();
  }

  /// is video is playing

  /// set the video path
  Future<void> setVideoPath(Project project, String newVideoPath) async {
    video.path = newVideoPath;
    await reload(project);
    _saveProject();
  }

  /// set new camera
  Future<void> setCamera(CameraDefine cameraDefine) async {
    video.camera = cameraDefine;
    await reload(_projectProvider!.project!);
    _saveProject();
  }

  /// set the current zoom level
  Future<void> setCameraZoom(double value) async {
    video.zoom = value;
    _saveProject();
  }

  /// save the project and notify the listeners
  void _saveProject() {
    _projectProvider?.saveProject(this);
    notifyListeners();
  }

  /// enable zone editor, return true if success
  Future<bool> enableZoneEditor() async {
    notifyListeners();
    return true;
  }

  /// disable the zone editor
  Future<void> disableZoneEditor() async {}

  /// remove the video source
  Future<void> delete() async {
    //sleep for 3 second to wait the video source screen to be removed
    await Future.delayed(const Duration(seconds: 3));
    dispose();
  }

  /// set video name
  void setVideoName(String name) {
    video.videoName = name;
    _saveProject();
  }

  /// toggle zone selected classes
  void toggleObjectClass(int classId) {
    if (video.objectClasses.contains(classId)) {
      if (video.objectClasses.length == 1) {
        // at least one class should be selected
        return;
      }
      video.objectClasses.remove(classId);
    } else {
      video.objectClasses.add(classId);
    }
    _saveProject();
  }

  /// check if there is no activity, this function called on every minute to keep counter fresh
  void noActivityCheck(DateTime now) {}

  /// reset all counts in project
  void resetCounts() async {
    notifyListeners();
  }

  /// develop mode, add random counts to the project
  Future<void> addRandomCounts() async {
    DateTime now = DateTime.now().subtract(Duration(minutes: 1));
    updateSample(now);
    notifyListeners();
  }

  /// save current count, the project is about to close
  void saveCurrentCount(DateTime now) {}

  /// set detection threshold
  Future<void> setSettingsDetectionThreshold(double value) async {
    video.confidenceThreshold = value;
    _detectionThresholdTimer?.cancel();
    _detectionThresholdTimer = Timer(const Duration(seconds: 2), () async {
      _saveProject();
      _detectionThresholdTimer = null;
    });
  }

  /// set nms threshold
  Future<void> setSettingsNmsThreshold(double value) async {
    video.nmsThreshold = value;
    _nmsThresholdTimer?.cancel();
    _nmsThresholdTimer = Timer(const Duration(seconds: 2), () async {
      _saveProject();
      _nmsThresholdTimer = null;
    });
  }

  /// set match threshold
  Future<void> setSettingsMatchThreshold(double value) async {
    video.matchThreshold = value;
    _matchThresholdTimer?.cancel();
    _matchThresholdTimer = Timer(const Duration(seconds: 2), () async {
      _saveProject();
      _matchThresholdTimer = null;
    });
  }

  /// set max allowed lost threshold
  Future<void> setSettingsMaxLostSeconds(double value) async {
    video.maxLostSeconds = value;
    _maxLostSecondsTimer?.cancel();
    _maxLostSecondsTimer = Timer(const Duration(seconds: 2), () async {
      _saveProject();
      _maxLostSecondsTimer = null;
    });
  }

  /// set min allowed lost threshold
  Future<void> setSettingsMinLostSeconds(double value) async {
    video.minLostSeconds = value;
    _minLostSecondsTimer?.cancel();
    _minLostSecondsTimer = Timer(const Duration(seconds: 2), () async {
      _saveProject();
      _minLostSecondsTimer = null;
    });
  }

  /// set max allowed lost threshold
  Future<void> setSettingsValidThreshold(int value) async {
    video.validThreshold = value;
    _validThresholdTimer?.cancel();
    _validThresholdTimer = Timer(const Duration(seconds: 2), () async {
      _saveProject();
      _validThresholdTimer = null;
    });
  }

  /// reset the AI screen settings
  Future<void> resetDetectionSettings() async {
    video.resetDetectionSettings();
    _saveProject();
  }
}
