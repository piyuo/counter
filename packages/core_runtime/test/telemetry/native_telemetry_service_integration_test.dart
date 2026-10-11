// TOC:
//  - NativeTelemetryService integration — flush applies server config overrides via HttpTelemetryTransport
//  - NativeTelemetryService integration — malformed response body does not override local AppState
//  - NativeTelemetryService integration — flush + retention pruning with DriftPayloadQueueRepository
//  - NativeTelemetryService integration — repeated flush does not resend delivered payload
//  - NativeTelemetryService integration — pruneExpired keeps recent payloads and pending rows

import 'dart:convert';
import 'dart:io';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/telemetry/drift_telemetry_database.dart';
import 'package:core_runtime/telemetry/drift_telemetry_queue.dart';
import 'package:core_runtime/telemetry/http_telemetry_transport.dart';
import 'package:core_runtime/telemetry/native_telemetry_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

Future<TelemetryDatabaseFun> _openTempTelemetryDb() async {
  final tempDir = await Directory.systemTemp.createTemp('native_telemetry_service_integration_test_');
  final dbPath = '${tempDir.path}${Platform.pathSeparator}telemetry_test.db';
  final db = await DriftTelemetryDatabase.open(filePath: dbPath);

  addTearDown(() async {
    await db()!.close();
    await DriftTelemetryDatabase.removeFile(filePath: dbPath);
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  return db;
}

core_domain.Observation _observation({required DateTime startUtc}) {
  final startBusiness = startUtc.toLocal();
  return core_domain.Observation(
    granularity: core_domain.ObservationGranularity.minutes5,
    year: startBusiness.year,
    month: startBusiness.month,
    day: startBusiness.day,
    hour: startBusiness.hour,
    minute: startBusiness.minute,
    frameCount: 0,
    confidenceRatioSum: 0,
    confidenceSampleCount: 0,
    confidenceRatio: 0,
    coveredSeconds: 1,
    expectedSeconds: 1,
    coverageRatio: 1,
    areas: const [],
  );
}

int _observationId({required DateTime startUtc}) => _observation(startUtc: startUtc).id;

String _payloadId({required DateTime startUtc}) => _observationId(startUtc: startUtc).toString();

void main() {
  group('NativeTelemetryService integration', () {
    test('flush applies server detection/detectionParams/deliveryConfig overrides to AppState', () async {
      final repo = _FakeAppStateRepository(const core_domain.AppState(deviceId: 'device-1'));
      final container = ProviderContainer(
        overrides: [
          core_domain.appStateRepositoryProvider.overrideWith((ref) => repo),
          core_domain.hardwareCapabilityServiceProvider.overrideWith((ref) => _FakeHardwareCapabilityService()),
          core_domain.authStorageServiceProvider.overrideWith((ref) => _FakeAuthStorageService()),
        ],
      );
      addTearDown(container.dispose);
      final queue = _ReadyOnceQueue(
        core_domain.QueuedObservation(
          observation: _observation(startUtc: DateTime.utc(2026, 1, 1, 0, 0)),
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
      final service = NativeTelemetryService(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personalCustom(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: transport,
        responseWorker: core_domain.ResponseWorker(
          onServerConfigOverride: ({detectionType, detectionParams, deliveryConfig}) async {
            await container
                .read(core_domain.appProvider.notifier)
                .applyServerConfigOverrides(
                  detectionType: detectionType,
                  detectionParams: detectionParams,
                  deliveryConfig: deliveryConfig,
                );
          },
        ),
      );

      await service.uploadNow();

      final state = await container.read(core_domain.appProvider.future);
      expect(state.detectionType, const core_domain.DetectionType.vehicle());
      expect(state.detectionParams.trackHighThresh, 0.77);
      expect(state.uploadConfig.wallClockCadenceMin, 15);
      expect(queue.markedSuccessIds, [_observationId(startUtc: DateTime.utc(2026, 1, 1, 0, 0))]);
    });

    test('flush with malformed JSON still marks success and keeps AppState unchanged', () async {
      final initialState = const core_domain.AppState(deviceId: 'device-1');
      final repo = _FakeAppStateRepository(initialState);
      final container = ProviderContainer(
        overrides: [
          core_domain.appStateRepositoryProvider.overrideWith((ref) => repo),
          core_domain.hardwareCapabilityServiceProvider.overrideWith((ref) => _FakeHardwareCapabilityService()),
          core_domain.authStorageServiceProvider.overrideWith((ref) => _FakeAuthStorageService()),
        ],
      );
      addTearDown(container.dispose);

      final queue = _ReadyOnceQueue(
        core_domain.QueuedObservation(
          observation: _observation(startUtc: DateTime.utc(2026, 1, 1, 0, 5)),
          createdAtUtc: DateTime.utc(2026, 1, 1, 0, 0),
        ),
      );

      final transport = HttpTelemetryTransport(
        client: _FakeHttpClient((request) async => http.Response('{not-json', 200)),
      );
      final service = NativeTelemetryService(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personalCustom(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: transport,
        responseWorker: core_domain.ResponseWorker(
          onServerConfigOverride: ({detectionType, detectionParams, deliveryConfig}) async {
            await container
                .read(core_domain.appProvider.notifier)
                .applyServerConfigOverrides(
                  detectionType: detectionType,
                  detectionParams: detectionParams,
                  deliveryConfig: deliveryConfig,
                );
          },
        ),
      );

      await service.uploadNow();

      final state = await container.read(core_domain.appProvider.future);
      expect(state, initialState);
      expect(queue.markedSuccessIds, [_observationId(startUtc: DateTime.utc(2026, 1, 1, 0, 5))]);
    });

    test('flush marks delivered history and pruneExpired applies retention on Drift queue', () async {
      final db = await _openTempTelemetryDb();
      final queue = DriftTelemetryQueue(db);

      final service = NativeTelemetryService(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personalCustom(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: const _NoopSuccessTransport(),
      );

      await service.enqueue(_observation(startUtc: DateTime.utc(2026, 1, 1, 0, 0)));

      await service.uploadNow();

      final availableBeforePrune = await queue.fetchRecent(daysBack: 7);
      final payloadId = _payloadId(startUtc: DateTime.utc(2026, 1, 1, 0, 0));
      expect(availableBeforePrune.map((p) => p.observation.id.toString()), contains(payloadId));
      expect(await queue.pendingCount(), 0);

      final oldCreatedMs = DateTime.now().toUtc().subtract(const Duration(days: 11)).millisecondsSinceEpoch;
      await (db()!.update(
        db()!.telemetryQueue,
      )..where((t) => t.id.equals(payloadId))).write(TelemetryQueueCompanion(createdAtMs: Value(oldCreatedMs)));

      await queue.pruneExpired(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final availableAfterPrune = await queue.fetchRecent(daysBack: 7);
      expect(availableAfterPrune.map((p) => p.observation.id.toString()), isNot(contains(payloadId)));
    });

    test('repeated flush does not resend already-delivered payload', () async {
      final db = await _openTempTelemetryDb();
      final queue = DriftTelemetryQueue(db);
      final transport = _CountingSuccessTransport();

      final service = NativeTelemetryService(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personalCustom(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: transport,
      );

      await service.enqueue(_observation(startUtc: DateTime.utc(2026, 1, 1, 0, 0)));

      await service.uploadNow();
      await service.uploadNow();

      expect(transport.sendCount, 1);
      expect(await queue.pendingCount(), 0);
      final available = await queue.fetchRecent(daysBack: 7);
      final delivered = available.where((p) => p.uploadedAtUtc != null).map((p) => p.observation.id.toString());
      expect(delivered, contains(_payloadId(startUtc: DateTime.utc(2026, 1, 1, 0, 0))));
    });

    test('pruneExpired keeps recent payloads and does not remove pending payloads', () async {
      final db = await _openTempTelemetryDb();
      final queue = DriftTelemetryQueue(db);
      final service = NativeTelemetryService(
        uploadConfigResolver: () async => const core_domain.UploadConfig(),
        sessionResolver: () async => const core_domain.UploadSession(
          config: core_domain.UploadConfig(),
          dataServer: core_domain.DataServer.personalCustom(url: 'https://example.com/api/telemetry'),
          deviceId: 'device-1',
          bearerToken: 'tok',
        ),
        queue: queue,
        serializer: const _JsonSerializer(),
        transport: const _NoopSuccessTransport(),
      );

      // First payload is delivered via flush.
      await service.enqueue(_observation(startUtc: DateTime.utc(2026, 1, 1, 0, 0)));
      await service.uploadNow();

      // Second payload remains pending (not flushed).
      await service.enqueue(_observation(startUtc: DateTime.utc(2026, 1, 1, 1, 0)));

      await queue.pruneExpired(DateTime.now().toUtc().subtract(const Duration(days: 10)));

      final available = await queue.fetchRecent(daysBack: 7);
      final pending = await queue.fetchReady(limit: 10);
      expect(
        available.map((p) => p.observation.id.toString()),
        contains(_payloadId(startUtc: DateTime.utc(2026, 1, 1, 0, 0))),
      );
      expect(
        pending.map((p) => p.observation.id.toString()),
        contains(_payloadId(startUtc: DateTime.utc(2026, 1, 1, 1, 0))),
      );
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

class _FakeHardwareCapabilityService implements core_domain.HardwareCapabilityService {
  @override
  Future<List<core_domain.VideoSource>> getAvailableCameras() async => [];

  @override
  Future<core_domain.VideoSource?> getDefaultVideoSource() async => null;

  @override
  Future<bool> hasCameraVideoSource() async => false;

  @override
  Future<bool> isVideoSourceValid(core_domain.VideoSource videoSource) async => false;
}

class _FakeAuthStorageService implements core_domain.AuthStorageService {
  final Map<String, String> _values = {};

  @override
  Future<String> get(String key) async => _values[key] ?? '';

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }

  @override
  Future<void> reset() async {
    _values.clear();
  }

  @override
  Future<void> set(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<bool> isExists(String key) async => _values.containsKey(key);
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

class _ReadyOnceQueue implements core_domain.TelemetryQueue {
  _ReadyOnceQueue(this.pending);

  final core_domain.QueuedObservation pending;
  bool _returned = false;
  final List<int> markedSuccessIds = [];

  @override
  Future<void> enqueue(core_domain.Observation observation) async {}

  @override
  Future<List<core_domain.QueuedObservation>> fetchReady({int limit = 10}) async {
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
  Future<void> markUploadedBatch(List<int> ids) async {
    markedSuccessIds.addAll(ids);
  }

  @override
  Future<int> pendingCount() async => _returned ? 0 : 1;

  @override
  Future<List<core_domain.QueuedObservation>> fetchRecent({int daysBack = 10}) async {
    return _returned ? const [] : [pending];
  }

  @override
  Future<void> reset() async {}
}

class _JsonSerializer implements core_domain.PayloadSerializer {
  const _JsonSerializer();

  @override
  String get contentType => 'application/json';

  @override
  List<int> serialize(
    List<core_domain.Observation> observations, {
    required String deviceId,
    String? projectId,
    String? assignId,
  }) {
    final body = <String, Object?>{
      'schema': core_domain.kSchemaVersion,
      'deviceId': deviceId,
      'observations': observations.map((p) => p.toJson()).toList(growable: false),
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
