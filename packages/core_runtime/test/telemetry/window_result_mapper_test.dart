// TOC:
//  - WindowResultMapper — map: populates top-level TelemetryPayload fields
//  - WindowResultMapper — map: maps each area correctly
//  - WindowResultMapper — map: generates a unique payloadId per call
//  - WindowResultMapper — map: propagates deviceId
//  - WindowResultMapper — map: handles empty areas map

import 'package:core_domain/telemetry/models/telemetry_payload.dart';
import 'package:core_runtime/telemetry/window_result_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vision/flutter_vision.dart' as vision;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

vision.WindowCountState _result({Map<int, vision.AreaMetrics>? areas}) => vision.WindowCountState(
  startUtc: DateTime.utc(2026, 3, 1, 10, 0),
  startBusiness: DateTime(2026, 3, 1, 10, 0),
  session: 'session-1',
  sequence: 1,
  frameCount: 7200,
  confidence: 87.5,
  areas:
      areas ??
      {
        1: vision.AreaMetrics(
          areaId: 1,
          areaName: 'Area 1',
          passBy: 5,
          entry: 3,
          exit: 2,
          avgOccupancy: 1.5,
          maxOccupancy: 4,
          avgDwellSec: 45.0,
          maxDwellSec: 200,
        ),
      },
  missingDuration: const Duration(seconds: 72),
  doneRatio: 0,
  inProgressRatio: 1,
  missingRatio: 0,
  fps: 20,
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
      expect(payload.startBusiness, result.startBusiness);
      expect(payload.businessDate, '2026-03-01'); // Derived from startBusiness
      expect(payload.session, result.session);
      expect(payload.sequence, result.sequence);
      expect(payload.frameCount, result.frameCount);
      expect(payload.missingSec, result.missingDuration.inSeconds);
      expect(payload.confidence, closeTo(result.confidence, 0.0001));
      expect(payload.isPartial, true);
      // coverageRatio: (300s - 72s) / 300s = 0.76
      expect(payload.coverage, closeTo(0.76, 0.0001));
      // fps: 7200 frames / 228s = 31.58 fps
      expect(payload.fps, closeTo(31.58, 0.01));
    });

    test('generates a unique payloadId on each call', () {
      // Use different sequence numbers to generate different payloadIds
      final result1 = _result();
      final result2 = vision.WindowCountState(
        startUtc: result1.startUtc,
        startBusiness: result1.startBusiness,
        session: result1.session,
        sequence: result1.sequence + 1, // Different sequence
        frameCount: result1.frameCount,
        confidence: result1.confidence,
        areas: result1.areas,
        missingDuration: result1.missingDuration,
        doneRatio: result1.doneRatio,
        inProgressRatio: result1.inProgressRatio,
        missingRatio: result1.missingRatio,
        fps: result1.fps,
      );

      final id1 = getPayloadId(mapper.map(result1));
      final id2 = getPayloadId(mapper.map(result2));
      expect(id1, isNotEmpty);
      expect(id1, isNot(equals(id2)));
    });

    test('maps area events correctly', () {
      final payload = mapper.map(_result());
      expect(payload.areas.length, 1);
      final area = payload.areas.first;
      expect(area.areaId, 1);
      expect(area.passBy, 5);
      expect(area.entry, 3);
      expect(area.exit, 2);
    });

    test('maps area state metrics correctly', () {
      final payload = mapper.map(_result());
      final area = payload.areas.first;
      expect(area.avgOccupancy, closeTo(1.5, 0.0001));
      expect(area.maxOccupancy, 4);
      expect(area.avgDwellSec, closeTo(45.0, 0.0001));
      expect(area.maxDwellSec, 200);
    });

    test('handles an empty areas map', () {
      final payload = mapper.map(_result(areas: {}));
      expect(payload.areas, isEmpty);
    });

    test('maps multiple areas', () {
      final result = _result(
        areas: {
          1: vision.AreaMetrics(
            areaId: 1,
            areaName: 'Area 1',
            passBy: 1,
            entry: 1,
            exit: 0,
            avgOccupancy: 0.5,
            maxOccupancy: 1,
            avgDwellSec: 10.0,
            maxDwellSec: 20,
          ),
          2: vision.AreaMetrics(
            areaId: 2,
            areaName: 'Area 2',
            passBy: 2,
            entry: 0,
            exit: 2,
            avgOccupancy: 1.0,
            maxOccupancy: 2,
            avgDwellSec: 20.0,
            maxDwellSec: 40,
          ),
        },
      );
      final payload = mapper.map(result);
      expect(payload.areas.length, 2);
    });
  });
}
