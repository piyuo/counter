// TOC:
//  - JsonPayloadSerializer — contentType header
//  - JsonPayloadSerializer — serialize: empty list in envelope
//  - JsonPayloadSerializer — serialize: single payload produces valid envelope
//  - JsonPayloadSerializer — serialize: multiple payloads preserved in order
//  - JsonPayloadSerializer — serialize: payloadId round-trips correctly

import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/json_payload_serializer.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

core_domain.TelemetryPayload _payload(String id) => core_domain.TelemetryPayload(
  startUtc: DateTime.utc(2026, 1, 1),
  startBusiness: DateTime(2026, 1, 1),
  businessDate: '2026-01-01',
  session: 'session-1',
  sequence: 1,
  frameCount: 0,
  missingSec: 0,
  confidence: 0.0,
  isPartial: false,
  coverage: 0.95,
  fps: 0.0,
  areas: [
    const core_domain.AreaPayload(
      areaId: 1,
      passBy: 10,
      entry: 5,
      exit: 5,
      avgOccupancy: 2.5,
      maxOccupancy: 8,
      avgDwellSec: 30.0,
      maxDwellSec: 120,
    ),
  ],
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const serializer = JsonPayloadSerializer();

  List<int> serialize(List<core_domain.TelemetryPayload> payloads) =>
      serializer.serialize(payloads, schemaVersion: core_domain.TelemetryPayload.schemaVersion, deviceId: 'device-1');

  group('JsonPayloadSerializer', () {
    test('contentType is application/json', () {
      expect(serializer.contentType, 'application/json');
    });

    test('serialize returns a valid UTF-8 JSON envelope for an empty list', () {
      final bytes = serialize([]);
      final decoded = jsonDecode(utf8.decode(bytes));
      expect(decoded, isA<Map<String, dynamic>>());
      expect((decoded as Map<String, dynamic>)['schema'], core_domain.TelemetryPayload.schemaVersion);
      expect(decoded['deviceId'], 'device-1');
      expect(decoded['payloads'], isEmpty);
    });

    test('serialize wraps a single payload in payloads envelope key', () {
      final bytes = serialize([_payload('p1')]);
      final decoded = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      final payloads = decoded['payloads'] as List;
      expect(payloads.length, 1);
    });

    test('serialize preserves payloadId for round-trip verification', () {
      final bytes = serialize([_payload('uuid-abc-123')]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List).first as Map<String, dynamic>;
      expect(decoded['id'], 'uuid-abc-123');
    });

    test('serialize preserves order with multiple payloads', () {
      final bytes = serialize([_payload('first'), _payload('second')]);
      final decoded = (jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List;
      expect(decoded.length, 2);
      expect((decoded[0] as Map)['id'], 'first');
      expect((decoded[1] as Map)['id'], 'second');
    });

    test('serialize includes area metrics', () {
      final bytes = serialize([_payload('p1')]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List).first as Map<String, dynamic>;
      final areas = decoded['areas'] as List;
      expect(areas.length, 1);
      expect((areas.first as Map)['areaId'], 1);
      expect((areas.first as Map)['passBy'], 10);
      expect((areas.first as Map).containsKey('currentOccupancy'), isFalse);
    });

    test('serialize rounds floating-point metrics for payload size reduction', () {
      final payload = core_domain.TelemetryPayload(
        startUtc: DateTime.utc(2026, 5, 22, 0, 15),
        startBusiness: DateTime(2026, 5, 22, 0, 15),
        businessDate: '2026-05-22',
        session: 'session-1',
        sequence: 1,
        frameCount: 276,
        missingSec: 289616,
        confidence: 79.24257674886763,
        isPartial: true,
        coverage: 0.034613333333333336,
        fps: 26.57935285053929,
        areas: const [
          core_domain.AreaPayload(
            areaId: -1,
            passBy: 19,
            stay: 0,
            entry: 0,
            exit: 0,
            appear: 0,
            disappear: 0,
            avgOccupancy: 7.1732851985559565,
            maxOccupancy: 12,
            avgDwellSec: 4.164057876195269,
            maxDwellSec: 9,
          ),
        ],
      );

      final bytes = serialize([payload]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List).first as Map<String, dynamic>;
      final area = (decoded['areas'] as List).first as Map<String, dynamic>;

      expect(decoded['confidence'], 79.24);
      expect(decoded['coverageRatio'], 0.03);
      expect(decoded['fps'], 26.6);
      expect(area['avgOccupancy'], 7.17);
      expect(area['avgDwellSec'], 4.2);
    });

    test('serialize omits zero-valued default area metrics', () {
      final payload = core_domain.TelemetryPayload(
        startUtc: DateTime.utc(2026, 5, 22, 0, 15),
        startBusiness: DateTime(2026, 5, 22, 0, 15),
        businessDate: '2026-05-22',
        session: 'session-1',
        sequence: 1,
        frameCount: 10,
        missingSec: 0,
        confidence: 10.0,
        isPartial: false,
        coverage: 1.0,
        fps: 26.0,
        areas: const [
          core_domain.AreaPayload(
            areaId: -1,
            passBy: 18,
            stay: 0,
            entry: 0,
            exit: 0,
            appear: 0,
            disappear: 0,
            avgOccupancy: 7.62,
            maxOccupancy: 12,
            avgDwellSec: 4.4,
            maxDwellSec: 10,
          ),
        ],
      );

      final bytes = serialize([payload]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List).first as Map<String, dynamic>;
      final area = (decoded['areas'] as List).first as Map<String, dynamic>;

      expect(area['areaId'], -1);
      expect(area['passBy'], 18);
      expect(area['avgOccupancy'], 7.62);
      expect(area['maxOccupancy'], 12);
      expect(area['avgDwellSec'], 4.4);
      expect(area['maxDwellSec'], 10);

      expect(area.containsKey('stay'), isFalse);
      expect(area.containsKey('entry'), isFalse);
      expect(area.containsKey('exit'), isFalse);
      expect(area.containsKey('appear'), isFalse);
      expect(area.containsKey('disappear'), isFalse);
    });
  });
}
