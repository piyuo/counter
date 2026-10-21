// TOC
// 1. Dwell bucket helpers
// 2. AreaMetrics model
//
// Time basis and DST for Observation (defined in observation.dart)
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

import 'package:core_domain/utils/round_double.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'area_metrics_payload.dart';

part 'area_metrics.freezed.dart';
part 'area_metrics.g.dart';

/// Returns the histogram bucket index for a finished dwell duration.
int dwellBucketIndex(int seconds) {
  for (var index = 0; index < kDwellBucketEdgesSeconds.length; index++) {
    if (seconds < kDwellBucketEdgesSeconds[index]) return index;
  }
  return kDwellBucketEdgesSeconds.length;
}

/// Analytics metrics for one interest area within an [Observation].
///
/// Event fields are direct counts for this observation and add across actual
/// periods. Typical-day profiles average matching event counts across days, so
/// a profile value may be fractional.
///
/// passBy, stagnant, entry, exit, appear, and disappear are one-shot events per
/// track ID while it remains in the bounded tracker history. An ID can be
/// counted again after eviction or reset.
///
/// Tracks are not confirmed distinct people or vehicles: a tracking ID
/// switch creates a new track and is counted again.
///
/// Time is measured two ways. Dwell is one sample per finished visit; presence
/// is time spent inside during each observation. See those fields.
///
/// Occupancy, dwell, and presence sums and counts are the source of truth for
/// their derived means. Event counts are stored and serialized directly.
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
    /// Each track is counted ONLY ONCE (subject to bounded track history), in
    /// the observation where it first makes contact. It is not
    /// counted again if it stays in the area or leaves and re-enters.
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
    @Default(0) @RoundedDouble() double passBy,

    /// Number of unique tracks that stayed inside the area continuously for at
    /// least the configured stagnant threshold. Absences shorter than the
    /// disappear threshold do not restart the clock.
    ///
    /// Each track is counted ONLY ONCE (subject to bounded track history), in
    /// the observation where it reaches the threshold.
    ///
    /// Example: the threshold is 30 seconds and a track enters at 12:04:50. It
    /// reaches 30 seconds at 12:05:20, so stagnant increases by 1 in the
    /// 12:05-12:10 observation (not in 12:00-12:05, where the stay started).
    ///
    /// This metric is additive across observations.
    ///
    /// Limitation: a new track ID is a new track and is counted again.
    @Default(0) @RoundedDouble() double stagnant,

    /// Number of tracks whose initial position was outside this area and were
    /// later observed inside it. Applies only to local areas; the global area
    /// always reports zero.
    ///
    /// Each track ID is counted once in the observation where it first enters.
    /// This is additive across observations, subject to bounded history.
    @Default(0) @RoundedDouble() double entry,

    /// Number of tracks whose initial position was inside this area and were
    /// later observed outside it. Applies only to local areas; the global area
    /// always reports zero.
    ///
    /// Each track ID is counted once in the observation where it first exits.
    /// This is additive across observations, subject to bounded history.
    @Default(0) @RoundedDouble() double exit,

    /// Number of tracks first detected with their center position inside this
    /// area.
    ///
    /// Applies to both local areas and the global monitored scene.
    /// Each track ID is counted once in the observation where it first appears.
    /// This is additive across observations, subject to bounded history.
    @Default(0) @RoundedDouble() double appear,

    /// Number of tracks last seen inside the area and then absent long enough
    /// to satisfy the configured disappear threshold.
    ///
    /// Applies to both local areas and the global monitored scene.
    ///
    /// For the global area, this means that the track was lost from scene
    /// tracking; it does not mean that the object was confirmed to have
    /// exited the camera view.
    ///
    /// Each track ID is counted once while retained in tracker history. A
    /// returning track may add another dwell sample but no second disappear.
    /// Visits closed by source dropout, pause, clock jump, or stop do not count
    /// as disappear. For a local area, this also fires when the track leaves
    /// the area but remains visible elsewhere.
    @Default(0) @RoundedDouble() double disappear,

    /// Number of occupancy samples in this observation.
    ///
    /// Occupancy is sampled once per frame, so this equals
    /// [Observation.frameCount]. It is kept here for convenience so each area
    /// can be read on its own.
    ///
    /// Its sum and sample count are additive across child observations.
    @Default(0) int occupancySampleCount,

    /// Sum of the object counts across all occupancy samples.
    ///
    /// Example: samples of 2, 3, and 1 objects give a sum of 6 and a count
    /// of 3.
    ///
    /// Additive across child observations.
    @Default(0) int occupancySum,

    /// Sum of the squared object counts across all occupancy samples.
    ///
    /// Example: samples of 2, 3, and 1 objects give 4 + 9 + 1 = 14.
    ///
    /// Additive across child observations. Together with
    /// [occupancySum] and [occupancySampleCount] it gives the variance:
    ///
    /// variance = occupancySumSquares / occupancySampleCount - mean²
    ///
    /// The sum, sum of squares, and count remain the source of truth; the mean
    /// and variance are derived from them.
    @Default(0) int occupancySumSquares,

    /// Mean number of objects in the area per sample, or 0 when there are no
    /// samples.
    ///
    /// occupancyMean = occupancySum / occupancySampleCount
    ///
    /// This is an average over frames, not over time, so no time-weighting is
    /// applied. The sum and count remain the source of truth; this field is
    /// included for convenience.
    /// Maximum occupancy observed in any sample during this observation.
    ///
    /// For an aggregated observation, this is the maximum value from its
    /// child observations.
    @Default(0) int occupancyMax,

    /// Most recent occupancy sample observed for this area. When no valid
    /// occupancy sample exists, this is zero; use [occupancySampleCount] to
    /// distinguish this from a measured zero.
    ///
    /// This is state, not an additive metric; an aggregated observation
    /// should retain the value from its latest child observation.
    @Default(0) int occupancyLast,

    // ===== DWELL: how long visitors stay. One sample per finished visit. =====

    /// Number of finished visits recorded in this observation.
    ///
    /// A visit is finished when the track has been gone from the area for the
    /// disappear threshold. The whole visit is recorded ONCE, in the observation
    /// where it is confirmed finished (not where it started).
    ///
    /// Example: a visit from 12:03 to 12:13 adds one sample of 600 s to the
    /// 12:10-12:15 observation and nothing to the earlier ones.
    ///
    /// A visit that spans midnight is recorded in the day it finishes. Visits
    /// still open when the source drops out, monitoring pauses, the clock
    /// jumps, or monitoring stops are discarded without a dwell sample because
    /// the interruption does not establish when the track actually left.
    /// Resetting or changing interest areas also discards open visits.
    ///
    /// Additive across child observations.
    @Default(0) int dwellSampleCount,

    /// Sum of dwell durations, in whole seconds, across all dwell samples.
    ///
    /// Each dwell sample is rounded to whole seconds before it is added.
    ///
    /// Additive across child observations.
    @Default(0) int dwellSumSeconds,

    /// Mean dwell time in seconds across all dwell samples, or 0 when there
    /// are no samples.
    ///
    /// dwellMeanSeconds = dwellSumSeconds / dwellSampleCount
    ///
    /// No time-weighting is applied. The sum and count remain the source of
    /// truth; this field is included for convenience.
    /// Longest finished visit recorded in this observation, in whole seconds.
    ///
    /// Attributed to the observation where the visit finished. For an aggregated
    /// observation, this is the maximum of its child observations.
    @Default(0) int dwellMaxSeconds,

    /// Number of finished visits in each duration bucket, in order:
    /// `<5s, 5-15s, 15-60s, 1-5min, 5-10min, 10-30min, 30-60min, >=60min`.
    ///
    /// Each bucket includes its lower edge and excludes its upper edge (a 300 s
    /// visit is in 5-10min, and a 3600 s visit is in >=60min). The edges are
    /// fixed by [kDwellBucketEdgesSeconds]; the list always has [kDwellBucketCount]
    /// Additive across child observations: add the lists element by element.
    @Default([0, 0, 0, 0, 0, 0, 0, 0]) List<int> dwellHistogram,

    // ===== PRESENCE: time spent inside during each observation. =====
    // Use it to find the busiest or most-lingering time and to compare areas.
    // Do NOT read it as visit length.

    /// Number of tracks present for a positive amount of time during this
    /// observation. Each present track is one sample.
    ///
    /// A track that stays across several observations is a separate sample in
    /// each one, so at hour, day or longer levels this is a count of
    /// track-observation pairs, not of distinct tracks (use passBy for that).
    ///
    /// Additive across child observations.
    @Default(0) int presenceSampleCount,

    /// Total seconds that tracks spent inside the area during this observation
    /// (track-seconds, rounded to whole seconds per observation).
    ///
    /// Example: a track inside from 12:03 to 12:13 adds 120 s to 12:00-12:05,
    /// 300 s to 12:05-12:10 and 180 s to 12:10-12:15.
    ///
    /// When `Observation.coveredSeconds` is positive,
    /// presenceSumSeconds / coveredSeconds is the time-weighted average number
    /// of tracks in the area while detection data was valid. Unlike
    /// [occupancyMean], it does not depend on frame rate.
    ///
    /// Additive across child observations.
    @Default(0) int presenceSumSeconds,

    /// Mean seconds each present track spent inside during this observation, or
    /// 0 when there are no samples.
    ///
    /// presenceMeanSeconds = presenceSumSeconds / presenceSampleCount
    ///
    /// This is not visit length. The sums and count remain the source of truth;
    /// this field is included for convenience.
  }) = _AreaMetrics;

  /// the mean occupancy during this observation.
  double get occupancyMean => _mean(occupancySum, occupancySampleCount);

  /// the mean dwell time during this observation.
  double get dwellMeanSeconds => _mean(dwellSumSeconds, dwellSampleCount);

  /// the mean presence time during this observation.
  double get presenceMeanSeconds => _mean(presenceSumSeconds, presenceSampleCount);

  double get occupancyVariance {
    if (occupancySampleCount == 0) return 0;
    final mean = occupancySum / occupancySampleCount;
    final v = occupancySumSquares / occupancySampleCount - mean * mean;
    return v < 0 ? 0 : v; // guard against rounding noise
  }

  AreaMetricsPayload toPayload() => AreaMetricsPayload(
    areaId: areaId,
    areaName: areaName,
    passBy: passBy.toInt(), // we only send payload on 5 minutes observation,so event must be int no decimals.
    stagnant: stagnant.toInt(),
    entry: entry.toInt(),
    exit: exit.toInt(),
    appear: appear.toInt(),
    disappear: disappear.toInt(),
    occupancySampleCount: occupancySampleCount,
    occupancySum: occupancySum,
    occupancySumSquares: occupancySumSquares,
    occupancyMax: occupancyMax,
    occupancyLast: occupancyLast,
    occupancyMean: occupancyMean,
    occupancyVariance: occupancyVariance,
    dwellSampleCount: dwellSampleCount,
    dwellSumSeconds: dwellSumSeconds,
    dwellMeanSeconds: dwellMeanSeconds,
    dwellMaxSeconds: dwellMaxSeconds,
    dwellHistogram: dwellHistogram,
    presenceSampleCount: presenceSampleCount,
    presenceSumSeconds: presenceSumSeconds,
    presenceMeanSeconds: presenceMeanSeconds,
  );

  double _mean(num sum, int count) => count == 0 ? 0 : sum / count;

  factory AreaMetrics.fromJson(Map<String, dynamic> json) => _$AreaMetricsFromJson(json);
}
