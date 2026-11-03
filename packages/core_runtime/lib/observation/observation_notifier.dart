// TOC
// 1. Imports
// 2. ObservationNotifier — Riverpod notifier orchestrating all counting logic
// 3. Lifecycle (build, disposal, start/stop)
// 4. Frame processing with occupancy/event tracking
// 5. Live accessors and diagnostics

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_platform/universal_platform.dart';

import 'area_tracker.dart';
import 'frame_gap_tracker.dart';
import 'interest_area_notifier.dart';
import 'observation_aggregator.dart';
import 'observation_scheduler.dart';

part 'observation_notifier.g.dart';

/// Maximum frame gap tolerated before an open visit is discarded.
/// Tune this to match the tracking engine's track-ID persistence.
const Duration _maxVisitContinuityGap = Duration(seconds: 5);
const Duration _observationEstimateResetAfter = Duration(minutes: 5);

/// Riverpod notifier that orchestrates all counting and area-metric tracking.
///
/// **Responsibilities:**
/// - Manages a [ObservationScheduler] aligned to local 5-minute wall-clock boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/presence/dwell/flow metrics via [ObservationAggregator]
/// - Emits live [Observation] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [fiveMinuteObservations] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/presence/dwell samples are accumulated in [ObservationAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [ObservationAggregator.snapshot] is emitted on [fiveMinuteObservations]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [StateMetrics] maintains occupancy and presence aggregates
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [core_domain.InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - `areaContains` inverse-rotates points before testing containment
@Riverpod(keepAlive: true) // do not autoDispose , there are services that depend on, e.g. NativeAppLinkService
class ObservationNotifier extends _$ObservationNotifier implements core_domain.ObservationService {
  /// Optional constructor overrides used only in tests to inject fake clocks
  /// and thresholds. Application configuration supplies nonzero detection
  /// thresholds before observation starts; zero defaults make stagnant count
  /// on the first in-area frame for direct or test construction.
  ObservationNotifier({
    this._nowProvider,
    this._monotonicNowProvider,
    int stagnantThresholdSeconds = 0,
    int disappearThresholdSeconds = 0,
  }) : _stagnantThreshold = Duration(seconds: stagnantThresholdSeconds),
       _disappearThreshold = Duration(seconds: disappearThresholdSeconds),
       _globalTracker = AreaTracker.global(
         stagnantThreshold: Duration(seconds: stagnantThresholdSeconds),
         disappearThreshold: Duration(seconds: disappearThresholdSeconds),
       ) {
    assert(stagnantThresholdSeconds >= 0, 'stagnantThresholdSeconds must be non-negative');
    assert(disappearThresholdSeconds >= 0, 'disappearThresholdSeconds must be non-negative');
  }

  // Cached provider values used in processFrame to avoid per-frame lookups.
  List<core_domain.InterestArea> _activeAreasCache = const [];
  ProviderSubscription<core_domain.InterestAreaState>? _interestAreaSubscription;

  final DateTime Function()? _nowProvider;
  final Duration Function()? _monotonicNowProvider;

  /// Minimum continuous in-area duration, in seconds, before a track
  /// contributes to the `stagnant` count in observation. Absences shorter
  /// than the disappear threshold do not restart the clock.
  Duration _stagnantThreshold;

  /// Minimum continuous absence duration, in seconds, before a previously
  /// in-area track contributes to `disappear` in observation.
  Duration _disappearThreshold;

  /// Keep-alive link to prevent the notifier from being disposed while the camera is active.
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  var _keepAliveLink; // KeepAliveLink — not exported from flutter_riverpod barrel

  /// Manages local wall-clock 5-minute windows and their start/end events.
  late final ObservationScheduler _scheduler;

  /// Tracks missing durations (e.g., frame drops, throttling) for coverage.
  final FrameGapTracker _frameGapTracker = FrameGapTracker();

  /// Timestamp of the latest actual frame, used to determine visit continuity.
  DateTime? _lastActualFrameAtUtc;

  /// Global area tracker (area ID = 0) for cross-area event aggregation.
  final AreaTracker _globalTracker;

  /// Per-area trackers indexed by area ID; created on demand and reset when
  /// interest areas change.
  final Map<int, AreaTracker> _areaTrackers = {};

  /// Current window aggregator object.
  ///
  /// Holds metrics for the active scheduler window, or a fresh empty snapshot
  /// before the scheduler opens its first window.
  late ObservationAggregator _currentAggregator;

  /// Emits finalized [Observation] snapshots when 5-minute windows close.
  final StreamController<core_domain.Observation> _fiveMinuteObservationController = StreamController.broadcast();

  /// Stream that emits a [Observation] every time a 5-minute window closes.
  @override
  Stream<core_domain.Observation> get fiveMinuteObservations => _fiveMinuteObservationController.stream;

  /// Last time a live state snapshot was broadcast; used to throttle updates to 1/sec.
  DateTime? _lastStateEmittedAtUtc;

  bool _isPaused = false;
  bool _forceNextFrameBroadcast = false;
  DateTime? _pausedAtUtc;
  Duration? _pausedAtMonotonic;

  /// Flag to prevent state updates after disposal.
  bool _isDisposed = false;

  /// Periodic timer used to advance missing coverage while the source is stalled.
  Timer? _sourceIssueTimer;

  // ============================================================================
  // Riverpod lifecycle (build, disposal, start/stop)
  // ============================================================================

  /// Creates the scheduler and sets up disposal and interest-area hooks.
  ///
  /// Called once when the provider is first accessed.
  @override
  core_domain.ObservationState build() {
    _currentAggregator = _buildDefaultAggregator();
    _scheduler = _createScheduler();

    ref.onDispose(() {
      _isDisposed = true;
      stop();
      _fiveMinuteObservationController.close();
      _interestAreaSubscription?.close();
      _interestAreaSubscription = null;
    });

    // subscribe to interest area
    _activeAreasCache = ref.read(interestAreaProvider).areas;
    _interestAreaSubscription ??= ref.container.listen<core_domain.InterestAreaState>(interestAreaProvider, (_, next) {
      if (!_areasHaveChanged(next.areas)) return;
      _activeAreasCache = next.areas;
      onAreasChanged(next.areas);
    }, fireImmediately: true);
    return core_domain.ObservationState(liveObservation: _snapshotCurrentWindow());
  }

  /// Builds the scheduler and wires its callbacks:
  /// - `onWindowStart` creates a new [ObservationAggregator]
  /// - `onWindowEnd` finalizes it and emits on [fiveMinuteObservations]
  /// - `onClockJump` discards open visits before the window rolls
  ObservationScheduler _createScheduler() => ObservationScheduler(
    nowProvider: _nowProvider,
    monotonicNowProvider: _monotonicNowProvider,
    onClockJump: (_) {
      _closeOpenVisits();
      _lastActualFrameAtUtc = null;
    },
    onWindowStart: (startBusiness, missingDuration) {
      _currentAggregator = ObservationAggregator(
        areaNameResolver: areaNameResolver,
        startBusiness: startBusiness,
        missingDuration: missingDuration,
      );

      // currently configured local areas, even before any frame arrives.
      _currentAggregator.ensureStateSample(core_domain.kGlobalAreaId);
      for (final areaId in _areaTrackers.keys) {
        _currentAggregator.ensureStateSample(areaId);
      }
      _frameGapTracker.advanceTo(startBusiness.toUtc().add(missingDuration));
    },
    onWindowEnd: (_) {
      _accountFrameTailAtWindowBoundary();

      final completedObservation = _currentAggregator.snapshot();
      _currentAggregator = _buildDefaultAggregator();
      state = state.copyWith(liveObservation: _snapshotCurrentWindow());
      _fiveMinuteObservationController.add(completedObservation);

      appkit.logDebug('[ObservationNotifier] window end: ${completedObservation.toJson()}');
    },
  );

  String areaNameResolver(int areaId) {
    if (areaId == core_domain.kGlobalAreaId) return 'Global';
    final area = _activeAreasCache.firstWhereOrNull((a) => a.id == areaId);
    return area?.name ?? '';
  }

  @override
  void start() {
    if (_scheduler.isRunning) return;

    // Fresh session: stop() leaves trackers and the last window in place.
    _areaTrackers.clear();
    _globalTracker.reset();
    _frameGapTracker.reset();
    _lastActualFrameAtUtc = null;
    _isPaused = false;
    _forceNextFrameBroadcast = false;
    _pausedAtUtc = null;
    _pausedAtMonotonic = null;
    _currentAggregator = _buildDefaultAggregator();
    _lastStateEmittedAtUtc = null;
    state = state.copyWith(
      liveObservation: _snapshotCurrentWindow(),
      status: core_domain.ObservationStatus.live,
      observationStart: _nowProvider?.call().toUtc() ?? DateTime.now().toUtc(),
    );

    _keepAliveLink = ref.keepAlive();
    _scheduler.start();
  }

  /// Stops the scheduler and discards the open window. Only windows that
  /// closed at a boundary are emitted, so consumers never see a partial one.
  @override
  void stop() {
    _stopSourceIssueTimer();
    _isPaused = false;
    _forceNextFrameBroadcast = false;
    _pausedAtUtc = null;
    _pausedAtMonotonic = null;
    if (_scheduler.isRunning) _scheduler.stop();
    if (!_isDisposed) {
      state = state.copyWith(
        liveObservation: _snapshotCurrentWindow(),
        status: core_domain.ObservationStatus.stopped,
        observationStart: null,
      );
    }
    _keepAliveLink?.close();
    _keepAliveLink = null;
  }

  /// Updates stagnant/disappear thresholds at runtime without recreating provider.
  ///
  /// New values are applied to global and local trackers immediately and affect
  /// subsequent [processFrame] calls.
  @override
  void setThresholdSeconds({int? stagnantThresholdSeconds, int? disappearThresholdSeconds}) {
    if (stagnantThresholdSeconds != null && stagnantThresholdSeconds < 0) {
      throw ArgumentError.value(stagnantThresholdSeconds, 'stagnantThresholdSeconds', 'must be non-negative');
    }
    if (disappearThresholdSeconds != null && disappearThresholdSeconds < 0) {
      throw ArgumentError.value(disappearThresholdSeconds, 'disappearThresholdSeconds', 'must be non-negative');
    }

    if (stagnantThresholdSeconds != null) {
      _stagnantThreshold = Duration(seconds: stagnantThresholdSeconds);
    }
    if (disappearThresholdSeconds != null) {
      _disappearThreshold = Duration(seconds: disappearThresholdSeconds);
    }

    _globalTracker.configureThresholds(stagnantThreshold: _stagnantThreshold, disappearThreshold: _disappearThreshold);
    for (final tracker in _areaTrackers.values) {
      tracker.configureThresholds(stagnantThreshold: _stagnantThreshold, disappearThreshold: _disappearThreshold);
    }
  }

  /// Updates only the stagnant threshold at runtime.
  void setStagnantThresholdSeconds(int stagnantThresholdSeconds) {
    setThresholdSeconds(stagnantThresholdSeconds: stagnantThresholdSeconds);
  }

  /// Updates only the disappear threshold at runtime.
  void setDisappearThresholdSeconds(int disappearThresholdSeconds) {
    setThresholdSeconds(disappearThresholdSeconds: disappearThresholdSeconds);
  }

  /// Recreates local trackers when the configured interest areas change.
  ///
  /// Open visits and bounded per-track histories are discarded, so a still
  /// visible track may be counted as a new pass-by in the updated area.
  void onAreasChanged(List<core_domain.InterestArea> areas) {
    _areaTrackers.clear();
    for (final area in areas) {
      _areaTrackers[area.id] = AreaTracker.local(
        area.id,
        stagnantThreshold: _stagnantThreshold,
        disappearThreshold: _disappearThreshold,
      );
      _currentAggregator.ensureStateSample(area.id);
    }

    _scheduler.ensureWindowActive();
    state = state.copyWith(liveObservation: _snapshotCurrentWindow());
  }

  /// Compares two lists of [InterestArea] objects for equality.
  /// Returns true if areas have changed, false if they're the same.
  bool _areasHaveChanged(List<core_domain.InterestArea> newAreas) {
    if (newAreas.length != _activeAreasCache.length) return true;
    for (int i = 0; i < newAreas.length; i++) {
      if (newAreas[i] != _activeAreasCache[i]) return true;
    }
    return false;
  }

  /// Debug helper that forces the current window to end immediately.
  ///
  /// This triggers the scheduler's [onWindowEnd] callback and then immediately
  /// reopens a fresh active window for continued frame processing.
  void debugForceWindowEnd() {
    if (!_scheduler.isRunning) return;
    _scheduler.debugForceWindowEnd();
    _scheduler.ensureWindowActive();
    _broadcastLiveSnapshot(checkOneSecondThrottle: false);
  }

  /// Pauses frame processing and accounts missing time while the source is stalled.
  @override
  void pause() {
    if (!_scheduler.isRunning || _isPaused) return;
    _isPaused = true;
    _pausedAtUtc = _nowProvider?.call().toUtc() ?? DateTime.now().toUtc();
    _pausedAtMonotonic = _monotonicNowProvider?.call();
    state = state.copyWith(status: core_domain.ObservationStatus.interrupted);
    _startSourceIssueTimer();
  }

  /// Resumes frame processing after accounting missing time through this instant.
  @override
  void resume() {
    if (!_scheduler.isRunning || !_isPaused) return;
    _advanceMissingWhileSourceStalled();
    _stopSourceIssueTimer();
    final resumedAtUtc = _nowProvider?.call().toUtc() ?? DateTime.now().toUtc();
    final pausedAtMonotonic = _pausedAtMonotonic;
    final pauseDuration = pausedAtMonotonic != null && _monotonicNowProvider != null
        ? _monotonicNowProvider.call() - pausedAtMonotonic
        : resumedAtUtc.difference(_pausedAtUtc!);
    if (pauseDuration > _observationEstimateResetAfter) {
      state = state.copyWith(observationStart: resumedAtUtc);
    }
    _isPaused = false;
    _pausedAtUtc = null;
    _pausedAtMonotonic = null;
    _scheduler.ensureWindowActive();
    _forceNextFrameBroadcast = true;
  }

  // ============================================================================
  // Frame processing
  // ============================================================================

  /// Processes a single frame of confirmed tracked objects.
  ///
  /// **Algorithm:**
  /// 1. Computes elapsed time since last frame (accounting for gaps/throttling)
  /// 2. Routes tracked objects through global and per-area trackers
  /// 3. Updates occupancy/presence/dwell/flow metrics in the aggregator
  /// 4. Broadcasts a live [Observation] snapshot (throttled to 1/sec)
  ///
  /// **Rotation Handling:**
  /// - AI models report centers in *rotated image* coordinates
  /// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
  /// - Points are inverse-rotated before containment checks (see [areaContains])
  ///
  /// **Parameters:**
  /// - [tracks]: Confirmed tracked objects with center and confidence
  /// - [rotationDegrees]: Inverse rotation to apply (negative = counter-clockwise)
  ///
  /// **Lifecycle:** Ignored unless the notifier is started. Opens the active
  /// window lazily through [ObservationScheduler.ensureWindowActive].
  @override
  void processFrame<T>(List<T> tracks, double rotationDegrees) {
    if (!_scheduler.isRunning || _isPaused) return;

    // Helper to test whether a point (typically the center of a detected
    // bounding box) lies inside an `InterestArea`.
    //
    // Explanation:
    // - The camera image is often rotated to match the device orientation
    //   before being fed to the AI model. The model therefore reports boxes
    //   and centers in the *rotated image* coordinate space.
    // - `InterestArea`s, however, are defined in un-rotated screen coordinates
    //   (they do not rotate with the device). To test containment correctly
    //   we must map the model-provided point back into the screen coordinate
    //   space (i.e. apply the inverse rotation).
    // - We perform the inverse rotation by rotating the point by
    //   `-rotationDegrees` using `_rotatePoint`, then call `area.contains`.
    // - If `rotationDegrees` is zero we skip the rotation for performance.
    // - On iOS landscape (e.g. iPad forced-rotation), the preview instead swaps
    //   the image center reference for display (see TrackedObjectOverlay /
    //   interest_area_utils) rather than truly rotating points, so tracked
    //   object centers and area points are already directly comparable there.
    bool areaContains(core_domain.InterestArea area, core_domain.PointData point) {
      final isSwappedRenderMode = UniversalPlatform.isIOS && _isLandscapeOrientation();
      if (rotationDegrees == 0.0 || isSwappedRenderMode) {
        final result = area.contains(point);
        return result;
      }
      // Inverse-rotate the point back to screen coordinates.
      final result = area.contains(_rotatePoint(point, -rotationDegrees));
      return result;
    }

    final now = _nowProvider?.call() ?? DateTime.now().toUtc();
    final actualFrameAtUtc = now.toUtc();
    final lastActualFrameAtUtc = _lastActualFrameAtUtc;
    if (lastActualFrameAtUtc != null && actualFrameAtUtc.isBefore(lastActualFrameAtUtc)) return;

    _closeOpenVisitsIfActualFrameGapExceeded(actualFrameAtUtc);

    // Ensure an active window exists before reading the aggregator.
    _scheduler.ensureWindowActive();

    final aggregator = _currentAggregator;
    _lastActualFrameAtUtc = actualFrameAtUtc;

    final frameTiming = _frameGapTracker.consumeFrameTiming(now);
    if (frameTiming.missingDuration > Duration.zero) {
      aggregator.addMissingDuration(frameTiming.missingDuration);
    }

    var elapsedSinceLastFrameMs = frameTiming.validDuration.inMilliseconds;
    final windowStartUtc = _scheduler.windowStartUtc;
    if (frameTiming.previousFrameAt == null && windowStartUtc != null) {
      // Startup policy: for a short initial delay, estimate that the first
      // frame's presence applies from the window start; this is inferred, not
      // directly observed presence.
      final startDelay = now.difference(windowStartUtc);
      if (startDelay > Duration.zero && startDelay < kFrameGapJitterThreshold) {
        elapsedSinceLastFrameMs = startDelay.inMilliseconds;
      }
    }
    if (frameTiming.previousFrameAt != null &&
        windowStartUtc != null &&
        frameTiming.previousFrameAt!.toUtc().isBefore(windowStartUtc)) {
      elapsedSinceLastFrameMs = 0;
    }

    aggregator.incrementProcessedFrameCount();

    var confidenceRatioSum = 0.0;
    var confidenceSampleCount = 0;
    for (final track in tracks) {
      if (track is vision.TrackedObject) {
        if (!track.activated) continue;
        confidenceRatioSum += track.confidenceRatio;
        confidenceSampleCount++;
      }
    }
    aggregator.addConfidenceAggregate(confidenceRatioSum: confidenceRatioSum, sampleCount: confidenceSampleCount);

    // Process global area (all tracks, no spatial filtering).
    _globalTracker.processFrame(
      tracks,
      aggregator,
      frameTimestampUtc: now,
      elapsedSinceLastFrameMs: elapsedSinceLastFrameMs,
      checkContains: (_) => true,
      checkInitialContains: (_) => true,
    );

    // Process each interest area (spatial filtering via areaContains).
    final areas = _activeAreasCache;
    for (final area in areas) {
      final tracker = _areaTrackers.putIfAbsent(
        area.id,
        () =>
            AreaTracker.local(area.id, stagnantThreshold: _stagnantThreshold, disappearThreshold: _disappearThreshold),
      );
      tracker.processFrame(
        tracks,
        aggregator,
        frameTimestampUtc: now,
        elapsedSinceLastFrameMs: elapsedSinceLastFrameMs,
        checkContains: (t) => areaContains(area, core_domain.PointData.fromOffset(t.center)),
        checkInitialContains: (t) => areaContains(area, core_domain.PointData.fromOffset(t.initialCenter)),
      );
    }

    final forceBroadcast = _forceNextFrameBroadcast;
    _forceNextFrameBroadcast = false;
    final statusChanged = state.status != core_domain.ObservationStatus.live;
    _broadcastLiveSnapshot(
      checkOneSecondThrottle: !forceBroadcast && !statusChanged,
      status: core_domain.ObservationStatus.live,
    );
  }

  /// Returns the current occupancy count for a specific area (global or local).
  ///
  /// Returns 0 if the area has no tracker or no active aggregator.
  int getCurrentCount(int areaId) => areaId == core_domain.kGlobalAreaId
      ? _globalTracker.lastFrameOccupancy
      : (_areaTrackers[areaId]?.lastFrameOccupancy ?? 0);

  /// Returns cumulative emitted pass-by events for a specific area.
  ///
  /// The count grows since the tracker's last reset. A track may be counted
  /// again if its ID is evicted from the bounded de-duplication history.
  int getTotalCount(int areaId) => areaId == core_domain.kGlobalAreaId
      ? _globalTracker.passByTotalCount
      : (_areaTrackers[areaId]?.passByTotalCount ?? 0);

  void _startSourceIssueTimer() {
    if (_isDisposed) return;
    _advanceMissingWhileSourceStalled();
    _sourceIssueTimer ??= Timer.periodic(const Duration(seconds: 1), (_) => _advanceMissingWhileSourceStalled());
  }

  void _stopSourceIssueTimer() {
    _sourceIssueTimer?.cancel();
    _sourceIssueTimer = null;
  }

  void _closeOpenVisits() {
    _globalTracker.discardOpenVisits();
    for (final tracker in _areaTrackers.values) {
      tracker.discardOpenVisits();
    }
  }

  bool _closeOpenVisitsIfActualFrameGapExceeded(DateTime atUtc) {
    final lastActualFrameAtUtc = _lastActualFrameAtUtc;
    if (lastActualFrameAtUtc == null || atUtc.difference(lastActualFrameAtUtc) <= _maxVisitContinuityGap) return false;

    _closeOpenVisits();
    return true;
  }

  /// Accounts the coverage tail through the earlier of the window end and now.
  void _accountFrameTailAtWindowBoundary() {
    final windowEnd = _scheduler.windowEndUtc;
    if (windowEnd == null) return;
    final nowUtc = _nowProvider?.call().toUtc() ?? DateTime.now().toUtc();
    final effectiveEnd = windowEnd.isAfter(nowUtc) ? nowUtc : windowEnd;
    final continuityLost = _closeOpenVisitsIfActualFrameGapExceeded(effectiveEnd);
    final frameInterval = _frameGapTracker.consumeFrameTiming(effectiveEnd);

    if (!continuityLost && frameInterval.validDuration > Duration.zero) {
      final frameDeltaMs = frameInterval.validDuration.inMilliseconds;
      _globalTracker.addPresenceForLastFrame(_currentAggregator, frameDeltaMs);
      for (final tracker in _areaTrackers.values) {
        tracker.addPresenceForLastFrame(_currentAggregator, frameDeltaMs);
      }
    }

    if (frameInterval.missingDuration > Duration.zero) {
      _currentAggregator.addMissingDuration(frameInterval.missingDuration);
    }
  }

  /// Broadcasts a live [Observation] snapshot (throttled to 1/sec).
  ///
  /// Called after every frame processing to update listeners with live metrics.
  /// Throttling prevents excessive state updates on high-framerate sources.
  void _broadcastLiveSnapshot({required bool checkOneSecondThrottle, core_domain.ObservationStatus? status}) {
    if (_isDisposed) return;

    final now = _nowProvider?.call() ?? DateTime.now().toUtc();
    final last = _lastStateEmittedAtUtc;
    // Only update the state and notify listeners once per second
    if (!checkOneSecondThrottle || (last == null || now.difference(last) >= const Duration(seconds: 1))) {
      _lastStateEmittedAtUtc = now;
      state = state.copyWith(liveObservation: _snapshotCurrentWindow(), status: status ?? state.status);
    }
  }

  core_domain.Observation _snapshotCurrentWindow() {
    final now = _nowProvider?.call() ?? DateTime.now().toUtc();
    final elapsedSeconds = now.toUtc().difference(_currentAggregator.startBusiness.toUtc()).inSeconds;
    return _currentAggregator.snapshot(elapsedSeconds: elapsedSeconds);
  }

  /// Advances missing duration while the source is known to be stalled.
  ///
  /// Unlike frame-driven gap tracking, this path must count every elapsed
  /// second, so it bypasses the jitter threshold.
  void _advanceMissingWhileSourceStalled() {
    if (_isDisposed || !_isPaused) return;

    _scheduler.ensureWindowActive();
    final aggregator = _currentAggregator;

    final now = _nowProvider?.call() ?? DateTime.now().toUtc();
    final missingGap = _frameGapTracker.consumeGap(now, ignoreJitterThreshold: true);
    if (missingGap > Duration.zero) {
      aggregator.addMissingDuration(missingGap);
    }
    _broadcastLiveSnapshot(checkOneSecondThrottle: false);
  }

  /// Mirrors `OrientationBuilder`'s `Orientation.landscape` check for the
  /// primary view, without requiring a `BuildContext` inside this notifier.
  bool _isLandscapeOrientation() {
    final views = PlatformDispatcher.instance.views;
    if (views.isEmpty) return false;
    final view = views.first;
    final logicalSize = view.physicalSize / view.devicePixelRatio;
    final result = logicalSize.width > logicalSize.height;
    return result;
  }

  /// Rotates a point by the given degrees around the origin.
  ///
  /// Used to inverse-rotate tracked object centers from image coordinates
  /// back to screen coordinates for proper containment testing.
  core_domain.PointData _rotatePoint(core_domain.PointData point, double degrees) {
    if (degrees == 0) return point;
    final radians = degrees * (math.pi / 180);
    final cosValue = math.cos(radians);
    final sinValue = math.sin(radians);
    return core_domain.PointData(
      dx: point.dx * cosValue - point.dy * sinValue,
      dy: point.dx * sinValue + point.dy * cosValue,
    );
  }

  ObservationAggregator _buildDefaultAggregator() {
    final now = _nowProvider?.call() ?? DateTime.now();
    return ObservationAggregator(
      areaNameResolver: areaNameResolver,
      startBusiness: now.isUtc ? now.toLocal() : now,
      missingDuration: Duration.zero,
    );
  }
}
