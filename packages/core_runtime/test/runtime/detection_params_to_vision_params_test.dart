// TOC:
// - detectionParamsToVisionParams: verifies domain DetectionParams values are forwarded to VisionParams

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/core_runtime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('detectionParamsToVisionParams', () {
    test('forwards counting thresholds to VisionParams', () {
      const detectionParams = core_domain.DetectionParams(stagnantThresholdSeconds: 42, disappearThresholdSeconds: 9);

      final visionParams = detectionParamsToVisionParams(detectionParams);

      expect(visionParams.stagnantThresholdSeconds, 42);
      expect(visionParams.disappearThresholdSeconds, 9);
    });
  });
}
