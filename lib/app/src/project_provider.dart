import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vision/vision.dart' as vision;
import 'package:wakelock_plus/wakelock_plus.dart';

import 'benchmark.dart';
import 'camera_manager.dart';
import 'model/project.dart';
import 'model/project_summary.dart';
import 'model/video.dart';
import 'util/orientation_provider.dart';
import 'video_provider.dart';
import 'webcam_manager.dart';
import 'wizard_commands.dart';
import 'zone_color_table.dart';

/// indicate the video playing state
enum VideoPlayingState { allPlay, somePlay, allPause }

/// Project provider can create, open, and manage the project. wizard package will find the project provider from context to work with.
class ProjectProvider with ChangeNotifier {
  ProjectProvider({
    this.onProjectOpened,
    this.onProjectClosed,
    this.onProjectChanged,
    this.onGetProjectSummaries,
    this.onGetProjectById,
    this.onDeleteProject,
  });

  /// keep the benchmark result to use in the create project screen choose default model
  BenchmarkLocalStorage benchmarkLocalStorage = BenchmarkLocalStorage();

  /// the width threshold for using side layout
  double sideLayoutWidthThreshold = 1024;

  /// the navigator key to keep the navigator state from switch between side and floating layout
  final navigatorKey = GlobalKey<NavigatorState>();

  /// the opened project
  Project? project;

  /// the wizard stream controller, used to send command to the wizard screen
  StreamController<WizardCommand> wizardStreamController = StreamController<WizardCommand>.broadcast();

  /// the video source providers for each video source and controller.
  final List<VideoProvider> videoProviders = [];

  /// the fullscreen video source, set video source to full screen allow user easy to set zone and zoom level
  VideoProvider? fullscreenVideoProvider;

  /// is project opened
  bool get isProjectOpened => project != null;

  /// called when project opened
  final void Function(Project project)? onProjectOpened;

  /// called when project closed
  final void Function(Project project)? onProjectClosed;

  /// called when project settings changed, videoSource not null mean change is from one of the video source
  final void Function(Project, Video?)? onProjectChanged;

  /// called by open project screen to get the project summaries
  final Future<List<ProjectSummary>> Function()? onGetProjectSummaries;

  /// called by open project screen to get the project summaries
  final Future<Project?> Function(String)? onGetProjectById;

  /// called by open project screen to delete the project
  final Future<void> Function(String)? onDeleteProject;

  /// get the project summaries
  Future<List<ProjectSummary>> getProjectSummaries() async {
    if (onGetProjectSummaries != null) {
      return await onGetProjectSummaries!();
    }
    return [];
  }

  /// get the project by its id
  Future<Project?> getProjectById(String projectId) async {
    if (onGetProjectById != null) {
      return await onGetProjectById!(projectId);
    }
    return null;
  }

  /// delete the project
  Future<void> deleteProject(String projectId) async {
    closeProject();
    await deleteProjectInAppDirectory(projectId);
    if (onDeleteProject != null) {
      await onDeleteProject!(projectId);
    }
  }

  /// delete the project temp media file in app directory, save by [saveFileToAppDirectory]
  Future<void> deleteProjectInAppDirectory(String projectId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final projectDir = Directory('${appDir.path}/$projectId');
    if (await projectDir.exists()) {
      await projectDir.delete(recursive: true);
    }
  }

  /// the camera manager
  CameraManager cameraManager = CameraManager();

  /// the webcam manager
  WebcamManager webcamManager = WebcamManager();

  /// is lock to portrait mode?
  bool isLockToPortrait = false;

  /// the device orientation for mobile device
  DeviceOrientation? deviceOrientation;

  /// the orientation provider for locked portrait mode
  OrientationProvider? orientationProvider;

  /// true if live stream is allowed
  bool get isLiveStreamAllowed => UniversalPlatform.isMobile ? true : true;

  /// have webcam on device
  bool get hasWebcam => webcamManager.hasWebcam;

  /// true if use are allowed to add webcam
  bool get isAddWebcamAllowed {
    /// must have webcam and not all webcams are used
    return webcamManager.webcamDefines.length > project!.webcamsCount;
  }

  /// have camera on device
  bool get hasCamera => cameraManager.hasCamera;

  /// true if use are allowed to add camera
  bool get isAddCameraAllowed {
    if (project == null) {
      return hasCamera;
    }
    // camera must be supported and no camera exists in the project
    return hasCamera && !project!.hasCameraInVideos;
  }

  /// used to delay the detection threshold setting
  Timer? _detectionThresholdTimer;

  /// used to delay the NMS threshold setting
  Timer? _nmsThresholdTimer;

  /// used to delay the match threshold setting
  Timer? _matchThresholdTimer;

  /// used to delay the max lost seconds setting
  Timer? _maxLostSecondsTimer;

  /// used to delay the valid threshold setting
  Timer? _validThresholdTimer;

  /// used to delay the model setting
  Timer? _modelChangedTimer;

  /// the sampler for visionController
  late final vision.Sampler sampler;

  /// true if the zone editor is enabled
  bool get isZoneEditorEnabled => fullscreenVideoProvider != null;

  /// get the project provider
  static ProjectProvider of(BuildContext context) {
    return Provider.of<ProjectProvider>(context, listen: false);
  }

  /// init the project provider
  Future<void> init(BuildContext context) async {
    sampler = vision.Sampler(
      onActivityAdded: (activity) {
        print('activity added, createdAt: ${activity.createdAt}');
      },
    );
    await initializeDateFormatting();
    benchmarkLocalStorage.init(); // don't await on this, cause we only need it when user open the create project screen
    await cameraManager.init();
    await webcamManager.init();
    if (UniversalPlatform.isMobile) {
      orientationProvider ??= OrientationProvider(
        onOrientationChanged: (DeviceOrientation orientation) {
          deviceOrientation = orientation;

          notifyListeners();
        },
      );
      await orientationProvider!.start();
    }
    notifyListeners();
  }

  /// dispose multi view provider
  @override
  void dispose() {
    _onProjectClosed();
    wizardStreamController.close();
    orientationProvider?.dispose();
    super.dispose();
  }

  /// call when project is opened
  void _onProjectOpened() {
    WakelockPlus.enable();
  }

  /// close the project
  void closeProject() async {
    _onProjectClosed();
    notifyListeners();
  }

  /// call when project is ready to close
  void _onProjectClosed() async {
    if (project != null) {
      onProjectClosed?.call(project!);
      unlockFromPortrait();
      WakelockPlus.disable();
    }
    for (final videoProvider in videoProviders) {
      videoProvider.dispose();
    }
    videoProviders.clear();
    project = null;
  }

  /// notify the video playing state changed
  void notifyVideoPlayingChange() {
    notifyListeners();
  }

  /// get the video playing state
  VideoPlayingState get videoPlayingState {
    if (project == null) {
      return VideoPlayingState.allPause;
    }
    if (project!.videos.isEmpty) {
      return VideoPlayingState.allPause;
    }
    bool allPlay = true;
    bool allPause = true;
    for (final videoProvider in videoProviders) {
      if (videoProvider.isPlaying) {
        allPause = false;
      } else {
        allPlay = false;
      }
    }
    if (allPlay) {
      return VideoPlayingState.allPlay;
    } else if (allPause) {
      return VideoPlayingState.allPause;
    } else {
      return VideoPlayingState.somePlay;
    }
  }

  /// check if there is no activity, this function called on every minute to keep counter fresh
  void noActivityCheck(DateTime now) {
    for (final videoProvider in videoProviders) {
      videoProvider.noActivityCheck(now);
    }
  }

  ///
  Future<void> lockToPortrait() async {
    isLockToPortrait = true;
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> unlockFromPortrait() async {
    if (!isLockToPortrait) {
      return;
    }

    isLockToPortrait = false;
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// create a formatted timestamp
  String _crateFormattedTimestamp() {
    final now = DateTime.now();
    final formatter = DateFormat('MMddHHmm');
    return formatter.format(now);
  }

  /// send a wizard command
  void sendWizardCommand(
    WizardCommands command, {
    Object? arguments,
  }) {
    wizardStreamController.add(WizardCommand(command, arguments: arguments));
  }

  /// create a project name
  String _createProjectName(vision.MediaType type, String? path) {
//    String name = mediaTypeToString(type);
    return 'Project ${_crateFormattedTimestamp()}';
  }

  /// create a video name
  String _createVideoName(BuildContext context, vision.MediaType type) {
    int index = project!.videos.length;
    String name;
    do {
      name = _createVideoNameByIndex(context, type, ++index);
    } while (project!.isVideoNameExists(name));
    return name;
  }

  /// create a video name by given index
  String _createVideoNameByIndex(BuildContext context, vision.MediaType type, int index) {
    return 'Video$index';
  }

  /// set the filter
  void setFilter(vision.Filter filter) {
    if (filter.equals(project!.filter)) {
      return;
    }
    project!.filter = filter;
    DateTime now = DateTime.now();
    // update sampling in each video provider
    for (final videoProvider in videoProviders) {
      videoProvider.updateSamplingOnFilterChange(now, filter);
    }
    notifyProjectChanged(null);
  }

  /// get next video id that available to use
  int getNextVideoId() {
    if (project == null) {
      return 0;
    }

    int maxId = 0;
    for (final video in project!.videos) {
      if (video.videoId > maxId) {
        maxId = video.videoId;
      }
    }
    return maxId + 1;
  }

  /// get next zone id that available to use
  int getNextZoneId() {
    if (project == null) {
      return 0;
    }

    int maxId = 0;
    for (final video in project!.videos) {
      for (final zone in video.zones) {
        if (zone.zoneId > maxId) {
          maxId = zone.zoneId;
        }
      }
    }
    return maxId + 1;
  }

  /// open a existing project
  Future<bool> openProject(BuildContext context, String projectId) async {
    project = await getProjectById(projectId);
    if (project == null) {
      return false;
    }
    sampler.reset(project!.filter);
    // reset zone global id first to avoid id conflict
    final nextZoneId = getNextZoneId();
    setNextZoneColorIndex(nextZoneId);
    if (context.mounted) {
      await _makeProjectOpened(context);
      notifyListeners();
      return true;
    }
    return false;
  }

  /// start a new project with a video source, return tru e if success
  Future<bool> newProject(
    BuildContext context, {
    required String projectId,
    required vision.MediaType mediaType,
    String? path,
    int? videoId,
  }) async {
    _onProjectClosed();
    setNextZoneColorIndex(0);

    // create project with a video source
    project = Project(
      projectId: projectId,
      projectName: _createProjectName(mediaType, path),
      videos: [],
      model: benchmarkLocalStorage.recommendedModel,
    );
    sampler.reset(project!.filter);
    _addVideoToProject(context, mediaType: mediaType, path: path, videoId: videoId);
    await _makeProjectOpened(context);
    onProjectChanged?.call(project!, null);
    notifyListeners();
    return true;
  }

  /// prepare the project to be ready, this function will be called when the project is opened
  Future<void> _makeProjectOpened(BuildContext context) async {
    await _prepareVideoProviders(context);
    if (UniversalPlatform.isMobile && project!.isCameraOnly) {
      await lockToPortrait();
    }
    onProjectOpened?.call(project!);
    _onProjectOpened();
  }

  /// add a new video to project
  Video _addVideoToProject(
    BuildContext context, {
    required vision.MediaType mediaType,
    required String? path,
    int? videoId,
  }) {
    final video = Video(
      videoId: videoId ?? getNextVideoId(),
      mediaType: mediaType,
      videoName: _createVideoName(context, mediaType),
      path: path,
    );

    // make sure the video source has a camera or webcam
    if (mediaType == vision.MediaType.camera && video.camera == null) {
      if (cameraManager.cameraDefines.isNotEmpty) {
        video.camera = cameraManager.cameraDefines.first;
      }
    } else if (mediaType == vision.MediaType.webcam && video.webcam == null) {
      if (webcamManager.webcamDefines.isNotEmpty) {
        for (final webcam in webcamManager.webcamDefines) {
          if (!project!.isWebcamDefineExists(webcam)) {
            video.webcam = webcam;
            break;
          }
        }
      }
    }
    project!.videos.add(video);
    return video;
  }

  /// check if the video source already has a provider
  bool isVideoAlreadyHasProvider(Video video) {
    for (final videoProvider in videoProviders) {
      if (videoProvider.video == video) {
        return true;
      }
    }
    return false;
  }

  /// every video source must have a video provider to manage the video source.

  Future<VideoProvider?> _prepareVideoProviders(BuildContext context) async {
    VideoProvider? videoProvider;
    for (final video in project!.videos) {
      if (isVideoAlreadyHasProvider(video)) {
        continue;
      }
      videoProvider = VideoProvider(
        video: video,
        projectProvider: this,
        sampler: sampler,
      );

      videoProviders.add(videoProvider);
      await videoProvider.init(context, project!);
    }
    return videoProvider;
  }

  /// add a new video source to the project
  Future<VideoProvider?> newVideoToProject(
    BuildContext context, {
    required vision.MediaType mediaType,
    String? path,
    int? videoId,
  }) async {
    assert(project != null, 'Project must be opened');
    _addVideoToProject(context, mediaType: mediaType, path: path, videoId: videoId);
    final videoProvider = await _prepareVideoProviders(context);
    return videoProvider;
  }

  /// Remove a video source
  Future<void> deleteVideo(VideoProvider videoProvider) async {
    if (videoProvider.video.mediaType == vision.MediaType.file) {
      // delete the video file
      final file = File(videoProvider.video.path!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    await exitVideoScreen(videoProvider);
    project?.videos.remove(videoProvider.video);
    videoProviders.remove(videoProvider);
    videoProvider.remove();
    notifyListeners();
  }

  /// notify listeners and [onProjectChanged] callback, if videoProvider is not null, it means the change is from the video source
  void notifyProjectChanged(VideoProvider? videoProvider) {
    onProjectChanged?.call(project!, videoProvider?.video);
    notifyListeners();
  }

  /// enter video screen, need show the zone editor on wizard screen
  Future<void> enterVideoScreen(VideoProvider videoProvider) async {
    final ok = await videoProvider.enableZoneEditor();
    if (!ok) {
      return;
    }

    // set fullscreen video provider will stop render gauge, reduce chance of error
    fullscreenVideoProvider = videoProvider;
    notifyListeners();
  }

  /// exit zone screen, no need show the zone editor on wizard screen
  Future<void> exitVideoScreen(VideoProvider videoProvider) async {
    await videoProvider.disableZoneEditor();
    fullscreenVideoProvider = null;
    notifyListeners();
  }

  /// get video source provider by video source
  VideoProvider getVideoProvider(Video video) {
    return videoProviders.firstWhere(
      (videoSourceProvider) => videoSourceProvider.video == video,
    );
  }

  /// set project name
  void setProjectName(String name) {
    project?.projectName = name;
    notifyProjectChanged(null);
  }

  /// change the model used by the controller
  Future<void> setModel(vision.Models model) async {
    if (project!.model == model) {
      return;
    }
    project!.model = model;
    _modelChangedTimer?.cancel();
    _modelChangedTimer = Timer(const Duration(seconds: 2), () async {
      for (final videoProvider in videoProviders) {
        await videoProvider.setModel(model);
      }
      notifyProjectChanged(null);
      _modelChangedTimer = null;
    });
  }

  /// set detection threshold
  Future<void> setSettingsDetectionThreshold(double value) async {
    project?.confidenceThreshold = value;
    _detectionThresholdTimer?.cancel();
    _detectionThresholdTimer = Timer(const Duration(seconds: 2), () async {
      for (final videoProvider in videoProviders) {
        await videoProvider.setRecognition(detectionThreshold: value);
      }
      notifyProjectChanged(null);
      _detectionThresholdTimer = null;
    });
  }

  /// set nms threshold
  Future<void> setSettingsNmsThreshold(double value) async {
    project?.nmsThreshold = value;
    _nmsThresholdTimer?.cancel();
    _nmsThresholdTimer = Timer(const Duration(seconds: 2), () async {
      for (final videoProvider in videoProviders) {
        await videoProvider.setRecognition(nmsThreshold: value);
      }
      notifyProjectChanged(null);
      _nmsThresholdTimer = null;
    });
  }

  /// set match threshold
  Future<void> setSettingsMatchThreshold(double value) async {
    project?.matchThreshold = value;
    _matchThresholdTimer?.cancel();
    _matchThresholdTimer = Timer(const Duration(seconds: 2), () async {
      for (final videoProvider in videoProviders) {
        await videoProvider.setRecognition(matchThreshold: value);
      }
      notifyProjectChanged(null);
      _matchThresholdTimer = null;
    });
  }

  /// set max allowed lost threshold
  Future<void> setSettingsMaxLostSeconds(int value) async {
    project?.maxLostSeconds = value;
    _maxLostSecondsTimer?.cancel();
    _maxLostSecondsTimer = Timer(const Duration(seconds: 2), () async {
      for (final videoProvider in videoProviders) {
        await videoProvider.setRecognition(maxLostSeconds: value);
      }
      notifyProjectChanged(null);
      _maxLostSecondsTimer = null;
    });
  }

  /// set max allowed lost threshold
  Future<void> setSettingsValidThreshold(int value) async {
    project?.validThreshold = value;
    _validThresholdTimer?.cancel();
    _validThresholdTimer = Timer(const Duration(seconds: 2), () async {
      for (final videoProvider in videoProviders) {
        await videoProvider.setRecognition(validThreshold: value);
      }
      notifyProjectChanged(null);
      _validThresholdTimer = null;
    });
  }

  /// reset the AI screen settings
  Future<void> resetDetectionSettings() async {
    if (project == null) {
      return;
    }
    project!.resetDetectionSettings();
    project!.model = benchmarkLocalStorage.recommendedModel;
    for (final videoProvider in videoProviders) {
      await videoProvider.setRecognition(
        model: project!.model,
        nmsThreshold: project!.nmsThreshold,
        matchThreshold: project!.matchThreshold,
        trackingThreshold: project!.trackingThreshold,
        detectionThreshold: project!.confidenceThreshold,
        maxLostSeconds: project!.maxLostSeconds,
      );
    }
    notifyProjectChanged(null);
  }

  /// called when the camera changed
  Future<void> onVideoCameraChanged() async {
    // = cameraProvider!.getCameraDefine();
    notifyListeners();
  }

  /// called when camera or webcam changed
  Future<void> onVideoWebcamChanged(int index) async {
    //project.webcam = webcamProvider!.selectedWebcam;
  }

  /// return selected class names
  /*String get timeRangesNames {
    return '';
    final nameList = project!.schedule.schedulePeriods.map((e) => e.label).toList();
    String name = nameList.join(', ');
    // truncate the name if it is longer than 16 characters
    if (name.length > 16) {
      name = '${name.substring(0, 16)}...';
    }
    return name;
  }*/

  /// called when the time ranges changed
  void notifyTimeRangesChanged() {
    notifyListeners();
  }

  /// notify the tally annotations are changed
  void notifyTallyAnnotationsChanged() {
    notifyProjectChanged(null);
  }
}
