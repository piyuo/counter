import 'package:core_domain/core_domain.dart' as core_domain;

import 'router_provider.dart';

String? routeFromLifecycle(core_domain.Lifecycle lifecycle) {
  if (lifecycle.isOnboarding) {
    return kOnboarding;
  }
  if (lifecycle.isNoCamera) {
    return kNoCamera;
  }
  return null;
}
