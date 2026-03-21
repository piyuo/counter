// TOC:
//  - TelemetryPayload: top-level wire model for one observation window
//  - AreaPayload:       per-area analytics within that window

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry_payload.freezed.dart';
part 'telemetry_payload.g.dart';

const int kCurrentSchemaVersion = 1;

/// Wire model sent to the backend.  Decoupled from [WindowCountState] so the
/// transport format can evolve independently of the detection engine.
@freezed
sealed class TelemetryPayload with _$TelemetryPayload {
  const factory TelemetryPayload({
    /// UUID v4 — used by the server for idempotent de-duplication on retry.
    required String id,

    /// Window start time in UTC.
    required DateTime startUtc,

    /// Window end time in UTC.
    required DateTime endUtc,

    /// Identifier of the counting session this window belongs to.
    required String sessionId,

    /// 1-based index of this window within [sessionId].
    required int windowIndex,

    /// Total number of frames processed in this window.
    required int frameCount,

    /// Exact total duration of missing input within this window (milliseconds).
    required int missingDurationMs,

    /// Mean confidence (%) across all tracked-object samples in this window.
    required double confidence,

    /// True when the observation window was interrupted before completion.
    required bool isPartial,

    /// Fraction of the window that contained valid detection data (0.0–1.0).
    required double coverageRatio,

    /// Average processed frames per second over covered (non-missing) time.
    required double fps,

    /// Per-area analytics.  One entry per configured interest area.
    required List<AreaPayload> areas,
  }) = _TelemetryPayload;

  /// schemaVersion is used by the backend to identify the format of incoming payloads.
  /// Payload serializer must pack this into payload container.
  static int get schemaVersion => 1;

  factory TelemetryPayload.fromJson(Map<String, dynamic> json) => _$TelemetryPayloadFromJson(json);
}

@freezed
sealed class AreaPayload with _$AreaPayload {
  const factory AreaPayload({
    /// Index matching the configured interest-area ID.
    required int id,

    /// Objects detected moving past the area without entering it.
    @Default(0) int passBy,

    /// Objects that stayed within the area.
    @Default(0) int stay,

    /// Objects that crossed the threshold into the area.
    @Default(0) int entry,

    /// Objects that crossed the threshold out of the area.
    @Default(0) int exit,

    /// Objects that appeared in the area.
    @Default(0) int appear,

    /// Objects that disappeared from the area.
    @Default(0) int disappear,

    /// Mean occupancy across discrete frame samples in this window.
    ///
    /// This is a simple arithmetic mean (sum of sampled occupancies / number of
    /// samples), with no time-weighting.
    @Default(0) double occupancyAvg,

    /// Peak occupancy observed at any sample in the window.
    @Default(0) int occupancyPeak,

    /// Mean dwell time in seconds across all dwell observations.
    @Default(0) double dwellAvgSec,

    /// Peak dwell time in rounded seconds.
    @Default(0) int dwellPeakSec,
  }) = _AreaPayload;

  factory AreaPayload.fromJson(Map<String, dynamic> json) => _$AreaPayloadFromJson(json);
}
