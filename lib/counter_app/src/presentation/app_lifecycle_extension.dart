import '../models/app_lifecycle.dart';

extension AppLifecycleExtension on AppLifecycle {
  bool get isOnboarding => this is NeedsOnboarding;
  bool get isNoCamera => this is NoCamera;
}
