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

part 'observation.freezed.dart';
part 'observation.g.dart';

/// The granularity of an [Observation].
///
/// The same [Observation] model is used at every aggregation level:
/// 5 minutes → hour → day → month → year.
enum ObservationGranularity { minutes5, hour, day, month, year }

const int kGlobalAreaId = 0;

/// Default duration of a raw Vision Engine observation.
const kWindowDuration = Duration(minutes: 5);

/// Observation of a period of time.
///
/// The same model is used for every aggregation level:
///
/// - 5-minute observation
/// - hourly observation
/// - daily observation
/// - monthly observation
/// - yearly observation
///
/// Ratio and average fields are rounded to 2 decimals when written to JSON.
@freezed
sealed class Observation with _$Observation {
  const Observation._();

  const factory Observation({
    /// Aggregation interval represented by this observation.
    ///
    /// Determines which of [hour] and [minute] are used (see the table on
    /// [year]).
    @Default(ObservationGranularity.minutes5) ObservationGranularity granularity,

    /// Identifies the date represented by this observation.
    ///
    /// Business (local wall-clock) date. See "Time basis and DST" at the top
    /// of this file.
    ///
    /// Components that do not apply to the [granularity] are -1:
    ///
    /// - minutes5: year=2026, month=06, day=24, hour=23, minute=05
    /// - hour:     year=2026, month=06, day=24, hour=23, minute=-1
    /// - day:      year=2026, month=06, day=24, hour=-1, minute=-1
    /// - month:    year=2026, month=06, day=-1, hour=-1, minute=-1
    /// - year:     year=2026, month=-1, day=-1, hour=-1, minute=-1
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,

    /// Sum of confidence ratios (0.0-1.0), one per tracked-object
    /// confidence sample contributing to this observation.
    ///
    /// Additive across child observations. there is no round when summing but will round when written to JSON to avoid 92.99999999 issue
    @RoundedDouble() required double confidenceRatioSum,

    /// Number of tracked-object confidence samples contributing to this
    /// observation.
    ///
    /// Additive across child observations.
    required int confidenceSampleCount,

    /// Mean confidence as a ratio in the range 0.0-1.0, or 0 when there are
    /// no samples.
    ///
    /// confidenceRatio = confidenceRatioSum / confidenceSampleCount
    ///
    /// The sum and count remain the source of truth; this field is included
    /// for convenience.
    @RoundedDouble() required double confidenceRatio,

    /// Number of seconds with valid detection data in this observation.
    ///
    /// For example, a 5-minute window has a maximum of 300 covered seconds,
    /// minus any time when detection data was missing.
    ///
    /// Additive across child observations.
    required int coveredSeconds,

    /// Expected duration, in seconds, of this observation's period.
    ///
    /// For example, a 5-minute window has 300 expected seconds.
    ///
    /// Additive across child observations.
    required int expectedSeconds,

    /// Fraction of the observation period that contained valid detection
    /// data, in the range 0.0-1.0, or 0 when [expectedSeconds] is 0.
    ///
    /// coverageRatio = coveredSeconds / expectedSeconds
    ///
    /// For aggregated observations, sum the seconds first, then divide.
    /// Do not average the ratios of child observations. The seconds remain
    /// the source of truth; this field is included for convenience.
    @RoundedDouble() required double coverageRatio,

    /// Per-area analytics.
    ///
    /// One entry exists for each configured interest area, including the
    /// global area.
    required List<AreaMetrics> areas,

    /// Total number of frames processed during this observation.
    ///
    /// Additive across child observations.
    required int frameCount,
  }) = _Observation;

  factory Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);

  /// Numeric ID made from the four-digit year and two-digit date/time
  /// components. Components with a value of -1 are encoded as `00` to
  /// preserve their positions.
  ///
  /// IDs are unique only within one [granularity].
  int get id => _keyFromComponents([year, month, day, hour, minute]);

  /// Local wall-clock date/time represented by this observation.
  ///
  /// Components with a value of -1 fall back to the start of the period:
  /// a month observation uses day 1, and a year observation uses January 1.
  ///
  /// Use this only for display and local calendar operations on the
  /// monitoring device.
  DateTime get dateTime =>
      DateTime(year, month > 0 ? month : 1, day > 0 ? day : 1, hour >= 0 ? hour : 0, minute >= 0 ? minute : 0);

  /// Returns year, month, and day; components with a value of -1 are encoded as `00`.
  int get dateKey => _keyFromComponents([year, month, day]);

  /// Returns hour and minute as an integer; components with a value of -1 are encoded as `00`.
  ///
  /// Only compare time keys between observations of the same [granularity].
  int get timeKey => _keyFromComponents([hour, minute]);

  /// Returns year, month, day, and hour; components with a value of -1 are encoded as `00`.
  int get dateHourKey => _keyFromComponents([year, month, day, hour]);

  int get missingSeconds => expectedSeconds - coveredSeconds;

  /// String form of the business date. The format depends on [granularity]:
  ///
  /// - minutes5, hour, day: `2026-08-26`
  /// - month: `2026-08`
  /// - year: `2026`
  String get businessDate => switch (granularity) {
    ObservationGranularity.minutes5 || ObservationGranularity.hour || ObservationGranularity.day =>
      '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}-'
          '${day.toString().padLeft(2, '0')}',

    ObservationGranularity.month =>
      '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}',

    ObservationGranularity.year => year.toString().padLeft(4, '0'),
  };

  String get businessDateTime => switch (granularity) {
    ObservationGranularity.minutes5 || ObservationGranularity.hour || ObservationGranularity.day =>
      '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}-'
          '${day.toString().padLeft(2, '0')} '
          '${(hour >= 0 ? hour : 0).toString().padLeft(2, '0')}:'
          '${(minute >= 0 ? minute : 0).toString().padLeft(2, '0')}',

    ObservationGranularity.month =>
      '${year.toString().padLeft(4, '0')}-'
          '${month.toString().padLeft(2, '0')}',

    ObservationGranularity.year => year.toString().padLeft(4, '0'),
  };

  @override
  String toString() {
    return 'Observation('
        'granularity: ${granularity.name}, '
        'year: $year, '
        'month: $month, '
        'day: $day, '
        'hour: $hour, '
        'minute: $minute, '
        'frameCount: $frameCount, '
        'confidenceRatioSum: ${confidenceRatioSum.toStringAsFixed(2)}, '
        'confidenceSampleCount: $confidenceSampleCount, '
        'confidenceRatio: ${confidenceRatio.toStringAsFixed(2)}, '
        'expectedSeconds: $expectedSeconds, '
        'coveredSeconds: $coveredSeconds, '
        'coverageRatio: ${coverageRatio.toStringAsFixed(2)}, '
        'areas: [${areas.join(', ')}]'
        ')';
  }
}

int _keyFromComponents(Iterable<int> components) {
  final key = components.map((component) => component == -1 ? '00' : component.toString().padLeft(2, '0')).join();
  return key.isEmpty ? 0 : int.parse(key);
}

/// Analytics metrics for one interest area within an [Observation].
///
/// Most event metrics are additive. For example, the hourly [passBy] count
/// can be calculated by summing the [passBy] values from its twelve
/// 5-minute observations.
///
/// Note: "unique" event counts are unique per observation window only. A track
/// that spans two windows is counted once in each, so summed values are event
/// counts, not the number of distinct people or vehicles.
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

    /// Number of unique tracks that made at least one in-area contact during
    /// this observation.
    ///
    /// A track is counted once per observation, on its first in-area contact.
    ///
    /// This metric is additive. For example, summing the passBy values from
    /// twelve 5-minute observations produces the hourly passBy count.
    required int passBy,

    /// Number of unique tracks that remained inside the area continuously for
    /// at least the configured stagnant threshold.
    ///
    /// Each qualifying track is counted once per observation.
    ///
    /// This metric is additive across observations.
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

    /// Mean number of objects in the area per sample, or 0 when there are no
    /// samples.
    ///
    /// occupancyAvg = occupancySampleSum / occupancySampleCount
    ///
    /// This is an average over frames, not over time, so no time-weighting is
    /// applied. The sum and count remain the source of truth; this field is
    /// included for convenience.
    @RoundedDouble() required double occupancyAvg,

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

    /// Sum of dwell durations, in whole seconds, across all dwell samples.
    ///
    /// Each dwell sample is rounded to whole seconds before it is added.
    ///
    /// Additive across child observations.
    required int dwellSumSeconds,

    /// Number of dwell samples included in this observation.
    ///
    /// Additive across child observations.
    required int dwellSampleCount,

    /// Mean dwell time in seconds across all dwell samples, or 0 when there
    /// are no samples.
    ///
    /// dwellAvgSeconds = dwellSumSeconds / dwellSampleCount
    ///
    /// No time-weighting is applied. The sum and count remain the source of
    /// truth; this field is included for convenience.
    @RoundedDouble() required double dwellAvgSeconds,

    /// Longest single dwell time, in whole seconds, observed during this
    /// observation.
    ///
    /// Each dwell time is rounded to whole seconds before it is compared.
    ///
    /// For an aggregated observation, this is the maximum value from its
    /// child observations.
    required int dwellMaxSeconds,
  }) = _AreaMetrics;

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
      'occupancyAvg: ${occupancyAvg.toStringAsFixed(2)}, '
      'occupancyMax: $occupancyMax, '
      'occupancyLast: $occupancyLast, '
      'dwellSumSeconds: $dwellSumSeconds, '
      'dwellSampleCount: $dwellSampleCount, '
      'dwellAvgSeconds: ${dwellAvgSeconds.toStringAsFixed(2)}, '
      'dwellMaxSeconds: $dwellMaxSeconds'
      ')';
}
