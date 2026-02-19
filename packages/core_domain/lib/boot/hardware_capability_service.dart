import 'package:core_domain/state/models/frontend.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hardware_capability_service.g.dart';

abstract class HardwareCapabilityService {
  Future<bool> isFrontendValid(Frontend frontend);
  Future<bool> hasCamFrontend();
}

@riverpod
HardwareCapabilityService hardwareCapabilityService(Ref ref) {
  throw UnimplementedError('appStateRepositoryProvider must be overridden');
}
