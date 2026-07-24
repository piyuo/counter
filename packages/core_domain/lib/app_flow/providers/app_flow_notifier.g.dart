// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_flow_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppFlowNotifier)
final appFlowProvider = AppFlowNotifierProvider._();

final class AppFlowNotifierProvider
    extends $NotifierProvider<AppFlowNotifier, AppFlow> {
  AppFlowNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appFlowProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appFlowNotifierHash();

  @$internal
  @override
  AppFlowNotifier create() => AppFlowNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppFlow>(value),
    );
  }
}

String _$appFlowNotifierHash() => r'ac42420584d15ba5f805e3ab058e8dad9081fe80';

abstract class _$AppFlowNotifier extends $Notifier<AppFlow> {
  AppFlow build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppFlow, AppFlow>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppFlow, AppFlow>,
              AppFlow,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
