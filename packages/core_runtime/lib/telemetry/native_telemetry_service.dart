// TOC:
//  - NativeTelemetryService: production TelemetryService wiring all collaborators
//
// Timer strategy:
//  - startPeriodicUpload() resolves cadence and schedules one aligned upload.
//  - After each scheduled run, the next aligned upload is scheduled again.
//  - No minute polling is used.
//  - Settings changes take effect without recreating the service.

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/foundation.dart';

import 'drift_telemetry_queue.dart';
import 'http_telemetry_transport.dart';
import 'json_payload_serializer.dart';

/// Concrete [core_domain.TelemetryService] that wires together:
/// - Drift SQLite queue ([DriftTelemetryQueue])
/// - JSON serialization ([JsonPayloadSerializer])
/// - HTTP transport ([HttpTelemetryTransport])
/// - Wall-clock aligned periodic upload driven by [core_domain.UploadConfig]
class NativeTelemetryService implements core_domain.TelemetryService {
  /// [sessionResolver] is called each time upload runs so the session always
  /// reflects the latest backend URL + token.
  ///
  /// Return null to skip upload when no backend is configured.
  ///
  /// [jitterSecResolver] returns the stable per-device upload jitter (0–180 s).
  /// Added to every wall-clock boundary to spread simultaneous uploads and
  /// prevent thundering herd. Defaults to zero jitter when omitted.
  ///
  /// [serializer], [transport], and [responseWorker] can be injected for testing.
  /// Defaults: [JsonPayloadSerializer], [HttpTelemetryTransport], and
  /// [ResponseWorker] (with [onServerConfigOverride] applied).
  NativeTelemetryService({
    required Future<core_domain.UploadConfig> Function() uploadConfigResolver,
    required Future<core_domain.UploadSession?> Function() sessionResolver,
    core_domain.ServerConfigOverrideApplier? onServerConfigOverride,
    required core_domain.TelemetryQueue queue,
    core_domain.PayloadSerializer? serializer,
    core_domain.TelemetryTransport? transport,
    core_domain.ResponseWorker? responseWorker,
    Future<int> Function() jitterSecResolver = _zeroJitter,
    DateTime Function() nowProvider = DateTime.now,
  }) : _uploadConfigResolver = uploadConfigResolver,
       _jitterSecResolver = jitterSecResolver,
       _nowProvider = nowProvider,
       _worker = core_domain.UploadWorker(
         queue: queue,
         serializer: serializer ?? const JsonPayloadSerializer(),
         transport: transport ?? HttpTelemetryTransport(),
         responseWorker: responseWorker ?? core_domain.ResponseWorker(onServerConfigOverride: onServerConfigOverride),
         sessionResolver: sessionResolver,
       ) {
    unawaited(_emitNextUploadTime());
  }

  static Future<int> _zeroJitter() async => 0;

  final Future<core_domain.UploadConfig> Function() _uploadConfigResolver;
  final Future<int> Function() _jitterSecResolver;

  final DateTime Function() _nowProvider;

  final core_domain.UploadWorker _worker;

  final ValueNotifier<DateTime?> _nextUploadTimeNotifier = ValueNotifier<DateTime?>(null);

  Timer? _scheduledUploadTimer;

  bool _schedulerActive = false;

  /// Prevents overlapping uploads when manual and scheduled triggers overlap.
  bool _uploadTickInProgress = false;

  @override
  ValueListenable<DateTime?> get nextUploadTimeListenable => _nextUploadTimeNotifier;

  @override
  Future<void> enqueue(core_domain.TelemetryPayload payload) => _worker.queue.enqueue(payload);

  @override
  Future<bool> sendNow(List<core_domain.TelemetryPayload> payloads) => _worker.sendPayloadsDirect(payloads);

  @override
  Future<bool> uploadNow() async {
    try {
      return await _worker.run();
    } finally {
      await _emitNextUploadTime();
    }
  }

  @override
  DateTime? get lastUploadTimeUtc => _worker.lastUploadTimeUtc;

  @override
  bool? get isLastUploadSuccess => _worker.isLastUploadSuccess;

  @override
  String? get lastError => _worker.lastError;

  @override
  core_domain.TelemetryErrorCode? get lastErrorCode => _worker.lastErrorCode;

  @override
  String? get url => _worker.lastUrl;

  @override
  void startPeriodicUpload() {
    stopPeriodicUpload();
    _schedulerActive = true;
    unawaited(_scheduleNextUpload());
  }

  @override
  void stopPeriodicUpload() {
    _schedulerActive = false;
    _cancelTimer();
  }

  /// Recomputes the next scheduled upload after config changes.
  ///
  /// When the scheduler is active this cancels the old timer and schedules a
  /// new one from the latest cadence. When inactive it still notifies listeners
  /// so UI can refresh the derived next-upload label immediately.
  void refreshSchedule() {
    if (_schedulerActive) {
      unawaited(_scheduleNextUpload());
      return;
    }

    unawaited(_emitNextUploadTime());
  }

  Future<void> _scheduleNextUpload() async {
    if (!_schedulerActive) return;

    final uploadConfig = await _resolveUploadConfig();
    if (!_schedulerActive) return;

    final jitterSec = await _jitterSecResolver();
    final now = _nowProvider();
    final nextTime = _nextUploadTimeFrom(now, uploadConfig.wallClockCadenceMin);
    final jitter = Duration(seconds: jitterSec);
    var delay = nextTime.difference(now) + jitter;
    if (delay.isNegative) {
      delay = Duration.zero;
    }

    await _emitNextUploadTime(nextTime.add(jitter));

    _scheduledUploadTimer?.cancel();
    _scheduledUploadTimer = Timer(delay, () {
      unawaited(_onScheduledUploadTimerFired());
    });
  }

  Future<void> _onScheduledUploadTimerFired() async {
    if (!_schedulerActive) return;

    await _runScheduledUpload();

    if (!_schedulerActive) return;
    unawaited(_scheduleNextUpload());
  }

  Future<void> _runScheduledUpload() async {
    if (_uploadTickInProgress) return;

    _uploadTickInProgress = true;

    try {
      await _worker.run();
    } finally {
      _uploadTickInProgress = false;
      await _emitNextUploadTime();
    }
  }

  @override
  Future<DateTime> nextUploadTime() async {
    final uploadConfig = await _resolveUploadConfig();
    final jitterSec = await _jitterSecResolver();
    return _nextUploadTimeFrom(_nowProvider(), uploadConfig.wallClockCadenceMin).add(Duration(seconds: jitterSec));
  }

  /// Executes one upload attempt immediately.
  ///
  /// Intended for deterministic unit tests.
  Future<void> runScheduledUploadForTest() => _runScheduledUpload();

  Future<core_domain.UploadConfig> _resolveUploadConfig() async {
    try {
      return await _uploadConfigResolver();
    } catch (_) {
      return const core_domain.UploadConfig();
    }
  }

  DateTime _nextUploadTimeFrom(DateTime now, int cadenceMinValue) {
    final cadenceMin = cadenceMinValue <= 0 ? 1 : cadenceMinValue;

    final minutesSinceMidnight = now.hour * 60 + now.minute;

    final nextSlotMinutes = (minutesSinceMidnight ~/ cadenceMin + 1) * cadenceMin;

    final nextHour = nextSlotMinutes ~/ 60;
    final nextMinute = nextSlotMinutes % 60;

    if (nextHour >= 24) {
      return DateTime(now.year, now.month, now.day + 1, nextHour % 24, nextMinute);
    }

    return DateTime(now.year, now.month, now.day, nextHour, nextMinute);
  }

  void _cancelTimer() {
    _scheduledUploadTimer?.cancel();
    _scheduledUploadTimer = null;
  }

  Future<void> _emitNextUploadTime([DateTime? value]) async {
    _nextUploadTimeNotifier.value = value ?? await nextUploadTime();
  }
}
