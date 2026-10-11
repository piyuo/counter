// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InsightNotifier)
final insightProvider = InsightNotifierProvider._();

final class InsightNotifierProvider
    extends $NotifierProvider<InsightNotifier, core_domain.InsightState> {
  InsightNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightNotifierHash();

  @$internal
  @override
  InsightNotifier create() => InsightNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(core_domain.InsightState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.InsightState>(value),
    );
  }
}

String _$insightNotifierHash() => r'5dfb85467b4f6de246b3b340b3d0f9ca77cdcb9d';

abstract class _$InsightNotifier extends $Notifier<core_domain.InsightState> {
  core_domain.InsightState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<core_domain.InsightState, core_domain.InsightState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<core_domain.InsightState, core_domain.InsightState>,
              core_domain.InsightState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
