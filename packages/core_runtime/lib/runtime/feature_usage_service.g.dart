// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_usage_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeatureUsageService)
final featureUsageServiceProvider = FeatureUsageServiceProvider._();

final class FeatureUsageServiceProvider
    extends $NotifierProvider<FeatureUsageService, void> {
  FeatureUsageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featureUsageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featureUsageServiceHash();

  @$internal
  @override
  FeatureUsageService create() => FeatureUsageService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$featureUsageServiceHash() =>
    r'3940a075980db3cef1b21db1ca5589d256c30253';

abstract class _$FeatureUsageService extends $Notifier<void> {
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
