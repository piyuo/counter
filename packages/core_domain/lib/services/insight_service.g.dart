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

String _$insightServiceHash() => r'4af930ce22816365666c7b8120f2b5a9e42e042f';

/// State

@ProviderFor(insightState)
final insightStateProvider = InsightStateProvider._();

/// State

final class InsightStateProvider
    extends $FunctionalProvider<InsightState, InsightState, InsightState>
    with $Provider<InsightState> {
  /// State
  InsightStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightStateHash();

  @$internal
  @override
  $ProviderElement<InsightState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InsightState create(Ref ref) {
    return insightState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InsightState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InsightState>(value),
    );
  }
}

String _$insightStateHash() => r'9307134a0589d22b841145a1f5ef5f3aad1f1f31';
