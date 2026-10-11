// TOC:
//  - DriftPayloadQueueRepository — enqueue: inserts with correct fields
//  - DriftPayloadQueueRepository — enqueue: ignores duplicates and preserves the first row
//  - DriftPayloadQueueRepository — fetchReady: returns pending items only
//  - DriftPayloadQueueRepository — fetchReady: respects limit
//  - DriftPayloadQueueRepository — fetchReady: orders by createdAt ascending
//  - DriftPayloadQueueRepository — TelemetryQueue helpers: predicate coverage
//  - DriftPayloadQueueRepository — TelemetryQueue helpers: retention predicates
//  - DriftPayloadQueueRepository — markUploadedBatch: marks batch as uploaded
//  - DriftPayloadQueueRepository — pruneExpired: removes old rows by createdAt only
//  - DriftPayloadQueueRepository — pendingCount: returns correct count
//  - DriftPayloadQueueRepository — fetchRecent: returns rows created within daysBack
//  - DriftPayloadQueueRepository — upload logs: append/fetch/prune lifecycle

import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/drift_telemetry_database.dart';
import 'package:core_runtime/telemetry/drift_telemetry_queue.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Test helpers
// ---------------------------------------------------------------------------

final _timesByKey = <String, int>{};
var _nextTimeIndex = 0;

int _timeFor(String key) => _timesByKey.putIfAbsent(key, () {
  final minuteOfDay = _nextTimeIndex++;
  return minuteOfDay ~/ 60 * 100 + minuteOfDay % 60;
});

core_domain.Observation _observation(String id) {
  final time = _timeFor(id);
  return core_domain.Observation(
    granularity: core_domain.ObservationGranularity.minutes5,
    year: 2026,
    month: 1,
    day: 1,
    hour: time ~/ 100,
    minute: time % 100,
    frameCount: 0,
    confidenceRatioSum: 0,
    confidenceSampleCount: 0,
    confidenceRatio: 0,
    coveredSeconds: 0,
    expectedSeconds: 0,
    coverageRatio: 0,
    areas: const [],
  );
}

String _id(String key) => '${20260101 * 10000 + _timeFor(key)}';

int _observationId(String key) => int.parse(_id(key));

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late TelemetryDatabaseFun db;
  late DriftTelemetryQueue repo;
  late Directory tempDir;
  late String dbPath;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('drift_payload_queue_repository_test_');
    dbPath = '${tempDir.path}${Platform.pathSeparator}telemetry_test.db';
    db = await DriftTelemetryDatabase.open(filePath: dbPath);
    repo = DriftTelemetryQueue(db);
  });

  tearDown(() async {
    await db()!.close();
    await DriftTelemetryDatabase.removeFile(filePath: dbPath);
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('DriftPayloadQueueRepository', () {
    // -----------------------------------------------------------------------
    // enqueue
    // -----------------------------------------------------------------------

    test('enqueue inserts a row retrievable by fetchReady', () async {
      await repo.enqueue(_observation('p1'));
      final rows = await repo.fetchReady();
      expect(rows.length, 1);
      expect(rows.first.observation.id.toString(), _id('p1'));
    });

    test('enqueue round-trips the payload JSON correctly', () async {
      final original = _observation('p1');
      await repo.enqueue(original);
      final row = (await repo.fetchReady()).first;
      expect(row.observation.id, original.id);
    });

    test('enqueue ignores duplicate payload IDs and preserves the first row', () async {
      final original = _observation('dup-1');
      final duplicate = original.copyWith(frameCount: 99);
      await repo.enqueue(original);
      await repo.enqueue(duplicate);

      expect(await repo.pendingCount(), 1);
      final rows = await repo.fetchReady(limit: 10);
      expect(rows, hasLength(1));
      expect(rows.single.observation.id.toString(), _id('dup-1'));
      expect(rows.single.observation.frameCount, original.frameCount);
    });

    // -----------------------------------------------------------------------
    // fetchReady
    // -----------------------------------------------------------------------

    test('fetchReady excludes rows that are delivered', () async {
      await repo.enqueue(_observation('pending'));
      await repo.enqueue(_observation('delivered'));
      await repo.markUploadedBatch([_observationId('delivered')]);

      final rows = await repo.fetchReady();
      expect(rows.any((r) => r.observation.id.toString() == _id('pending')), isTrue);
      expect(rows.any((r) => r.observation.id.toString() == _id('delivered')), isFalse);
    });

    test('fetchReady returns at most [limit] items', () async {
      for (var i = 0; i < 5; i++) {
        await repo.enqueue(_observation('p$i'));
      }
      final rows = await repo.fetchReady(limit: 3);
      expect(rows.length, 3);
    });

    test('fetchReady returns items in createdAt ascending order', () async {
      // Enqueue with explicit timing by using separate enqueue calls.
      await repo.enqueue(_observation('first'));
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await repo.enqueue(_observation('second'));

      final rows = await repo.fetchReady();
      expect(rows.first.observation.id.toString(), _id('first'));
      expect(rows.last.observation.id.toString(), _id('second'));
    });

    test('TelemetryQueue helper predicates match delivered state', () async {
      await repo.enqueue(_observation('pending'));
      await repo.enqueue(_observation('delivered'));
      await repo.enqueue(_observation('recent-delivered'));
      await repo.markUploadedBatch([_observationId('delivered'), _observationId('recent-delivered')]);

      await (db()!.update(db()!.telemetryQueue)..where((t) => t.id.equals(_id('pending')))).write(
        TelemetryQueueCompanion(
          createdAtMs: Value(DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch),
        ),
      );

      await (db()!.update(db()!.telemetryQueue)..where((t) => t.id.equals(_id('delivered')))).write(
        TelemetryQueueCompanion(
          uploadedAtMs: Value(DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch),
        ),
      );

      final tenDaysAgoMs = DateTime.now().toUtc().subtract(const Duration(days: 10)).millisecondsSinceEpoch;
      final beforeMs = DateTime.now().toUtc().subtract(const Duration(days: 10)).millisecondsSinceEpoch;

      final pendingRows =
          await (db()!.select(db()!.telemetryQueue)
                ..where((t) => t.isPending)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)]))
              .get();
      final deliveredRows =
          await (db()!.select(db()!.telemetryQueue)
                ..where((t) => t.isUploaded)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)]))
              .get();
      final createdBeforeRows = await (db()!.select(
        db()!.telemetryQueue,
      )..where((t) => t.isCreatedBefore(beforeMs))).get();
      final deliveredAfterRows = await (db()!.select(
        db()!.telemetryQueue,
      )..where((t) => t.isUploadedAfter(tenDaysAgoMs))).get();

      expect(pendingRows.map((row) => row.id), contains(_id('pending')));
      expect(pendingRows.map((row) => row.id), isNot(contains(_id('delivered'))));
      expect(pendingRows.map((row) => row.id), isNot(contains(_id('recent-delivered'))));
      expect(deliveredRows.map((row) => row.id), contains(_id('delivered')));
      expect(deliveredRows.map((row) => row.id), contains(_id('recent-delivered')));
      expect(deliveredRows.map((row) => row.id), isNot(contains(_id('pending'))));
      expect(createdBeforeRows.map((row) => row.id), contains(_id('pending')));
      expect(createdBeforeRows.map((row) => row.id), isNot(contains(_id('recent-delivered'))));
      expect(deliveredAfterRows.map((row) => row.id), contains(_id('recent-delivered')));
      expect(deliveredAfterRows.map((row) => row.id), isNot(contains(_id('pending'))));
    });

    // -----------------------------------------------------------------------
    // markUploadedBatch
    // -----------------------------------------------------------------------

    test('markUploadedBatch handles empty list gracefully', () async {
      await repo.markUploadedBatch([]);
      expect(await repo.pendingCount(), 0);
    });

    test('markUploadedBatch excludes items from pending and batch marks delivered', () async {
      await repo.enqueue(_observation('p1'));
      await repo.enqueue(_observation('p2'));
      await repo.enqueue(_observation('p3'));

      await repo.markUploadedBatch([_observationId('p1'), _observationId('p3')]);

      final ready = await repo.fetchReady(limit: 10);
      expect(ready.map((r) => r.observation.id.toString()), [_id('p2')]);
      expect(await repo.pendingCount(), 1);

      final available = await repo.fetchRecent(daysBack: 7);
      final p1 = available.firstWhere((row) => row.observation.id.toString() == _id('p1'));
      final p3 = available.firstWhere((row) => row.observation.id.toString() == _id('p3'));
      expect(p1.isUploaded, isTrue);
      expect(p3.isUploaded, isTrue);
    });

    test('markUploadedBatch on unknown ids is a no-op', () async {
      await repo.enqueue(_observation('p1'));
      await repo.markUploadedBatch([-1, -2]);
      expect(await repo.pendingCount(), 1);
    });

    // -----------------------------------------------------------------------
    // pruneExpired
    // -----------------------------------------------------------------------

    test('pruneExpired removes items created before the cutoff', () async {
      await repo.enqueue(_observation('old'));
      await repo.enqueue(_observation('new'));

      // Mark 'old' as created far in the past by checking it is in the queue,
      // then prune with a cutoff that is after the 'old' item but we can only
      // test this by relying on insertion timestamps being close to now.
      // Instead: prune everything up to 1 ms in the future to remove all.
      await repo.pruneExpired(DateTime.now().toUtc().add(const Duration(milliseconds: 1)));

      expect(await repo.pendingCount(), 0);
    });

    test('pruneExpired keeps items created after the cutoff', () async {
      await repo.enqueue(_observation('p1'));
      // Cutoff in the distant past — nothing should be removed.
      await repo.pruneExpired(DateTime.utc(2000));
      expect(await repo.pendingCount(), 1);
    });

    test('pruneExpired removes rows older than cutoff regardless of delivery state', () async {
      await repo.enqueue(_observation('old-pending'));
      await repo.enqueue(_observation('old-delivered'));
      await repo.markUploadedBatch([_observationId('old-delivered')]);

      final oldCreatedMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await (db()!.update(db()!.telemetryQueue)..where((t) => t.id.equals(_id('old-pending')))).write(
        TelemetryQueueCompanion(createdAtMs: Value(oldCreatedMs)),
      );
      await (db()!.update(db()!.telemetryQueue)..where((t) => t.id.equals(_id('old-delivered')))).write(
        TelemetryQueueCompanion(createdAtMs: Value(oldCreatedMs)),
      );

      await repo.pruneExpired(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final available = await repo.fetchRecent(daysBack: 30);
      expect(available.any((r) => r.observation.id.toString() == _id('old-delivered')), isFalse);
      expect(await repo.pendingCount(), 0);
    });

    // -----------------------------------------------------------------------
    // pendingCount
    // -----------------------------------------------------------------------

    test('pendingCount returns 0 for an empty queue', () async {
      expect(await repo.pendingCount(), 0);
    });

    test('pendingCount reflects the total number of rows', () async {
      await repo.enqueue(_observation('p1'));
      await repo.enqueue(_observation('p2'));
      expect(await repo.pendingCount(), 2);
      await repo.markUploadedBatch([_observationId('p1')]);
      expect(await repo.pendingCount(), 1);
    });

    test('fetchRecent returns rows created within daysBack', () async {
      await repo.enqueue(_observation('delivered'));
      await repo.enqueue(_observation('pending'));
      await repo.markUploadedBatch([_observationId('delivered')]);

      final rows = await repo.fetchRecent(daysBack: 7);
      expect(rows.map((row) => row.observation.id.toString()), containsAll(<String>[_id('delivered'), _id('pending')]));

      final delivered = rows.firstWhere((row) => row.observation.id.toString() == _id('delivered'));
      final pending = rows.firstWhere((row) => row.observation.id.toString() == _id('pending'));
      expect(delivered.isUploaded, isTrue);
      expect(delivered.uploadedAtUtc, isNotNull);
      expect(pending.isUploaded, isFalse);
      expect(pending.uploadedAtUtc, isNull);
    });

    test('fetchRecent excludes rows older than daysBack by createdAt', () async {
      await repo.enqueue(_observation('old-pending'));
      await repo.enqueue(_observation('old-delivered'));
      await repo.markUploadedBatch([_observationId('old-delivered')]);
      await repo.enqueue(_observation('recent-pending'));

      final elevenDaysAgoMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await (db()!.update(db()!.telemetryQueue)..where((t) => t.id.equals(_id('old-pending')))).write(
        TelemetryQueueCompanion(createdAtMs: Value(elevenDaysAgoMs)),
      );
      await (db()!.update(db()!.telemetryQueue)..where((t) => t.id.equals(_id('old-delivered')))).write(
        TelemetryQueueCompanion(createdAtMs: Value(elevenDaysAgoMs)),
      );

      final rows = await repo.fetchRecent(daysBack: 7);
      final ids = rows.map((row) => row.observation.id.toString()).toList();

      expect(ids, contains(_id('recent-pending')));
      expect(ids, isNot(contains(_id('old-pending'))));
      expect(ids, isNot(contains(_id('old-delivered'))));
    });

    test('appendUploadLog + fetchRecentUploadLogs stores and reads newest-first rows', () async {
      final now = DateTime.now().toUtc();
      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(now.subtract(const Duration(minutes: 65)), success: true),
          attemptedAtUtc: now.subtract(const Duration(minutes: 65)),
          success: true,
          payloadSizeKb: 0,
        ),
      );
      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(now, success: false),
          attemptedAtUtc: now,
          success: false,
          payloadSizeKb: 42,
          error: 'transport_exception',
        ),
      );

      final logs = await repo.fetchRecentUploadLogs(daysBack: 7, limit: 10);
      expect(logs.length, 2);
      expect(logs.first.datetime.isAfter(logs.last.datetime), isTrue);
      expect(logs.first.id, greaterThan(logs.last.id));
      expect(logs.first.success, isFalse);
      expect(logs.first.error, 'transport_exception');
    });

    test('appendUploadLog reuses the same hour/status bucket on repeated failure retries', () async {
      final currentUtc = DateTime.now().toUtc();
      final attempt = DateTime.utc(currentUtc.year, currentUtc.month, currentUtc.day, currentUtc.hour, 1);

      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(attempt, success: false),
          attemptedAtUtc: attempt,
          success: false,
          payloadSizeKb: 10,
          retryCount: 0,
          error: 'transport_exception',
        ),
      );
      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(attempt.add(const Duration(minutes: 1)), success: false),
          attemptedAtUtc: attempt.add(const Duration(minutes: 1)),
          success: false,
          payloadSizeKb: 12,
          retryCount: 1,
          error: 'transport_exception',
        ),
      );

      final logs = await repo.fetchRecentUploadLogs(daysBack: 7, limit: 10);

      expect(logs.length, 1);
      expect(logs.single.success, isFalse);
      expect(logs.single.error, 'transport_exception');
      expect(logs.single.datetime, attempt.add(const Duration(minutes: 1)).toLocal());
    });

    test('appendUploadLog keeps separate success and failure buckets in the same hour', () async {
      final currentUtc = DateTime.now().toUtc();
      final attempt = DateTime.utc(currentUtc.year, currentUtc.month, currentUtc.day, currentUtc.hour, 1);

      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(attempt, success: false),
          attemptedAtUtc: attempt,
          success: false,
          payloadSizeKb: 10,
          retryCount: 1,
          error: 'transport_exception',
        ),
      );
      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(attempt.add(const Duration(minutes: 20)), success: true),
          attemptedAtUtc: attempt.add(const Duration(minutes: 20)),
          success: true,
          payloadSizeKb: 8,
          retryCount: 2,
        ),
      );

      final logs = await repo.fetchRecentUploadLogs(daysBack: 7, limit: 10);

      expect(logs.length, 2);
      expect(logs.where((log) => log.success).length, 1);
      expect(logs.where((log) => !log.success).length, 1);
    });

    test('fetchUploadLogById returns the matching upload log', () async {
      final attempt = DateTime.utc(2026, 5, 19, 12, 1);
      final log = core_domain.UploadLog(
        id: core_domain.UploadLog.generateIdFromUtcTime(attempt, success: false),
        attemptedAtUtc: attempt,
        success: false,
        payloadSizeKb: 12,
        retryCount: 1,
        error: 'transport_exception',
      );
      await repo.appendUploadLog(log);

      final fetched = await repo.fetchUploadLogById(log.id);

      expect(fetched, isNotNull);
      expect(fetched!.id, log.id);
      expect(fetched.success, isFalse);
      expect(fetched.retryCount, 1);
      expect(fetched.error, 'transport_exception');
    });

    test('fetchUploadLogById returns null when the log does not exist', () async {
      final fetched = await repo.fetchUploadLogById(20260519120);

      expect(fetched, isNull);
    });

    test('fetchRecentUploadLogs excludes rows older than daysBack', () async {
      final oldAttemptMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await db()!
          .into(db()!.telemetryUploadLog)
          .insert(
            TelemetryUploadLogCompanion.insert(
              id: const Value(2000010100),
              attemptedAtMs: oldAttemptMs,
              success: true,
              payloadSizeKb: 0,
            ),
          );
      final now = DateTime.now().toUtc();
      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(now, success: true),
          attemptedAtUtc: now,
          success: true,
          payloadSizeKb: 0,
        ),
      );

      final logs = await repo.fetchRecentUploadLogs(daysBack: 7, limit: 10);
      expect(logs.length, 1);
      expect(logs.single.id, isNot(2000010100));
      expect(logs.single.datetime.millisecondsSinceEpoch, isNot(oldAttemptMs));
    });

    test('pruneUploadLogs removes rows older than the cutoff', () async {
      final oldAttemptMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await db()!
          .into(db()!.telemetryUploadLog)
          .insert(
            TelemetryUploadLogCompanion.insert(
              id: const Value(2000010100),
              attemptedAtMs: oldAttemptMs,
              success: true,
              payloadSizeKb: 0,
            ),
          );
      final now = DateTime.now().toUtc();
      await repo.appendUploadLog(
        core_domain.UploadLog(
          id: core_domain.UploadLog.generateIdFromUtcTime(now, success: true),
          attemptedAtUtc: now,
          success: true,
          payloadSizeKb: 0,
        ),
      );

      await repo.pruneUploadLogs(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final rows = await db()!.select(db()!.telemetryUploadLog).get();
      expect(rows.length, 1);
      expect(rows.single.attemptedAtMs, isNot(oldAttemptMs));
    });
  });
}
