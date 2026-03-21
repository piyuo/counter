// TOC:
//  - NativeTelemetryService integration — flush applies server config overrides via HttpTelemetryTransport
//  - NativeTelemetryService integration — malformed response body does not override local AppState
//  - NativeTelemetryService integration — flush + retention pruning with DriftPayloadQueueRepository
//  - NativeTelemetryService integration — repeated flush does not resend delivered payload
//  - NativeTelemetryService integration — pruneExpired keeps recent payloads and pending rows

import 'dart:convert';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/drift_payload_queue_repository.dart';
import 'package:core_runtime/telemetry/http_telemetry_transport.dart';
import 'package:core_runtime/telemetry/native_telemetry_service.dart';
import 'package:core_runtime/telemetry/telemetry_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

Future<TelemetryDatabase> _openTempTelemetryDb() async {
  final tempDir = await Directory.systemTemp.createTemp('native_telemetry_service_integration_test_');
  final dbPath = '${tempDir.path}${Platform.pathSeparator}telemetry_test.db';
  final db = await TelemetryDatabase.open(filePath: dbPath);

  addTearDown(() async {
    await db.close();
    await TelemetryDatabase.remove(filePath: dbPath);
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  return db;
}

void main() {
  group('NativeTelemetryService integration', () {
    test('flush applies server detection/detectionParams/deliveryConfig overrides to AppState', () async {
      final repo = _FakeAppStateRepository(const core_domain.AppState(deviceId: 'device-1'));
      final container = ProviderContainer(
        overrides: [core_domain.appStateRepositoryProvider.overrideWith((ref) => repo)],
      );
      addTearDown(container.dispose);

      final queue = _ReadyOnceQueue(
        core_domain.QueuedPayload(
          id: 'p1',
          payload: core_domain.TelemetryPayload(
            id: 'p1',
            startUtc: DateTime.utc(2026, 1, 1, 0, 0),
            endUtc: DateTime.utc(2026, 1, 1, 0, 5),
            sessionId: 'session-1',
            windowIndex: 1,
            frameCount: 0,
            missingDurationMs: 0,
            confidence: 0.0,
            isPartial: false,
            coverageRatio: 1.0,
            fps: 0.0,
            areas: const [],
          ),
          createdAtUtc: DateTime.utc(2026, 1, 1, 0, 0),
        ),
      );

      final responseBody = jsonEncode({
        'error': '',
        'detection': {'runtimeType': 'vehicle'},
        'detectionParams': {'trackHighThresh': 0.77},
        'deliveryConfig': {'intervalMin': 15},
      });

      final transport = HttpTelemetryTransport(
        client: _FakeHttpClient((request) async => http.Response(responseBody, 200)),
      );
      final service = NativeTelemetryService.withDependencies(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personal(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: transport,
        responseWorker: core_domain.ResponseWorker(
          onServerConfigOverride: ({detection, detectionParams, deliveryConfig}) async {
            await container
                .read(core_domain.appProvider.notifier)
                .applyServerConfigOverrides(
                  detection: detection,
                  detectionParams: detectionParams,
                  deliveryConfig: deliveryConfig,
                );
          },
        ),
      );

      await service.uploadNow();

      final state = await container.read(core_domain.appProvider.future);
      expect(state.detection, const core_domain.DetectionType.vehicle());
      expect(state.detectionParams.trackHighThresh, 0.77);
      expect(state.uploadConfig.wallClockCadenceMin, 15);
      expect(queue.markedSuccessIds, ['p1']);
    });

    test('flush with malformed JSON still marks success and keeps AppState unchanged', () async {
      final initialState = const core_domain.AppState(deviceId: 'device-1');
      final repo = _FakeAppStateRepository(initialState);
      final container = ProviderContainer(
        overrides: [core_domain.appStateRepositoryProvider.overrideWith((ref) => repo)],
      );
      addTearDown(container.dispose);

      final queue = _ReadyOnceQueue(
        core_domain.QueuedPayload(
          id: 'p2',
          payload: core_domain.TelemetryPayload(
            id: 'p2',
            startUtc: DateTime.utc(2026, 1, 1, 0, 5),
            endUtc: DateTime.utc(2026, 1, 1, 0, 10),
            sessionId: 'session-1',
            windowIndex: 1,
            frameCount: 0,
            missingDurationMs: 0,
            confidence: 0.0,
            isPartial: false,
            coverageRatio: 1.0,
            fps: 0.0,
            areas: const [],
          ),
          createdAtUtc: DateTime.utc(2026, 1, 1, 0, 0),
        ),
      );

      final transport = HttpTelemetryTransport(
        client: _FakeHttpClient((request) async => http.Response('{not-json', 200)),
      );
      final service = NativeTelemetryService.withDependencies(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personal(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: transport,
        responseWorker: core_domain.ResponseWorker(
          onServerConfigOverride: ({detection, detectionParams, deliveryConfig}) async {
            await container
                .read(core_domain.appProvider.notifier)
                .applyServerConfigOverrides(
                  detection: detection,
                  detectionParams: detectionParams,
                  deliveryConfig: deliveryConfig,
                );
          },
        ),
      );

      await service.uploadNow();

      final state = await container.read(core_domain.appProvider.future);
      expect(state, initialState);
      expect(queue.markedSuccessIds, ['p2']);
    });

    test('flush marks delivered history and pruneExpired applies retention on Drift queue', () async {
      final db = await _openTempTelemetryDb();
      final queue = DriftPayloadQueueRepository(db);

      final service = NativeTelemetryService.withDependencies(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personal(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: const _NoopSuccessTransport(),
      );

      await service.enqueue(
        core_domain.TelemetryPayload(
          id: 'p-reset',
          startUtc: DateTime.utc(2026, 1, 1, 0, 0),
          endUtc: DateTime.utc(2026, 1, 1, 0, 5),
          sessionId: 'session-1',
          windowIndex: 1,
          frameCount: 0,
          missingDurationMs: 0,
          confidence: 0.0,
          isPartial: false,
          coverageRatio: 1.0,
          fps: 0.0,
          areas: const [],
        ),
      );

      await service.uploadNow();

      final availableBeforePrune = await queue.fetchRecent(daysBack: 7);
      expect(availableBeforePrune.map((p) => p.id), contains('p-reset'));
      expect(await queue.pendingCount(), 0);

      final oldCreatedMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await (db.update(
        db.telemetryQueue,
      )..where((t) => t.id.equals('p-reset'))).write(TelemetryQueueCompanion(createdAtMs: Value(oldCreatedMs)));

      await queue.pruneExpired(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final availableAfterPrune = await queue.fetchRecent(daysBack: 7);
      expect(availableAfterPrune.map((p) => p.id), isNot(contains('p-reset')));
    });

    test('repeated flush does not resend already-delivered payload', () async {
      final db = await _openTempTelemetryDb();
      final queue = DriftPayloadQueueRepository(db);
      final transport = _CountingSuccessTransport();

      final service = NativeTelemetryService.withDependencies(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personal(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: transport,
      );

      await service.enqueue(
        core_domain.TelemetryPayload(
          id: 'p-once',
          startUtc: DateTime.utc(2026, 1, 1, 0, 0),
          endUtc: DateTime.utc(2026, 1, 1, 0, 5),
          sessionId: 'session-1',
          windowIndex: 1,
          frameCount: 0,
          missingDurationMs: 0,
          confidence: 0.0,
          isPartial: false,
          coverageRatio: 1.0,
          fps: 0.0,
          areas: const [],
        ),
      );

      await service.uploadNow();
      await service.uploadNow();

      expect(transport.sendCount, 1);
      expect(await queue.pendingCount(), 0);
      final available = await queue.fetchRecent(daysBack: 7);
      final delivered = available.where((p) => p.uploadedAtUtc != null).map((p) => p.id);
      expect(delivered, contains('p-once'));
    });

    test('pruneExpired keeps recent payloads and does not remove pending payloads', () async {
      final db = await _openTempTelemetryDb();
      final queue = DriftPayloadQueueRepository(db);
      final service = NativeTelemetryService.withDependencies(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personal(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: const _NoopSuccessTransport(),
      );

      // First payload is delivered via flush.
      await service.enqueue(
        core_domain.TelemetryPayload(
          id: 'p-delivered',
          startUtc: DateTime.utc(2026, 1, 1, 0, 0),
          endUtc: DateTime.utc(2026, 1, 1, 0, 5),
          sessionId: 'session-1',
          windowIndex: 1,
          frameCount: 0,
          missingDurationMs: 0,
          confidence: 0.0,
          isPartial: false,
          coverageRatio: 1.0,
          fps: 0.0,
          areas: const [],
        ),
      );
      await service.uploadNow();

      // Second payload remains pending (not flushed).
      await service.enqueue(
        core_domain.TelemetryPayload(
          id: 'p-pending',
          startUtc: DateTime.utc(2026, 1, 1, 1, 0),
          endUtc: DateTime.utc(2026, 1, 1, 1, 5),
          sessionId: 'session-1',
          windowIndex: 2,
          frameCount: 0,
          missingDurationMs: 0,
          confidence: 0.0,
          isPartial: false,
          coverageRatio: 1.0,
          fps: 0.0,
          areas: const [],
        ),
      );

      await queue.pruneExpired(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final available = await queue.fetchRecent(daysBack: 7);
      final pending = await queue.fetchReady(limit: 10);
      expect(available.map((p) => p.id), contains('p-delivered'));
      expect(pending.map((p) => p.id), contains('p-pending'));
      expect(await queue.pendingCount(), 1);
    });
  });
}

class _NoopSuccessTransport implements core_domain.TelemetryTransport {
  const _NoopSuccessTransport();

  @override
  Future<core_domain.TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async => const core_domain.TelemetryResponse(v: 1, ok: true, data: core_domain.ServerData());
}

class _CountingSuccessTransport implements core_domain.TelemetryTransport {
  int sendCount = 0;

  @override
  Future<core_domain.TelemetryResponse> send({
    required String url,
    required String? bearerToken,
    required List<int> body,
    required String contentType,
  }) async {
    sendCount += 1;
    return const core_domain.TelemetryResponse(v: 1, ok: true, data: core_domain.ServerData());
  }
}

class _FakeAppStateRepository implements core_domain.AppStateRepository {
  _FakeAppStateRepository(this._state);

  core_domain.AppState _state;

  @override
  Future<core_domain.AppState> load() async => _state;

  @override
  Future<void> reset() async {
    _state = const core_domain.AppState();
  }

  @override
  Future<void> save(core_domain.AppState state) async {
    _state = state;
  }
}

class _ReadyOnceQueue implements core_domain.TelemetryQueueRepository {
  _ReadyOnceQueue(this.pending);

  final core_domain.QueuedPayload pending;
  bool _returned = false;
  final List<String> markedSuccessIds = [];

  @override
  Future<void> enqueue(core_domain.TelemetryPayload payload) async {}

  @override
  Future<List<core_domain.QueuedPayload>> fetchReady({int limit = 10}) async {
    if (_returned) return const [];
    _returned = true;
    return [pending];
  }

  @override
  Future<void> appendUploadLog(core_domain.UploadLog log) async {}

  @override
  Future<List<core_domain.UploadLogList>> fetchRecentUploadLogs({int daysBack = 10, int limit = 500}) async {
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
    markedSuccessIds.addAll(ids);
  }

  @override
  Future<int> pendingCount() async => _returned ? 0 : 1;

  @override
  Future<List<core_domain.QueuedPayload>> fetchRecent({int daysBack = 10}) async {
    return _returned ? const [] : [pending];
  }
}

class _JsonSerializer implements core_domain.PayloadSerializer {
  const _JsonSerializer();

  @override
  String get contentType => 'application/json';

  @override
  List<int> serialize(
    List<core_domain.TelemetryPayload> payloads, {
    required int schemaVersion,
    required String deviceId,
  }) {
    final body = <String, Object?>{
      'schema': schemaVersion,
      'deviceId': deviceId,
      'payloads': payloads.map((p) => p.toJson()).toList(growable: false),
    };
    return utf8.encode(jsonEncode(body));
  }
}

class _FakeHttpClient extends http.BaseClient {
  _FakeHttpClient(this._handler);

  final Future<http.Response> Function(http.BaseRequest request) _handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request);
    return http.StreamedResponse(
      Stream<List<int>>.value(response.bodyBytes),
      response.statusCode,
      request: request,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
