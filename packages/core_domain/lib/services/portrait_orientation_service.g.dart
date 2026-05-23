// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portrait_orientation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(portraitOrientationService)
final portraitOrientationServiceProvider =
    PortraitOrientationServiceProvider._();

final class PortraitOrientationServiceProvider
    extends
        $FunctionalProvider<
          PortraitOrientationService,
          PortraitOrientationService,
          PortraitOrientationService
        >
    with $Provider<PortraitOrientationService> {
  PortraitOrientationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'portraitOrientationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$portraitOrientationServiceHash();

  @$internal
  @override
  $ProviderElement<PortraitOrientationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PortraitOrientationService create(Ref ref) {
    return portraitOrientationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PortraitOrientationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PortraitOrientationService>(value),
    );
  }
}

String _$portraitOrientationServiceHash() =>
    r'984f825b23ccf8e2b5123b003ffac4eec57da7c9';
