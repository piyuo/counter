// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_queue.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryQueue)
final telemetryQueueProvider = TelemetryQueueProvider._();

final class TelemetryQueueProvider
    extends $FunctionalProvider<TelemetryQueue, TelemetryQueue, TelemetryQueue>
    with $Provider<TelemetryQueue> {
  TelemetryQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryQueueHash();

  @$internal
  @override
  $ProviderElement<TelemetryQueue> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TelemetryQueue create(Ref ref) {
    return telemetryQueue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryQueue value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryQueue>(value),
    );
  }
}

String _$telemetryQueueHash() => r'1bf972965fd3071d89d88f2e8d33003c6bb69e48';
