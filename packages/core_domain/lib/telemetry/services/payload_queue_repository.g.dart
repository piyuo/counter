// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_queue_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetryQueueRepository)
final telemetryQueueRepositoryProvider = TelemetryQueueRepositoryProvider._();

final class TelemetryQueueRepositoryProvider
    extends
        $FunctionalProvider<
          TelemetryQueueRepository,
          TelemetryQueueRepository,
          TelemetryQueueRepository
        >
    with $Provider<TelemetryQueueRepository> {
  TelemetryQueueRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryQueueRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryQueueRepositoryHash();

  @$internal
  @override
  $ProviderElement<TelemetryQueueRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TelemetryQueueRepository create(Ref ref) {
    return telemetryQueueRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetryQueueRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetryQueueRepository>(value),
    );
  }
}

String _$telemetryQueueRepositoryHash() =>
    r'a7472b36c191b5ab63747e9a704269fe81d99750';
