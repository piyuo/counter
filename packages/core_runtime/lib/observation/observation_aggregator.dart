// TOC
// 1. Event primitives (EventType, MutableEventCounts)
// 2. ObservationAggregator (window-level event and state aggregation)
// 3. StateMetrics (running occupancy/dwell aggregations)

import 'package:core_domain/core_domain.dart' as core_domain;

enum EventType { passBy, entry, exit, appear, disappear, stagnant }

class MutableEventCounts {
  int passBy = 0;
  int entry = 0;
  int exit = 0;
  int appear = 0;
  int disappear = 0;
  int stagnant = 0;
}

/// Resolves an area ID to its human-readable name.
typedef AreaNameResolver = String Function(int areaId);

/// Aggregates per-area events and occupancy/dwell state within a time window.
class ObservationAggregator {
  /// Inclusive start timestamp of the aggregation window in business time.
  final DateTime startBusiness;

  // Per-area event counters (pass-by / enter / exit / appear / disappear / stay).
  final Map<int, MutableEventCounts> _eventCounts = {};

  // Per-area running occupancy/dwell metrics.
  final Map<int, StateMetrics> _stateMetrics = {};

  // Total duration missing from source frames within this window.
  Duration _missingDuration;

  Duration get missingDuration => _missingDuration;

  // Number of frames processed in this window.
  int _processedFrameCount;

  // Running sum/count of tracked-object confidence ratio samples in this window.
  double _confidenceRatioSum;
  int _confidenceSampleCount;

  final AreaNameResolver areaNameResolver;

  ObservationAggregator({
    required this.areaNameResolver,
    required this.startBusiness,
    required this._missingDuration,
    this._processedFrameCount = 0,
    this._confidenceRatioSum = 0.0,
    this._confidenceSampleCount = 0,
  });

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
  void addConfidenceAggregate({required double confidenceRatioSum, required int sampleCount}) {
    if (sampleCount <= 0) return;
    _confidenceRatioSum += confidenceRatioSum;
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
      case EventType.stagnant:
        metrics.stagnant++;
        break;
    }
  }

  /// Adds one occupancy/dwell sample for [areaId].
  void addStateSample(int areaId, int occupancy, int maxDwellSeconds, int sumDwellSeconds, int dwellTrackCount) {
    final metrics = _stateMetrics.putIfAbsent(areaId, () => StateMetrics());
    metrics.addSample(occupancy, maxDwellSeconds, sumDwellSeconds, dwellTrackCount);
  }

  /// Ensures empty state metrics exist for [areaId].
  void ensureStateSample(int areaId) {
    _stateMetrics.putIfAbsent(areaId, () => StateMetrics());
  }

  /// Returns an immutable [core_domain.Observation] reflecting current values.
  /// Does not mutate the aggregator; can be called multiple times.
  ///
  /// For the global area, entry/exit are forced to zero because they have no
  /// useful scene-wide boundary. Global appear/disappear counts are retained.
  core_domain.Observation snapshot() {
    core_domain.AreaMetrics buildAreaMetrics(int areaId) {
      final events = _eventCounts[areaId] ?? MutableEventCounts();
      final metrics = _stateMetrics[areaId] ?? StateMetrics();

      return core_domain.AreaMetrics(
        areaId: areaId,
        areaName: areaNameResolver(areaId),
        passBy: events.passBy,
        entry: areaId == core_domain.kGlobalAreaId ? 0 : events.entry, // Force entry to zero for global area
        exit: areaId == core_domain.kGlobalAreaId ? 0 : events.exit, // Force exit to zero for global area
        appear: events.appear,
        disappear: events.disappear,
        stagnant: events.stagnant,
        occupancySampleCount: metrics.occupancySampleCount,
        occupancySampleSum: metrics.occupancySampleSum,
        occupancyAvg: metrics.occupancyAvg,
        occupancyMax: metrics.occupancyMax,
        occupancyLast: metrics.occupancyLast,
        dwellSumSeconds: metrics.dwellSumSeconds,
        dwellSampleCount: metrics.dwellSampleCount,
        dwellAvgSeconds: metrics.dwellAvgSeconds,
        dwellMaxSeconds: metrics.dwellMaxSeconds,
      );
    }

    final areaIds = <int>{..._eventCounts.keys, ..._stateMetrics.keys};
    // Build metrics for every area touched by either events or state samples.
    final areasList = areaIds.map(buildAreaMetrics).toList();

    final adjustedMissing = _adjustedMissingDuration(_missingDuration);
    final expectedSeconds = core_domain.kWindowDuration.inSeconds;
    final coveredSeconds = (expectedSeconds - adjustedMissing.inSeconds).clamp(0, expectedSeconds);
    final observation = core_domain.Observation(
      granularity: core_domain.ObservationGranularity.minutes5,
      year: startBusiness.year,
      month: startBusiness.month,
      day: startBusiness.day,
      hour: startBusiness.hour,
      minute: startBusiness.minute,
      confidenceRatioSum: _confidenceRatioSum,
      confidenceSampleCount: _confidenceSampleCount,
      confidenceRatio: _confidenceSampleCount == 0 ? 0 : _confidenceRatioSum / _confidenceSampleCount,
      coveredSeconds: coveredSeconds,
      expectedSeconds: expectedSeconds,
      coverageRatio: expectedSeconds == 0 ? 0 : coveredSeconds / expectedSeconds,
      areas: areasList,
      frameCount: _processedFrameCount,
    );

    return observation;
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
/// - occupancyLast: last sampled occupancy
/// - occupancyAvg: simple sample mean across frames
/// - occupancyMax: maximum sampled occupancy
class StateMetrics {
  int occupancySampleCount = 0;
  int occupancySampleSum = 0;
  int occupancyMax = 0;
  int occupancyLast = 0;
  int dwellSumSeconds = 0;
  int dwellSampleCount = 0;
  int maxDwellSeconds = 0;

  /// Adds one frame-level sample.
  void addSample(int occupancy, int maxDwellSeconds, int sumDwellSeconds, int dwellTrackCount) {
    occupancySampleCount++;
    occupancySampleSum += occupancy;
    if (occupancy > occupancyMax) occupancyMax = occupancy;
    occupancyLast = occupancy;

    dwellSumSeconds += sumDwellSeconds;
    dwellSampleCount += dwellTrackCount;
    if (maxDwellSeconds > this.maxDwellSeconds) this.maxDwellSeconds = maxDwellSeconds;
  }

  /// Mean occupancy across discrete frame samples (simple average).
  double get occupancyAvg => occupancySampleCount == 0 ? 0.0 : occupancySampleSum / occupancySampleCount;

  /// Mean dwell time in seconds across all tracked dwell observations.
  double get dwellAvgSeconds => dwellSampleCount == 0 ? 0.0 : dwellSumSeconds / dwellSampleCount;

  /// Max dwell time in rounded seconds.
  int get dwellMaxSeconds => maxDwellSeconds;
}
