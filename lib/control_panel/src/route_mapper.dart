import 'package:counter/counter_app/counter_app.dart' as counter_app;

import 'router_provider.dart';

String? routeFromLifecycle(counter_app.AppLifecycle lifecycle) {
  if (lifecycle.isOnboarding) {
    return kOnboarding;
  }
  if (lifecycle.isNoCamera) {
    return kNoCamera;
  }
  return null;
}
