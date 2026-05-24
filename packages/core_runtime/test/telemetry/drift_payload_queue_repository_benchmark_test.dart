// TOC:
// - Benchmark test for DriftPayloadQueueRepository.fetchRecent with 2016 payloads
// - Simulates 7 days of telemetry history (realistic mobile app scenario)
// - Measures: total time, per-payload decode time, memory impact

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/drift_payload_queue_repository.dart';
import 'package:core_runtime/telemetry/telemetry_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftPayloadQueueRepository - fetchRecent Benchmark', () {
    late TelemetryDatabase db;
    late DriftPayloadQueueRepository repository;
    late Directory tempDir;
    late String dbPath;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('drift_payload_queue_benchmark_test_');
      dbPath = '${tempDir.path}${Platform.pathSeparator}telemetry_benchmark.db';
      db = await TelemetryDatabase.open(filePath: dbPath);
      repository = DriftPayloadQueueRepository(db);
    });

    tearDown(() async {
      await db.close();
      await TelemetryDatabase.remove(filePath: dbPath);
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('fetchRecent stress test: 2016 payloads (7 days × 288/day)', () async {
      final stopwatch = Stopwatch();
      const payloadsPerDay = 288;
      const daysBack = 7;
      const totalPayloads = payloadsPerDay * daysBack;

      print('\n=== fetchRecent STRESS TEST ===');
      print('Inserting $totalPayloads payloads over $daysBack days...');

      // Insert payloads
      stopwatch.start();
      final now = DateTime.now().toUtc();
      for (int day = 0; day < daysBack; day++) {
        for (int hour = 0; hour < 24; hour++) {
          for (int minute = 0; minute < 12; minute++) {
            final createdAt = now.subtract(Duration(days: day, hours: hour, minutes: minute * 5));
            final payload = _createTestPayload(
              payloadId: 'payload-${day * 24 * 12 + hour * 12 + minute}',
              startUtc: createdAt,
              endUtc: createdAt.add(const Duration(minutes: 5)),
            );
            await repository.enqueue(payload);
          }
        }
      }
      stopwatch.stop();
      print('✓ Inserted $totalPayloads payloads in ${stopwatch.elapsedMilliseconds}ms');

      // Benchmark fetchRecent
      stopwatch.reset();
      stopwatch.start();
      final result = await repository.fetchRecent(daysBack: daysBack);
      stopwatch.stop();

      final totalTimeMs = stopwatch.elapsedMilliseconds;
      final perPayloadTimeUs = (stopwatch.elapsedMicroseconds / result.length).toStringAsFixed(2);
      final avgPayloadSizeEstimate = 2.0; // KB

      print('\n=== BENCHMARK RESULTS ===');
      print('Total payloads fetched: ${result.length}');
      print('Total fetch + decode time: ${totalTimeMs}ms');
      print('Per-payload decode time: $perPayloadTimeUs µs');
      print('Estimated memory impact: ${(result.length * avgPayloadSizeEstimate).toStringAsFixed(1)}KB');
      print('Throughput: ${(result.length / totalTimeMs * 1000).toStringAsFixed(0)} payloads/sec');

      // Assertions for acceptable performance
      expect(result.length, equals(totalPayloads), reason: 'Should fetch all payloads');
      expect(totalTimeMs, lessThan(5000), reason: 'Should complete in < 5 seconds (mobile acceptable)');
      expect(
        double.parse(perPayloadTimeUs),
        lessThan(2000),
        reason: 'Per-payload decode < 2ms (frame budget ~16ms for 60fps)',
      );

      print('\n✓ Performance acceptable for history view');
    });

    test('fetchRecent: verify correctness with mixed delivery states', () async {
      const payloadsPerDay = 288;
      const daysBack = 7;
      const totalPayloads = payloadsPerDay * daysBack;
      final now = DateTime.now().toUtc();
      // Insert 2016 payloads (7 days)
      for (int day = 0; day < daysBack; day++) {
        for (int hour = 0; hour < 24; hour++) {
          for (int minute = 0; minute < 12; minute++) {
            final createdAt = now.subtract(Duration(days: day, hours: hour, minutes: minute * 5));
            final payload = _createTestPayload(
              payloadId: 'payload-${day * 24 * 12 + hour * 12 + minute}',
              startUtc: createdAt,
              endUtc: createdAt.add(const Duration(minutes: 5)),
            );
            await repository.enqueue(payload);
          }
        }
      }

      // Mark half as delivered
      final allPayloads = await repository.fetchRecent(daysBack: daysBack);
      final half = (allPayloads.length / 2).ceil();
      final deliveredIds = allPayloads.take(half).map((p) => p.id).toList();
      await repository.markUploadedBatch(deliveredIds);

      // Fetch again
      final result = await repository.fetchRecent(daysBack: daysBack);
      final deliveredPayloads = result.where((p) => p.uploadedAtUtc != null).toList();
      final pendingPayloads = result.where((p) => p.uploadedAtUtc == null).toList();

      print('Total: ${result.length}, Delivered: ${deliveredPayloads.length}, Pending: ${pendingPayloads.length}');
      print('✓ All payloads included regardless of delivery state');

      expect(result.length, equals(totalPayloads));
      expect(deliveredPayloads.length, equals(half));
      expect(pendingPayloads.length, equals(totalPayloads - half));
    });
  });
}

/// Creates a realistic test telemetry payload with all required fields
core_domain.TelemetryPayload _createTestPayload({
  required String payloadId,
  required DateTime startUtc,
  required DateTime endUtc,
}) {
  final startBusiness = startUtc.toLocal();
  final businessDate =
      '${startBusiness.year.toString().padLeft(4, '0')}-${startBusiness.month.toString().padLeft(2, '0')}-${startBusiness.day.toString().padLeft(2, '0')}';
  return core_domain.TelemetryPayload(
    startUtc: startUtc,
    startBusiness: startBusiness,
    businessDate: businessDate,
    session: 'session-1',
    sequence: 1,
    frameCount: 100,
    missingSec: 0,
    confidence: 0.95,
    isPartial: false,
    coverage: 1.0,
    fps: 30.0,
    areas: [
      core_domain.AreaPayload(
        areaId: 1,
        passBy: 5,
        entry: 3,
        exit: 2,
        avgOccupancy: 0.5,
        maxOccupancy: 3,
        avgDwellSec: 2.5,
        maxDwellSec: 5,
      ),
    ],
  );
}
