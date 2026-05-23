// TOC:
//  - lockToPortrait() forwards portrait-only orientations
//  - unlockFromPortrait() restores portrait and landscape orientations

import 'package:core_runtime/runtime/system_chrome_portrait_orientation_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SystemChromePortraitOrientationService', () {
    test('lockToPortrait() forwards portrait-only orientations', () async {
      List<DeviceOrientation>? captured;
      final service = SystemChromePortraitOrientationService(
        setPreferredOrientations: (orientations) async {
          captured = orientations;
        },
      );

      await service.lockToPortrait();

      expect(captured, const [DeviceOrientation.portraitUp]);
    });

    test('unlockFromPortrait() restores portrait and landscape orientations', () async {
      List<DeviceOrientation>? captured;
      final service = SystemChromePortraitOrientationService(
        setPreferredOrientations: (orientations) async {
          captured = orientations;
        },
      );

      await service.unlockFromPortrait();

      expect(captured, const [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    });
  });
}
