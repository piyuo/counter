// TOC:
//  - ResponseWorker — process: treats ok:false envelope as failure
//  - ResponseWorker — process: treats ok:true envelope as success
//  - ResponseWorker — process: applies server override fields from data payload
//  - ResponseWorker — process: maps config.uploadIntervalSec to delivery cadence

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_domain/telemetry/models/telemetry_response.dart';
import 'package:core_domain/telemetry/response_worker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResponseWorker', () {
    test('process does not apply overrides for wrapped error envelope', () async {
      var overrideApplied = false;
      final worker = ResponseWorker(
        onServerConfigOverride: ({detection, detectionParams, deliveryConfig}) async {
          overrideApplied = true;
        },
      );

      await worker.process(const TelemetryResponse(v: 1, ok: false, error: 'http_non_success', data: null));

      expect(overrideApplied, isFalse);
    });

    test('process completes for ok:true response', () async {
      const worker = ResponseWorker();

      await expectLater(worker.process(const TelemetryResponse(v: 1, ok: true, data: null)), completes);
    });

    test('process applies server override fields from data payload', () async {
      core_domain.DetectionType? appliedDetection;
      core_domain.DetectionParams? appliedDetectionParams;
      core_domain.UploadConfig? appliedDeliveryConfig;

      final worker = ResponseWorker(
        onServerConfigOverride: ({detection, detectionParams, deliveryConfig}) async {
          appliedDetection = detection;
          appliedDetectionParams = detectionParams;
          appliedDeliveryConfig = deliveryConfig;
        },
      );

      await worker.process(
        const TelemetryResponse(
          v: 1,
          ok: true,
          data: ServerData(
            detection: core_domain.DetectionType.human(),
            detectionParams: core_domain.DetectionParams(trackHighThresh: 0.81),
            deliveryConfig: core_domain.UploadConfig(wallClockCadenceMin: 12),
          ),
        ),
      );

      expect(appliedDetection, const core_domain.DetectionType.human());
      expect(appliedDetectionParams?.trackHighThresh, 0.81);
      expect(appliedDeliveryConfig?.wallClockCadenceMin, 12);
    });

    test('process maps config.uploadIntervalSec to delivery cadence minutes', () async {
      core_domain.UploadConfig? appliedDeliveryConfig;

      final worker = ResponseWorker(
        onServerConfigOverride: ({detection, detectionParams, deliveryConfig}) async {
          appliedDeliveryConfig = deliveryConfig;
        },
      );

      await worker.process(
        const TelemetryResponse(v: 1, ok: true, data: ServerData(config: ServerConfig(uploadIntervalSec: 61))),
      );

      expect(appliedDeliveryConfig?.wallClockCadenceMin, 2);
    });
  });
}
