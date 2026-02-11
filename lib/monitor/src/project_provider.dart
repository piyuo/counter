import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../db/src/project_summary.dart';
import 'camera_manager.dart';
import 'model/project.dart';
import 'model/video.dart';
import 'video_provider.dart';
import 'webcam_manager.dart';
import 'wizard_commands.dart';
import 'zone_color_table.dart';

/// indicate the video playing state
enum VideoPlayingState { allPlay, somePlay, allPause }

/// Project provider can create, open, and manage the project. wizard package will find the project provider from context to work with.
class ProjectProvider with ChangeNotifier {
  ProjectProvider({
    this.onClearActivities,
    this.onDatabaseMaintain,
    this.onProjectOpened,
    this.onProjectClosed,
    this.onProjectSave,
    this.onGetProjectSummaries,
    this.onGetProjectById,
    this.onDeleteProject,
  });

  /// is project loading, this used to new project or loading project
  bool isLoading = false;

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

  /// click App Version in About screen 10 times to enable develop mode
  bool developMode = false;

  /// is project opened
  bool get isProjectOpened => project != null;

  /// get recent activities when project opened
  final VoidCallback? onDatabaseMaintain;

  /// Callback function that is called when activities need to be cleared.
  final Future<void> Function(String projectId)? onClearActivities;

  /// called when project opened
  final void Function(Project project)? onProjectOpened;

  /// called when project closed
  final void Function(Project project)? onProjectClosed;

  /// called when project need to save, video not null mean change is from one of the video source
  final void Function(Project, Video?)? onProjectSave;

  /// called by open project screen to get the project summaries
  final Future<List<ProjectSummary>> Function()? onGetProjectSummaries;

  /// called by open project screen to get the project summaries
  final Future<Project?> Function(String)? onGetProjectById;

  /// called by open project screen to delete the project
  final Future<void> Function(String)? onDeleteProject;

  /// set the show center red dot on target
  void setShowCenterRedDotOnTarget(bool value) {
    project!.isShowCenterRedDotOnTarget = value;
    for (final videoProvider in videoProviders) {
      videoProvider.setShowCenterRedDotOnTarget(value);
    }
    saveProject(null);
  }

  /// set the show ghost target
  void setShowGhostTarget(bool value) {
    project!.isShowGhostTarget = value;
    for (final videoProvider in videoProviders) {
      videoProvider.setShowGhostTarget(value);
    }
    saveProject(null);
  }

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
    await closeProject();
    await deleteProjectInAppDirectory(projectId);
    if (onDeleteProject != null) {
      await onDeleteProject!(projectId);
    }
  }

  /// delete the project temp media file in app directory, save by [saveFileToAppDirectory]
  Future<void> deleteProjectInAppDirectory(String projectId) async {
    final appDir = await getApplicationSupportDirectory();
    final projectDir = Directory('${appDir.path}/$projectId');
    if (await projectDir.exists()) {
      await projectDir.delete(recursive: true);
    }
  }

  /// the camera manager
  CameraManager? _cameraManager;

  /// the webcam manager
  WebcamManager? _webcamManager;

  /// get the camera manager and initialize it if not yet
  Future<CameraManager> getCameraManager() async {
    if (_cameraManager == null) {
      _cameraManager = CameraManager();
      await _cameraManager!.init();
    }
    return _cameraManager!;
  }

  /// get the webcam manager and initialize it if not yet
  Future<WebcamManager> getWebcamManager() async {
    if (_webcamManager == null) {
      _webcamManager = WebcamManager();
      await _webcamManager!.init();
    }
    return _webcamManager!;
  }

  /// get the camera count
  int get cameraCount {
    return _cameraManager?.cameraDefines.length ?? 0;
  }

  /// get the webcam count
  int get webcamCount {
    return _webcamManager?.webcamDefines.length ?? 0;
  }

  /// get the camera define by index
  CameraDefine? getCameraDefine(int index) {
    return _cameraManager?.cameraDefines[index];
  }

  /// get the webcam define by index
  WebcamDefine? getWebcamDefine(int index) {
    return _webcamManager?.webcamDefines[index];
  }

  /// is lock to portrait mode?
  bool isLockToPortrait = false;

  /// true if live stream is allowed
  bool get isLiveStreamAllowed => UniversalPlatform.isMobile ? false : true;

  /// used to delay the save project setting
  Timer? _saveProjectTimer;

  /// true if the zone editor is enabled
  bool get isZoneEditorEnabled => fullscreenVideoProvider != null;

  /// get the project provider
  static ProjectProvider of(BuildContext context) {
    return Provider.of<ProjectProvider>(context, listen: false);
  }

  /// init the project provider
  Future<void> init(BuildContext context) async {
    onDatabaseMaintain?.call();
    await initializeDateFormatting();
    notifyListeners();
  }

  /// dispose multi view provider
  @override
  void dispose() {
    _saveProjectTimer?.cancel();
    _onProjectClosed();
    wizardStreamController.close();
    super.dispose();
  }

  /// call when project is opened
  void _onProjectOpened() {
    WakelockPlus.enable();
  }

  /// close the project
  Future<void> closeProject() async {
    // shutdown all video providers before dispose it
    for (final videoProvider in videoProviders) {
      await videoProvider.shutdown();
    }

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
    DateTime now = DateTime.now();
    for (final videoProvider in videoProviders) {
      videoProvider.saveCurrentCount(now);
      videoProvider.dispose();
    }
    videoProviders.clear();
    project = null;
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
    for (final videoProvider in videoProviders) {}
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
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    final formatter = DateFormat('yy-MMdd-HHmm');
    return formatter.format(now);
  }

  /// send a wizard command
  void sendWizardCommand(WizardCommands command, {Object? arguments}) {
    wizardStreamController.add(WizardCommand(command, arguments: arguments));
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
    return maxId + 1;
  }

  /// open a existing project
  Future<bool> openProject(String projectId) async {
    setLoading(true);
    try {
      project = await getProjectById(projectId);
      if (project == null) {
        return false;
      }
      await _makeProjectOpened();
      for (final videoProvider in videoProviders) {}

      // reset zone global id first to avoid id conflict
      final nextZoneId = getNextZoneId();
      setNextZoneColorIndex(nextZoneId);

      notifyListeners();
      return true;
    } finally {
      setLoading(false);
    }
  }

  /// notify listeners and [onProjectSave] callback, if videoProvider is not null, it means the change is from the video source
  void saveProject(VideoProvider? videoProvider) {
    if (project == null) {
      return;
    }
    _saveProjectTimer?.cancel();
    _saveProjectTimer = Timer(const Duration(seconds: 2), () async {
      onProjectSave?.call(project!, videoProvider?.video);
      _saveProjectTimer = null;
    });
    notifyListeners();
  }

  /// start a new project with a video source, return tru e if success
  Future<bool> newProject({required String projectId, String? path, int? videoId}) async {
    setLoading(true);
    try {
      _onProjectClosed();
      setNextZoneColorIndex(0);

      saveProject(null);
      return true;
    } finally {
      setLoading(false);
    }
  }

  /// set loading state
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// prepare the project to be ready, this function will be called when the project is opened
  Future<void> _makeProjectOpened() async {
    await _prepareVideoProviders();
    if (UniversalPlatform.isMobile && project!.isCameraOnly) {
      await lockToPortrait();
    }

    onProjectOpened?.call(project!);
    _onProjectOpened();
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

  Future<VideoProvider?> _prepareVideoProviders() async {
    VideoProvider? videoProvider;
    for (final video in project!.videos) {
      if (isVideoAlreadyHasProvider(video)) {
        continue;
      }
    }
    return videoProvider;
  }

  /// reset all counts in project
  Future<void> resetCounts() async {
    await onClearActivities?.call(project!.projectId);
    for (final videoProvider in videoProviders) {
      videoProvider.resetCounts();
    }
    notifyListeners();
  }

  /// develop mode, add random counts to the project
  Future<void> addRandomCounts() async {
    for (final videoProvider in videoProviders) {
      videoProvider.addRandomCounts();
    }
    notifyListeners();
  }

  /// Gets the current occupied count.
  int get currentOccupiedCount {
    int count = 0;
    for (final videoProvider in videoProviders) {}
    return count;
  }

  /// Remove a video source
  Future<void> deleteVideo(VideoProvider videoProvider) async {}

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
    return videoProviders.firstWhere((videoSourceProvider) => videoSourceProvider.video == video);
  }

  /// set project name
  void setProjectName(String name) {
    project?.projectName = name;
    saveProject(null);
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
    saveProject(null);
  }
}
