// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(insightService)
final insightServiceProvider = InsightServiceProvider._();

final class InsightServiceProvider
    extends $FunctionalProvider<InsightService, InsightService, InsightService>
    with $Provider<InsightService> {
  InsightServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightServiceHash();

  @$internal
  @override
  $ProviderElement<InsightService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InsightService create(Ref ref) {
    return insightService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InsightService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InsightService>(value),
    );
  }
}

String _$insightServiceHash() => r'e4e1fb7af774be2d4dc68aedadc92d3dd9f39189';
