import 'dart:async';
import 'dart:math';

import 'package:counter/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:path_provider/path_provider.dart';

import 'model/project.dart';
import 'model/video.dart';
import 'project_provider.dart';
import 'zone_color_table.dart';
import 'zone_editor_controller.dart';

/// Video provider for manage video source and controller.
class VideoProvider with ChangeNotifier {
  VideoProvider({
    required vision.OrientationProvider orientationProvider,
    required this.video,
    required ProjectProvider projectProvider,
  }) : _projectProvider = projectProvider {
    sampler = vision.Sampler(
      onActivityAdded: (zoneId, classId, activity) {
        _projectProvider?.notifyActivityAdded(video.videoId, zoneId, classId, activity);
      },
    );
    // pass sampler to vision controller, project keep counting through sampler in each vision controller
    visionController = vision.Controller(
      orientationProvider: orientationProvider,
      sampler: sampler,
      isShowCenterRedDotOnTarget: _projectProvider!.project!.isShowCenterRedDotOnTarget,
      isShowGhostTarget: _projectProvider!.project!.isShowGhostTarget,
      onSourceReady: (visionController, media) async {
        if (video.zones.isEmpty) {
          final zone = _addDefaultZone();
          video.zones.add(zone);
        }

        double min, max;
        (min, max) = await visionController.getCameraZoomRange();
        minZoom = min;
        maxZoom = max;
        isZoomToolEnabled = min != max;

        return vision.RecognitionDefinition(
          model: video.model,
          objectClasses: video.objectClasses,
          videoZones: video.zones,
          nmsThreshold: video.nmsThreshold,
          matchThreshold: video.matchThreshold,
          validThreshold: video.validThreshold,
          trackingThreshold: video.trackingThreshold,
          detectionThreshold: video.confidenceThreshold,
          minLostSeconds: video.minLostSeconds,
          maxLostSeconds: video.maxLostSeconds,
        );
      },
    );
    playerController = vision.PlayerController(visionController: visionController, title: video.videoName);
  }

  /// the sampler for visionController
  late final vision.Sampler sampler;

  /// project provider for notify the project change. don't dispose it.
  ProjectProvider? _projectProvider;

  /// the video source to be edited
  final Video video;

  /// the controllers for each video source
  late final vision.Controller visionController;

  /// the player controller for each video source
  late final vision.PlayerController playerController;

  /// zoneEditor will be set when enable zone editor
  ZoneEditorController? zoneEditorController;

  /// true to show zoom level tool on the camera screen
  bool isZoomToolEnabled = false;

  /// true to show the zone editor
  bool get isZoneEditorEnabled => zoneEditorController != null;

  /// the min zoom level
  double minZoom = 1;

  /// the max zoom level
  double maxZoom = 1;

  /// get the current zoom level
  double get zoom => video.zoom;

  /// get the current media width
  int get mediaWidth => visionController.mediaWidth ?? 600;

  /// get the current media height
  int get mediaHeight => visionController.mediaHeight ?? 600;

  /// get the current media aspect ratio
  int get mediaAspectRatio => mediaWidth ~/ mediaHeight;

  /// get last error code
  vision.Error? get lastError => visionController.lastError;

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
    await visionController.init();
    await reload(project);
  }

  /// shutdown the server prepare for dispose.
  Future<void> shutdown() async {
    await visionController.shutdown();
  }

  /// dispose multi view provider
  @override
  void dispose() {
    _projectProvider = null;
    visionController.dispose();
    playerController.dispose();
    zoneEditorController?.dispose();
    zoneEditorController = null;
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
  void setShowCenterRedDotOnTarget(bool value) {
    visionController.setShowCenterRedDotOnTarget(value);
  }

  /// set the show ghost target
  void setShowGhostTarget(bool value) {
    visionController.setShowGhostTarget(value);
  }

  /// add activity when project is opened or add test data
  void addActivity(int zoneId, int classId, vision.Activity activity) {
    visionController.addActivity(zoneId, classId, activity);
  }

  /// update the sampling
  void updateSample(DateTime now) {
    visionController.updateSample(now);
  }

  /// reset sampler filter
  void resetSamplerFilter(vision.Filter filter) {
    sampler.reset(filter);
  }

  /// Return the icon of the video source media type
  IconData getMediaTypeIcon() {
    switch (video.sourceType) {
      case vision.SourceType.webcam:
        return CupertinoIcons.videocam;
      case vision.SourceType.camera:
        return CupertinoIcons.camera;
      case vision.SourceType.liveStream:
        return CupertinoIcons.cloud;
      case vision.SourceType.file:
        return CupertinoIcons.folder;
    }
  }

  /// update the sampling when filter changed
  void updateSamplingOnFilterChange(DateTime now, vision.Filter filter) {
    visionController.updateSamplingOnFilterChange(now, filter);
  }

  /// set classes to recognition
  Future<void> setObjectClassesToRecognition() async {
    // change object classes must set zone also
    await visionController.setRecognition(
      vision.RecognitionDefinition(objectClasses: video.objectClasses, videoZones: video.zones),
    );
  }

  /// set the recognition for detection
  Future<void> setRecognition(vision.RecognitionDefinition definition) async {
    await visionController.setRecognition(definition);
  }

  /// reload the video source, if project not null mean need setRecognition
  Future<void> reload(Project project) async {
    video.zoom = 1;
    await visionController.close();
    switch (video.sourceType) {
      case vision.SourceType.file:
        assert(video.path != null && video.path!.isNotEmpty, 'file path is empty');
        final appDir = await getApplicationSupportDirectory();
        final filePath = '${appDir.path}/${video.path}';
        await visionController.openFile(filePath);
      case vision.SourceType.camera:
        assert(video.camera != null, 'camera is null');
        await visionController.openCamera(video.camera!.name);
      case vision.SourceType.webcam:
        assert(video.webcam != null, 'webcam is null');
        await visionController.openWebcam(video.webcam!.index);
      case vision.SourceType.liveStream:
        assert(video.path != null && video.path!.isNotEmpty, 'live url path is empty');
        await visionController.openLiveURL(video.path!);
    }

    notifyListeners();
  }

  /// get the video type
  vision.SourceType get type => video.sourceType;

  /// is video is playing
  bool get isNotFrozen => visionController.isNotFrozen;

  /// set the video path
  Future<void> setVideoPath(Project project, String newVideoPath) async {
    video.path = newVideoPath;
    await reload(project);
    _saveProject();
  }

  /// set new camera
  Future<void> setCamera(CameraDefine cameraDefine) async {
    if (visionController.currentCameraName == cameraDefine.name) {
      return;
    }

    video.camera = cameraDefine;
    await reload(_projectProvider!.project!);
    _saveProject();
  }

  /// set the current zoom level
  Future<void> setCameraZoom(double value) async {
    video.zoom = value;
    await visionController.setCameraZoom(value);
    _saveProject();
  }

  /// save the project and notify the listeners
  void _saveProject() {
    _projectProvider?.saveProject(this);
    notifyListeners();
  }

  /// enable zone editor, return true if success
  Future<bool> enableZoneEditor() async {
    if (!visionController.isSourceReady) {
      return false;
    }
    await visionController.enableDetection(false);

    zoneEditorController = ZoneEditorController(
      mediaWidth: visionController.mediaWidth!,
      mediaHeight: visionController.mediaHeight!,
      newZones: video.zones,
      onZoneChanged: () {
        _saveProject();
      },
    );
    notifyListeners();
    return true;
  }

  /// disable the zone editor
  Future<void> disableZoneEditor() async {
    if (zoneEditorController == null) {
      return;
    }

    if (zoneEditorController!.isChanged) {
      await _setZones(zoneEditorController!.zones);
    }

    await visionController.enableDetection(true);
    zoneEditorController?.dispose();
    zoneEditorController = null;
  }

  /// set the current zoom
  Future<void> _setZones(List<vision.VideoZone> zones) async {
    if (zones != video.zones) {
      video.zones.clear();
      video.zones.addAll(zones);
    }
    await visionController.setRecognition(vision.RecognitionDefinition(videoZones: video.zones));
  }

  /// return the current zones and counts
  List<vision.Zone> get zones => visionController.zones;

  /// add a new zone to the video source
  vision.VideoZone addZone(BuildContext context) {
    assert(zoneEditorController != null, 'zoneEditorController is null');
    vision.VideoZone zone = zoneEditorController!.addZone(context);
    video.zones.add(zone);
    return zone;
  }

  /// add default zone if the project is new
  vision.VideoZone _addDefaultZone() {
    final safePadding = MediaQuery.of(appkit.globalContext).padding;
    final mediaWidth = visionController.mediaWidth!;
    final mediaHeight = visionController.mediaHeight!;
    final double reductionValue = min(mediaWidth * 0.1, mediaHeight * 0.1);

    final offsetX = reductionValue / 2;
    final offsetY = (reductionValue / 2) + safePadding.top;
    final zoneId = _projectProvider!.getNextZoneId();
    final zone = vision.VideoZone(
      tallyAnnotations: vision.defaultTallyAnnotation(appkit.globalContext),
      zoneId: zoneId,
      name: '${appkit.globalContext.l.default_zone_name} $zoneId',
      color: getNextZoneColor(),
      points: [
        Offset(offsetX, offsetY),
        Offset(mediaWidth - offsetX, offsetY),
        Offset(mediaWidth - offsetX, mediaHeight - offsetY),
        Offset(offsetX, mediaHeight - offsetY),
      ],
    );
    return zone;
  }

  /// check if the zone can be removed
  bool isZoneAllowRemove() {
    return video.zones.length > 1;
  }

  /// remove the video source
  Future<void> delete() async {
    await visionController.close();
    //sleep for 3 second to wait the video source screen to be removed
    await Future.delayed(const Duration(seconds: 3));
    dispose();
  }

  /// set video name
  void setVideoName(String name) {
    video.videoName = name;
    playerController.title = name;
    _saveProject();
  }

  /// set the zone name
  void setZoneName(vision.VideoZone videoZone, String name) {
    videoZone.name = name;
    _saveProject();
  }

  /// set the zone show summary on screen
  void setZoneShowSummaryOnScreen(vision.VideoZone videoZone, bool value) {
    videoZone.showSummaryOnScreen = value;
    _saveProject();
  }

  /// set the zone name
  void setZoneColor(vision.VideoZone videoZone, Color color) {
    videoZone.color = color;
    _saveProject();
  }

  /// set the zone stagnant threshold
  void setZoneStagnantThreshold(vision.VideoZone videoZone, int stagnantThreshold) {
    videoZone.stagnantThreshold = stagnantThreshold;
    visionController.setStagnantThreshold(videoZone.zoneId, videoZone.stagnantThreshold);
    _saveProject();
  }

  /// set the zone reentered threshold
  void setZoneReenteredThreshold(vision.VideoZone videoZone, int reenteredThreshold) {
    videoZone.reenteredThreshold = reenteredThreshold;
    visionController.setReenteredThreshold(videoZone.zoneId, videoZone.reenteredThreshold);
    _saveProject();
  }

  /// set the zone cooldown threshold
  void setZoneCooldownThreshold(vision.VideoZone videoZone, int cooldownThreshold) {
    videoZone.cooldownThreshold = cooldownThreshold;
    visionController.setCooldownThreshold(videoZone.zoneId, videoZone.cooldownThreshold);
    _saveProject();
  }

  /// update the tally annotation
  void updateTallyAnnotation(vision.TallyAnnotation tallyAnnotation) {
    _saveProject();
  }

  /// remove a zone from the video source
  void deleteZone(vision.VideoZone zone) {
    assert(zoneEditorController != null, 'zoneEditorController is null');
    zoneEditorController!.removeZone(zone);
    video.zones.remove(zone);
    notifyListeners();
  }

  /// toggle the strategy for the zone
  bool toggleZoneTollyAnnotation(vision.VideoZone videoZone, vision.TallyAnnotation tallyAnnotation) {
    if (tallyAnnotation.enabled) {
      // user want disable a tally annotation, check if it is the only one enabled
      int annotationEnabledCount = 0;
      for (final annotation in videoZone.tallyAnnotations) {
        if (annotation.enabled) {
          annotationEnabledCount++;
        }
      }

      if (annotationEnabledCount == 1) {
        return false;
      }
    }

    tallyAnnotation.enabled = !tallyAnnotation.enabled;
    _saveProject();
    return true;
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
  void noActivityCheck(DateTime now) {
    visionController.noActivityCheck(now);
  }

  /// reset all counts in project
  void resetCounts() async {
    visionController.resetCounts();
    notifyListeners();
  }

  /// develop mode, add random counts to the project
  Future<void> addRandomCounts() async {
    DateTime now = DateTime.now().subtract(Duration(minutes: 1));
    var begin = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    for (final zone in video.zones) {
      for (final classId in video.objectClasses) {
        // add 24 hours activity
        for (int i = 1440; i >= 0; i--) {
          //add from 2 hours ago to now, latest is always the last
          final activity = vision.Activity(
            createdAt: begin.subtract(Duration(minutes: i)),
            spawned: Random().nextInt(9),
            vanished: Random().nextInt(9),
            entered: Random().nextInt(9),
            exited: Random().nextInt(9),
            stagnant: Random().nextInt(9),
            reentered: Random().nextInt(9),
            occupied: Random().nextInt(9),
            stayDuration: Random().nextInt(9),
          );
          addActivity(zone.zoneId, classId, activity);
          _projectProvider?.notifyActivityAdded(video.videoId, zone.zoneId, classId, activity);
        }
      }
    }
    updateSample(now);
    notifyListeners();
  }

  /// save current count, the project is about to close
  void saveCurrentCount(DateTime now) {
    visionController.makeCurrentSample(now);
  }

  /// Gets the current occupied count.
  int get currentOccupiedCount {
    return visionController.currentOccupiedCount;
  }

  /// change the model used by the controller
  Future<void> setModel(vision.Models model) async {
    if (video.model == model) {
      return;
    }
    video.model = model;
    _modelChangedTimer?.cancel();
    _modelChangedTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(model: model));
      _saveProject();
      _modelChangedTimer = null;
    });
  }

  /// set detection threshold
  Future<void> setSettingsDetectionThreshold(double value) async {
    video.confidenceThreshold = value;
    _detectionThresholdTimer?.cancel();
    _detectionThresholdTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(detectionThreshold: value));
      _saveProject();
      _detectionThresholdTimer = null;
    });
  }

  /// set nms threshold
  Future<void> setSettingsNmsThreshold(double value) async {
    video.nmsThreshold = value;
    _nmsThresholdTimer?.cancel();
    _nmsThresholdTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(nmsThreshold: value));
      _saveProject();
      _nmsThresholdTimer = null;
    });
  }

  /// set match threshold
  Future<void> setSettingsMatchThreshold(double value) async {
    video.matchThreshold = value;
    _matchThresholdTimer?.cancel();
    _matchThresholdTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(matchThreshold: value));
      _saveProject();
      _matchThresholdTimer = null;
    });
  }

  /// set max allowed lost threshold
  Future<void> setSettingsMaxLostSeconds(double value) async {
    video.maxLostSeconds = value;
    _maxLostSecondsTimer?.cancel();
    _maxLostSecondsTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(maxLostSeconds: value));
      _saveProject();
      _maxLostSecondsTimer = null;
    });
  }

  /// set min allowed lost threshold
  Future<void> setSettingsMinLostSeconds(double value) async {
    video.minLostSeconds = value;
    _minLostSecondsTimer?.cancel();
    _minLostSecondsTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(minLostSeconds: value));
      _saveProject();
      _minLostSecondsTimer = null;
    });
  }

  /// set max allowed lost threshold
  Future<void> setSettingsValidThreshold(int value) async {
    video.validThreshold = value;
    _validThresholdTimer?.cancel();
    _validThresholdTimer = Timer(const Duration(seconds: 2), () async {
      await setRecognition(vision.RecognitionDefinition(validThreshold: value));
      _saveProject();
      _validThresholdTimer = null;
    });
  }

  /// reset the AI screen settings
  Future<void> resetDetectionSettings() async {
    video.resetDetectionSettings();
    video.model = _projectProvider!.benchmarkLocalStorage.recommendedModel;
    await setRecognition(
      vision.RecognitionDefinition(
        model: video.model,
        nmsThreshold: video.nmsThreshold,
        matchThreshold: video.matchThreshold,
        trackingThreshold: video.trackingThreshold,
        detectionThreshold: video.confidenceThreshold,
        maxLostSeconds: video.maxLostSeconds,
      ),
    );
    _saveProject();
  }
}
