import 'package:core_domain/lifecycle/models/lifecycle.dart';

extension LifecycleExtension on Lifecycle {
  bool get isOnboarding => this is NeedsOnboarding;
  bool get isNoCamera => this is NoCamera;
}
