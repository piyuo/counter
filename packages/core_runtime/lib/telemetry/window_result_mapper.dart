// TOC:
//  - WindowResultMapper: converts vision.WindowCountState → TelemetryPayload
//
// Note: generates a fresh UUID v4 payloadId for each mapped result so the
// server can de-duplicate retried deliveries.

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_vision/flutter_vision.dart' as vision;

/// Converts a [vision.WindowCountState] produced by the detection engine into the
/// [core_domain.TelemetryPayload] wire model used by the delivery pipeline.
class WindowResultMapper {
  const WindowResultMapper({required this.deviceId});

  /// Opaque device identifier included in every payload.
  final String deviceId;

  core_domain.TelemetryPayload map(vision.WindowCountState windowCount) {
    final areas = windowCount.areas.entries.map((entry) {
      final m = entry.value;
      return core_domain.AreaPayload(
        areaId: m.areaId,
        areaName: m.areaName,
        passBy: m.passBy,
        entry: m.entry,
        exit: m.exit,
        avgOccupancy: m.avgOccupancy,
        maxOccupancy: m.maxOccupancy,
        avgDwellSec: m.avgDwellSec,
        maxDwellSec: m.maxDwellSec,
      );
    }).toList();

    // Derive businessDate from startBusiness
    final sb = windowCount.startBusiness;
    final businessDate =
        '${sb.year.toString().padLeft(4, '0')}-${sb.month.toString().padLeft(2, '0')}-${sb.day.toString().padLeft(2, '0')}';

    // Calculate coverage: fraction of the window with valid data
    // Observation windows are 5 minutes (300 seconds)
    const int windowDurationSec = 300;
    final int missingDurationSec = windowCount.missingDuration.inSeconds;
    final double coverage = (windowDurationSec - missingDurationSec) / windowDurationSec;

    // Calculate actual fps over the covered period
    final int coveredDurationSec = windowDurationSec - missingDurationSec;
    final double actualFps = coveredDurationSec > 0 ? windowCount.frameCount / coveredDurationSec : windowCount.fps;

    return core_domain.TelemetryPayload(
      session: windowCount.session,
      sequence: windowCount.sequence,
      startUtc: windowCount.startUtc,
      startBusiness: windowCount.startBusiness,
      businessDate: businessDate,
      frameCount: windowCount.frameCount,
      missingSec: windowCount.missingDuration.inSeconds,
      confidence: windowCount.confidence,
      isPartial: windowCount.doneRatio < 1.0,
      coverage: coverage,
      fps: actualFps,
      areas: areas,
    );
  }
}
