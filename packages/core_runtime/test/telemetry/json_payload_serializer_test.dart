// TOC:
//  - JsonPayloadSerializer — contentType header
//  - JsonPayloadSerializer — serialize: empty list in envelope
//  - JsonPayloadSerializer — serialize: single payload produces valid envelope
//  - JsonPayloadSerializer — serialize: multiple payloads preserved in order
//  - JsonPayloadSerializer — serialize: session and sequence for identification
//  - JsonPayloadSerializer — schema validation: empty payloads passes schema
//  - JsonPayloadSerializer — schema validation: single payload passes schema
//  - JsonPayloadSerializer — schema validation: multiple payloads pass schema
//  - JsonPayloadSerializer — schema validation: with projectId and assignId

import 'dart:convert';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/json_payload_serializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_schema/json_schema.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Loads the JSON schema from the docs folder
JsonSchema _loadSchema() {
  // Working directory is packages/core_runtime/, navigate to docs/
  final schemaFile = File('../../docs/payload-schema-v1.json');
  if (!schemaFile.existsSync()) {
    throw Exception('Schema file not found at ${schemaFile.absolute.path}');
  }
  final schemaJson = jsonDecode(schemaFile.readAsStringSync());
  return JsonSchema.create(schemaJson);
}

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

    test('serialize preserves session and sequence for payload identification', () {
      final bytes = serialize([_payload('p1')]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List).first as Map<String, dynamic>;
      expect(decoded['session'], 'session-1');
      expect(decoded['sequence'], 1);
    });

    test('serialize preserves order with multiple payloads', () {
      final payload1 = core_domain.TelemetryPayload(
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
        areas: [],
      );
      final payload2 = core_domain.TelemetryPayload(
        startUtc: DateTime.utc(2026, 1, 1),
        startBusiness: DateTime(2026, 1, 1),
        businessDate: '2026-01-01',
        session: 'session-1',
        sequence: 2,
        frameCount: 0,
        missingSec: 0,
        confidence: 0.0,
        isPartial: false,
        coverage: 0.95,
        fps: 0.0,
        areas: [],
      );
      final bytes = serialize([payload1, payload2]);
      final decoded = (jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['payloads'] as List;
      expect(decoded.length, 2);
      expect((decoded[0] as Map)['sequence'], 1);
      expect((decoded[1] as Map)['sequence'], 2);
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
      expect(decoded['coverage'], 0.03);
      expect(decoded['fps'], 26.6);
      expect(area['avgOccupancy'], 7.17);
      expect(area['avgDwellSec'], 4.2);
    });

    test('serialize includes all area metrics per schema requirements', () {
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
      expect(area['maxDwellSec'], 10.0);

      // Per schema, all fields are required even if zero
      expect(area['stay'], 0);
      expect(area['entry'], 0);
      expect(area['exit'], 0);
      expect(area['appear'], 0);
      expect(area['disappear'], 0);
    });

    group('schema validation', () {
      late JsonSchema schema;

      setUpAll(() {
        schema = _loadSchema();
      });

      test('empty payloads array passes schema validation', () {
        final bytes = serialize([]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('single complete payload passes schema validation', () {
        final payload = core_domain.TelemetryPayload(
          startUtc: DateTime.utc(2026, 7, 14, 2, 20),
          startBusiness: DateTime(2026, 7, 13, 19, 20),
          businessDate: '2026-07-13',
          session: '2607131922',
          sequence: 1,
          frameCount: 2963,
          missingSec: 177,
          confidence: 86.92,
          isPartial: true,
          coverage: 0.41,
          fps: 24.2,
          areas: const [
            core_domain.AreaPayload(
              areaId: 0,
              areaName: 'Global',
              passBy: 1,
              stay: 0,
              entry: 0,
              exit: 0,
              appear: 0,
              disappear: 0,
              avgOccupancy: 0.99,
              maxOccupancy: 1,
              avgDwellSec: 60.7,
              maxDwellSec: 122.0,
            ),
          ],
        );

        final bytes = serialize([payload]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('multiple payloads pass schema validation', () {
        final payload1 = core_domain.TelemetryPayload(
          startUtc: DateTime.utc(2026, 7, 14, 2, 20),
          startBusiness: DateTime(2026, 7, 13, 19, 20),
          businessDate: '2026-07-13',
          session: '2607131922',
          sequence: 1,
          frameCount: 2963,
          missingSec: 177,
          confidence: 86.92,
          isPartial: true,
          coverage: 0.41,
          fps: 24.2,
          areas: const [
            core_domain.AreaPayload(
              areaId: 0,
              areaName: 'Global',
              passBy: 12,
              stay: 3,
              entry: 5,
              exit: 4,
              appear: 2,
              disappear: 2,
              avgOccupancy: 1.32,
              maxOccupancy: 4,
              avgDwellSec: 87.6,
              maxDwellSec: 243.0,
            ),
          ],
        );

        final payload2 = core_domain.TelemetryPayload(
          startUtc: DateTime.utc(2026, 7, 14, 2, 25),
          startBusiness: DateTime(2026, 7, 13, 19, 25),
          businessDate: '2026-07-13',
          session: '2607131922',
          sequence: 2,
          frameCount: 7511,
          missingSec: 5,
          confidence: 85.66,
          isPartial: false,
          coverage: 0.98,
          fps: 25.5,
          areas: const [
            core_domain.AreaPayload(
              areaId: 0,
              areaName: 'Global',
              passBy: 8,
              stay: 5,
              entry: 3,
              exit: 3,
              appear: 1,
              disappear: 1,
              avgOccupancy: 2.1,
              maxOccupancy: 6,
              avgDwellSec: 120.5,
              maxDwellSec: 300.0,
            ),
          ],
        );

        final bytes = serialize([payload1, payload2]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('payload with projectId and assignId passes schema validation', () {
        final payload = core_domain.TelemetryPayload(
          startUtc: DateTime.utc(2026, 7, 14, 2, 20),
          startBusiness: DateTime(2026, 7, 13, 19, 20),
          businessDate: '2026-07-13',
          session: '2607131922',
          sequence: 1,
          frameCount: 2963,
          missingSec: 177,
          confidence: 86.92,
          isPartial: true,
          coverage: 0.41,
          fps: 24.2,
          areas: const [
            core_domain.AreaPayload(
              areaId: 0,
              areaName: 'Global',
              passBy: 1,
              stay: 0,
              entry: 0,
              exit: 0,
              appear: 0,
              disappear: 0,
              avgOccupancy: 0.99,
              maxOccupancy: 1,
              avgDwellSec: 60.7,
              maxDwellSec: 122.0,
            ),
          ],
        );

        final bytes = serializer.serialize(
          [payload],
          schemaVersion: core_domain.TelemetryPayload.schemaVersion,
          deviceId: 'device-1',
          projectId: 'project-001',
          assignId: 'assign-001',
        );
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('payload with multiple areas passes schema validation', () {
        final payload = core_domain.TelemetryPayload(
          startUtc: DateTime.utc(2026, 7, 14, 2, 20),
          startBusiness: DateTime(2026, 7, 13, 19, 20),
          businessDate: '2026-07-13',
          session: '2607131922',
          sequence: 1,
          frameCount: 2963,
          missingSec: 0,
          confidence: 90.5,
          isPartial: false,
          coverage: 1.0,
          fps: 30.0,
          areas: const [
            core_domain.AreaPayload(
              areaId: 0,
              areaName: 'Global',
              passBy: 10,
              stay: 5,
              entry: 3,
              exit: 3,
              appear: 1,
              disappear: 1,
              avgOccupancy: 2.5,
              maxOccupancy: 5,
              avgDwellSec: 45.0,
              maxDwellSec: 120.0,
            ),
            core_domain.AreaPayload(
              areaId: 1,
              areaName: 'Entrance',
              passBy: 15,
              stay: 2,
              entry: 8,
              exit: 8,
              appear: 2,
              disappear: 2,
              avgOccupancy: 1.5,
              maxOccupancy: 3,
              avgDwellSec: 20.5,
              maxDwellSec: 60.0,
            ),
            core_domain.AreaPayload(
              areaId: 2,
              areaName: 'Display Area',
              passBy: 5,
              stay: 8,
              entry: 4,
              exit: 4,
              appear: 1,
              disappear: 1,
              avgOccupancy: 3.2,
              maxOccupancy: 6,
              avgDwellSec: 90.8,
              maxDwellSec: 180.0,
            ),
          ],
        );

        final bytes = serialize([payload]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });
    });
  });
}
