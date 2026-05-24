// TOC:
//  - DriftPayloadQueueRepository — enqueue: inserts with correct fields
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
import 'package:core_domain/telemetry/models/telemetry_payload.dart';
import 'package:core_runtime/telemetry/drift_payload_queue_repository.dart';
import 'package:core_runtime/telemetry/telemetry_database.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

core_domain.TelemetryPayload _payload(String id, {DateTime? startUtc}) {
  final resolvedStartUtc = startUtc ?? DateTime.utc(2026, 1, 1);
  final startBusiness = resolvedStartUtc.toLocal();
  final businessDate =
      '${startBusiness.year.toString().padLeft(4, '0')}-${startBusiness.month.toString().padLeft(2, '0')}-${startBusiness.day.toString().padLeft(2, '0')}';
  return core_domain.TelemetryPayload(
    startUtc: resolvedStartUtc,
    startBusiness: startBusiness,
    businessDate: businessDate,
    session: 'session-1',
    sequence: 1,
    frameCount: 0,
    missingSec: 0,
    confidence: 0.0,
    isPartial: false,
    coverage: 1.0,
    fps: 0.0,
    areas: const [],
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late TelemetryDatabase db;
  late DriftPayloadQueueRepository repo;
  late Directory tempDir;
  late String dbPath;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('drift_payload_queue_repository_test_');
    dbPath = '${tempDir.path}${Platform.pathSeparator}telemetry_test.db';
    db = await TelemetryDatabase.open(filePath: dbPath);
    repo = DriftPayloadQueueRepository(db);
  });

  tearDown(() async {
    await db.close();
    await TelemetryDatabase.remove(filePath: dbPath);
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('DriftPayloadQueueRepository', () {
    // -----------------------------------------------------------------------
    // enqueue
    // -----------------------------------------------------------------------

    test('enqueue inserts a row retrievable by fetchReady', () async {
      await repo.enqueue(_payload('p1'));
      final rows = await repo.fetchReady();
      expect(rows.length, 1);
      expect(rows.first.id, 'p1');
    });

    test('enqueue round-trips the payload JSON correctly', () async {
      final original = _payload('p1');
      await repo.enqueue(original);
      final row = (await repo.fetchReady()).first;
      expect(getPayloadId(row.payload), getPayloadId(original));
    });

    test('enqueue is idempotent when payloadId already exists', () async {
      final duplicate = _payload('dup-1');
      await repo.enqueue(duplicate);

      await repo.enqueue(duplicate);

      expect(await repo.pendingCount(), 1);
      final rows = await repo.fetchReady(limit: 10);
      expect(rows.where((row) => row.id == 'dup-1').length, 1);
    });

    // -----------------------------------------------------------------------
    // fetchReady
    // -----------------------------------------------------------------------

    test('fetchReady excludes rows that are delivered', () async {
      await repo.enqueue(_payload('pending'));
      await repo.enqueue(_payload('delivered'));
      await repo.markUploadedBatch(['delivered']);

      final rows = await repo.fetchReady();
      expect(rows.any((r) => r.id == 'pending'), isTrue);
      expect(rows.any((r) => r.id == 'delivered'), isFalse);
    });

    test('fetchReady returns at most [limit] items', () async {
      for (var i = 0; i < 5; i++) {
        await repo.enqueue(_payload('p$i'));
      }
      final rows = await repo.fetchReady(limit: 3);
      expect(rows.length, 3);
    });

    test('fetchReady returns items in createdAt ascending order', () async {
      // Enqueue with explicit timing by using separate enqueue calls.
      await repo.enqueue(_payload('first'));
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await repo.enqueue(_payload('second'));

      final rows = await repo.fetchReady();
      expect(rows.first.id, 'first');
      expect(rows.last.id, 'second');
    });

    test('TelemetryQueue helper predicates match delivered state', () async {
      await repo.enqueue(_payload('pending'));
      await repo.enqueue(_payload('delivered'));
      await repo.enqueue(_payload('recent-delivered'));
      await repo.markUploadedBatch(['delivered', 'recent-delivered']);

      await (db.update(db.telemetryQueue)..where((t) => t.id.equals('pending'))).write(
        TelemetryQueueCompanion(
          createdAtMs: Value(DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch),
        ),
      );

      await (db.update(db.telemetryQueue)..where((t) => t.id.equals('delivered'))).write(
        TelemetryQueueCompanion(
          uploadedAtMs: Value(DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch),
        ),
      );

      final tenDaysAgoMs = DateTime.now().toUtc().subtract(const Duration(days: 10)).millisecondsSinceEpoch;
      final beforeMs = DateTime.now().toUtc().subtract(const Duration(days: 10)).millisecondsSinceEpoch;

      final pendingRows =
          await (db.select(db.telemetryQueue)
                ..where((t) => t.isPending)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)]))
              .get();
      final deliveredRows =
          await (db.select(db.telemetryQueue)
                ..where((t) => t.isUploaded)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)]))
              .get();
      final createdBeforeRows = await (db.select(db.telemetryQueue)..where((t) => t.isCreatedBefore(beforeMs))).get();
      final deliveredAfterRows = await (db.select(
        db.telemetryQueue,
      )..where((t) => t.isUploadedAfter(tenDaysAgoMs))).get();

      expect(pendingRows.map((row) => row.id), contains('pending'));
      expect(pendingRows.map((row) => row.id), isNot(contains('delivered')));
      expect(pendingRows.map((row) => row.id), isNot(contains('recent-delivered')));
      expect(deliveredRows.map((row) => row.id), contains('delivered'));
      expect(deliveredRows.map((row) => row.id), contains('recent-delivered'));
      expect(deliveredRows.map((row) => row.id), isNot(contains('pending')));
      expect(createdBeforeRows.map((row) => row.id), contains('pending'));
      expect(createdBeforeRows.map((row) => row.id), isNot(contains('recent-delivered')));
      expect(deliveredAfterRows.map((row) => row.id), contains('recent-delivered'));
      expect(deliveredAfterRows.map((row) => row.id), isNot(contains('pending')));
    });

    // -----------------------------------------------------------------------
    // markUploadedBatch
    // -----------------------------------------------------------------------

    test('markUploadedBatch handles empty list gracefully', () async {
      await repo.markUploadedBatch([]);
      expect(await repo.pendingCount(), 0);
    });

    test('markUploadedBatch excludes items from pending and batch marks delivered', () async {
      await repo.enqueue(_payload('p1'));
      await repo.enqueue(_payload('p2'));
      await repo.enqueue(_payload('p3'));

      await repo.markUploadedBatch(['p1', 'p3']);

      final ready = await repo.fetchReady(limit: 10);
      expect(ready.map((r) => r.id), ['p2']);
      expect(await repo.pendingCount(), 1);

      final available = await repo.fetchRecent(daysBack: 7);
      final p1 = available.firstWhere((row) => row.id == 'p1');
      final p3 = available.firstWhere((row) => row.id == 'p3');
      expect(p1.isUploaded, isTrue);
      expect(p3.isUploaded, isTrue);
    });

    test('markUploadedBatch on unknown ids is a no-op', () async {
      await repo.enqueue(_payload('p1'));
      await repo.markUploadedBatch(['nonexistent1', 'nonexistent2']);
      expect(await repo.pendingCount(), 1);
    });

    // -----------------------------------------------------------------------
    // pruneExpired
    // -----------------------------------------------------------------------

    test('pruneExpired removes items created before the cutoff', () async {
      await repo.enqueue(_payload('old'));
      await repo.enqueue(_payload('new'));

      // Mark 'old' as created far in the past by checking it is in the queue,
      // then prune with a cutoff that is after the 'old' item but we can only
      // test this by relying on insertion timestamps being close to now.
      // Instead: prune everything up to 1 ms in the future to remove all.
      await repo.pruneExpired(DateTime.now().toUtc().add(const Duration(milliseconds: 1)));

      expect(await repo.pendingCount(), 0);
    });

    test('pruneExpired keeps items created after the cutoff', () async {
      await repo.enqueue(_payload('p1'));
      // Cutoff in the distant past — nothing should be removed.
      await repo.pruneExpired(DateTime.utc(2000));
      expect(await repo.pendingCount(), 1);
    });

    test('pruneExpired removes rows older than cutoff regardless of delivery state', () async {
      await repo.enqueue(_payload('old-pending'));
      await repo.enqueue(_payload('old-delivered'));
      await repo.markUploadedBatch(['old-delivered']);

      final oldCreatedMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await (db.update(
        db.telemetryQueue,
      )..where((t) => t.id.equals('old-pending'))).write(TelemetryQueueCompanion(createdAtMs: Value(oldCreatedMs)));
      await (db.update(
        db.telemetryQueue,
      )..where((t) => t.id.equals('old-delivered'))).write(TelemetryQueueCompanion(createdAtMs: Value(oldCreatedMs)));

      await repo.pruneExpired(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final available = await repo.fetchRecent(daysBack: 30);
      expect(available.any((r) => r.id == 'old-delivered'), isFalse);
      expect(await repo.pendingCount(), 0);
    });

    // -----------------------------------------------------------------------
    // pendingCount
    // -----------------------------------------------------------------------

    test('pendingCount returns 0 for an empty queue', () async {
      expect(await repo.pendingCount(), 0);
    });

    test('pendingCount reflects the total number of rows', () async {
      await repo.enqueue(_payload('p1'));
      await repo.enqueue(_payload('p2'));
      expect(await repo.pendingCount(), 2);
      await repo.markUploadedBatch(['p1']);
      expect(await repo.pendingCount(), 1);
    });

    test('fetchRecent returns rows created within daysBack', () async {
      await repo.enqueue(_payload('delivered'));
      await repo.enqueue(_payload('pending'));
      await repo.markUploadedBatch(['delivered']);

      final rows = await repo.fetchRecent(daysBack: 7);
      expect(rows.map((row) => row.id), containsAll(<String>['delivered', 'pending']));

      final delivered = rows.firstWhere((row) => row.id == 'delivered');
      final pending = rows.firstWhere((row) => row.id == 'pending');
      expect(delivered.isUploaded, isTrue);
      expect(delivered.uploadedAtUtc, isNotNull);
      expect(pending.isUploaded, isFalse);
      expect(pending.uploadedAtUtc, isNull);
    });

    test('fetchRecent excludes rows older than daysBack by createdAt', () async {
      await repo.enqueue(_payload('old-pending'));
      await repo.enqueue(_payload('old-delivered'));
      await repo.markUploadedBatch(['old-delivered']);
      await repo.enqueue(_payload('recent-pending'));

      final elevenDaysAgoMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await (db.update(
        db.telemetryQueue,
      )..where((t) => t.id.equals('old-pending'))).write(TelemetryQueueCompanion(createdAtMs: Value(elevenDaysAgoMs)));
      await (db.update(db.telemetryQueue)..where((t) => t.id.equals('old-delivered'))).write(
        TelemetryQueueCompanion(createdAtMs: Value(elevenDaysAgoMs)),
      );

      final rows = await repo.fetchRecent(daysBack: 7);
      final ids = rows.map((row) => row.id).toList();

      expect(ids, contains('recent-pending'));
      expect(ids, isNot(contains('old-pending')));
      expect(ids, isNot(contains('old-delivered')));
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
      final attempt = DateTime.utc(2026, 5, 19, 12, 1);

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
      final attempt = DateTime.utc(2026, 5, 19, 12, 1);

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
      await db
          .into(db.telemetryUploadLog)
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
      await db
          .into(db.telemetryUploadLog)
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

      final rows = await db.select(db.telemetryUploadLog).get();
      expect(rows.length, 1);
      expect(rows.single.attemptedAtMs, isNot(oldAttemptMs));
    });
  });
}
