// TOC
// 1. Event primitives (EventType, MutableEventCounts)
// 2. CountWindowAggregator (window-level event and state aggregation)
// 3. StateMetrics (running occupancy/dwell aggregations)

import 'window_count_state.dart';

enum EventType {
  passBy,
  entry,
  exit,
  appear,
  disappear,
  stay,
}

class MutableEventCounts {
  int passBy = 0;
  int entry = 0;
  int exit = 0;
  int appear = 0;
  int disappear = 0;
  int stay = 0;
}

/// Resolves an area ID to its human-readable name.
typedef AreaNameResolver = String Function(int areaId);

/// Aggregates per-area events and occupancy/dwell state within a time window.
class CountWindowAggregator {
  /// Inclusive start timestamp of the aggregation window.
  final DateTime startUtc;

  /// Inclusive start timestamp of the aggregation window in business time.
  final DateTime startBusiness;

  /// Identifier of the pedestrian counting session this observation window
  /// belongs to.
  ///
  /// Generated from the session's business start time (yyMMddHHmm).
  final String session;

  /// Sequential number of this observation window within the counting session.
  ///
  /// Starts at 1 and increments by one for each 5-minute window.
  final int sequence;

  // Per-area event counters (pass-by / enter / exit / appear / disappear / stay).
  final Map<int, MutableEventCounts> _eventCounts = {};

  // Per-area running occupancy/dwell metrics.
  final Map<int, StateMetrics> _stateMetrics = {};

  // Total duration missing from source frames within this window.
  Duration _missingDuration;

  Duration get missingDuration => _missingDuration;

  // Number of frames processed in this window.
  int _processedFrameCount;

  // Running sum/count of tracked-object confidence samples in this window.
  int _confidenceSum;
  int _confidenceSampleCount;

  final AreaNameResolver areaNameResolver;

  CountWindowAggregator({
    required this.areaNameResolver,
    required this.startUtc,
    required this.startBusiness,
    this.session = '',
    this.sequence = 0,
    required Duration missingDuration,
    int processedFrameCount = 0,
    int confidenceSum = 0,
    int confidenceSampleCount = 0,
  })  : _missingDuration = missingDuration,
        _processedFrameCount = processedFrameCount,
        _confidenceSum = confidenceSum,
        _confidenceSampleCount = confidenceSampleCount;

  /// Adds source-gap duration used to compute coverage ratio.
  ///
  /// Non-positive durations are ignored.
  void addMissingDuration(Duration duration) {
    if (duration <= Duration.zero) return;
    _missingDuration += duration;
  }

  /// Increments processed frame count for this window by one frame.
  void incrementProcessedFrameCount() {
    _processedFrameCount++;
  }

  /// Adds aggregated confidence values observed in the current frame.
  void addConfidenceAggregate({required int confidenceSum, required int sampleCount}) {
    if (sampleCount <= 0) return;
    _confidenceSum += confidenceSum;
    _confidenceSampleCount += sampleCount;
  }

  /// Increments one event counter for [areaId].
  void incrementEvent(int areaId, EventType event) {
    final metrics = _eventCounts.putIfAbsent(areaId, () => MutableEventCounts());
    switch (event) {
      case EventType.passBy:
        metrics.passBy++;
        break;
      case EventType.entry:
        metrics.entry++;
        break;
      case EventType.exit:
        metrics.exit++;
        break;
      case EventType.appear:
        metrics.appear++;
        break;
      case EventType.disappear:
        metrics.disappear++;
        break;
      case EventType.stay:
        metrics.stay++;
        break;
    }
  }

  /// Adds one occupancy/dwell sample for [areaId].
  void addStateSample(
    int areaId,
    int occupancy,
    double maxDwellMs,
    double sumDwellMs,
    int dwellTrackCount,
  ) {
    final metrics = _stateMetrics.putIfAbsent(areaId, () => StateMetrics());
    metrics.addSample(
      occupancy,
      maxDwellMs,
      sumDwellMs,
      dwellTrackCount,
    );
  }

  /// Ensures empty state metrics exist for [areaId].
  void ensureStateSample(int areaId) {
    _stateMetrics.putIfAbsent(areaId, () => StateMetrics());
  }

  /// Returns an immutable [WindowCountState] reflecting current aggregated values.
  /// Does not mutate the aggregator; can be called multiple times.
  ///
  /// For the global area, enter/exit are intentionally forced to zero.
  WindowCountState snapshot() {
    final areasMap = <int, AreaMetrics>{};

    AreaMetrics buildAreaMetrics(int areaId) {
      final events = _eventCounts[areaId] ?? MutableEventCounts();
      final metrics = _stateMetrics[areaId] ?? StateMetrics();

      return AreaMetrics(
        areaId: areaId,
        areaName: areaNameResolver(areaId),
        passBy: events.passBy,
        entry: areaId == kGlobalAreaId ? 0 : events.entry,
        exit: areaId == kGlobalAreaId ? 0 : events.exit,
        appear: events.appear,
        disappear: events.disappear,
        stay: events.stay,
        currentOccupancy: metrics.currentOccupancy,
        avgOccupancy: metrics.avgOccupancy,
        maxOccupancy: metrics.maxOccupancy,
        avgDwellSec: metrics.avgDwellSec,
        maxDwellSec: metrics.maxDwellSec,
      );
    }

    final areaIds = <int>{
      ..._eventCounts.keys,
      ..._stateMetrics.keys,
    };

    // Build metrics for every area touched by either events or state samples.
    for (final key in areaIds) {
      areasMap[key] = buildAreaMetrics(key);
    }

    final adjustedMissing = _adjustedMissingDuration(_missingDuration);
    final nowUtc = DateTime.now().toUtc();
    final totalMs = kWindowDuration.inMilliseconds;
    final endUtc = startUtc.add(kWindowDuration);
    final remainingMs = nowUtc.isBefore(endUtc) ? endUtc.difference(nowUtc).inMilliseconds : 0;
    final elapsedMs = nowUtc.isBefore(endUtc) ? totalMs - remainingMs : totalMs;
    final missingElapsedMs = adjustedMissing.inMilliseconds.clamp(0, elapsedMs.clamp(0, totalMs));

    final inProgress = (remainingMs / totalMs).clamp(0.0, 1.0);
    final missing = (missingElapsedMs / totalMs).clamp(0.0, 1.0);
    final done = (1.0 - inProgress - missing).clamp(0.0, 1.0);

    // Compute fps at snapshot time
    final coveredMs = (done * totalMs).round().clamp(0, totalMs);
    final computedFps = coveredMs <= 0 ? 0.0 : _processedFrameCount / (coveredMs / 1000.0);

    return WindowCountState(
      startUtc: startUtc,
      startBusiness: startBusiness,
      session: session,
      sequence: sequence,
      areas: areasMap,
      missingDuration: adjustedMissing,
      frameCount: _processedFrameCount,
      confidence: _confidenceSampleCount == 0 ? 0.0 : _confidenceSum / _confidenceSampleCount,
      doneRatio: done,
      inProgressRatio: inProgress,
      missingRatio: missing,
      fps: computedFps,
    );
  }

  Duration _adjustedMissingDuration(Duration duration) {
    if (duration.isNegative) return Duration.zero;
    if (duration.inSeconds >= 299) return Duration(seconds: 300); // our counting window is capped at 5 minutes
    return duration;
  }
}

/// Running aggregation of occupancy and dwell-time samples for one area.
///
/// Occupancy exposes three values:
/// - currentOccupancy: last sampled occupancy
/// - avgOccupancy: simple sample mean across frames
/// - maxOccupancy: maximum sampled occupancy
class StateMetrics {
  int _sampleCount = 0;
  int _sumOccupancy = 0;
  int _maxOccupancy = 0;
  int _currentOccupancy = 0;
  double _sumDwellMs = 0.0;
  int _sumDwellTrackCount = 0;
  double _maxDwellMs = 0;

  /// Adds one frame-level sample.
  void addSample(int occupancy, double maxDwellMs, double sumDwellMs, int dwellTrackCount) {
    _sampleCount++;
    _sumOccupancy += occupancy;
    if (occupancy > _maxOccupancy) _maxOccupancy = occupancy;
    _currentOccupancy = occupancy;

    _sumDwellMs += sumDwellMs;
    _sumDwellTrackCount += dwellTrackCount;
    if (maxDwellMs > _maxDwellMs) _maxDwellMs = maxDwellMs;
  }

  /// Mean occupancy across discrete frame samples (simple average).
  double get avgOccupancy => _sampleCount == 0 ? 0.0 : _sumOccupancy / _sampleCount;

  /// Latest occupancy sample observed in this window.
  int get currentOccupancy => _sampleCount == 0 ? 0 : _currentOccupancy;

  /// Peak occupancy across samples.
  int get maxOccupancy => _maxOccupancy;

  /// Mean dwell time in seconds across all tracked dwell observations.
  double get avgDwellSec => _sumDwellTrackCount == 0 ? 0.0 : (_sumDwellMs / _sumDwellTrackCount) / 1000.0;

  /// Max dwell time in rounded seconds.
  double get maxDwellSec => (_maxDwellMs / 1000).round().toDouble();
}
