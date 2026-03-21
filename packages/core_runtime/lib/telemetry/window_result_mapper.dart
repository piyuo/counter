// TOC:
//  - WindowResultMapper: converts vision.WindowCountState → TelemetryPayload
//
// Note: generates a fresh UUID v4 payloadId for each mapped result so the
// server can de-duplicate retried deliveries.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;
import 'package:uuid/uuid.dart';

/// Converts a [vision.WindowCountState] produced by the detection engine into the
/// [core_domain.TelemetryPayload] wire model used by the delivery pipeline.
class WindowResultMapper {
  const WindowResultMapper({required this.deviceId});

  /// Opaque device identifier included in every payload.
  final String deviceId;

  static const _uuid = Uuid();

  core_domain.TelemetryPayload map(vision.WindowCountState result) {
    final areas = result.areas.entries.map((entry) {
      final m = entry.value;
      return core_domain.AreaPayload(
        id: entry.key,
        passBy: m.passBy,
        entry: m.entry,
        exit: m.exit,
        occupancyAvg: m.occupancyAvg,
        occupancyPeak: m.occupancyPeak,
        dwellAvgSec: m.dwellAvgSec,
        dwellPeakSec: m.dwellPeakSec,
      );
    }).toList();

    return core_domain.TelemetryPayload(
      id: _uuid.v4(),
      startUtc: result.startUtc,
      endUtc: result.endUtc,
      sessionId: result.sessionId,
      windowIndex: result.windowIndex,
      frameCount: result.frameCount,
      missingDurationMs: result.missingDuration.inMilliseconds,
      confidence: result.confidence,
      isPartial: result.coverageRatio < 1.0,
      coverageRatio: result.coverageRatio,
      fps: result.fps,
      areas: areas,
    );
  }
}
