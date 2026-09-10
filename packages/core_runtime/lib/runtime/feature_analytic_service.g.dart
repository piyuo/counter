// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_analytic_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeatureAnalyticService)
final featureAnalyticServiceProvider = FeatureAnalyticServiceProvider._();

final class FeatureAnalyticServiceProvider
    extends $NotifierProvider<FeatureAnalyticService, void> {
  FeatureAnalyticServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featureAnalyticServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featureAnalyticServiceHash();

  @$internal
  @override
  FeatureAnalyticService create() => FeatureAnalyticService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$featureAnalyticServiceHash() =>
    r'9f3db8776104fbccb5db9f22e7f36a3505a51808';

abstract class _$FeatureAnalyticService extends $Notifier<void> {
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
