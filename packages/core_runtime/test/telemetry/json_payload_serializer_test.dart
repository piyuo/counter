// TOC:
//  - JsonPayloadSerializer — contentType header
//  - JsonPayloadSerializer — serialize: empty observations list in envelope
//  - JsonPayloadSerializer — serialize: single observation produces valid envelope
//  - JsonPayloadSerializer — serialize: multiple observations preserved in order
//  - JsonPayloadSerializer — serialize: latest area occupancy

import 'dart:convert';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/json_payload_serializer.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// -----coverageRatio--------------------------------------------------------------

core_domain.ObservationPayload _payload({
  required int date,
  required int time,
  int frameCount = 0,
  double confidenceRatio = 0.0,
  int expectedSeconds = 300,
  int coveredSeconds = 300,
  List<core_domain.AreaMetricsPayload> areas = const [],
}) {
  final year = date ~/ 10000;
  final month = date ~/ 100 % 100;
  final day = date % 100;
  final hour = time ~/ 100;
  final minute = time % 100;
  return core_domain.ObservationPayload(
    granularity: 'minutes5',
    year: year,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    id: core_domain.keyFromComponents([year, month, day, hour, minute]),
    businessDate:
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}',
    confidenceRatio: confidenceRatio,
    expectedSeconds: expectedSeconds,
    coveredSeconds: coveredSeconds,
    coverageRatio: expectedSeconds == 0 ? 0 : coveredSeconds / expectedSeconds,
    areas: areas,
    frameCount: frameCount,
  );
}

core_domain.ObservationPayload _typicalPayload(int time) => _payload(
  date: 20260101,
  time: time,
  coveredSeconds: 285,
  areas: [
    const core_domain.AreaMetricsPayload(
      areaId: 1,
      areaName: '',
      passBy: 10,
      entry: 5,
      exit: 5,
      occupancySampleCount: 2,
      occupancySum: 5,
      occupancySumSquares: 13,
      occupancyMax: 8,
      occupancyLast: 6,
      dwellSampleCount: 1,
      dwellSumSeconds: 30,
      dwellMeanSeconds: 30,
      dwellMaxSeconds: 120,
      presenceSampleCount: 1,
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

  List<int> serialize(List<core_domain.ObservationPayload> observations) =>
      serializer.serialize(observations, deviceId: 'device-1');

  group('JsonPayloadSerializer', () {
    test('contentType is application/json', () {
      expect(serializer.contentType, 'application/json');
    });

    test('toJson builds the upload envelope with optional metadata', () {
      final json = serializer.toJson(
        [_typicalPayload(1000)],
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
      final observation = _typicalPayload(1000);
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
      final bytes = serialize([_typicalPayload(1000)]);
      final decoded = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      final observations = decoded['observations'] as List;
      expect(observations.length, 1);
      expect(decoded, isNot(contains('payloads')));
    });

    test('serialize preserves business date and time components', () {
      final bytes = serialize([_typicalPayload(1000)]);
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
      final payload1 = _payload(date: 20260101, time: 1000, coveredSeconds: 285);
      final payload2 = _payload(date: 20260101, time: 1005, coveredSeconds: 285);
      final bytes = serialize([payload1, payload2]);
      final decoded = (jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List;
      expect(decoded.length, 2);
      expect((decoded[0] as Map)['minute'], 0);
      expect((decoded[1] as Map)['minute'], 5);
    });

    test('serialize includes area metrics', () {
      final bytes = serialize([_typicalPayload(1000)]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List).first
              as Map<String, dynamic>;
      final areas = decoded['areas'] as List;
      expect(areas.length, 1);
      expect((areas.first as Map)['areaId'], 1);
      expect((areas.first as Map)['passBy'], 10);
      expect((areas.first as Map)['occupancyLast'], 6);
    });

    test('serialize preserves ratio and area payload fields', () {
      final payload = _payload(
        date: 20260522,
        time: 15,
        frameCount: 276,
        confidenceRatio: 0.7924125,
        coveredSeconds: 10,
        areas: const [
          core_domain.AreaMetricsPayload(
            areaId: 0,
            areaName: '',
            passBy: 19,
            occupancySampleCount: 10,
            occupancySum: 72,
            occupancySumSquares: 576,
            occupancyMean: 7.2,
            occupancyVariance: 5.76,
            occupancyMax: 12,
            occupancyLast: 8,
            dwellSumSeconds: 42,
            dwellSampleCount: 10,
            dwellMeanSeconds: 4.2,
            dwellMaxSeconds: 9,
            presenceSampleCount: 1,
            presenceSumSeconds: 1,
            presenceMeanSeconds: 1,
          ),
        ],
      );

      final bytes = serialize([payload]);
      final decoded =
          ((jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>)['observations'] as List).first
              as Map<String, dynamic>;
      final area = (decoded['areas'] as List).first as Map<String, dynamic>;

      expect(decoded['confidenceRatio'], 0.79);
      expect(decoded.containsKey('confidenceSum'), isFalse);
      expect(decoded.containsKey('confidenceSampleCount'), isFalse);
      expect(decoded['coverageRatio'], 0.03);
      expect(decoded['coveredSeconds'], 10);
      expect(decoded['expectedSeconds'], 300);
      expect(area['occupancySum'], 72);
      expect(area['occupancySumSquares'], 576);
      expect(area['occupancyLast'], 8);
      expect(area['occupancyMean'], 7.2);
      expect(area['occupancyVariance'], 5.76);
      expect(area['dwellSumSeconds'], 42);
      expect(area['dwellMaxSeconds'], 9);
      expect(area['dwellMeanSeconds'], 4.2);
      expect(area['presenceMeanSeconds'], 1);
    });

    test('serialize includes area metrics', () {
      final payload = _payload(
        date: 20260522,
        time: 15,
        frameCount: 10,
        confidenceRatio: 0.1,
        areas: const [
          core_domain.AreaMetricsPayload(
            areaId: 0,
            areaName: '',
            passBy: 18,
            occupancySampleCount: 50,
            occupancySum: 381,
            occupancySumSquares: 2935,
            occupancyMax: 12,
            occupancyLast: 9,
            dwellSampleCount: 5,
            dwellSumSeconds: 22,
            dwellMeanSeconds: 4.4,
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
      expect(area['occupancySum'], 381);
      expect(area['occupancyMax'], 12);
      expect(area['occupancyLast'], 9);
      expect(area['dwellSampleCount'], 5);
      expect(area['dwellSumSeconds'], 22);
      expect(area['dwellMaxSeconds'], 10);
    });
  });
}
