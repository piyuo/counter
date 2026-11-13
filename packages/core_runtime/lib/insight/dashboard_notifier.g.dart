// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardNotifier)
final dashboardProvider = DashboardNotifierProvider._();

final class DashboardNotifierProvider
    extends $NotifierProvider<DashboardNotifier, core_domain.DashboardState> {
  DashboardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardNotifierHash();

  @$internal
  @override
  DashboardNotifier create() => DashboardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(core_domain.DashboardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.DashboardState>(value),
    );
  }
}

String _$dashboardNotifierHash() => r'a4c908b51209b428491860a92b7165aa3ca4995f';

abstract class _$DashboardNotifier
    extends $Notifier<core_domain.DashboardState> {
  core_domain.DashboardState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<core_domain.DashboardState, core_domain.DashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                core_domain.DashboardState,
                core_domain.DashboardState
              >,
              core_domain.DashboardState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
