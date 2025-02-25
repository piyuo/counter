import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vision/vision.dart' as vision;

import 'model/project.dart';
import 'model/video.dart';
import 'project_provider.dart';
import 'zone_color_table.dart';
import 'zone_editor_controller.dart';

/// Video provider for manage video source and controller.
class VideoProvider with ChangeNotifier {
  VideoProvider({
    required this.video,
    required ProjectProvider projectProvider,
  }) : _projectProvider = projectProvider {
    sampler = vision.Sampler(onActivityAdded: (zoneId, classId, activity) {
      _projectProvider?.notifyActivityAdded(video.videoId, zoneId, classId, activity);
    });
    // pass sampler to vision controller, project keep counting through sampler in each vision controller
    visionController = vision.Controller(sampler: sampler);
    playerController = vision.PlayerController(
      visionController: visionController,
      title: video.videoName,
    );
  }

  /// the sampler for visionController
  late final vision.Sampler sampler;

  /// project provider for notify the project change. don't dispose it.
  ProjectProvider? _projectProvider;

  /// the video source to be edited
  final Video video;

  /// the controllers for each video source
  late final vision.Controller visionController;

  /// the status subscription for vision controller
  StreamSubscription<vision.Status>? _visionStatusSubscription;

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
  vision.GeneralError? get lastError => visionController.lastError;

  /// is video has error
  bool get hasError => visionController.hasError;

  /// init the video provider and load initial video source
  Future<void> init(BuildContext context, Project project) async {
    isZoomToolEnabled = false;
    await visionController.init();
    if (context.mounted) {
      await reload(context, project, true);
    }

    _visionStatusSubscription = visionController.statusController.stream.listen((status) {
      switch (status) {
        case vision.Status.playing:
          _projectProvider?.notifyVideoPlayingChange();
          break;
        case vision.Status.paused:
          _projectProvider?.notifyVideoPlayingChange();
          break;
        default:
          break;
      }
    });
  }

  /// dispose multi view provider
  @override
  void dispose() {
    _visionStatusSubscription?.cancel();
    _projectProvider = null;
    visionController.dispose();
    playerController.dispose();
    zoneEditorController?.dispose();
    zoneEditorController = null;
    super.dispose();
  }

  /// load recent activity when project is opened
  void loadRecentActivity(int zoneId, int classId, vision.Activity activity) {
    visionController.loadRecentActivity(zoneId, classId, activity);
  }

  /// reset sampler filter
  void resetSamplerFilter(vision.Filter filter) {
    sampler.reset(filter);
  }

  /// Return the icon of the video source
  getIcon() {
    switch (video.mediaType) {
      case vision.MediaType.webcam:
        return CupertinoIcons.videocam;
      case vision.MediaType.camera:
        return CupertinoIcons.camera;
      case vision.MediaType.live:
        return Icons.live_tv;
      case vision.MediaType.file:
        return CupertinoIcons.folder;
    }
  }

  /// update the sampling when filter changed
  void updateSamplingOnFilterChange(DateTime now, vision.Filter filter) {
    visionController.updateSamplingOnFilterChange(now, filter);
  }

  /// set the recognition for detection
  Future<void> setRecognition({
    vision.Models? model,
    List<vision.VideoZone>? videoZones,
    double? nmsThreshold,
    double? detectionThreshold,
    double? trackingThreshold,
    double? matchThreshold,
    int? validThreshold,
    int? maxLostSeconds,
    List<int>? classes,
  }) async {
    await visionController.setRecognition(
      model: model,
      newVideoZones: videoZones,
      nmsThreshold: nmsThreshold,
      matchThreshold: matchThreshold,
      validThreshold: validThreshold,
      trackingThreshold: trackingThreshold,
      detectionThreshold: detectionThreshold,
      maxLostSeconds: maxLostSeconds,
      classes: classes,
    );
  }

  /// reload the video source, if project not null mean need setRecognition
  Future<int> reload(BuildContext context, Project project, bool isSetRecognition) async {
    int errorCode = vision.errorOK;
    video.zoom = 1;
    await visionController.close();
    switch (video.mediaType) {
      case vision.MediaType.file:
        assert(video.path != null && video.path!.isNotEmpty, 'file path is empty');
        errorCode = await visionController.openFile(video.path!);
      case vision.MediaType.camera:
        assert(video.camera != null, 'camera is null');
        errorCode = await visionController.openCamera(video.camera!.name);
        if (errorCode == vision.errorOK) {
          double min, max;
          (min, max) = await visionController.getCameraZoomRange();
          minZoom = min;
          maxZoom = max;
          isZoomToolEnabled = min != max;
        }
      case vision.MediaType.webcam:
        assert(video.webcam != null, 'webcam is null');
        errorCode = await visionController.openWebcam(video.webcam!.index);
      case vision.MediaType.live:
        assert(video.path != null && video.path!.isNotEmpty, 'live url path is empty');
        errorCode = await visionController.openLiveURL(video.path!);
    }
    if (errorCode != vision.errorOK) {
      notifyListeners();
      return errorCode;
    }

    if (video.zones.isEmpty && context.mounted) {
      await _addDefaultZone(
        context,
        updateRecognition: !isSetRecognition,
      );
    }
    if (isSetRecognition) {
      await setRecognition(
        model: project.model,
        videoZones: video.zones,
        nmsThreshold: project.nmsThreshold,
        matchThreshold: project.matchThreshold,
        validThreshold: project.validThreshold,
        trackingThreshold: project.trackingThreshold,
        detectionThreshold: project.confidenceThreshold,
        maxLostSeconds: project.maxLostSeconds,
        classes: selectedObjectClassesInAllZone,
      ); // disabled this line will enter preview mode
    }

    if (video.mediaType == vision.MediaType.camera) {
      // other types will start automatically in Server
      await visionController.play();
    }

    notifyListeners();
    return errorCode;
  }

  /// change the model used by the controller
  Future<void> setModel(vision.Models model) async {
    visionController.setRecognition(model: model);
  }

  /// get the video type
  vision.MediaType get type => video.mediaType;

  /// is video is playing
  bool get isPlaying => visionController.isPlaying;

  /// set the video path
  Future<int> setVideoPath(BuildContext context, Project project, String newVideoPath) async {
    video.path = newVideoPath;
    final isPlaying = visionController.isPlaying;
    final errorCode = await reload(context, project, false);
    if (isPlaying) {
      await visionController.play();
    }
    return errorCode;
  }

  /// set the current zoom level
  Future<void> setCameraZoom(double value) async {
    video.zoom = value;
    await visionController.setCameraZoom(value);
    notifyListeners();
  }

  /// enable zone editor, return true if success
  Future<bool> enableZoneEditor() async {
    if (!visionController.hasMedia) {
      return false;
    }
    await visionController.enableDetection(false);

    zoneEditorController = ZoneEditorController();
    zoneEditorController!.setMediaSize(visionController.mediaWidth!, visionController.mediaHeight!);
    zoneEditorController!.setZones(video.zones);

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
    notifyListeners();
  }

  /// set the current zoom
  Future<void> _setZones(List<vision.VideoZone> zones) async {
    if (zones != video.zones) {
      video.zones.clear();
      video.zones.addAll(zones);
    }
    await visionController.setRecognition(newVideoZones: video.zones);
    notifyListeners();
  }

  /// return the current zones and counts
  List<vision.Zone> get zones => visionController.zones;

  /// add a new zone to the video source
  vision.VideoZone addZone(BuildContext context) {
    assert(zoneEditorController != null, 'zoneEditorController is null');
    vision.VideoZone zone = zoneEditorController!.addZone(context);
    video.zones.add(zone);
    notifyListeners();
    return zone;
  }

  /// add default zone if the project is new
  Future<void> _addDefaultZone(
    BuildContext context, {
    bool updateRecognition = true,
  }) async {
    final mediaWidth = visionController.mediaWidth!;
    final mediaHeight = visionController.mediaHeight!;
    final double reductionValue = min(mediaWidth * 0.1, mediaHeight * 0.1);

    final offsetX = reductionValue / 2;
    final offsetY = reductionValue / 2;
    final zoneId = _projectProvider!.getNextZoneId();
    final zone = vision.VideoZone(
      tallyAnnotations: vision.defaultTallyAnnotation(context),
      zoneId: zoneId,
      name: 'Zone $zoneId',
      color: getNextZoneColor(),
      points: [
        Offset(offsetX, offsetY),
        Offset(mediaWidth - offsetX, offsetY),
        Offset(mediaWidth - offsetX, mediaHeight - offsetY),
        Offset(offsetX, mediaHeight - offsetY),
      ],
    );
    video.zones.add(zone);
    if (updateRecognition) {
      await _setZones(video.zones);
    }
  }

  /// check if the zone can be removed
  bool isZoneAllowRemove() {
    return video.zones.length > 1;
  }

  /// remove the video source
  Future<void> remove() async {
    await visionController.close();

    //sleep for 3 second to wait the video source screen to be removed
    await Future.delayed(const Duration(seconds: 3));
    dispose();
  }

  /// set video name
  void setVideoName(String name) {
    video.videoName = name;
    playerController.title = name;
    notifyListeners();
  }

  /// set the zone name
  void setZoneName(vision.VideoZone videoZone, String name) {
    videoZone.name = name;
    notifyListeners();
  }

  /// set the zone name
  void setZoneColor(vision.VideoZone videoZone, Color color) {
    videoZone.color = color;
    notifyListeners();
  }

  /// set the zone stagnant threshold
  void setZoneStagnantThreshold(vision.VideoZone videoZone, int stagnantThreshold) {
    videoZone.stagnantThreshold = stagnantThreshold;
    visionController.setStagnantThreshold(videoZone.zoneId, videoZone.stagnantThreshold);
    notifyListeners();
  }

  /// set the zone reentered threshold
  void setZoneReenteredThreshold(vision.VideoZone videoZone, int reenteredThreshold) {
    videoZone.reenteredThreshold = reenteredThreshold;
    visionController.setReenteredThreshold(videoZone.zoneId, videoZone.reenteredThreshold);
    notifyListeners();
  }

  /// set the zone cooldown threshold
  void setZoneCooldownThreshold(vision.VideoZone videoZone, int cooldownThreshold) {
    videoZone.cooldownThreshold = cooldownThreshold;
    visionController.setCooldownThreshold(videoZone.zoneId, videoZone.cooldownThreshold);
    notifyListeners();
  }

  /// update the tally annotation
  void updateTallyAnnotation(vision.TallyAnnotation tallyAnnotation) {
    notifyListeners();
  }

  /// toggle zone selected classes
  void toggleZoneSelectedClasses(vision.VideoZone videoZone, int classId) {
    if (videoZone.selectedClasses.contains(classId)) {
      if (videoZone.selectedClasses.length == 1) {
        // at least one class should be selected
        return;
      }
      videoZone.selectedClasses.remove(classId);
    } else {
      videoZone.selectedClasses.add(classId);
    }
    _projectProvider?.notifyProjectChanged(this);
  }

  /// remove a zone from the video source
  void removeZone(vision.VideoZone zone) {
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
    notifyListeners();
    return true;
  }

  /// get all selected object classes
  List<int> get selectedObjectClassesInAllZone {
    List<int> classes = [];
    for (final zone in video.zones) {
      for (final classId in zone.selectedClasses) {
        if (!classes.contains(classId)) {
          classes.add(classId);
        }
      }
    }
    return classes;
  }

  /// add all object class from each zone into recognition classes
  Future<void> rebuildRecognitionClasses() async {
    await visionController.setRecognition(classes: selectedObjectClassesInAllZone);
    notifyListeners();
  }

  /// check if there is no activity, this function called on every minute to keep counter fresh
  void noActivityCheck(DateTime now) {
    visionController.noActivityCheck(now);
  }
}
