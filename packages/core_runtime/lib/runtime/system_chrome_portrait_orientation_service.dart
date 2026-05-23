// TOC:
//  - SystemChrome-backed portrait orientation service

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/services.dart';

typedef PreferredOrientationsSetter = Future<void> Function(List<DeviceOrientation> orientations);

class SystemChromePortraitOrientationService implements core_domain.PortraitOrientationService {
  SystemChromePortraitOrientationService({PreferredOrientationsSetter? setPreferredOrientations})
    : _setPreferredOrientations = setPreferredOrientations ?? SystemChrome.setPreferredOrientations;

  final PreferredOrientationsSetter _setPreferredOrientations;

  @override
  Future<void> lockToPortrait() {
    return _setPreferredOrientations(const [DeviceOrientation.portraitUp]);
  }

  @override
  Future<void> unlockFromPortrait() {
    return _setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
