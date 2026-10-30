// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyticsService)
final analyticsServiceProvider = AnalyticsServiceProvider._();

final class AnalyticsServiceProvider
    extends
        $FunctionalProvider<
          AnalyticsService,
          AnalyticsService,
          AnalyticsService
        >
    with $Provider<AnalyticsService> {
  AnalyticsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsServiceHash();

  @$internal
  @override
  $ProviderElement<AnalyticsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsService create(Ref ref) {
    return analyticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsService>(value),
    );
  }
}

String _$analyticsServiceHash() => r'ca22b9fd50072d2d951691b9b024d6da0085b997';

/// State (read side)

@ProviderFor(analyticsState)
final analyticsStateProvider = AnalyticsStateProvider._();

/// State (read side)

final class AnalyticsStateProvider
    extends $FunctionalProvider<AnalyticsState, AnalyticsState, AnalyticsState>
    with $Provider<AnalyticsState> {
  /// State (read side)
  AnalyticsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsStateHash();

  @$internal
  @override
  $ProviderElement<AnalyticsState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsState create(Ref ref) {
    return analyticsState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsState>(value),
    );
  }
}

String _$analyticsStateHash() => r'baed0ef2d5d0a8be1c45e838915b553d1c83d4b7';
