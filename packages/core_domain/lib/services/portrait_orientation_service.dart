// TOC:
//  - PortraitOrientationService contract
//  - Riverpod provider override point

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portrait_orientation_service.g.dart';

abstract class PortraitOrientationService {
  Future<void> lockToPortrait();

  Future<void> unlockFromPortrait();
}

@riverpod
PortraitOrientationService portraitOrientationService(Ref ref) {
  throw UnimplementedError('portraitOrientationServiceProvider must be overridden');
}
