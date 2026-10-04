// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(observationService)
final observationServiceProvider = ObservationServiceProvider._();

final class ObservationServiceProvider
    extends
        $FunctionalProvider<
          ObservationService,
          ObservationService,
          ObservationService
        >
    with $Provider<ObservationService> {
  ObservationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'observationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$observationServiceHash();

  @$internal
  @override
  $ProviderElement<ObservationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ObservationService create(Ref ref) {
    return observationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ObservationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ObservationService>(value),
    );
  }
}

String _$observationServiceHash() =>
    r'ae41bed1f6ab0629bc91bf9f1ecfc9d386e6ff02';
