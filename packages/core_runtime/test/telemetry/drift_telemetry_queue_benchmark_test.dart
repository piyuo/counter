// TOC:
// - Benchmark test for DriftPayloadQueueRepository.fetchRecent with 2016 payloads
// - Simulates 7 days of telemetry history (realistic mobile app scenario)
// - Measures: total time, per-payload decode time, memory impact

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/database/app_database.dart';
import 'package:core_runtime/telemetry/drift_telemetry_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftPayloadQueueRepository - fetchRecent Benchmark', () {
    late AppDatabaseFun db;
    late DriftTelemetryQueue repository;
    late Directory tempDir;
    late String dbPath;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('drift_payload_queue_benchmark_test_');
      dbPath = '${tempDir.path}${Platform.pathSeparator}telemetry_benchmark.db';
      db = await AppDatabase.open(filePath: dbPath);
      repository = DriftTelemetryQueue(db);
    });

    tearDown(() async {
      await db()!.close();
      await AppDatabase.removeFile(filePath: dbPath);
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

      // Benchmark payload insertion and fetch throughput.
      stopwatch.start();
      final now = DateTime.now().toUtc();
      for (int day = 0; day < daysBack; day++) {
        for (int hour = 0; hour < 24; hour++) {
          for (int minute = 0; minute < 12; minute++) {
            final createdAt = now.subtract(Duration(days: day, hours: hour, minutes: minute * 5));
            await repository.add(_createTestObservation(startUtc: createdAt));
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
            await repository.add(_createTestObservation(startUtc: createdAt));
          }
        }
      }

      // Mark half as delivered
      final allPayloads = await repository.fetchRecent(daysBack: daysBack);
      final half = (allPayloads.length / 2).ceil();
      final deliveredIds = allPayloads.take(half).map((p) => p.observation.id).toList();
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

/// Creates a realistic test observation with all required fields.
core_domain.Observation _createTestObservation({required DateTime startUtc}) {
  final startBusiness = startUtc.toLocal();
  return core_domain.Observation(
    granularity: core_domain.ObservationGranularity.minutes5,
    year: startBusiness.year,
    month: startBusiness.month,
    day: startBusiness.day,
    hour: startBusiness.hour,
    minute: startBusiness.minute,
    frameCount: 100,
    confidenceRatioSum: 0.95,
    confidenceSampleCount: 1,
    confidenceRatio: 95,
    coveredSeconds: 1,
    expectedSeconds: 1,
    coverageRatio: 1,
    areas: const [
      core_domain.AreaMetrics(
        areaId: 1,
        areaName: 'Area 1',
        passBy: 5,
        stagnant: 0,
        entry: 3,
        exit: 2,
        appear: 0,
        disappear: 0,
        occupancySampleSum: 1,
        occupancySampleSumSquares: 1,
        occupancySampleCount: 2,
        occupancyMean: 0.5,
        occupancyMax: 3,
        occupancyLast: 1,
        dwellSumSeconds: 5,
        dwellSampleCount: 2,
        dwellMeanSeconds: 2.5,
        dwellMaxSeconds: 5,
      ),
    ],
  );
}
