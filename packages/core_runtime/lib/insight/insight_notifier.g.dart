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
    extends $NotifierProvider<InsightNotifier, core_domain.InsightDashboard> {
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
  Override overrideWithValue(core_domain.InsightDashboard value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.InsightDashboard>(value),
    );
  }
}

String _$insightNotifierHash() => r'b7b4d442ee2e8ac02d364dbff05b15a6dc6fee98';

abstract class _$InsightNotifier
    extends $Notifier<core_domain.InsightDashboard> {
  core_domain.InsightDashboard build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<core_domain.InsightDashboard, core_domain.InsightDashboard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                core_domain.InsightDashboard,
                core_domain.InsightDashboard
              >,
              core_domain.InsightDashboard,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
