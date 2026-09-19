// TOC
// 1. Constants
// 2. AreaTracker — Per-area counting state and event de-duplication
// 3. Public API (constructors, getters, reset, processFrame)
// 4. Private Helpers (event recording and bounded history)

import 'package:flutter_vision/flutter_vision.dart' as vision;

import 'window_count_state.dart';
import 'count_window_aggregator.dart';

/// Maximum number of track IDs kept per history set to bound memory usage.
const int kMaxTrackHistory = 5000;

/// Tracks per-area counting state and emits aggregated event/state samples.
///
/// Global trackers (areaId = null) only track pass-by, appear/disappear, and
/// occupancy metrics. Local trackers (areaId != null) additionally emit
/// enter/exit events.
class AreaTracker {
  final int? areaId;
  Duration stayThreshold;
  Duration disappearThreshold;

  /// True for the special global tracker.
  bool get isGlobal => areaId == null;

  /// Resolved area id used by the aggregator API.
  int get _effectiveAreaId => areaId ?? kGlobalAreaId;

  // Bounded de-duplication histories so the same track does not emit repeatedly.
  final Set<int> _enteredTracks = {};
  final Set<int> _exitedTracks = {};
  final Set<int> _contactedTracks = {};
  final Set<int> _appearedTracks = {};
  final Set<int> _disappearedTracks = {};
  final Set<int> _stayedTracks = {};

  // Track id -> first timestamp when the track was observed inside continuously.
  final Map<int, DateTime> _insideSinceByTrackId = {};

  // Track id -> first timestamp when the track became absent after being inside.
  final Map<int, DateTime> _pendingDisappearSinceByTrackId = {};

  // Track ids that were inside this area in the previous processed frame.
  Set<int> _previousInsideTrackIds = {};

  // Latest frame occupancy for this area.
  int _currentOccupancy = 0;

  AreaTracker.global({this.stayThreshold = Duration.zero, this.disappearThreshold = Duration.zero}) : areaId = null;

  AreaTracker.local(int this.areaId, {this.stayThreshold = Duration.zero, this.disappearThreshold = Duration.zero});

  /// Current frame occupancy for this area.
  int get currentOccupancy => _currentOccupancy;

  /// Number of unique tracks that have made pass-by contact in this window.
  int get totalCount => _contactedTracks.length;

  /// Updates runtime thresholds for stay/disappear events.
  void configureThresholds({required Duration stayThreshold, required Duration disappearThreshold}) {
    this.stayThreshold = stayThreshold;
    this.disappearThreshold = disappearThreshold;
  }

  /// Clears all de-duplication history and current occupancy.
  void reset() {
    _enteredTracks.clear();
    _exitedTracks.clear();
    _contactedTracks.clear();
    _appearedTracks.clear();
    _disappearedTracks.clear();
    _stayedTracks.clear();
    _insideSinceByTrackId.clear();
    _pendingDisappearSinceByTrackId.clear();
    _previousInsideTrackIds = {};
    _currentOccupancy = 0;
  }

  void processFrame(
    List<vision.TrackedObject> tracks,
    CountWindowAggregator aggregator, {
    DateTime? frameTimestampUtc,
    required bool Function(vision.TrackedObject) checkContains,
    required bool Function(vision.TrackedObject) checkInitialContains,
  }) {
    final nowUtc = (frameTimestampUtc ?? DateTime.now().toUtc()).toUtc();

    // Per-frame metrics that are forwarded into window-level state aggregation.
    int occupancy = 0;
    double sumDwellMs = 0.0;
    int dwellTrackCount = 0;
    double maxDwellMs = 0;
    final currentInsideTrackIds = <int>{};

    for (final track in tracks) {
      final isInsideCurrent = checkContains(track);
      if (!isInsideCurrent) {
        // exit: initial inside, current outside
        if (!isGlobal && checkInitialContains(track)) {
          _recordUniqueEvent(_exitedTracks, track.trackId, aggregator, EventType.exit);
        }
        continue;
      }

      // Inside
      currentInsideTrackIds.add(track.trackId);
      _insideSinceByTrackId.putIfAbsent(track.trackId, () => nowUtc);
      _pendingDisappearSinceByTrackId.remove(track.trackId);
      occupancy++;
      final trackDwellMs = track.stayDuration.inMilliseconds.toDouble();
      sumDwellMs += trackDwellMs;
      dwellTrackCount++;
      if (trackDwellMs > maxDwellMs) {
        maxDwellMs = trackDwellMs;
      }

      // first_contact: current inside
      _recordPassBy(track.trackId, aggregator);

      // appear: first detected center position for the track is inside area.
      if (checkInitialContains(track)) {
        _recordUniqueEvent(_appearedTracks, track.trackId, aggregator, EventType.appear);
      }

      final insideSince = _insideSinceByTrackId[track.trackId];
      if (insideSince != null && nowUtc.difference(insideSince) >= stayThreshold) {
        _recordUniqueEvent(_stayedTracks, track.trackId, aggregator, EventType.stay);
      }

      if (!isGlobal) {
        // enter: initial outside, current inside
        final isInsideInitial = checkInitialContains(track);
        if (!isInsideInitial) {
          _recordUniqueEvent(_enteredTracks, track.trackId, aggregator, EventType.entry);
        }
      }
    }

    // disappear: track was inside in previous frame and is absent from this frame.
    for (final previousInsideTrackId in _previousInsideTrackIds) {
      if (!currentInsideTrackIds.contains(previousInsideTrackId)) {
        _pendingDisappearSinceByTrackId.putIfAbsent(previousInsideTrackId, () => nowUtc);
      }
    }

    final pendingDisappearEntries = _pendingDisappearSinceByTrackId.entries.toList(growable: false);
    for (final entry in pendingDisappearEntries) {
      if (currentInsideTrackIds.contains(entry.key)) continue;
      if (nowUtc.difference(entry.value) < disappearThreshold) continue;

      _recordUniqueEvent(_disappearedTracks, entry.key, aggregator, EventType.disappear);
      _pendingDisappearSinceByTrackId.remove(entry.key);
      _insideSinceByTrackId.remove(entry.key);
    }

    _previousInsideTrackIds = currentInsideTrackIds;

    _currentOccupancy = occupancy;
    aggregator.addStateSample(_effectiveAreaId, occupancy, maxDwellMs, sumDwellMs, dwellTrackCount);
  }

  /// Records pass-by on first contact and refreshes recency on repeated contact.
  void _recordPassBy(int trackId, CountWindowAggregator aggregator) {
    if (_contactedTracks.add(trackId)) {
      aggregator.incrementEvent(_effectiveAreaId, EventType.passBy);
      _trimHistory(_contactedTracks);
      return;
    }

    // Reinsert to move this track to the end of insertion order.
    _contactedTracks.remove(trackId);
    _contactedTracks.add(trackId);
  }

  void _recordUniqueEvent(Set<int> history, int trackId, CountWindowAggregator aggregator, EventType event) {
    // For one-shot event semantics we only deduped and cap memory.
    // We intentionally do not refresh recency for existing track IDs here.
    if (!history.add(trackId)) return;
    aggregator.incrementEvent(_effectiveAreaId, event);
    _trimHistory(history);
  }

  /// Trims history to keep at most [kMaxTrackHistory] ids.
  void _trimHistory(Set<int> history) {
    if (history.length > kMaxTrackHistory) {
      // LinkedHashSet is insertion-ordered, so this evicts the oldest inserted item.
      history.remove(history.first);
    }
  }
}
