// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_transport.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryTransport)
final telemetryTransportProvider = TelemetryTransportProvider._();

final class TelemetryTransportProvider
    extends
        $FunctionalProvider<
          TelemetryTransport,
          TelemetryTransport,
          TelemetryTransport
        >
    with $Provider<TelemetryTransport> {
  TelemetryTransportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryTransportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryTransportHash();

  @$internal
  @override
  $ProviderElement<TelemetryTransport> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelemetryTransport create(Ref ref) {
    return telemetryTransport(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryTransport value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryTransport>(value),
    );
  }
}

String _$telemetryTransportHash() =>
    r'5198aac2001adad0e17546240e5fb2299aecd4cb';
