// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vision_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(visionService)
final visionServiceProvider = VisionServiceProvider._();

final class VisionServiceProvider
    extends $FunctionalProvider<VisionService, VisionService, VisionService>
    with $Provider<VisionService> {
  VisionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionServiceHash();

  @$internal
  @override
  $ProviderElement<VisionService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VisionService create(Ref ref) {
    return visionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionService>(value),
    );
  }
}

String _$visionServiceHash() => r'e881f2137d053554c9efb8719834ccb0ad90274a';

/// State

@ProviderFor(visionState)
final visionStateProvider = VisionStateProvider._();

/// State

final class VisionStateProvider
    extends $FunctionalProvider<VisionState, VisionState, VisionState>
    with $Provider<VisionState> {
  /// State
  VisionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visionStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visionStateHash();

  @$internal
  @override
  $ProviderElement<VisionState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VisionState create(Ref ref) {
    return visionState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisionState>(value),
    );
  }
}

String _$visionStateHash() => r'44a0058a30a9d368b61ed01685b8e3d744c4ebdb';
