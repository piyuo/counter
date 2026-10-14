// TOC
// Observation model
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
import 'area_metrics.dart';

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
