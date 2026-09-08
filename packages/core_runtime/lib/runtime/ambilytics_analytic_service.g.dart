// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambilytics_analytic_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AmbilyticsAnalyticService)
final ambilyticsAnalyticServiceProvider = AmbilyticsAnalyticServiceProvider._();

final class AmbilyticsAnalyticServiceProvider
    extends $NotifierProvider<AmbilyticsAnalyticService, void> {
  AmbilyticsAnalyticServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ambilyticsAnalyticServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ambilyticsAnalyticServiceHash();

  @$internal
  @override
  AmbilyticsAnalyticService create() => AmbilyticsAnalyticService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$ambilyticsAnalyticServiceHash() =>
    r'253c82b568a55be7a38b48372e5222125a20b0e7';

abstract class _$AmbilyticsAnalyticService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
