// TOC:
//  - Helpers: stub implementations and test-payload factory
//  - UploadWorker — run(): no-op when configResolver returns null
//  - UploadWorker — run(): prunes expired items before delivery
//  - UploadWorker — run(): delivers a single batch and marks success
//  - UploadWorker — run(): drains multiple batches until queue is empty
//  - UploadWorker — run(): keeps failed items pending for later attempts
//  - UploadWorker — run(): stops after first transport failure
//  - UploadWorker — sendPayloadsDirect(): sends selected payloads immediately
//  - UploadWorker — status attributes: initial state, success, rejection, exception, discard

import 'package:core_domain/state/models/data_server.dart';
import 'package:core_domain/state/models/upload_config.dart';
import 'package:core_domain/telemetry/models/queued_payload.dart';
import 'package:core_domain/telemetry/models/telemetry_payload.dart';
import 'package:core_domain/telemetry/models/telemetry_response.dart';
import 'package:core_domain/telemetry/models/upload_log.dart';
import 'package:core_domain/telemetry/models/upload_session.dart';
import 'package:core_domain/telemetry/models/uppload_log_list.dart';
import 'package:core_domain/telemetry/services/payload_queue_repository.dart';
import 'package:core_domain/telemetry/services/payload_serializer.dart';
import 'package:core_domain/telemetry/services/telemetry_transport.dart';
import 'package:core_domain/telemetry/upload_worker.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Creates a minimal [TelemetryPayload] using [id] as the payloadId.
TelemetryPayload _payload(String id) => TelemetryPayload(
  id: id,
  startUtc: DateTime.utc(2026, 1, 1),
  endUtc: DateTime.utc(2026, 1, 1, 1),
  sessionId: 'session-1',
  windowIndex: 1,
  frameCount: 0,
  missingDurationMs: 0,
  confidence: 0.0,
  isPartial: false,
  coverageRatio: 1.0,
  fps: 0.0,
  areas: const [],
);

/// [createdAt] defaults to a far-future date (2099) so it is never pruned by
/// [TelemetryQueueRepository.pruneExpired] in tests that use [_config] defaults.
QueuedPayload _pending(String id, {DateTime? createdAt}) =>
    QueuedPayload(id: id, payload: _payload(id), createdAtUtc: createdAt ?? DateTime.utc(2099, 1, 1));

/// A persisted [UploadConfig] with small limits to keep tests concise.
UploadConfig _deliveryConfig({int maxBatchSize = 10}) => UploadConfig(maxBatchSize: maxBatchSize);

UploadSession _config({int maxBatchSize = 10}) => UploadSession(
  config: _deliveryConfig(maxBatchSize: maxBatchSize),
  dataServer: const DataServer.personal(url: 'https://example.com/api'),
  deviceId: 'device-1',
  bearerToken: 'tok_test',
);

// ---------------------------------------------------------------------------
// Stub implementations
// ---------------------------------------------------------------------------

class _StubQueue implements TelemetryQueueRepository {
  final _rows = <QueuedPayload>[];
  final _deliveryLogsById = <int, UploadLog>{};
  final _successfulIds = <String>{};
  DateTime? lastPrunedBefore;
  DateTime? lastDeliveryLogPrunedBefore;

  void seed(QueuedPayload row) => _rows.add(row);

  @override
  Future<void> enqueue(TelemetryPayload payload) async {
    _rows.add(_pending(payload.id));
  }

  @override
  Future<List<QueuedPayload>> fetchReady({int limit = 10}) async {
    return _rows.take(limit).toList();
  }

  @override
  Future<void> appendUploadLog(UploadLog log) async {
    _deliveryLogsById[log.id] = log;
  }

  @override
  Future<List<UploadLogList>> fetchRecentUploadLogs({int daysBack = 7, int limit = 500}) async {
    final logs = _deliveryLogsById.values.toList(growable: false)
      ..sort((a, b) => b.attemptedAtUtc.compareTo(a.attemptedAtUtc));
    return logs
        .map(
          (log) => UploadLogList(
            id: log.id,
            success: log.success,
            datetime: log.attemptedAtUtc.toLocal(),
            payloadSizeKb: log.payloadSizeKb,
            payloadCount: log.payloadCount,
            error: log.error,
          ),
        )
        .take(limit)
        .toList(growable: false);
  }

  @override
  Future<UploadLog?> fetchUploadLogById(int id) async {
    return _deliveryLogsById[id];
  }

  @override
  Future<void> pruneUploadLogs(DateTime before) async {
    lastDeliveryLogPrunedBefore = before;
    _deliveryLogsById.removeWhere((_, log) => log.attemptedAtUtc.isBefore(before));
  }

  @override
  Future<void> markUploadedBatch(List<String> ids) async {
    _successfulIds.addAll(ids);
    _rows.removeWhere((p) => ids.contains(p.id));
  }

  @override
  Future<void> pruneExpired(DateTime before) async {
    lastPrunedBefore = before;
    _rows.removeWhere((p) => p.createdAtUtc.isBefore(before));
  }

  @override
  Future<int> pendingCount() async => _rows.length;

  @override
  Future<List<QueuedPayload>> fetchRecent({int daysBack = 7}) async => List.of(_rows);
}

/// Transport that always throws a [Exception] to simulate a network-level
/// failure (exercises the `catch (error)` path in [UploadWorker.run]).
class _ThrowingTransport implements TelemetryTransport {
  @override
  Future<TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    throw Exception('simulated network error');
  }
}

class _StubSerializer implements PayloadSerializer {
  @override
  String get contentType => 'application/json';

  @override
  List<int> serialize(List<TelemetryPayload> payloads, {required int schemaVersion, required String deviceId}) => [
    1,
    2,
    3,
  ];
}

class _StubTransport implements TelemetryTransport {
  int callCount = 0;
  bool shouldFail = false;

  @override
  Future<TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    callCount++;
    if (shouldFail) {
      return const TelemetryResponse(v: 1, ok: false, error: 'transport_exception', data: null);
    }
    return const TelemetryResponse(v: 1, ok: true, data: ServerData());
  }
}

/// Builds a [UploadWorker] with the given collaborators.
UploadWorker _worker(
  _StubQueue queue,
  _StubSerializer serializer,
  TelemetryTransport transport, {
  UploadSession? config,
}) => UploadWorker(
  queue: queue,
  serializer: serializer,
  transport: transport,
  sessionResolver: () async => config ?? _config(),
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('UploadWorker', () {
    // -----------------------------------------------------------------------
    // no-op cases
    // -----------------------------------------------------------------------

    test('run() is a no-op when configResolver returns null', () async {
      final queue = _StubQueue()..seed(_pending('p1'));
      final transport = _StubTransport();
      final worker = UploadWorker(
        queue: queue,
        serializer: _StubSerializer(),
        transport: transport,
        sessionResolver: () async => null,
      );

      final success = await worker.run();

      expect(success, isFalse);
      expect(transport.callCount, 0);
      expect(await queue.pendingCount(), 1);
    });

    // -----------------------------------------------------------------------
    // prune
    // -----------------------------------------------------------------------

    test('run() calls pruneExpired with the configured payload retention cutoff', () async {
      final queue = _StubQueue();
      final before = DateTime.now().toUtc();
      final worker = _worker(queue, _StubSerializer(), _StubTransport(), config: _config());

      final success = await worker.run();

      expect(success, isTrue);
      expect(queue.lastPrunedBefore, isNotNull);
      final expectedCutoff = DateTime.now().toUtc().subtract(const Duration(days: 7));
      expect(queue.lastPrunedBefore!.difference(expectedCutoff).abs(), lessThan(const Duration(seconds: 5)));
      expect(queue.lastPrunedBefore!.isAfter(before), isFalse);
    });

    test('run() calls pruneUploadLogs with the configured delivery-log retention cutoff', () async {
      final queue = _StubQueue();
      final worker = _worker(queue, _StubSerializer(), _StubTransport(), config: _config());

      final success = await worker.run();

      expect(success, isTrue);
      expect(queue.lastDeliveryLogPrunedBefore, isNotNull);
      final expectedCutoff = DateTime.now().toUtc().subtract(const Duration(days: 7));
      expect(queue.lastDeliveryLogPrunedBefore!.difference(expectedCutoff).abs(), lessThan(const Duration(seconds: 5)));
    });

    test('run() removes expired items before delivery', () async {
      final queue = _StubQueue();
      // Item created 10 days ago — older than the fixed 7-day retention window.
      queue.seed(_pending('expired', createdAt: DateTime.now().toUtc().subtract(const Duration(days: 10))));
      final transport = _StubTransport();
      final worker = _worker(queue, _StubSerializer(), transport, config: _config());

      final success = await worker.run();

      expect(success, isTrue);
      expect(await queue.pendingCount(), 0);
      expect(transport.callCount, 0); // pruned before delivery loop
    });

    // -----------------------------------------------------------------------
    // successful delivery
    // -----------------------------------------------------------------------

    test('run() delivers a single ready payload and removes it', () async {
      final queue = _StubQueue()..seed(_pending('p1'));
      final transport = _StubTransport();
      final worker = _worker(queue, _StubSerializer(), transport);

      final success = await worker.run();

      expect(success, isTrue);
      expect(transport.callCount, 1);
      expect(await queue.pendingCount(), 0);
    });

    test('run() drains multiple batches until the queue is empty', () async {
      final queue = _StubQueue()
        ..seed(_pending('p1'))
        ..seed(_pending('p2'))
        ..seed(_pending('p3'));
      final transport = _StubTransport();
      // batchSize=2 forces two transport calls for 3 items.
      final worker = _worker(queue, _StubSerializer(), transport, config: _config(maxBatchSize: 2));

      final success = await worker.run();

      expect(success, isTrue);
      expect(transport.callCount, 2);
      expect(await queue.pendingCount(), 0);
    });

    // -----------------------------------------------------------------------
    // failure & retry
    // -----------------------------------------------------------------------

    test('run() keeps failed payload pending on wrapped error response', () async {
      final queue = _StubQueue()..seed(_pending('p1'));
      final transport = _StubTransport()..shouldFail = true;
      final worker = _worker(queue, _StubSerializer(), transport);

      final success = await worker.run();

      expect(success, isFalse);
      // Item remains pending for the next run.
      expect(await queue.pendingCount(), 1);
    });

    test('run() stops processing after the first transport failure', () async {
      final queue = _StubQueue()
        ..seed(_pending('p1'))
        ..seed(_pending('p2'));
      final transport = _StubTransport()..shouldFail = true;
      // batchSize=1 so each item is its own batch.
      final worker = _worker(queue, _StubSerializer(), transport, config: _config(maxBatchSize: 1));

      final success = await worker.run();

      expect(success, isFalse);
      expect(transport.callCount, 1); // stops after first failure
      expect(await queue.pendingCount(), 2); // both items remain
    });

    test('sendPayloadsDirect() sends in config-sized batches and returns true on success', () async {
      final transport = _StubTransport();
      final worker = _worker(_StubQueue(), _StubSerializer(), transport, config: _config(maxBatchSize: 2));

      final success = await worker.sendPayloadsDirect([_payload('d1'), _payload('d2'), _payload('d3')]);

      expect(success, isTrue);
      expect(transport.callCount, 2);
      expect(worker.isLastUploadSuccess, isTrue);
    });

    test('sendPayloadsDirect() stops at first failure and returns false', () async {
      final transport = _StubTransport()..shouldFail = true;
      final worker = _worker(_StubQueue(), _StubSerializer(), transport, config: _config(maxBatchSize: 2));

      final success = await worker.sendPayloadsDirect([_payload('d1'), _payload('d2'), _payload('d3')]);

      expect(success, isFalse);
      expect(transport.callCount, 1);
      expect(worker.isLastUploadSuccess, isFalse);
      expect(worker.lastError, 'transport_exception');
    });

    // -----------------------------------------------------------------------
    // status attributes
    // -----------------------------------------------------------------------

    group('status attributes', () {
      test('all fields are null before any run', () async {
        final worker = _worker(_StubQueue(), _StubSerializer(), _StubTransport());

        expect(worker.lastUploadTimeUtc, isNull);
        expect(worker.isLastUploadSuccess, isNull);
        expect(worker.lastError, isNull);
      });

      test('session unavailable sets failure status fields', () async {
        final worker = UploadWorker(
          queue: _StubQueue()..seed(_pending('p1')),
          serializer: _StubSerializer(),
          transport: _StubTransport(),
          sessionResolver: () async => null,
        );

        await worker.run();

        expect(worker.lastUploadTimeUtc, isNull);
        expect(worker.isLastUploadSuccess, isFalse);
        expect(worker.lastError, 'session_unavailable');
      });

      test('successful delivery sets isLastUploadSuccess=true and clears error fields', () async {
        final queue = _StubQueue()..seed(_pending('p1'));
        final before = DateTime.now().toUtc();
        final worker = _worker(queue, _StubSerializer(), _StubTransport());

        await worker.run();

        expect(worker.isLastUploadSuccess, isTrue);
        expect(worker.lastUploadTimeUtc, isNotNull);
        expect(worker.lastUploadTimeUtc!.isAfter(before), isTrue);
        expect(worker.lastError, isNull);
        expect(queue._deliveryLogsById.length, 1);
        expect(queue._deliveryLogsById.values.single.success, isTrue);
        expect(queue._deliveryLogsById.values.single.error, isNull);
      });

      test('server rejection sets isLastUploadSuccess=false', () async {
        final queue = _StubQueue()..seed(_pending('p1'));
        final before = DateTime.now().toUtc();
        final worker = _worker(queue, _StubSerializer(), _StubTransport()..shouldFail = true);

        await worker.run();

        expect(worker.isLastUploadSuccess, isFalse);
        expect(worker.lastUploadTimeUtc, isNotNull);
        expect(worker.lastUploadTimeUtc!.isAfter(before), isTrue);
        expect(worker.lastError, isNotEmpty);
        expect(queue._deliveryLogsById.length, 1);
        expect(queue._deliveryLogsById.values.single.success, isFalse);
      });

      test('transport exception sets lastError=transport_exception and lastClientError=false', () async {
        final queue = _StubQueue()..seed(_pending('p1'));
        final worker = _worker(queue, _StubSerializer(), _ThrowingTransport());

        await worker.run();

        expect(worker.isLastUploadSuccess, isFalse);
        expect(worker.lastError, 'transport_exception');
      });

      test('retryCount increments on repeated attempts within the same hour', () async {
        final queue = _StubQueue()..seed(_pending('p1'));
        final worker = _worker(queue, _StubSerializer(), _StubTransport()..shouldFail = true);

        final first = await worker.run();
        final second = await worker.run();

        expect(first, isFalse);
        expect(second, isFalse);
        expect(queue._deliveryLogsById.length, 1);
        expect(queue._deliveryLogsById.values.single.retryCount, 1);
      });

      test('successive successful batches update lastUploadTimeUtc to the most recent', () async {
        final queue = _StubQueue()
          ..seed(_pending('p1'))
          ..seed(_pending('p2'));
        // batchSize=1 forces two separate successful transport calls.
        final worker = _worker(queue, _StubSerializer(), _StubTransport(), config: _config(maxBatchSize: 1));
        final before = DateTime.now().toUtc();

        await worker.run();

        expect(worker.isLastUploadSuccess, isTrue);
        expect(worker.lastUploadTimeUtc!.isAfter(before), isTrue);
        expect(await queue.pendingCount(), 0);
      });
    });
  });
}
