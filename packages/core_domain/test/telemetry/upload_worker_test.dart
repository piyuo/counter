// TOC:
//  - Helpers: stub implementations and test-payload factory
//  - UploadWorker — run(): no-op when configResolver returns null
//  - UploadWorker — run(): prunes expired items before delivery
//  - UploadWorker — run(): delivers a single batch and marks success
//  - UploadWorker — run(): drains multiple batches until queue is empty
//  - UploadWorker — run(): keeps failed items pending for later attempts
//  - UploadWorker — run(): stops after first transport failure
//  - UploadWorker — run(): groups payloads by business date
//  - UploadWorker — run(): processes date groups in order
//  - UploadWorker — run(): stops on first date group failure
//  - UploadWorker — sendPayloadsDirect(): sends selected payloads immediately
//  - UploadWorker — status attributes: initial state, success, rejection, exception, discard

import 'package:core_domain/model/observation.dart';
import 'package:core_domain/state/models/data_server.dart';
import 'package:core_domain/state/models/upload_config.dart';
import 'package:core_domain/telemetry/models/queued_observation.dart';
import 'package:core_domain/telemetry/models/telemetry_response.dart';
import 'package:core_domain/telemetry/models/upload_log.dart';
import 'package:core_domain/telemetry/models/upload_log_list.dart';
import 'package:core_domain/telemetry/models/upload_session.dart';
import 'package:core_domain/telemetry/services/payload_serializer.dart';
import 'package:core_domain/telemetry/services/telemetry_queue.dart';
import 'package:core_domain/telemetry/services/telemetry_transport.dart';
import 'package:core_domain/telemetry/upload_worker.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Creates a minimal [Observation] for the given integer business date.
Observation _observation({int date = 20260101, int time = 0}) {
  return Observation(
    granularity: ObservationGranularity.minutes5,
    year: date ~/ 10000,
    month: date ~/ 100 % 100,
    day: date % 100,
    hour: time ~/ 100,
    minute: time % 100,
    confidenceRatioSum: 0,
    confidenceSampleCount: 0,
    confidenceRatio: 0,
    coveredSeconds: 0,
    expectedSeconds: 0,
    coverageRatio: 0,
    areas: const [],
    frameCount: 0,
  );
}

/// [createdAt] defaults to a far-future date (2099) so it is never pruned by
/// [TelemetryQueue.pruneExpired] in tests that use [_config] defaults.
QueuedObservation _pending(String testSeed, {DateTime? createdAt, Observation? observation}) {
  final seedMinutes = testSeed.codeUnits.fold<int>(0, (total, unit) => total + unit) % 1440;
  final time = (seedMinutes ~/ 60) * 100 + seedMinutes % 60;
  return QueuedObservation(
    observation: observation ?? _observation(time: time),
    createdAtUtc: createdAt ?? DateTime.utc(2099, 1, 1),
  );
}

/// A persisted [UploadConfig] with small limits to keep tests concise.
UploadConfig _deliveryConfig() => UploadConfig();

UploadSession _config() => UploadSession(
  config: _deliveryConfig(),
  dataServer: const DataServer.personalCustom(url: 'https://example.com/api'),
  deviceId: 'device-1',
  bearerToken: 'tok_test',
);

// ---------------------------------------------------------------------------
// Stub implementations
// ---------------------------------------------------------------------------

class _StubQueue implements TelemetryQueue {
  final _rows = <QueuedObservation>[];
  final _deliveryLogsById = <int, UploadLog>{};
  final _successfulIds = <int>{};
  DateTime? lastPrunedBefore;
  DateTime? lastDeliveryLogPrunedBefore;

  void seed(QueuedObservation row) => _rows.add(row);

  @override
  Future<void> enqueue(Observation observation) async {
    _rows.add(_pending(observation.id.toString(), observation: observation));
  }

  @override
  Future<List<QueuedObservation>> fetchReady({int limit = 10}) async {
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
  Future<void> markUploadedBatch(List<int> ids) async {
    _successfulIds.addAll(ids);
    _rows.removeWhere((p) => ids.contains(p.observation.id));
  }

  @override
  Future<void> pruneExpired(DateTime before) async {
    lastPrunedBefore = before;
    _rows.removeWhere((p) => p.createdAtUtc.isBefore(before));
  }

  @override
  Future<int> pendingCount() async => _rows.length;

  @override
  Future<List<QueuedObservation>> fetchRecent({int daysBack = 7}) async => List.of(_rows);

  @override
  Future<void> reset() async {
    _rows.clear();
    _deliveryLogsById.clear();
    _successfulIds.clear();
    lastPrunedBefore = null;
    lastDeliveryLogPrunedBefore = null;
  }
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
  final List<List<Observation>> serializedObservations = [];
  String? lastDeviceId;

  @override
  String get contentType => 'application/json';

  @override
  List<int> serialize(List<Observation> observations, {required String deviceId, String? projectId, String? assignId}) {
    serializedObservations.add(observations);
    lastDeviceId = deviceId;
    return [1, 2, 3];
  }
}

class _StubTransport implements TelemetryTransport {
  int callCount = 0;
  bool shouldFail = false;
  int? failOnCallNumber;
  final List<List<int>> receivedBodies = [];
  String? lastUrl;
  String? lastBearerToken;
  String? lastContentType;

  @override
  Future<TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    callCount++;
    receivedBodies.add(body);
    lastUrl = url;
    lastBearerToken = bearerToken;
    lastContentType = contentType;
    if (shouldFail || (failOnCallNumber != null && callCount == failOnCallNumber)) {
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
  group('UploadWorker.splitByDate', () {
    final worker = _worker(_StubQueue(), _StubSerializer(), _StubTransport());

    test('returns no groups for empty input', () {
      expect(worker.splitByDate([]), isEmpty);
    });

    test('sorts groups chronologically and preserves order within each group', () {
      final items = [
        _pending('later', observation: _observation(date: 20260103)),
        _pending('earlier-first', observation: _observation(date: 20260101)),
        _pending('middle', observation: _observation(date: 20260102)),
        _pending('earlier-second', observation: _observation(date: 20260101, time: 1)),
      ];

      final groups = worker.splitByDate(items);

      expect(groups.map((group) => group.map((item) => item.observation.id).toList()).toList(), [
        [items[1].observation.id, items[3].observation.id],
        [items[2].observation.id],
        [items[0].observation.id],
      ]);
    });
  });

  group('UploadWorker.deliverBatch', () {
    test('serializes and sends the batch, then runs onSuccess', () async {
      final queue = _StubQueue();
      final serializer = _StubSerializer();
      final transport = _StubTransport();
      final worker = _worker(queue, serializer, transport);
      final observations = [_observation(date: 20260101, time: 100)];
      var onSuccessCalled = false;

      final uploaded = await worker.deliverBatch(
        session: _config(),
        observations: observations,
        onSuccess: () async => onSuccessCalled = true,
      );

      expect(uploaded, isTrue);
      expect(serializer.serializedObservations.single, observations);
      expect(serializer.lastDeviceId, 'device-1');
      expect(transport.callCount, 1);
      expect(transport.lastUrl, 'https://example.com/api');
      expect(transport.lastBearerToken, 'tok_test');
      expect(transport.receivedBodies.single, [1, 2, 3]);
      expect(transport.lastContentType, 'application/json');
      expect(onSuccessCalled, isTrue);
      expect(worker.isLastUploadSuccess, isTrue);
      expect(queue._deliveryLogsById.values.single.payloadCount, 1);
    });

    test('does not run onSuccess and records the failure when transport rejects', () async {
      final queue = _StubQueue();
      final transport = _StubTransport()..shouldFail = true;
      final worker = _worker(queue, _StubSerializer(), transport);
      var onSuccessCalled = false;

      final uploaded = await worker.deliverBatch(
        session: _config(),
        observations: [_observation()],
        onSuccess: () async => onSuccessCalled = true,
      );

      expect(uploaded, isFalse);
      expect(onSuccessCalled, isFalse);
      expect(worker.isLastUploadSuccess, isFalse);
      expect(worker.lastError, 'transport_exception');
      expect(queue._deliveryLogsById.values.single.success, isFalse);
      expect(queue._deliveryLogsById.values.single.payloadCount, 1);
    });
  });

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
      final worker = _worker(queue, _StubSerializer(), transport, config: _config());

      final success = await worker.run();

      expect(success, isTrue);
      expect(transport.callCount, 1);
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
      final worker = _worker(queue, _StubSerializer(), transport, config: _config());

      final success = await worker.run();

      expect(success, isFalse);
      expect(transport.callCount, 1); // stops after first failure
      expect(await queue.pendingCount(), 2); // both items remain
    });

    // -----------------------------------------------------------------------
    // Integer business-date grouping
    // -----------------------------------------------------------------------

    test('run() groups payloads by business date and sends each date group separately', () async {
      final queue = _StubQueue()
        ..seed(_pending('p1', observation: _observation(date: 20260101)))
        ..seed(_pending('p2', observation: _observation(date: 20260101, time: 1)))
        ..seed(_pending('p3', observation: _observation(date: 20260102)))
        ..seed(_pending('p4', observation: _observation(date: 20260103)));
      final transport = _StubTransport();
      final worker = _worker(queue, _StubSerializer(), transport);

      final success = await worker.run();

      expect(success, isTrue);
      // Should make 3 transport calls: one for each unique business date.
      expect(transport.callCount, 3);
      expect(await queue.pendingCount(), 0);
    });

    test('run() orders date groups chronologically and preserves order within each date', () async {
      final queue = _StubQueue()
        // Date groups are sorted, while items within each group keep queue order.
        ..seed(_pending('p3', observation: _observation(date: 20260103, time: 300)))
        ..seed(_pending('p1a', observation: _observation(date: 20260101, time: 100)))
        ..seed(_pending('p2', observation: _observation(date: 20260102, time: 200)))
        ..seed(_pending('p1b', observation: _observation(date: 20260101, time: 105)));
      final transport = _StubTransport();
      final serializer = _StubSerializer();
      final worker = _worker(queue, serializer, transport);

      final success = await worker.run();

      expect(success, isTrue);
      expect(transport.callCount, 3);
      expect(serializer.serializedObservations.map((group) => group.first.dateKey), [20260101, 20260102, 20260103]);
      expect(
        serializer.serializedObservations
            .map((group) => group.map((observation) => observation.timeKey).toList())
            .toList(),
        [
          [100, 105],
          [200],
          [300],
        ],
      );
      // All should be uploaded
      expect(await queue.pendingCount(), 0);
    });

    test('run() keeps all payloads pending when first date group fails', () async {
      final queue = _StubQueue()
        ..seed(_pending('p1', observation: _observation(date: 20260101)))
        ..seed(_pending('p2', observation: _observation(date: 20260102)));
      final transport = _StubTransport()..failOnCallNumber = 1; // Fail on first call
      final worker = _worker(queue, _StubSerializer(), transport);

      final success = await worker.run();

      expect(success, isFalse);
      expect(transport.callCount, 1); // Stopped after first failure
      expect(await queue.pendingCount(), 2); // Both items remain pending
    });

    test('run() handles multiple payloads with same date in one batch', () async {
      final queue = _StubQueue()
        ..seed(_pending('p1', observation: _observation(date: 20260101)))
        ..seed(_pending('p2', observation: _observation(date: 20260101, time: 1)))
        ..seed(_pending('p3', observation: _observation(date: 20260101, time: 2)));
      final transport = _StubTransport();
      final worker = _worker(queue, _StubSerializer(), transport);

      final success = await worker.run();

      expect(success, isTrue);
      // All same date - should be sent in one call
      expect(transport.callCount, 1);
      expect(await queue.pendingCount(), 0);
    });

    // -----------------------------------------------------------------------
    // sendPayloadsDirect
    // -----------------------------------------------------------------------

    test('sendPayloadsDirect() sends in config-sized batches and returns true on success', () async {
      final transport = _StubTransport();
      final worker = _worker(_StubQueue(), _StubSerializer(), transport, config: _config());

      final success = await worker.sendObservationDirect([_observation(), _observation(), _observation()]);

      expect(success, isTrue);
      expect(transport.callCount, 1);
      expect(worker.isLastUploadSuccess, isTrue);
    });

    test('sendPayloadsDirect() stops at first failure and returns false', () async {
      final transport = _StubTransport()..shouldFail = true;
      final worker = _worker(_StubQueue(), _StubSerializer(), transport, config: _config());

      final success = await worker.sendObservationDirect([_observation(), _observation(), _observation()]);

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
        expect(worker.lastError!.isNotEmpty, true);
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
        expect(worker.lastError!.isNotEmpty, true);
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
        final worker = _worker(queue, _StubSerializer(), _StubTransport(), config: _config());
        final before = DateTime.now().toUtc();

        await worker.run();

        expect(worker.isLastUploadSuccess, isTrue);
        expect(worker.lastUploadTimeUtc!.isAfter(before), isTrue);
        expect(await queue.pendingCount(), 0);
      });
    });
  });
}
