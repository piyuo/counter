// TOC:
//  - TelemetryPayload: top-level wire model for one observation window
//  - AreaPayload:       per-area analytics within that window

import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry_payload.freezed.dart';
part 'telemetry_payload.g.dart';

const int kCurrentSchemaVersion = 1;

/// Returns a unique identifier for this payload, suitable for use as a queue row primary key.
String getPayloadId(TelemetryPayload payload) => '${payload.session}-${payload.sequence}';

DateTime getPayloadEndUtc(TelemetryPayload payload) => payload.startUtc.add(Duration(minutes: 5));

String getBusinessDateFromStartBusiness(TelemetryPayload payload) =>
    '${payload.startBusiness.year.toString().padLeft(4, '0')}-${payload.startBusiness.month.toString().padLeft(2, '0')}-${payload.startBusiness.day.toString().padLeft(2, '0')}';

/// Wire model sent to the backend.  Decoupled from [WindowCountState] so the
/// transport format can evolve independently of the detection engine.
@freezed
sealed class TelemetryPayload with _$TelemetryPayload {
  const factory TelemetryPayload({
    /// Identifier of the counting session this observation window belongs to.
    required String session,

    /// Sequential number of this observation window within the session.
    ///
    /// Starts at 1.
    required int sequence,

    /// Beginning of the observation window in UTC.
    ///
    /// This is the canonical timestamp used for synchronization,
    /// upload ordering, and auditing.
    required DateTime startUtc,

    /// Beginning of the same observation window expressed using the
    /// site's business clock.
    ///
    /// This timestamp is used for reports, grouping by business day,
    /// and business-hour analysis.
    required DateTime startBusiness,

    /// businessDate MUST equal the date portion of [startBusiness].
    ///
    /// It is stored separately because it is queried frequently and because
    /// payloads for the same business day are typically grouped into a single file.
    ///
    /// Example:
    /// 2026-06-24
    required String businessDate,

    /// Total number of frames processed in this window.
    required int frameCount,

    /// Exact total duration of missing input within this window (seconds).
    required int missingSec,

    /// Mean confidence (%) across all tracked-object samples in this window.
    @RoundedDouble2() required double confidence,

    /// True when the observation window was interrupted before completion.
    required bool isPartial,

    /// Fraction of the window that contained valid detection data (0.0–1.0).
    @RoundedDouble2() required double coverage,

    /// Average processed frames per second over covered (non-missing) time.
    @RoundedDouble2() required double fps,

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
    required int areaId,

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
    @RoundedDouble2() @Default(0) double avgOccupancy,

    /// Max occupancy observed at any sample in the window.
    @Default(0) int maxOccupancy,

    /// Mean dwell time in seconds across all dwell observations.
    @RoundedDouble2() @Default(0) double avgDwellSec,

    /// Maximum observed dwell time in rounded seconds.
    @Default(0) int maxDwellSec,
  }) = _AreaPayload;

  factory AreaPayload.fromJson(Map<String, dynamic> json) => _$AreaPayloadFromJson(json);
}

double _round(double value, int places) {
  final factor = pow(10, places).toDouble();
  return (value * factor).round() / factor;
}

class RoundedDouble2 implements JsonConverter<double, dynamic> {
  const RoundedDouble2();
  @override
  double fromJson(dynamic json) => (json as num).toDouble();
  @override
  double toJson(double value) => _round(value, 2);
}
