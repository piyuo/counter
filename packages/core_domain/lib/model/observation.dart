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
import 'activity.dart';
import 'observation_granularity.dart';
import 'observation_payload.dart';

part 'observation.freezed.dart';
part 'observation.g.dart';

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
/// Ratio getters are derived from their source values and are not serialized.
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
    required int year, // e.g., 2026 for a 5-minute observation
    required int month, // 1-12 for a 5-minute observation
    required int day, // 1-31 for a 5-minute observation
    required int hour, // 0-23 for a 5-minute observation
    required int minute, // 0-55 for a 5-minute observation, since Observations must align to wall-clock 5-minute intervals, e.g., 0, 5, 10, ..., 55
    /// Sum of tracked-object confidence ratios, each in the range 0.0-1.0.
    ///
    /// Additive across child observations. The sum is rounded to two decimal
    /// places when serialized to JSON.
    @Default(0) @RoundedDouble() double confidenceSum,

    /// Number of tracked-object confidence samples contributing to this
    /// observation.
    ///
    /// Additive across child observations.
    @Default(0) int confidenceSampleCount,

    /// Number of seconds with valid detection data in this observation.
    ///
    /// For example, a 5-minute window has a maximum of 300 covered seconds,
    /// minus any time when detection data was missing.
    ///
    /// Additive across child observations.
    /// Slots with few contributors look as strong as well-sampled ones.
    /// A slot present in 1 of 30 days is averaged over that one day, with no signal that it’s thin.
    /// You could weight by coveredSeconds to know how well-sampled a slot is.
    @Default(0) int coveredSeconds,

    /// Per-area analytics.
    ///
    /// One entry exists for each configured interest area, including the
    /// global area.
    required List<Activity> areas,

    /// Total number of frames processed during this observation.
    ///
    /// Additive across child observations.
    required int frameCount,

    /// Optional override for normalized profiles whose calendar date does not
    /// represent their weekday/weekend category. Regular observations derive
    /// this value from their business-local date.
    @JsonKey(name: 'isWeekend', includeIfNull: false) bool? weekendOverride,
  }) = _Observation;
  factory Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);

  /// Mean confidence ratio, or zero when there are no confidence samples.
  ///
  /// Derived from [confidenceSum] / [confidenceSampleCount].
  double get confidenceRatio => confidenceSampleCount == 0 ? 0 : confidenceSum / confidenceSampleCount;

  /// Fraction of expected duration with valid detection data, or zero when
  /// [expectedSeconds] is zero.
  double get coverageRatio => expectedSeconds == 0 ? 0 : coveredSeconds / expectedSeconds;

  /// Expected duration, in seconds, of this observation's period.
  ///
  /// Calendar periods use UTC arithmetic so device time zone and DST do not
  /// change the business-time duration.
  int get expectedSeconds => granularity.expectedSecondsFor(year, month);

  /// Estimates the total count for the full observation period,
  /// assuming missing time slots have the same average activity
  /// as the observed slots.
  ///
  /// Returns null if no valid observations are available.
  double estimateTotal(double recordedCount) {
    if (coverageRatio <= 0) return 0;
    return recordedCount / coverageRatio;
  }

  /// Numeric ID made from the four-digit year and two-digit date/time
  /// components. Components with a value of -1 are encoded as `00` to
  /// preserve their positions.
  ///
  /// IDs are unique only within one [granularity].
  int get id => keyFromComponents([year, month, day, hour, minute]);

  /// Local wall-clock date/time represented by this observation.
  ///
  /// Components with a value of -1 fall back to the start of the period:
  /// a month observation uses day 1, and a year observation uses January 1.
  ///
  /// Use this only for display and local calendar operations on the
  /// monitoring device.
  DateTime get dateTime =>
      DateTime(year, month > 0 ? month : 1, day > 0 ? day : 1, hour >= 0 ? hour : 0, minute >= 0 ? minute : 0);

  /// Whether the business-local date falls on Saturday or Sunday.
  bool get isWeekend => weekendOverride ?? dateTime.weekday >= DateTime.saturday;

  /// Returns year, month, and day; components with a value of -1 are encoded as `00`.
  int get dateKey => keyFromComponents([year, month, day]);

  /// Returns hour and minute as an integer; components with a value of -1 are encoded as `00`.
  ///
  /// Only compare time keys between observations of the same [granularity].
  int get timeKey => keyFromComponents([hour, minute]);

  /// Returns year, month, day, and hour; components with a value of -1 are encoded as `00`.
  int get dateHourKey => keyFromComponents([year, month, day, hour]);

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

  ObservationPayload toPayload() => ObservationPayload(
    granularity: granularity.name,
    id: id,
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    businessDate: businessDate,
    isWeekend: isWeekend,
    confidenceRatio: confidenceRatio,
    expectedSeconds: expectedSeconds,
    coveredSeconds: coveredSeconds,
    coverageRatio: coverageRatio,
    areas: areas.map((area) => area.toPayload()).toList(),
    frameCount: frameCount,
  );

  int compareTo(Observation other) {
    if (granularity != other.granularity) {
      throw ArgumentError.value(
        other.granularity,
        'other',
        'Cannot compare ${granularity.name} with ${other.granularity.name} observations',
      );
    }
    return id.compareTo(other.id);
  }
}
