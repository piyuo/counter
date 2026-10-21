import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/round_double.dart';
import 'area_metrics_payload.dart';

part 'observation_payload.freezed.dart';
part 'observation_payload.g.dart';

/// Current version for entire app.
const int kSchemaVersion = 2;

/// Global area ID used in per-area analytics.
const int kGlobalAreaId = 0;

/// Default duration of a raw Vision Engine observation.
const kWindowDuration = Duration(minutes: 5);

@freezed
sealed class ObservationPayload with _$ObservationPayload {
  const ObservationPayload._();

  const factory ObservationPayload({
    /// Aggregation interval represented by this observation.
    ///
    /// Determines which of [hour] and [minute] are used (see the table on
    /// [year]).
    @Default('') String granularity,

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
    required int id, // Unique identifier for this observation payload
    /// String form of the business date. The format depends on [granularity]:
    ///
    /// - minutes5, hour, day: `2026-08-26`
    /// - month: `2026-08`
    /// - year: `2026`
    @Default('') String businessDate,

    /// Mean confidence as a ratio in the range 0.0-1.0, or 0 when there are
    /// no samples.
    ///
    /// confidenceRatio = confidenceRatioSum / confidenceSampleCount
    ///
    /// The sum and count remain the source of truth; this field is included
    /// for convenience.
    @Default(0) @RoundedDouble() double confidenceRatio,

    /// Expected duration, in seconds, of this observation's period.
    ///
    /// For example, a 5-minute window has 300 expected seconds.
    ///
    /// Additive across child observations.
    @Default(0) int expectedSeconds,

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

    /// Fraction of the observation period that contained valid detection
    /// data, in the range 0.0-1.0, or 0 when [expectedSeconds] is 0.
    ///
    /// coverageRatio = coveredSeconds / expectedSeconds
    ///
    /// For aggregated observations, sum the seconds first, then divide.
    /// Do not average the ratios of child observations. The seconds remain
    /// the source of truth; this field is included for convenience.
    @Default(0) @RoundedDouble() double coverageRatio,

    /// Per-area analytics.
    ///
    /// One entry exists for each configured interest area, including the
    /// global area.
    required List<AreaMetricsPayload> areas,

    /// Total number of frames processed during this observation.
    ///
    /// Additive across child observations.
    required int frameCount,
  }) = _ObservationPayload;

  /// Returns year, month, and day; components with a value of -1 are encoded as `00`.
  int get dateKey => keyFromComponents([year, month, day]);

  /// Returns hour and minute as an integer; components with a value of -1 are encoded as `00`.
  ///
  /// Only compare time keys between observations of the same [granularity].
  int get timeKey => keyFromComponents([hour, minute]);

  /// Returns year, month, day, and hour; components with a value of -1 are encoded as `00`.
  int get dateHourKey => keyFromComponents([year, month, day, hour]);

  int get missingSeconds => expectedSeconds - coveredSeconds;

  /// Local wall-clock date/time represented by this observation.
  ///
  /// Components with a value of -1 fall back to the start of the period:
  /// a month observation uses day 1, and a year observation uses January 1.
  ///
  /// Use this only for display and local calendar operations on the
  /// monitoring device.
  DateTime get dateTime =>
      DateTime(year, month > 0 ? month : 1, day > 0 ? day : 1, hour >= 0 ? hour : 0, minute >= 0 ? minute : 0);

  factory ObservationPayload.fromJson(Map<String, dynamic> json) => _$ObservationPayloadFromJson(json);
}

int keyFromComponents(Iterable<int> components) {
  final key = components.map((component) => component == -1 ? '00' : component.toString().padLeft(2, '0')).join();
  return key.isEmpty ? 0 : int.parse(key);
}
