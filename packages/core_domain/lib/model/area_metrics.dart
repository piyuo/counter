// TOC
// 1. Observation model
// 2. AreaMetrics model
// 3. JSON helpers
//
// Architecture:
//   VisionEngine
//       ↓
//   Observation (5-minute)
//       ↓ aggregation
//   Observation (hour)
//       ↓ aggregation
//   Observation (day)
//       ↓ aggregation
//   Observation (month)
//       ↓ aggregation
//   Observation (year)
//
// Time basis and DST
//
// Observation's year, month, day, hour, and minute fields are BUSINESS time:
// the local wall-clock time at the monitored location, not UTC. This lets
// users compare the same business hours (e.g. 11:00-13:00) across stores in
// different time zones.
//
// Daylight saving time (and any device clock / time zone change) is a known,
// accepted limitation:
//
// - Fall back (a local hour repeats): two windows get the same date and time
//   (e.g. 01:30 occurs twice). The FIRST saved observation wins. Observations
//   are never overridden, so later duplicates with the same granularity, date
//   and time are discarded. Traffic recorded during the repeated hour's second
//   pass is lost.
// - Spring forward (a local hour is skipped): no windows exist for the skipped
//   times. The gap is not filled and no placeholder observations are created.
//   Aggregates are built only from the windows that exist.
//
// The first-saved-wins rule is enforced by the Analytics Engine when inserting
// into a DayFile; these models do not enforce it.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/round_double.dart';

part 'area_metrics.freezed.dart';
part 'area_metrics.g.dart';

/// Upper-exclusive edges for dwell duration buckets, in seconds.
const List<int> kDwellBucketEdgesSeconds = [5, 15, 60, 300];

/// Number of dwell duration buckets, including the unbounded final bucket.
const int kDwellBucketCount = 5;

/// Returns the histogram bucket index for a finished dwell duration.
int dwellBucketIndex(int seconds) {
  for (var index = 0; index < kDwellBucketEdgesSeconds.length; index++) {
    if (seconds < kDwellBucketEdgesSeconds[index]) return index;
  }
  return kDwellBucketEdgesSeconds.length;
}

/// Analytics metrics for one interest area within an [Observation].
///
/// Most event metrics are additive. For example, the hourly [passBy] count
/// can be calculated by summing the [passBy] values from its twelve
/// 5-minute observations.
///
/// Note: passBy and stagnant count each track ONCE for its whole lifetime, so
/// summed values are the number of distinct tracks. The other track-based
/// metrics (entry, exit, appear, disappear) are described on each field.
///
/// Tracks are not confirmed distinct people or vehicles: a tracking ID
/// switch creates a new track and is counted again.
///
/// Time is measured two ways. Dwell is one sample per finished visit; presence
/// is time spent inside during each observation. See those fields.
///
/// Sums and counts are the source of truth. Average fields are stored as
/// convenient values; if you edit a sum or count by hand, recompute the
/// averages that depend on it.
///
/// Average fields are rounded to 2 decimals when written to JSON.
@freezed
sealed class AreaMetrics with _$AreaMetrics {
  const AreaMetrics._();

  const factory AreaMetrics({
    /// Index matching the configured interest-area ID.
    ///
    /// [kGlobalAreaId] represents the global monitored scene.
    required int areaId,

    /// Name of the configured interest area.
    required String areaName,

    /// Number of unique tracks that touched this area for the first time.
    ///
    /// Each track is counted ONLY ONCE, in the observation where it first makes
    /// contact with the area. It is never counted again, even if it stays in the
    /// area for hours or leaves and re-enters, as long as its track ID does not
    /// change.
    ///
    /// Example: a track first touches the area at 12:03. passBy increases by 1 in
    /// the 12:00-12:05 observation only. If the same track stays there all day,
    /// passBy stays unchanged in every later observation.
    ///
    /// Because of this, the metric is additive: summing passBy over 5-minute
    /// observations gives the hourly value, and so on up to the year. The result
    /// is the number of new tracks first seen in that period.
    ///
    /// Limitation: a new track ID (for example after a tracking ID switch or an
    /// app restart) is a new track and is counted again.
    required int passBy,

    /// Number of unique tracks that stayed inside the area continuously for at
    /// least the configured stagnant threshold.
    ///
    /// Each track is counted ONLY ONCE, in the observation where it reaches the
    /// threshold. It is never counted again while it keeps the same track ID,
    /// even if it stays for the rest of the day.
    ///
    /// Example: the threshold is 30 seconds and a track enters at 12:04:50. It
    /// reaches 30 seconds at 12:05:20, so stagnant increases by 1 in the
    /// 12:05-12:10 observation (not in 12:00-12:05, where the stay started).
    ///
    /// This metric is additive across observations.
    ///
    /// Limitation: a new track ID is a new track and is counted again.
    required int stagnant,

    /// Number of tracks whose initial position was outside this area and were
    /// later observed inside it.
    ///
    /// This metric applies only to local interest areas. It is always zero
    /// for the global area because the global scene has no useful entry
    /// boundary.
    ///
    /// Each track contributes at most one entry event per observation.
    required int entry,

    /// Number of tracks whose initial position was inside this area and were
    /// later observed outside it.
    ///
    /// This metric applies only to local interest areas. It is always zero
    /// for the global area because the global scene has no useful exit
    /// boundary.
    ///
    /// Each track contributes at most one exit event per observation.
    required int exit,

    /// Number of objects first detected with their center position inside
    /// this area.
    ///
    /// Applies to both local areas and the global monitored scene.
    /// Each track contributes at most one appear event per observation.
    required int appear,

    /// Number of unique tracks that were last seen inside the area and then
    /// disappeared long enough to satisfy the configured disappear threshold.
    ///
    /// Applies to both local areas and the global monitored scene.
    ///
    /// For the global area, this means that the track was lost from scene
    /// tracking; it does not mean that the object was confirmed to have
    /// exited the camera view.
    required int disappear,

    /// Number of occupancy samples in this observation.
    ///
    /// Occupancy is sampled once per frame, so this equals
    /// [Observation.frameCount]. It is kept here for convenience so each area
    /// can be read on its own.
    ///
    /// Additive across child observations.
    required int occupancySampleCount,

    /// Sum of the object counts across all occupancy samples.
    ///
    /// Example: samples of 2, 3, and 1 objects give a sum of 6 and a count
    /// of 3.
    ///
    /// Additive across child observations.
    required int occupancySampleSum,

    /// Sum of the squared object counts across all occupancy samples.
    ///
    /// Example: samples of 2, 3, and 1 objects give 4 + 9 + 1 = 14.
    ///
    /// Additive across child observations. Together with
    /// [occupancySampleSum] and [occupancySampleCount] it gives the variance:
    ///
    /// variance = occupancySampleSumSquares / occupancySampleCount - mean²
    ///
    /// The sum, sum of squares, and count remain the source of truth; the mean
    /// and variance are derived from them.
    required int occupancySampleSumSquares,

    /// Mean number of objects in the area per sample, or 0 when there are no
    /// samples.
    ///
    /// occupancyMean = occupancySampleSum / occupancySampleCount
    ///
    /// This is an average over frames, not over time, so no time-weighting is
    /// applied. The sum and count remain the source of truth; this field is
    /// included for convenience.
    @RoundedDouble() required double occupancyMean,

    /// Maximum occupancy observed in any sample during this observation.
    ///
    /// For an aggregated observation, this is the maximum value from its
    /// child observations.
    required int occupancyMax,

    /// Most recent occupancy sample observed for this area.
    ///
    /// This is state, not an additive metric; an aggregated observation
    /// should retain the value from its latest child observation.
    required int occupancyLast,

    // ===== DWELL: how long visitors stay. One sample per finished visit. =====
    // ...(section note: use for typical visit length; do NOT use to find the
    // busiest time, because a visit is recorded when it ends)

    /// Number of finished visits recorded in this observation.
    ///
    /// A visit is finished when the track has been gone from the area for the
    /// disappear threshold. The whole visit is recorded ONCE, in the observation
    /// where it is confirmed finished (not where it started).
    ///
    /// Example: a visit from 12:03 to 12:13 adds one sample of 600 s to the
    /// 12:10-12:15 observation and nothing to the earlier ones.
    ///
    /// Additive across child observations.
    required int dwellSampleCount,

    /// Sum of dwell durations, in whole seconds, across all dwell samples.
    ///
    /// Each dwell sample is rounded to whole seconds before it is added.
    ///
    /// Additive across child observations.
    required int dwellSumSeconds,

    /// Mean dwell time in seconds across all dwell samples, or 0 when there
    /// are no samples.
    ///
    /// dwellMeanSeconds = dwellSumSeconds / dwellSampleCount
    ///
    /// No time-weighting is applied. The sum and count remain the source of
    /// truth; this field is included for convenience.
    @RoundedDouble() required double dwellMeanSeconds,

    /// Longest finished visit recorded in this observation, in whole seconds.
    ///
    /// Attributed to the observation where the visit finished. For an aggregated
    /// observation, this is the maximum of its child observations.
    required int dwellMaxSeconds,

    /// Number of finished visits in each duration bucket, in order:
    /// `<5s, 5-15s, 15-60s, 1-5min, >=5min`.
    ///
    /// Each bucket includes its lower edge and excludes its upper edge (a 60 s
    /// visit is in 1-5min, a 300 s visit is in >=5min). The edges are fixed by
    /// [kDwellBucketEdgesSeconds]; the list always has [kDwellBucketCount]
    /// entries and sums to [dwellSampleCount].
    ///
    /// Additive across child observations: add the lists element by element.
    @Default([0, 0, 0, 0, 0]) List<int> dwellHistogram,

    // ===== PRESENCE: time spent inside during each observation. =====
    // Use it to find the busiest or most-lingering time and to compare areas.
    // Do NOT read it as visit length.

    /// Number of tracks that were inside the area at any time during this
    /// observation. Each present track is one sample.
    ///
    /// A track that stays across several observations is a separate sample in
    /// each one, so at hour, day or longer levels this is a count of
    /// track-observation pairs, not of distinct tracks (use passBy for that).
    ///
    /// Additive across child observations.
    @Default(0) int presenceTrackCount,

    /// Total seconds that tracks spent inside the area during this observation
    /// (track-seconds, in whole seconds).
    ///
    /// Example: a track inside from 12:03 to 12:13 adds 120 s to 12:00-12:05,
    /// 300 s to 12:05-12:10 and 180 s to 12:10-12:15.
    ///
    /// presenceSumSeconds / coveredSeconds is the time-weighted average number
    /// of tracks in the area while detection data was valid. Unlike
    /// [occupancyMean], it does not depend on frame rate.
    ///
    /// Additive across child observations.
    @Default(0) int presenceSumSeconds,

    /// Mean seconds each present track spent inside during this observation, or
    /// 0 when there are no samples.
    ///
    /// presenceMeanSeconds = presenceSumSeconds / presenceTrackCount
    ///
    /// This is not visit length. The sums and count remain the source of truth;
    /// this field is included for convenience.
    @RoundedDouble() @Default(0) double presenceMeanSeconds,
  }) = _AreaMetrics;

  double get occupancyVariance {
    if (occupancySampleCount == 0) return 0;
    final mean = occupancySampleSum / occupancySampleCount;
    final v = occupancySampleSumSquares / occupancySampleCount - mean * mean;
    return v < 0 ? 0 : v; // guard against rounding noise
  }

  factory AreaMetrics.fromJson(Map<String, dynamic> json) => _$AreaMetricsFromJson(json);

  @override
  String toString() =>
      'AreaMetrics('
      'areaId: $areaId, '
      'areaName: $areaName, '
      'passBy: $passBy, '
      'stagnant: $stagnant, '
      'entry: $entry, '
      'exit: $exit, '
      'appear: $appear, '
      'disappear: $disappear, '
      'occupancySampleCount: $occupancySampleCount, '
      'occupancySampleSum: $occupancySampleSum, '
      'occupancySampleSumSquares: $occupancySampleSumSquares, '
      'occupancyMean: ${occupancyMean.toStringAsFixed(2)}, '
      'occupancyMax: $occupancyMax, '
      'occupancyLast: $occupancyLast, '
      'dwellSumSeconds: $dwellSumSeconds, '
      'dwellSampleCount: $dwellSampleCount, '
      'dwellMeanSeconds: ${dwellMeanSeconds.toStringAsFixed(2)}, '
      'dwellMaxSeconds: $dwellMaxSeconds, '
      'dwellHistogram: $dwellHistogram, '
      'presenceTrackCount: $presenceTrackCount, '
      'presenceSumSeconds: $presenceSumSeconds, '
      'presenceMeanSeconds: ${presenceMeanSeconds.toStringAsFixed(2)}'
      ')';
}
