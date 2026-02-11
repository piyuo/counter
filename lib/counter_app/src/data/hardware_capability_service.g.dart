// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardware_capability_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hardwareCapabilityService)
final hardwareCapabilityServiceProvider = HardwareCapabilityServiceProvider._();

final class HardwareCapabilityServiceProvider
    extends
        $FunctionalProvider<
          HardwareCapabilityService,
          HardwareCapabilityService,
          HardwareCapabilityService
        >
    with $Provider<HardwareCapabilityService> {
  HardwareCapabilityServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hardwareCapabilityServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hardwareCapabilityServiceHash();

  @$internal
  @override
  $ProviderElement<HardwareCapabilityService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HardwareCapabilityService create(Ref ref) {
    return hardwareCapabilityService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HardwareCapabilityService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HardwareCapabilityService>(value),
    );
  }
}

String _$hardwareCapabilityServiceHash() =>
    r'0e55786f014a91b6e4998abb1fdfb5b12df25d21';
