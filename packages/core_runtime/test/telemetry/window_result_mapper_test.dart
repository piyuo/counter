// TOC:
//  - WindowResultMapper — map: populates top-level TelemetryPayload fields
//  - WindowResultMapper — map: maps each area correctly
//  - WindowResultMapper — map: generates a unique payloadId per call
//  - WindowResultMapper — map: propagates deviceId
//  - WindowResultMapper — map: handles empty areas map

import 'package:core_runtime/telemetry/window_result_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

vision.WindowCountState _result({Map<int, vision.AreaMetrics>? areas}) => vision.WindowCountState(
  startUtc: DateTime.utc(2026, 3, 1, 10, 0),
  endUtc: DateTime.utc(2026, 3, 1, 11, 0),
  sessionId: 'session-1',
  windowIndex: 1,
  frameCount: 7200,
  confidence: 87.5,
  areas:
      areas ??
      {
        1: vision.AreaMetrics(
          passBy: 5,
          entry: 3,
          exit: 2,
          occupancyAvg: 1.5,
          occupancyPeak: 4,
          dwellAvgSec: 45.0,
          dwellPeakSec: 200,
        ),
      },
  missingDuration: const Duration(seconds: 72),
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const mapper = WindowResultMapper(deviceId: 'device-xyz');

  group('WindowResultMapper', () {
    test('copies top-level state fields and derived metrics', () {
      final result = _result();
      final payload = mapper.map(result);
      expect(payload.startUtc, result.startUtc);
      expect(payload.endUtc, result.endUtc);
      expect(payload.sessionId, result.sessionId);
      expect(payload.windowIndex, result.windowIndex);
      expect(payload.frameCount, result.frameCount);
      expect(payload.missingDurationMs, result.missingDuration.inMilliseconds);
      expect(payload.confidence, closeTo(result.confidence, 0.0001));
      expect(payload.isPartial, true);
      expect(payload.coverageRatio, closeTo(0.98, 0.0001));
      expect(payload.fps, closeTo(result.fps, 0.0001));
    });

    test('generates a unique payloadId on each call', () {
      final id1 = mapper.map(_result()).id;
      final id2 = mapper.map(_result()).id;
      expect(id1, isNotEmpty);
      expect(id1, isNot(equals(id2)));
    });

    test('maps area events correctly', () {
      final payload = mapper.map(_result());
      expect(payload.areas.length, 1);
      final area = payload.areas.first;
      expect(area.id, 1);
      expect(area.passBy, 5);
      expect(area.entry, 3);
      expect(area.exit, 2);
    });

    test('maps area state metrics correctly', () {
      final payload = mapper.map(_result());
      final area = payload.areas.first;
      expect(area.occupancyAvg, closeTo(1.5, 0.0001));
      expect(area.occupancyPeak, 4);
      expect(area.dwellAvgSec, closeTo(45.0, 0.0001));
      expect(area.dwellPeakSec, 200);
    });

    test('handles an empty areas map', () {
      final payload = mapper.map(_result(areas: {}));
      expect(payload.areas, isEmpty);
    });

    test('maps multiple areas', () {
      final result = _result(
        areas: {
          1: vision.AreaMetrics(
            passBy: 1,
            entry: 1,
            exit: 0,
            occupancyAvg: 0.5,
            occupancyPeak: 1,
            dwellAvgSec: 10.0,
            dwellPeakSec: 20,
          ),
          2: vision.AreaMetrics(
            passBy: 2,
            entry: 0,
            exit: 2,
            occupancyAvg: 1.0,
            occupancyPeak: 2,
            dwellAvgSec: 20.0,
            dwellPeakSec: 40,
          ),
        },
      );
      final payload = mapper.map(result);
      expect(payload.areas.length, 2);
    });
  });
}
