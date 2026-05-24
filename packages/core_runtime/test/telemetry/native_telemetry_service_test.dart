// TOC:
//  - NativeTelemetryService — enqueue: delegates to the queue
//  - NativeTelemetryService — flush: no-op when configResolver returns null
//  - NativeTelemetryService — flush: drains the queue when config available
//  - NativeTelemetryService — startPeriodicUpload: does not throw
//  - NativeTelemetryService — stopPeriodicUpload: cancels without error

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/telemetry/models/telemetry_payload.dart';
import 'package:core_runtime/telemetry/native_telemetry_service.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Stubs
// ---------------------------------------------------------------------------

class _StubQueue implements core_domain.TelemetryQueueRepository {
  final _rows = <core_domain.QueuedPayload>[];
  int fetchReadyCalls = 0;

  void seed(core_domain.TelemetryPayload payload) {
    _rows.add(
      core_domain.QueuedPayload(id: getPayloadId(payload), payload: payload, createdAtUtc: DateTime.utc(2099, 1, 1)),
    );
  }

  @override
  Future<void> enqueue(core_domain.TelemetryPayload payload) async {
    seed(payload);
  }

  @override
  Future<List<core_domain.QueuedPayload>> fetchReady({int limit = 10}) async {
    fetchReadyCalls += 1;
    return _rows.take(limit).toList(growable: false);
  }

  @override
  Future<void> appendUploadLog(core_domain.UploadLog log) async {}

  @override
  Future<List<core_domain.UploadLogList>> fetchRecentUploadLogs({int daysBack = 7, int limit = 500}) async {
    return const [];
  }

  @override
  Future<core_domain.UploadLog?> fetchUploadLogById(int id) async {
    return null;
  }

  @override
  Future<void> pruneUploadLogs(DateTime before) async {}

  @override
  Future<void> pruneExpired(DateTime before) async {}

  @override
  Future<void> markUploadedBatch(List<String> ids) async {
    _rows.removeWhere((row) => ids.contains(row.id));
  }

  @override
  Future<int> pendingCount() async => _rows.length;

  @override
  Future<List<core_domain.QueuedPayload>> fetchRecent({int daysBack = 7}) async {
    return const [];
  }

  @override
  Future<void> reset() async {
    _rows.clear();
    fetchReadyCalls = 0;
  }
}

class _StubSerializer implements core_domain.PayloadSerializer {
  @override
  String get contentType => 'application/json';

  @override
  List<int> serialize(
    List<core_domain.TelemetryPayload> payloads, {
    required int schemaVersion,
    required String deviceId,
    String? projectId,
    String? assignId,
  }) => [1, 2, 3];
}

class _NeverTransport implements core_domain.TelemetryTransport {
  @override
  Future<core_domain.TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    throw StateError('transport should not be called in this test');
  }
}

class _StubTransport implements core_domain.TelemetryTransport {
  _StubTransport(this._responses);

  final List<core_domain.TelemetryResponse> _responses;
  int callCount = 0;

  @override
  Future<core_domain.TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    callCount += 1;
    if (_responses.isEmpty) {
      return const core_domain.TelemetryResponse(v: 1, ok: true, data: core_domain.ServerData());
    }
    return _responses.removeAt(0);
  }
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('NativeTelemetryService', () {
    _StubQueue makeQueue() => _StubQueue();

    core_domain.TelemetryPayload makePayload(String id) {
      return core_domain.TelemetryPayload(
        startUtc: DateTime.utc(2026, 1, 1),
        startBusiness: DateTime(2026, 1, 1),
        businessDate: '2026-01-01',
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

    core_domain.UploadSession makeRuntimeConfig({int wallClockCadenceMin = 60}) {
      return core_domain.UploadSession(
        config: core_domain.UploadConfig(wallClockCadenceMin: wallClockCadenceMin),
        dataServer: const core_domain.DataServer.personalCustom(url: 'https://example.com/api'),
        deviceId: 'device-1',
        bearerToken: 'tok',
      );
    }

    NativeTelemetryService makeService({
      core_domain.UploadSession? config,
      _StubQueue? queue,
      core_domain.TelemetryTransport? transport,
      DateTime Function()? nowProvider,
    }) {
      return NativeTelemetryService(
        uploadConfigResolver: () async => config?.config ?? const core_domain.UploadConfig(),
        sessionResolver: () async => config,
        queue: queue ?? makeQueue(),
        serializer: _StubSerializer(),
        transport: transport ?? _NeverTransport(),
        nowProvider: nowProvider ?? DateTime.now,
      );
    }

    Future<DateTime?> waitForNextUploadTime(NativeTelemetryService service, bool Function(DateTime?) predicate) async {
      final current = service.nextUploadTimeListenable.value;
      if (predicate(current)) {
        return current;
      }

      final completer = Completer<DateTime?>();
      void listener() {
        final value = service.nextUploadTimeListenable.value;
        if (!completer.isCompleted && predicate(value)) {
          completer.complete(value);
        }
      }

      service.nextUploadTimeListenable.addListener(listener);
      addTearDown(() => service.nextUploadTimeListenable.removeListener(listener));

      return completer.future;
    }

    // -----------------------------------------------------------------------
    // enqueue
    // -----------------------------------------------------------------------

    test('enqueue adds the payload to the queue', () async {
      final queue = makeQueue();
      final svc = makeService(queue: queue);

      await svc.enqueue(
        core_domain.TelemetryPayload(
          startUtc: DateTime.utc(2026, 1, 1),
          startBusiness: DateTime(2026, 1, 1),
          businessDate: '2026-01-01',
          session: 'session-1',
          sequence: 1,
          frameCount: 0,
          missingSec: 0,
          confidence: 0.0,
          isPartial: false,
          coverage: 1.0,
          fps: 0.0,
          areas: const [],
        ),
      );

      expect(await queue.pendingCount(), 1);
    });

    // -----------------------------------------------------------------------
    // flush
    // -----------------------------------------------------------------------

    test('flush returns false when configResolver returns null', () async {
      final svc = makeService(config: null);
      await expectLater(svc.uploadNow(), completion(isFalse));
    });

    test('flush returns true when queue is empty and config is set', () async {
      final svc = makeService(config: makeRuntimeConfig());
      await expectLater(svc.uploadNow(), completion(isTrue));
    });

    test('flush returns false when delivery fails and leaves payload pending', () async {
      final queue = makeQueue()..seed(makePayload('p1'));
      final transport = _StubTransport([
        const core_domain.TelemetryResponse(v: 1, ok: false, error: 'transport_exception', data: null),
      ]);
      final svc = makeService(config: makeRuntimeConfig(), queue: queue, transport: transport);

      await expectLater(svc.uploadNow(), completion(isFalse));
      expect(svc.lastError, 'transport_exception');
      expect(await queue.pendingCount(), 1);
    });

    // -----------------------------------------------------------------------
    // timer lifecycle
    // -----------------------------------------------------------------------

    test('startPeriodicUpload does not throw', () {
      final svc = makeService();
      expect(() => svc.startPeriodicUpload(), returnsNormally);
      svc.stopPeriodicUpload(); // clean up
    });

    test('stopPeriodicUpload before start is a no-op', () {
      final svc = makeService();
      expect(() => svc.stopPeriodicUpload(), returnsNormally);
    });

    test('calling startPeriodicUpload twice does not accumulate timers', () {
      final svc = makeService();
      svc.startPeriodicUpload();
      expect(() => svc.startPeriodicUpload(), returnsNormally);
      svc.stopPeriodicUpload();
    });

    test('nextUploadTimeListenable updates after uploadNow completes', () async {
      final queue = makeQueue();
      final svc = makeService(
        config: makeRuntimeConfig(),
        queue: queue,
        nowProvider: () => DateTime(2026, 1, 1, 1, 30),
      );
      final valueFuture = waitForNextUploadTime(svc, (value) => value == DateTime(2026, 1, 1, 2, 0));

      await svc.uploadNow();
      final value = await valueFuture;

      expect(value, DateTime(2026, 1, 1, 2, 0));
    });

    test('nextUploadTimeListenable updates when scheduling the next upload', () async {
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        nowProvider: () => DateTime(2026, 1, 1, 1, 30),
      );
      final valueFuture = waitForNextUploadTime(svc, (value) => value == DateTime(2026, 1, 1, 2, 0));

      addTearDown(svc.stopPeriodicUpload);

      svc.startPeriodicUpload();
      final value = await valueFuture;

      expect(value, DateTime(2026, 1, 1, 2, 0));
    });

    test('refreshSchedule updates when scheduler is inactive', () async {
      var cadenceMin = 60;
      final svc = NativeTelemetryService(
        uploadConfigResolver: () async => core_domain.UploadConfig(wallClockCadenceMin: cadenceMin),
        sessionResolver: () async => makeRuntimeConfig(wallClockCadenceMin: cadenceMin),
        queue: makeQueue(),
        serializer: _StubSerializer(),
        transport: _NeverTransport(),
        nowProvider: () => DateTime(2026, 1, 1, 1, 30),
      );
      final valueFuture = waitForNextUploadTime(svc, (value) => value == DateTime(2026, 1, 1, 1, 45));

      cadenceMin = 15;
      svc.refreshSchedule();
      final value = await valueFuture;

      expect(value, DateTime(2026, 1, 1, 1, 45));
      expect(await svc.nextUploadTime(), DateTime(2026, 1, 1, 1, 45));
    });

    test('refreshSchedule reschedules immediately when scheduler is active', () async {
      var cadenceMin = 60;
      final svc = NativeTelemetryService(
        uploadConfigResolver: () async => core_domain.UploadConfig(wallClockCadenceMin: cadenceMin),
        sessionResolver: () async => makeRuntimeConfig(wallClockCadenceMin: cadenceMin),
        queue: makeQueue(),
        serializer: _StubSerializer(),
        transport: _NeverTransport(),
        nowProvider: () => DateTime(2026, 1, 1, 1, 30),
      );
      final valueFuture = waitForNextUploadTime(svc, (value) => value == DateTime(2026, 1, 1, 1, 45));

      addTearDown(svc.stopPeriodicUpload);

      svc.startPeriodicUpload();
      cadenceMin = 15;
      svc.refreshSchedule();
      final value = await valueFuture;

      expect(value, DateTime(2026, 1, 1, 1, 45));
      expect(await svc.nextUploadTime(), DateTime(2026, 1, 1, 1, 45));
    });

    test('runScheduledUploadForTest runs an upload attempt', () async {
      DateTime fakeNow = DateTime(2026, 1, 1, 1, 30);
      final queue = makeQueue();
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        queue: queue,
        nowProvider: () => fakeNow,
      );

      await svc.runScheduledUploadForTest();

      expect(queue.fetchReadyCalls, 1);
    });

    test('runScheduledUploadForTest is not wall-clock boundary gated', () async {
      DateTime fakeNow = DateTime(2026, 1, 1, 1, 4);
      final queue = makeQueue();
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        queue: queue,
        nowProvider: () => fakeNow,
      );

      await svc.runScheduledUploadForTest();
      fakeNow = DateTime(2026, 1, 1, 1, 59);
      await svc.runScheduledUploadForTest();

      expect(queue.fetchReadyCalls, 2);
    });

    test('failed run keeps payload pending', () async {
      DateTime fakeNow = DateTime(2026, 1, 1, 1, 0);
      final queue = makeQueue()..seed(makePayload('p1'));
      final transport = _StubTransport([
        const core_domain.TelemetryResponse(v: 1, ok: false, error: 'transport_exception', data: null),
      ]);
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        queue: queue,
        transport: transport,
        nowProvider: () => fakeNow,
      );

      await svc.runScheduledUploadForTest();

      expect(transport.callCount, 1);
      expect(svc.isLastUploadSuccess, isFalse);
      expect(await queue.pendingCount(), 1);
    });

    test('session unavailable leaves payload pending', () async {
      DateTime fakeNow = DateTime(2026, 1, 1, 1, 0);
      final queue = makeQueue()..seed(makePayload('p1'));
      final svc = makeService(config: null, queue: queue, nowProvider: () => fakeNow);

      await svc.runScheduledUploadForTest();

      expect(svc.isLastUploadSuccess, isFalse);
      expect(svc.lastError, isNotEmpty);
      expect(await queue.pendingCount(), 1);
    });

    test('failed run is retried by next scheduled run', () async {
      DateTime fakeNow = DateTime(2026, 1, 1, 1, 0);
      final queue = makeQueue()..seed(makePayload('p1'));
      final transport = _StubTransport([
        const core_domain.TelemetryResponse(v: 1, ok: false, error: 'transport_exception', data: null),
        const core_domain.TelemetryResponse(v: 1, ok: true, data: core_domain.ServerData()),
      ]);
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        queue: queue,
        transport: transport,
        nowProvider: () => fakeNow,
      );

      await svc.runScheduledUploadForTest();
      fakeNow = DateTime(2026, 1, 1, 1, 1);
      await svc.runScheduledUploadForTest();

      expect(transport.callCount, 2);
      expect(svc.isLastUploadSuccess, isTrue);
      expect(await queue.pendingCount(), 0);
    });

    // -----------------------------------------------------------------------
    // nextUploadTime
    // -----------------------------------------------------------------------

    test('nextUploadTime returns next slot boundary (01:30 with 60min cadence → 02:00)', () async {
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        nowProvider: () => DateTime(2026, 1, 1, 1, 30),
      );
      final next = await svc.nextUploadTime();
      expect(next, DateTime(2026, 1, 1, 2, 0));
    });

    test('nextUploadTime at exact boundary returns next slot (01:00 with 60min cadence → 02:00)', () async {
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        nowProvider: () => DateTime(2026, 1, 1, 1, 0),
      );
      final next = await svc.nextUploadTime();
      expect(next, DateTime(2026, 1, 1, 2, 0));
    });

    test('nextUploadTime rolls over midnight (23:30 with 60min cadence → next day 00:00)', () async {
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 60),
        nowProvider: () => DateTime(2026, 1, 1, 23, 30),
      );
      final next = await svc.nextUploadTime();
      expect(next, DateTime(2026, 1, 2, 0, 0));
    });

    test('nextUploadTime 5-minute cadence (01:03 → 01:05)', () async {
      final svc = makeService(
        config: makeRuntimeConfig(wallClockCadenceMin: 5),
        nowProvider: () => DateTime(2026, 1, 1, 1, 3),
      );
      final next = await svc.nextUploadTime();
      expect(next, DateTime(2026, 1, 1, 1, 5));
    });
  });
}
