// TOC
// 1. Imports
// 2. WindowCountNotifier — Riverpod notifier orchestrating all counting logic
// 3. Lifecycle (build, disposal, reset)
// 4. Context management (source type, interest areas)
// 5. Frame processing with occupancy/event tracking
// 6. Window finalization (5-minute aligned snapshots)
// 7. Live accessors and diagnostics
// 8. Private helpers (rotation, session ID generation)
// 9. Provider

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
import 'count_window_aggregator.dart';
import 'count_window_scheduler.dart';
import 'frame_gap_tracker.dart';
import 'interest_area_notifier.dart';
import 'interest_area_state.dart';
import 'session_cursor.dart';
import 'window_count_state.dart';

part 'window_count_notifier.g.dart';

abstract interface class WindowCountController {
  void processFrame(
    List<vision.TrackedObject> tracks, {
    required double rotationDegrees,
    List<core_domain.InterestArea>? areasForTest,
  });
}

/// Riverpod notifier that orchestrates all counting and occupancy tracking logic.
///
/// **Responsibilities:**
/// - Manages a [CountWindowScheduler] that aligns 5-minute counting windows to UTC boundaries
/// - Maintains per-area [AreaTracker] instances for spatial containment and event counting
/// - Aggregates per-window occupancy/dwell/flow metrics via [CountWindowAggregator]
/// - Emits live [WindowCountState] snapshots (throttled to 1/sec) on every frame
/// - Emits finalized window snapshots on [snapshots] when windows close
///
/// **Data Flow:**
/// 1. [processFrame] receives tracked objects and areas
/// 2. Frame timing is computed; missing gaps are tracked via [FrameGapTracker]
/// 3. Rotation is applied to normalize object centers to screen coordinates
/// 4. Global and per-area [AreaTracker]s process events (enter/exit/passBy)
/// 5. Occupancy/dwell samples are accumulated in [CountWindowAggregator]
/// 6. Live state is broadcast (throttled to 1/sec)
/// 7. On window close, [CountWindowAggregator.snapshot()] is emitted on [snapshots]
///
/// **Occupancy Averaging:**
/// - [AreaTracker.processFrame] submits one occupancy sample per processed frame
/// - [CountWindowAggregator.StateMetrics] maintains sample-average occupancy
/// - Missing gaps still affect coverage via [FrameGapTracker]
///
/// **Rotation Handling:**
/// - AI models report tracked object centers in the *rotated image* space
/// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
/// - [areaContains] inverse-rotates points before testing containment
@riverpod
class WindowCountNotifier extends _$WindowCountNotifier implements WindowCountController {
  /// Optional constructor overrides used only in tests to inject fake clocks.
  WindowCountNotifier({
    DateTime Function()? nowProvider,
    Duration Function()? monotonicNowProvider,
    int stayThresholdSeconds = 0,
    int disappearThresholdSeconds = 0,
  }) : _nowProvider = nowProvider,
       _monotonicNowProvider = monotonicNowProvider,
       _stayThreshold = Duration(seconds: stayThresholdSeconds),
       _disappearThreshold = Duration(seconds: disappearThresholdSeconds),
       _globalTracker = AreaTracker.global(
         stayThreshold: Duration(seconds: stayThresholdSeconds),
         disappearThreshold: Duration(seconds: disappearThresholdSeconds),
       ) {
    assert(stayThresholdSeconds >= 0, 'stayThresholdSeconds must be non-negative');
    assert(disappearThresholdSeconds >= 0, 'disappearThresholdSeconds must be non-negative');
  }

  // Cached provider values used in _processFrame to avoid per-frame lookups.
  List<core_domain.InterestArea> _activeAreasCache = const [];
  ProviderSubscription<InterestAreaState>? _interestAreaSubscription;

  final DateTime Function()? _nowProvider;
  final Duration Function()? _monotonicNowProvider;
  Duration _stayThreshold;
  Duration _disappearThreshold;

  /// Keep-alive link to prevent the notifier from being disposed while the camera is active.
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  var _keepAliveLink; // KeepAliveLink — not exported from flutter_riverpod barrel

  /// Manages 5-minute UTC-aligned windows, tracks window start/end events.
  CountWindowScheduler? _scheduler;

  /// Tracks missing durations (e.g., frame drops, throttling) for coverage.
  final FrameGapTracker _frameGapTracker = FrameGapTracker();

  // ============================================================================
  // Area tracking and aggregation
  // ============================================================================

  /// Global area tracker (area ID = -1) for cross-area event aggregation.
  final AreaTracker _globalTracker;

  /// Per-area trackers indexed by area ID; created on demand and reset when
  /// interest areas change.
  final Map<int, AreaTracker> _areaTrackers = {};

  /// Current window aggregator object.
  ///
  /// [_hasActiveWindow] indicates whether this instance is currently bound to
  /// an open scheduler window.
  late CountWindowAggregator _currentAggregator;

  // ============================================================================
  // Session management and state emission
  // ============================================================================

  /// Producer-side session cursor used to stamp per-window metadata.
  final SessionCursor _session = SessionCursor();

  /// Emits finalized [WindowCountState] snapshots when 5-minute windows close.
  final StreamController<WindowCountState> _snapshotsController = StreamController.broadcast();

  /// Last time a live state snapshot was broadcast; used to throttle updates to 1/sec.
  DateTime? _lastStateEmittedAtUtc;

  /// Flag to prevent state updates after disposal.
  bool _isDisposed = false;

  /// Periodic timer used to advance missing coverage while the source is stalled.
  Timer? _sourceIssueTimer;

  /// Stream that emits a [WindowCountState] every time a 5-minute window closes.
  Stream<WindowCountState> get snapshots => _snapshotsController.stream;

  // ============================================================================
  // Riverpod lifecycle (build, disposal, reset)
  // ============================================================================

  /// Initializes the scheduler and sets up disposal hooks.
  ///
  /// Called once when the provider is first accessed. Subsequent calls are no-ops.
  ///
  /// Window start/end callbacks are registered here:
  /// - [onWindowStart]: Creates a new [CountWindowAggregator]
  /// - [onWindowEnd]: Finalizes the aggregator and emits on [snapshots]
  @override
  WindowCountState build() {
    ref.onDispose(() {
      _isDisposed = true;
      stop();
      _snapshotsController.close();
      _interestAreaSubscription?.close();
      _interestAreaSubscription = null;
    });

    // subscribe to interest area
    _activeAreasCache = ref.read(interestAreaProvider).activeAreas;
    _interestAreaSubscription ??= ref.container.listen<InterestAreaState>(interestAreaProvider, (_, next) {
      if (!_areasHaveChanged(next.activeAreas)) return;
      _activeAreasCache = next.activeAreas;
      onAreasChanged(next.activeAreas);
    }, fireImmediately: true);
    _currentAggregator = _buildDefaultAggregator();
    return _currentAggregator.snapshot();
  }

  String areaNameResolver(int areaId) {
    if (areaId == kGlobalAreaId) return 'Global';
    final area = _activeAreasCache.firstWhereOrNull((a) => a.id == areaId);
    return area?.name ?? '';
  }

  void start() {
    if (_scheduler != null) {
      return;
    }
    reset();
    _keepAliveLink = ref.keepAlive();
    _scheduler = CountWindowScheduler(
      nowProvider: _nowProvider,
      monotonicNowProvider: _monotonicNowProvider,
      onWindowStart: (startUtc, startBusiness, missingDuration) {
        _currentAggregator = CountWindowAggregator(
          areaNameResolver: areaNameResolver,
          startUtc: startUtc,
          startBusiness: startBusiness,
          session: _session.session,
          sequence: _session.nextSequence(),
          missingDuration: missingDuration,
        );

        // Seed zero-value state rows so snapshots always include global and
        // currently configured local areas, even before any frame arrives.
        _currentAggregator.ensureStateSample(kGlobalAreaId);
        for (final areaId in _areaTrackers.keys) {
          _currentAggregator.ensureStateSample(areaId);
        }
      },
      onWindowEnd: (startUtc, startBusiness, missingDuration) {
        if (_scheduler == null) {
          return;
        }

        final missingGap = _frameGapTracker.consumeGap(_scheduler!.windowEndUtc!);
        if (missingGap > Duration.zero) {
          _currentAggregator.addMissingDuration(missingGap);
        }
        final lastSnapshot = _currentAggregator.snapshot();
        state = lastSnapshot;
        _snapshotsController.add(lastSnapshot);
        appkit.logDebug('[WindowCountNotifier] window end: $lastSnapshot');
        _currentAggregator = _buildDefaultAggregator();
      },
    );
    _scheduler!.start();
  }

  void stop() {
    if (_scheduler == null) {
      return;
    }

    _stopSourceIssueTimer();
    _scheduler?.dispose();
    _scheduler = null;
    _keepAliveLink?.close();
    _keepAliveLink = null;
  }

  /// Updates stay/disappear thresholds at runtime without recreating provider.
  ///
  /// New values are applied to global and local trackers immediately and affect
  /// subsequent [processFrame] calls.
  void setThresholdSeconds({int? stayThresholdSeconds, int? disappearThresholdSeconds}) {
    if (stayThresholdSeconds != null && stayThresholdSeconds < 0) {
      throw ArgumentError.value(stayThresholdSeconds, 'stayThresholdSeconds', 'must be non-negative');
    }
    if (disappearThresholdSeconds != null && disappearThresholdSeconds < 0) {
      throw ArgumentError.value(disappearThresholdSeconds, 'disappearThresholdSeconds', 'must be non-negative');
    }

    if (stayThresholdSeconds != null) {
      _stayThreshold = Duration(seconds: stayThresholdSeconds);
    }
    if (disappearThresholdSeconds != null) {
      _disappearThreshold = Duration(seconds: disappearThresholdSeconds);
    }

    _globalTracker.configureThresholds(stayThreshold: _stayThreshold, disappearThreshold: _disappearThreshold);
    for (final tracker in _areaTrackers.values) {
      tracker.configureThresholds(stayThreshold: _stayThreshold, disappearThreshold: _disappearThreshold);
    }
  }

  /// Updates only the stay threshold at runtime.
  void setStayThresholdSeconds(int stayThresholdSeconds) {
    setThresholdSeconds(stayThresholdSeconds: stayThresholdSeconds);
  }

  /// Updates only the disappear threshold at runtime.
  void setDisappearThresholdSeconds(int disappearThresholdSeconds) {
    setThresholdSeconds(disappearThresholdSeconds: disappearThresholdSeconds);
  }

  /// Resets all per-area and per-window tracking state but does not stop the scheduler.
  ///
  /// Used when:
  /// - Clearing state after interest areas change (no need to drain old windows)
  /// - Clearing state temporarily without stopping the counting engine
  ///
  /// Does NOT affect:
  /// - [_scheduler] (continues running)
  /// - [_sessionId] (preserved for continuity)
  ///
  /// Call [stop] if you need to halt the scheduler itself.
  void reset() {
    _session.reset();
    _stopSourceIssueTimer();
    _areaTrackers.clear();
    _globalTracker.reset();
    _frameGapTracker.reset();
    _scheduler?.reset();
    _currentAggregator = _buildDefaultAggregator();
    _lastStateEmittedAtUtc = null;
    final now = _nowProvider?.call() ?? DateTime.now();
    state = WindowCountState(
      startUtc: now.toUtc(),
      startBusiness: now.isUtc ? now.toLocal() : now,
      session: '',
      sequence: 0,
      areas: {},
      missingDuration: Duration.zero,
      frameCount: 0,
      confidence: 0.0,
      doneRatio: 0.0,
      inProgressRatio: 1.0,
      missingRatio: 0.0,
      fps: 0.0,
    );
  }

  void onAreasChanged(List<core_domain.InterestArea> areas) {
    _areaTrackers.clear();
    for (final area in areas) {
      _areaTrackers[area.id] = AreaTracker.local(
        area.id,
        stayThreshold: _stayThreshold,
        disappearThreshold: _disappearThreshold,
      );
      _currentAggregator.ensureStateSample(area.id);
    }

    _scheduler?.ensureWindowActive();
    final lastSnapshot = _currentAggregator.snapshot();
    state = lastSnapshot;
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

  /// Immediately snapshots the current in-progress window and emits it on
  /// [snapshots], without closing or resetting the window.
  ///
  /// If no window is currently open (e.g. after pausing), falls back to the
  /// last known [state] so the most-recent data is still emitted.
  /// No-op only when both are null.
  void flushCurrentWindow() {
    final snapshot = _currentAggregator.snapshot();
    _snapshotsController.add(snapshot);
    appkit.logInfo('[WindowCountNotifier] $snapshot');
  }

  /// Debug helper that forces the current window to end immediately.
  ///
  /// This triggers the scheduler's [onWindowEnd] callback and then immediately
  /// reopens a fresh active window for continued frame processing.
  void debugForceWindowEnd() {
    _scheduler?.debugForceWindowEnd();
    _scheduler?.ensureWindowActive();
    _broadcastLiveSnapshot(checkOneSecondThrottle: false);
  }

  // ============================================================================
  // Source status handling
  // ============================================================================

  /// Handles source status changes (start, stop, errors, size changes).
  ///
  /// Resets state on source start (new session) and broadcasts final snapshot
  /// on source stop/error (for diagnostic purposes).
  void handleEvent(vision.VisionEvent sourceStatus) {
    switch (sourceStatus) {
      case vision.VisionStarted():
        _stopSourceIssueTimer();
        _scheduler?.onSourceStarted();
        break;
      case vision.VisionStopped():
        _startSourceIssueTimer();
        break;
      case vision.VisionFailure():
        _startSourceIssueTimer();
        break;
      case vision.VisionIssue():
        _startSourceIssueTimer();
        break;
      case vision.VisionRecovered():
        _stopSourceIssueTimer();
        break;
      case vision.VisionAlert():
        _stopSourceIssueTimer();
        _scheduler?.onSourceStarted();
        break;
    }
  }

  // ============================================================================
  // Frame processing
  // ============================================================================

  /// Processes a single frame of confirmed tracked objects.
  ///
  /// **Algorithm:**
  /// 1. Computes elapsed time since last frame (accounting for gaps/throttling)
  /// 2. Routes tracked objects through global and per-area trackers
  /// 3. Updates occupancy/dwell/flow metrics in the aggregator
  /// 4. Broadcasts a live [WindowCountState] snapshot (throttled to 1/sec)
  ///
  /// **Rotation Handling:**
  /// - AI models report centers in *rotated image* coordinates
  /// - [InterestArea]s are defined in *screen* coordinates (un-rotated)
  /// - Points are inverse-rotated before containment checks (see [areaContains])
  ///
  /// **Parameters:**
  /// - [tracks]: Confirmed tracked objects with center and confidence
  /// - [rotationDegrees]: Inverse rotation to apply (negative = counter-clockwise)
  /// - [areas]: Current interest areas for spatial filtering
  ///
  /// **Precondition:** An active window must exist (created by scheduler).
  @override
  void processFrame(
    List<vision.TrackedObject> tracks, {
    required double rotationDegrees,
    List<core_domain.InterestArea>? areasForTest,
  }) {
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

    if (_scheduler == null) {
      return;
    }

    // Ensure an active window exists before reading the aggregator.
    _scheduler?.ensureWindowActive();

    final aggregator = _currentAggregator;
    final now = _nowProvider?.call() ?? DateTime.now().toUtc();

    final missingGap = _frameGapTracker.consumeGap(now);
    if (missingGap > Duration.zero) {
      aggregator.addMissingDuration(missingGap);
    }

    aggregator.incrementProcessedFrameCount();

    var confidenceSum = 0;
    var confidenceSampleCount = 0;
    for (final track in tracks) {
      if (!track.activated) continue;
      confidenceSum += track.confidence;
      confidenceSampleCount++;
    }
    aggregator.addConfidenceAggregate(confidenceSum: confidenceSum, sampleCount: confidenceSampleCount);

    // Process global area (all tracks, no spatial filtering).
    _globalTracker.processFrame(
      tracks,
      aggregator,
      frameTimestampUtc: now,
      checkContains: (_) => true,
      checkInitialContains: (_) => true,
    );

    // Process each interest area (spatial filtering via areaContains).
    final areas = areasForTest ?? _activeAreasCache;
    for (final area in areas) {
      final tracker = _areaTrackers.putIfAbsent(
        area.id,
        () => AreaTracker.local(area.id, stayThreshold: _stayThreshold, disappearThreshold: _disappearThreshold),
      );
      tracker.processFrame(
        tracks,
        aggregator,
        frameTimestampUtc: now,
        checkContains: (t) => areaContains(area, core_domain.PointData.fromOffset(t.center)),
        checkInitialContains: (t) => areaContains(area, core_domain.PointData.fromOffset(t.initialCenter)),
      );
    }

    _broadcastLiveSnapshot(checkOneSecondThrottle: true);
  }

  // ============================================================================
  // Live accessors (backward-compatible API)
  // ============================================================================

  /// Returns the current occupancy count for a specific area (global or local).
  ///
  /// Returns 0 if the area has no tracker or no active aggregator.
  int getCurrentCount(int areaId) =>
      areaId == kGlobalAreaId ? _globalTracker.currentOccupancy : (_areaTrackers[areaId]?.currentOccupancy ?? 0);

  /// Returns the cumulative enter + exit count for a specific area (global or local).
  ///
  /// Used to count total tracked objects that have passed through the area.
  int getTotalCount(int areaId) =>
      areaId == kGlobalAreaId ? _globalTracker.totalCount : (_areaTrackers[areaId]?.totalCount ?? 0);

  void _startSourceIssueTimer() {
    if (_isDisposed) return;
    _advanceMissingWhileSourceStalled();
    _sourceIssueTimer ??= Timer.periodic(const Duration(seconds: 1), (_) => _advanceMissingWhileSourceStalled());
  }

  void _stopSourceIssueTimer() {
    _sourceIssueTimer?.cancel();
    _sourceIssueTimer = null;
  }

  // ============================================================================
  // Private helpers
  // ============================================================================

  /// Broadcasts a live [WindowCountState] snapshot (throttled to 1/sec).
  ///
  /// Called after every frame processing to update listeners with live metrics.
  /// Throttling prevents excessive state updates on high-framerate sources.
  void _broadcastLiveSnapshot({required bool checkOneSecondThrottle}) {
    if (_isDisposed) return;

    final now = _nowProvider?.call() ?? DateTime.now().toUtc();
    final last = _lastStateEmittedAtUtc;
    // Only update the state and notify listeners once per second
    if (!checkOneSecondThrottle || (last == null || now.difference(last) >= const Duration(seconds: 1))) {
      _lastStateEmittedAtUtc = now;
      state = _currentAggregator.snapshot();
    }
  }

  /// Advances missing duration while the source is known to be stalled.
  ///
  /// Unlike frame-driven gap tracking, this path must count every elapsed
  /// second, so it bypasses the jitter threshold.
  void _advanceMissingWhileSourceStalled() {
    if (_isDisposed) return;

    _scheduler?.ensureWindowActive();

    final now = _nowProvider?.call() ?? DateTime.now().toUtc();
    final missingGap = _frameGapTracker.consumeGap(now, ignoreJitterThreshold: true);
    if (missingGap > Duration.zero) {
      _currentAggregator.addMissingDuration(missingGap);
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

  CountWindowAggregator _buildDefaultAggregator() {
    final now = _nowProvider?.call() ?? DateTime.now();
    return CountWindowAggregator(
      areaNameResolver: areaNameResolver,
      startUtc: now.toUtc(),
      startBusiness: now.isUtc ? now.toLocal() : now,
      missingDuration: Duration.zero,
    );
  }
}
