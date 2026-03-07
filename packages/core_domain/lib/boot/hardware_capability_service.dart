import 'package:core_domain/state/models/frontend.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hardware_capability_service.g.dart';

abstract class HardwareCapabilityService {
  Future<bool> isFrontendValid(Frontend frontend);
  Future<bool> hasCamFrontend();

  /// Returns a default [Frontend] at index 0 based on current platform.
  /// Caller must have already confirmed [hasCamFrontend] is true.
  Future<Frontend> getDefaultFrontend();

  /// Sets the default vision source for the current platform and initializes it.
  /// Handles both source selection and controller initialization in one step.
  Future<void> initializeVisionSystem(Ref ref);
}

@riverpod
HardwareCapabilityService hardwareCapabilityService(Ref ref) {
  throw UnimplementedError('appStateRepositoryProvider must be overridden');
}
