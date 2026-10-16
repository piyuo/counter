// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AnalyticsNotifier)
final analyticsProvider = AnalyticsNotifierProvider._();

final class AnalyticsNotifierProvider
    extends $NotifierProvider<AnalyticsNotifier, core_domain.AnalyticsState> {
  AnalyticsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsNotifierHash();

  @$internal
  @override
  AnalyticsNotifier create() => AnalyticsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(core_domain.AnalyticsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.AnalyticsState>(value),
    );
  }
}

String _$analyticsNotifierHash() => r'bea79f2f190e9907eede15bc3fd62a2f9372645b';

abstract class _$AnalyticsNotifier
    extends $Notifier<core_domain.AnalyticsState> {
  core_domain.AnalyticsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<core_domain.AnalyticsState, core_domain.AnalyticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                core_domain.AnalyticsState,
                core_domain.AnalyticsState
              >,
              core_domain.AnalyticsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
