// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryService)
final telemetryServiceProvider = TelemetryServiceProvider._();

final class TelemetryServiceProvider
    extends
        $FunctionalProvider<
          TelemetryService,
          TelemetryService,
          TelemetryService
        >
    with $Provider<TelemetryService> {
  TelemetryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryServiceHash();

  @$internal
  @override
  $ProviderElement<TelemetryService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TelemetryService create(Ref ref) {
    return telemetryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryService>(value),
    );
  }
}

String _$telemetryServiceHash() => r'c18d63ccede8b771a3d68bfdc9193820136ac623';
