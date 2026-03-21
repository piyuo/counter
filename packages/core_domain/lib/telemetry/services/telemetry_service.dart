// TOC:
//  - TelemetryService: top-level facade for the telemetry pipeline
//  - telemetryServiceProvider: Riverpod provider (overridden in core_runtime)

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/telemetry_payload.dart';

part 'telemetry_service.g.dart';

abstract class TelemetryService {
  /// Adds [payload] to the persistent queue.
  Future<void> enqueue(TelemetryPayload payload);

  /// Current and future next scheduled upload times.
  ///
  /// Null means the service has not resolved an initial value yet.
  ValueListenable<DateTime?> get nextUploadTimeListenable;

  /// Sends [payloads] directly to backend in batches without queueing.
  ///
  /// Intended for explicit user-triggered resend actions from history views.
  /// This is a one-shot attempt and does not schedule automatic retries.
  /// Returns true when all payloads are uploaded successfully.
  Future<bool> sendNow(List<TelemetryPayload> payloads);

  /// Runs one full upload pass: drains the queue in [UploadConfig.maxBatchSize]
  /// batches, Call on user press 'upload now' button.
  ///
  /// Returns `true` when the run completes without upload issues.
  Future<bool> uploadNow();

  /// Starts a periodic timer aligned to the current
  /// `UploadConfig.wallClockCadenceMin` wall-clock boundary.
  /// Implementations should pick up cadence changes without needing a full app
  /// restart.
  void startPeriodicUpload();

  /// Cancels the periodic timer.
  void stopPeriodicUpload();

  /// Returns the wall-clock [DateTime] of the next scheduled upload,
  /// based on the current [UploadConfig.wallClockCadenceMin].
  Future<DateTime> nextUploadTime();

  // ---------------------------------------------------------------------------
  // Upload status — reflects the outcome of the most recent flush().
  // All fields are null until the first flush completes.
  // ---------------------------------------------------------------------------

  /// UTC timestamp of the most recent upload attempt (success or failure).
  DateTime? get lastUploadTimeUtc;

  /// Outcome of the most recent upload attempt.
  ///
  /// - `true`: last attempt succeeded
  /// - `false`: last attempt failed
  /// - `null`: no attempt has happened yet
  bool? get isLastUploadSuccess;

  /// Machine-readable error code from the last failed attempt.
  String? get lastError;
}

@riverpod
TelemetryService telemetryService(Ref ref) {
  throw UnimplementedError('telemetryServiceProvider must be overridden');
}
