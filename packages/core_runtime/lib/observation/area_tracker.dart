// TOC
// 1. Constants
// 2. AreaTracker — Per-area counting state and event de-duplication
// 3. Public API (constructors, getters, reset, processFrame)
// 4. Private Helpers (event recording and bounded history)

import 'dart:collection';
import 'dart:math' as math;

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;

import 'observation_aggregator.dart';

/// Maximum number of track IDs kept per history set to bound memory usage.
const int kMaxTrackHistory = 5000;

/// Tracks per-area counting state and emits aggregated event/state samples.
///
/// Track-ID event histories are bounded and persist across observation windows.
/// `passBy`, `stagnant`, `entry`, `exit`, `appear`, and `disappear` are counted
/// once while an ID remains in its history. Long-running per-frame events
/// refresh recency; an inactive ID can be counted again after eviction or reset.
/// Dwell and presence are the duration measures.
class AreaTracker {
  final int areaId;
  Duration stagnantThreshold;
  Duration disappearThreshold;

  /// True for the special global tracker.
  bool get isGlobal => areaId == core_domain.kGlobalAreaId;

  int _passByTotalCount = 0;

  // Bounded de-duplication histories so the same track does not emit repeatedly.
  // use LinkedHashSet to maintain insertion order and enable efficient removal of oldest entries.
  final LinkedHashSet<int> _enteredTracks = LinkedHashSet<int>();
  final LinkedHashSet<int> _exitedTracks = LinkedHashSet<int>();
  final LinkedHashSet<int> _passByTracks = LinkedHashSet<int>();
  final LinkedHashSet<int> _appearedTracks = LinkedHashSet<int>();
  final LinkedHashSet<int> _disappearedTracks = LinkedHashSet<int>();
  final LinkedHashSet<int> _stagnantTracks = LinkedHashSet<int>();

  // Track id -> first timestamp when the track was observed inside continuously.
  final Map<int, DateTime> _insideSinceByTrackId = {};

  // Track id -> first timestamp when the track became absent after being inside.
  final Map<int, DateTime> _pendingDisappearSinceByTrackId = {};

  // Track ids that were inside this area in the previous processed frame.
  Set<int> _previousInsideTrackIds = {};

  // Latest frame occupancy for this area.
  int _lastFrameOccupancy = 0;

  /// Latest frame occupancy for this area.
  int get lastFrameOccupancy => _lastFrameOccupancy;

  AreaTracker.global({this.stagnantThreshold = Duration.zero, this.disappearThreshold = Duration.zero})
    : areaId = core_domain.kGlobalAreaId;

  AreaTracker.local(this.areaId, {this.stagnantThreshold = Duration.zero, this.disappearThreshold = Duration.zero});

  /// Cumulative pass-by events since the last [reset].
  ///
  /// This counter is not limited by the bounded track-ID history.
  int get passByTotalCount => _passByTotalCount;

  /// Updates runtime thresholds for stay/disappear events.
  void configureThresholds({required Duration stagnantThreshold, required Duration disappearThreshold}) {
    this.stagnantThreshold = stagnantThreshold;
    this.disappearThreshold = disappearThreshold;
  }

  /// Clears all de-duplication history and current occupancy.
  ///
  /// A subsequent observation of the same track ID can count as a new pass-by.
  void reset() {
    _passByTotalCount = 0;
    _enteredTracks.clear();
    _exitedTracks.clear();
    _passByTracks.clear();
    _appearedTracks.clear();
    _disappearedTracks.clear();
    _stagnantTracks.clear();
    _insideSinceByTrackId.clear();
    _pendingDisappearSinceByTrackId.clear();
    _previousInsideTrackIds = {};
    _lastFrameOccupancy = 0;
  }

  /// Discards incomplete visits when observation is interrupted.
  ///
  /// An interruption does not establish when a track actually left, so these
  /// visits must not be turned into dwell samples. Dwell is recorded only after
  /// disappearance is confirmed in [processFrame]. Event de-duplication
  /// histories are intentionally preserved.
  void discardOpenVisits() {
    _insideSinceByTrackId.clear();
    _pendingDisappearSinceByTrackId.clear();
    _previousInsideTrackIds = {};
    _lastFrameOccupancy = 0;
  }

  /// Credits [frameDeltaMs] to the tracks inside at the last processed frame.
  ///
  /// Used for the tail between the last frame and a window boundary, so that
  /// time is attributed to the window it elapsed in. (processFrame credits each
  /// frame's interval to the tracks inside that frame.)
  void addPresenceForLastFrame(ObservationAggregator aggregator, int frameDeltaMs) {
    aggregator.addPresenceSample(areaId, _previousInsideTrackIds, frameDeltaMs);
  }

  void processFrame<T>(
    List<T> tracks,
    ObservationAggregator aggregator, {
    DateTime? frameTimestampUtc,
    int elapsedSinceLastFrameMs = 0,
    required bool Function(vision.TrackedObject) checkContains,
    required bool Function(vision.TrackedObject) checkInitialContains,
  }) {
    final nowUtc = (frameTimestampUtc ?? DateTime.now().toUtc()).toUtc();

    // Occupancy is sampled once per processed frame.
    final currentInsideTrackIds = <int>{};

    for (final track in tracks) {
      if (track is! vision.TrackedObject || !track.activated) continue;
      final isInsideCurrent = checkContains(track);
      final isInsideInitial = checkInitialContains(track);
      if (!isInsideCurrent) {
        // Exit from this local area: initially inside, currently outside.
        if (!isGlobal && isInsideInitial) {
          _recordUniqueEvent(_exitedTracks, track.trackId, aggregator, EventType.exit, refreshExisting: true);
        }
        continue;
      }

      // Inside
      currentInsideTrackIds.add(track.trackId);
      _insideSinceByTrackId.putIfAbsent(track.trackId, () => nowUtc);
      _pendingDisappearSinceByTrackId.remove(track.trackId);

      // current inside = pass-by
      _recordPassBy(track.trackId, aggregator);

      // appear: first detected center position for the track is inside area.
      if (isInsideInitial) {
        _recordUniqueEvent(_appearedTracks, track.trackId, aggregator, EventType.appear, refreshExisting: true);
      }

      final insideSince = _insideSinceByTrackId[track.trackId];
      if (insideSince != null && nowUtc.difference(insideSince) >= stagnantThreshold) {
        _recordUniqueEvent(_stagnantTracks, track.trackId, aggregator, EventType.stagnant, refreshExisting: true);
      }

      if (!isGlobal) {
        // Entry into this local area: initially outside, currently inside.
        if (!isInsideInitial) {
          _recordUniqueEvent(_enteredTracks, track.trackId, aggregator, EventType.entry, refreshExisting: true);
        }
      }
    }

    // disappear: track was inside in previous frame and is absent from this frame.
    for (final previousInsideTrackId in _previousInsideTrackIds) {
      if (!currentInsideTrackIds.contains(previousInsideTrackId)) {
        _pendingDisappearSinceByTrackId.putIfAbsent(previousInsideTrackId, () => nowUtc);
      }
    }

    _pendingDisappearSinceByTrackId.removeWhere((trackId, pendingSince) {
      if (currentInsideTrackIds.contains(trackId)) return false;
      if (nowUtc.difference(pendingSince) < disappearThreshold) return false;

      _recordUniqueEvent(_disappearedTracks, trackId, aggregator, EventType.disappear);

      final insideSince = _insideSinceByTrackId.remove(trackId);
      if (insideSince != null) {
        _recordDwell(pendingSince.difference(insideSince), aggregator);
      }

      return true;
    });

    _previousInsideTrackIds = currentInsideTrackIds;
    _lastFrameOccupancy = currentInsideTrackIds.length;
    aggregator.addOccupancySample(areaId, _lastFrameOccupancy);
    aggregator.addPresenceSample(areaId, currentInsideTrackIds, elapsedSinceLastFrameMs);
  }

  void _recordDwell(Duration duration, ObservationAggregator aggregator) {
    final seconds = math.max(1, (duration.inMilliseconds / 1000).round());
    aggregator.addDwellSample(areaId, seconds);
  }

  /// Records pass-by on first contact and refreshes recency on repeated contact.
  void _recordPassBy(int trackId, ObservationAggregator aggregator) {
    if (_passByTracks.add(trackId)) {
      aggregator.incrementEvent(areaId, EventType.passBy);
      _passByTotalCount++;
      _trimHistory(_passByTracks);
      return;
    }

    // Reinsert to move this track to the end of insertion order.
    _passByTracks.remove(trackId);
    _passByTracks.add(trackId);
  }

  void _recordUniqueEvent(
    LinkedHashSet<int> history,
    int trackId,
    ObservationAggregator aggregator,
    EventType event, {
    bool refreshExisting = false,
  }) {
    if (!history.add(trackId)) {
      if (refreshExisting) {
        history.remove(trackId);
        history.add(trackId);
      }
      return;
    }
    aggregator.incrementEvent(areaId, event);
    _trimHistory(history);
  }

  /// Trims history to keep at most [kMaxTrackHistory] ids.
  void _trimHistory(LinkedHashSet<int> history) {
    if (history.length > kMaxTrackHistory) {
      // LinkedHashSet is insertion-ordered, so this evicts the oldest inserted item.
      history.remove(history.first);
    }
  }
}
