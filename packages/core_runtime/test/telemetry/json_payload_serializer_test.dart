// TOC:
//  - JsonPayloadSerializer — contentType header
//  - JsonPayloadSerializer — serialize: empty observations list in envelope
//  - JsonPayloadSerializer — serialize: single observation produces valid envelope
//  - JsonPayloadSerializer — serialize: multiple observations preserved in order
//  - JsonPayloadSerializer — serialize: latest area occupancy
//  - JsonPayloadSerializer — schema validation: empty observations passes schema
//  - JsonPayloadSerializer — schema validation: single observation passes schema
//  - JsonPayloadSerializer — schema validation: multiple observations pass schema
//  - JsonPayloadSerializer — schema validation: with projectId and assignId

import 'dart:convert';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/json_payload_serializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_schema/json_schema.dart';

// ---------------------------------------------------------------------------
// Helpers
// -----coverageRatio--------------------------------------------------------------

/// Loads the JSON schema from the docs folder
JsonSchema _loadSchema() {
  // Working directory is packages/core_runtime/, navigate to docs/
  final schemaFile = File('../../docs/payload-schema-v2.json');
  if (!schemaFile.existsSync()) {
    throw Exception('Schema file not found at ${schemaFile.absolute.path}');
  }
  final schemaJson = jsonDecode(schemaFile.readAsStringSync());
  return JsonSchema.create(schemaJson);
}

core_domain.Observation _observation({
  required int date,
  required int time,
  int frameCount = 0,
  double confidenceRatioSum = 0.0,
  int confidenceSampleCount = 0,
  int coveredSeconds = 300,
  int expectedSeconds = 300,
  List<core_domain.AreaMetrics> areas = const [],
}) => core_domain.Observation(
  granularity: core_domain.ObservationGranularity.minutes5,
  year: date ~/ 10000,
  month: date ~/ 100 % 100,
  day: date % 100,
  hour: time ~/ 100,
  minute: time % 100,
  confidenceRatioSum: confidenceRatioSum,
  confidenceSampleCount: confidenceSampleCount,
  confidenceRatio: confidenceSampleCount == 0 ? 0 : confidenceRatioSum / confidenceSampleCount,
  coveredSeconds: coveredSeconds,
  expectedSeconds: expectedSeconds,
  coverageRatio: expectedSeconds == 0 ? 0 : coveredSeconds / expectedSeconds,
  areas: areas,
  frameCount: frameCount,
);

core_domain.Observation _payload(int time) => core_domain.Observation(
  granularity: core_domain.ObservationGranularity.minutes5,
  year: 2026,
  month: 1,
  day: 1,
  hour: time ~/ 100,
  minute: time % 100,
  confidenceRatioSum: 0,
  confidenceSampleCount: 0,
  confidenceRatio: 0,
  coveredSeconds: 285,
  expectedSeconds: 300,
  coverageRatio: 0.95,
  areas: [
    const core_domain.AreaMetrics(
      areaId: 1,
      areaName: '',
      passBy: 10,
      stagnant: 0,
      entry: 5,
      exit: 5,
      appear: 0,
      disappear: 0,
      occupancySampleCount: 2,
      occupancySampleSum: 5,
      occupancySampleSumSquares: 13,
      occupancyMean: 2.5,
      occupancyMax: 8,
      occupancyLast: 6,
      dwellSampleCount: 1,
      dwellSumSeconds: 30,
      dwellMeanSeconds: 30,
      dwellMaxSeconds: 120,
      presenceTrackCount: 1,
      presenceSumSeconds: 1,
      presenceMeanSeconds: 1,
    ),
  ],
  frameCount: 0,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  const serializer = JsonPayloadSerializer();

  List<int> serialize(List<core_domain.Observation> observations) =>
      serializer.serialize(observations, deviceId: 'device-1');

  group('JsonPayloadSerializer', () {
    test('contentType is application/json', () {
      expect(serializer.contentType, 'application/json');
    });

    test('toJson builds the upload envelope with optional metadata', () {
      final json = serializer.toJson(
        [_payload(1000)],
        deviceId: 'device-1',
        projectId: 'project-001',
        assignId: 'assign-001',
      );

      expect(json['schema'], core_domain.kSchemaVersion);
      expect(json['deviceId'], 'device-1');
      expect(json['projectId'], 'project-001');
      expect(json['assignId'], 'assign-001');
      expect((json['observations'] as List).single['hour'], 10);
      expect((json['observations'] as List).single['minute'], 0);
      expect(json, isNot(contains('payloads')));
    });

    test('serializes presence seconds as an integer', () {
      final observation = _payload(1000);
      final area = observation.areas.single.copyWith(presenceSumSeconds: 1);
      final json = serializer.toJson([
        observation.copyWith(areas: [area]),
      ], deviceId: 'device-1');
      final serializedArea = ((json['observations'] as List).single as Map<String, dynamic>)['areas'] as List;

      expect((serializedArea.single as Map<String, dynamic>)['presenceSumSeconds'], 1);
      expect((serializedArea.single as Map<String, dynamic>)['presenceSumSeconds'], isA<int>());
    });

    test('toJson omits unset optional metadata', () {
      final json = serializer.toJson([], deviceId: 'device-1');

      expect(json, containsPair('deviceId', 'device-1'));
      expect(json['observations'], isEmpty);
      expect(json.containsKey('projectId'), isFalse);
      expect(json.containsKey('assignId'), isFalse);
    });

    test('serialize returns a valid UTF-8 JSON envelope for an empty list', () {
      final bytes = serialize([]);
      final decoded = jsonDecode(utf8.decode(bytes));
      expect(decoded, isA<Map<String, dynamic>>());
      expect(decoded['deviceId'], 'device-1');
      expect(decoded['observations'], isEmpty);
    });

    test('serialize wraps a single observation in observations envelope key', () {
      final bytes = serialize([_payload(1000)]);
      final decoded = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      final observations = decoded['observations'] as List;
      expect(observations.length, 1);
      expect(decoded, isNot(contains('payloads')));
    });

    test('serialize preserves business date and time components', () {
      final bytes = serialize([_payload(1000)]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List).first
              as Map<String, dynamic>;
      expect(decoded['granularity'], 'minutes5');
      expect(decoded['year'], 2026);
      expect(decoded['month'], 1);
      expect(decoded['day'], 1);
      expect(decoded['hour'], 10);
      expect(decoded['minute'], 0);
    });

    test('serialize preserves order with multiple payloads', () {
      final payload1 = core_domain.Observation(
        granularity: core_domain.ObservationGranularity.minutes5,
        year: 2026,
        month: 1,
        day: 1,
        hour: 10,
        minute: 0,
        confidenceRatioSum: 0,
        confidenceSampleCount: 0,
        coveredSeconds: 285,
        expectedSeconds: 300,
        confidenceRatio: 0,
        coverageRatio: 0.95,
        areas: [],
        frameCount: 0,
      );
      final payload2 = core_domain.Observation(
        granularity: core_domain.ObservationGranularity.minutes5,
        year: 2026,
        month: 1,
        day: 1,
        hour: 10,
        minute: 5,
        confidenceRatioSum: 0,
        confidenceSampleCount: 0,
        coveredSeconds: 285,
        expectedSeconds: 300,
        confidenceRatio: 0,
        coverageRatio: 0.95,
        areas: [],
        frameCount: 0,
      );
      final bytes = serialize([payload1, payload2]);
      final decoded = (jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List;
      expect(decoded.length, 2);
      expect((decoded[0] as Map)['minute'], 0);
      expect((decoded[1] as Map)['minute'], 5);
    });

    test('serialize includes area metrics', () {
      final bytes = serialize([_payload(1000)]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List).first
              as Map<String, dynamic>;
      final areas = decoded['areas'] as List;
      expect(areas.length, 1);
      expect((areas.first as Map)['areaId'], 1);
      expect((areas.first as Map)['passBy'], 10);
      expect((areas.first as Map)['occupancyLast'], 6);
    });

    test('serialize preserves totals, includes averages, and keeps max dwell in whole seconds', () {
      final payload = _observation(
        date: 20260522,
        time: 15,
        frameCount: 276,
        confidenceRatioSum: 79.24125,
        confidenceSampleCount: 100,
        coveredSeconds: 10,
        expectedSeconds: 289,
        areas: const [
          core_domain.AreaMetrics(
            areaId: 0,
            areaName: '',
            passBy: 19,
            stagnant: 0,
            entry: 0,
            exit: 0,
            appear: 0,
            disappear: 0,
            occupancySampleCount: 10,
            occupancySampleSum: 72,
            occupancySampleSumSquares: 576,
            occupancyMean: 7.26,
            occupancyMax: 12,
            occupancyLast: 8,
            dwellSumSeconds: 42,
            dwellSampleCount: 10,
            dwellMeanSeconds: 4.26,
            dwellMaxSeconds: 9,
          ),
        ],
      );

      final bytes = serialize([payload]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List).first
              as Map<String, dynamic>;
      final area = (decoded['areas'] as List).first as Map<String, dynamic>;

      expect(decoded['confidenceRatioSum'], 79.24);
      expect(decoded['confidenceRatio'], 0.79);
      expect(decoded['confidenceSampleCount'], 100);
      expect(decoded['coveredSeconds'], 10);
      expect(decoded['expectedSeconds'], 289);
      expect(area['occupancySampleSum'], 72);
      expect(area['occupancySampleSumSquares'], 576);
      expect(area['occupancyLast'], 8);
      expect(area['dwellSumSeconds'], 42);
      expect(area['dwellMaxSeconds'], 9);
      expect(area['occupancyMean'], 7.26);
      expect(area['dwellMeanSeconds'], 4.26);
    });

    test('serialize includes all area metrics per schema requirements', () {
      final payload = _observation(
        date: 20260522,
        time: 15,
        frameCount: 10,
        confidenceRatioSum: 0.1,
        confidenceSampleCount: 1,
        areas: const [
          core_domain.AreaMetrics(
            areaId: 0,
            areaName: '',
            passBy: 18,
            stagnant: 0,
            entry: 0,
            exit: 0,
            appear: 0,
            disappear: 0,
            occupancySampleCount: 50,
            occupancySampleSum: 381,
            occupancySampleSumSquares: 2935,
            occupancyMean: 0,
            occupancyMax: 12,
            occupancyLast: 9,
            dwellSampleCount: 5,
            dwellSumSeconds: 22,
            dwellMeanSeconds: 0,
            dwellMaxSeconds: 10,
          ),
        ],
      );

      final bytes = serialize([payload]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List).first
              as Map<String, dynamic>;
      final area = (decoded['areas'] as List).first as Map<String, dynamic>;

      expect(area['areaId'], 0);
      expect(area['passBy'], 18);
      expect(area['occupancySampleCount'], 50);
      expect(area['occupancySampleSum'], 381);
      expect(area['occupancyMax'], 12);
      expect(area['occupancyLast'], 9);
      expect(area['dwellSampleCount'], 5);
      expect(area['dwellSumSeconds'], 22);
      expect(area['dwellMaxSeconds'], 10.0);

      // Per schema, all fields are required even if zero
      expect(area['stagnant'], 0);
      expect(area.containsKey('dwell'), isFalse);
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

      test('published schema example passes schema validation', () {
        final exampleFile = File('../../docs/payload-example-v2.json');
        final example = jsonDecode(exampleFile.readAsStringSync());

        final validationErrors = schema.validate(example);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('empty observations array passes schema validation', () {
        final bytes = serialize([]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('single complete payload passes schema validation', () {
        final payload = _observation(
          date: 20260713,
          time: 1920,
          frameCount: 2963,
          confidenceRatioSum: 86.92,
          confidenceSampleCount: 100,
          coveredSeconds: 123,
          expectedSeconds: 300,
          areas: const [
            core_domain.AreaMetrics(
              areaId: 0,
              areaName: 'Global',
              passBy: 1,
              stagnant: 0,
              entry: 0,
              exit: 0,
              appear: 0,
              disappear: 0,
              occupancySampleCount: 100,
              occupancySampleSum: 99,
              occupancySampleSumSquares: 99,
              occupancyMax: 1,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 10,
              dwellSumSeconds: 607,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 122,
            ),
          ],
        );

        final bytes = serialize([payload]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('multiple observations pass schema validation', () {
        final payload1 = _observation(
          date: 20260713,
          time: 1920,
          frameCount: 2963,
          confidenceRatioSum: 86.92,
          confidenceSampleCount: 100,
          coveredSeconds: 123,
          expectedSeconds: 300,
          areas: const [
            core_domain.AreaMetrics(
              areaId: 0,
              areaName: 'Global',
              passBy: 12,
              stagnant: 3,
              entry: 5,
              exit: 4,
              appear: 2,
              disappear: 2,
              occupancySampleCount: 100,
              occupancySampleSum: 132,
              occupancySampleSumSquares: 244,
              occupancyMax: 4,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 100,
              dwellSumSeconds: 8760,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 243,
            ),
          ],
        );

        final payload2 = _observation(
          date: 20260713,
          time: 1925,
          frameCount: 7511,
          confidenceRatioSum: 85.66,
          confidenceSampleCount: 100,
          coveredSeconds: 294,
          expectedSeconds: 300,
          areas: const [
            core_domain.AreaMetrics(
              areaId: 0,
              areaName: 'Global',
              passBy: 8,
              stagnant: 5,
              entry: 3,
              exit: 3,
              appear: 1,
              disappear: 1,
              occupancySampleCount: 100,
              occupancySampleSum: 210,
              occupancySampleSumSquares: 476,
              occupancyMax: 6,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 100,
              dwellSumSeconds: 12050,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 300,
            ),
          ],
        );

        final bytes = serialize([payload1, payload2]);
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('payload with projectId and assignId passes schema validation', () {
        final payload = _observation(
          date: 20260713,
          time: 1920,
          frameCount: 2963,
          confidenceRatioSum: 86.92,
          confidenceSampleCount: 100,
          coveredSeconds: 123,
          expectedSeconds: 300,
          areas: const [
            core_domain.AreaMetrics(
              areaId: 0,
              areaName: 'Global',
              passBy: 1,
              stagnant: 0,
              entry: 0,
              exit: 0,
              appear: 0,
              disappear: 0,
              occupancySampleCount: 100,
              occupancySampleSum: 99,
              occupancySampleSumSquares: 99,
              occupancyMax: 1,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 10,
              dwellSumSeconds: 607,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 122,
            ),
          ],
        );

        final bytes = serializer.serialize(
          [payload],
          deviceId: 'device-1',
          projectId: 'project-001',
          assignId: 'assign-001',
        );
        final decoded = jsonDecode(utf8.decode(bytes));

        final validationErrors = schema.validate(decoded);
        expect(validationErrors.isValid, isTrue, reason: 'Schema validation failed: ${validationErrors.errors}');
      });

      test('payload with multiple areas passes schema validation', () {
        final payload = _observation(
          date: 20260713,
          time: 1920,
          frameCount: 2963,
          confidenceRatioSum: 90.5,
          confidenceSampleCount: 100,
          areas: const [
            core_domain.AreaMetrics(
              areaId: 0,
              areaName: 'Global',
              passBy: 10,
              stagnant: 5,
              entry: 3,
              exit: 3,
              appear: 1,
              disappear: 1,
              occupancySampleCount: 10,
              occupancySampleSum: 25,
              occupancySampleSumSquares: 125,
              occupancyMax: 5,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 10,
              dwellSumSeconds: 450,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 120,
            ),
            core_domain.AreaMetrics(
              areaId: 1,
              areaName: 'Entrance',
              passBy: 15,
              stagnant: 2,
              entry: 8,
              exit: 8,
              appear: 2,
              disappear: 2,
              occupancySampleCount: 10,
              occupancySampleSum: 15,
              occupancySampleSumSquares: 45,
              occupancyMax: 3,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 10,
              dwellSumSeconds: 205,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 60,
            ),
            core_domain.AreaMetrics(
              areaId: 2,
              areaName: 'Display Area',
              passBy: 5,
              stagnant: 8,
              entry: 4,
              exit: 4,
              appear: 1,
              disappear: 1,
              occupancySampleCount: 10,
              occupancySampleSum: 32,
              occupancySampleSumSquares: 176,
              occupancyMax: 6,
              occupancyLast: 0,
              occupancyMean: 0,
              dwellSampleCount: 10,
              dwellSumSeconds: 908,
              dwellMeanSeconds: 0,
              dwellMaxSeconds: 180,
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
