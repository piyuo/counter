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
    extends $NotifierProvider<InsightNotifier, InsightState> {
  InsightNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightNotifierHash();

  @$internal
  @override
  InsightNotifier create() => InsightNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InsightState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InsightState>(value),
    );
  }
}

String _$insightNotifierHash() => r'92019eca94d39fb5c560573a7e6ad7694ea98ce8';

abstract class _$InsightNotifier extends $Notifier<InsightState> {
  InsightState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<InsightState, InsightState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InsightState, InsightState>,
              InsightState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
