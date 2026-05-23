// TOC:
//  - PortraitOrientationController contract
//  - keepAlive Riverpod notifier for portrait lock state

import 'package:core_domain/services/portrait_orientation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portrait_orientation_notifier.g.dart';

abstract class PortraitOrientationController {
  Future<void> lockToPortrait();

  Future<void> unlockFromPortrait();
}

@Riverpod(keepAlive: true)
class PortraitOrientationNotifier extends _$PortraitOrientationNotifier implements PortraitOrientationController {
  @override
  bool build() => false;

  @override
  Future<void> lockToPortrait() async {
    if (state) {
      return;
    }

    await ref.read(portraitOrientationServiceProvider).lockToPortrait();
    state = true;
  }

  @override
  Future<void> unlockFromPortrait() async {
    if (!state) {
      return;
    }

    await ref.read(portraitOrientationServiceProvider).unlockFromPortrait();
    state = false;
  }
}
