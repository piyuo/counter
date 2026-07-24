// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_runtime_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppRuntimeNotifier)
final appRuntimeProvider = AppRuntimeNotifierProvider._();

final class AppRuntimeNotifierProvider
    extends $NotifierProvider<AppRuntimeNotifier, AppRuntimeState> {
  AppRuntimeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRuntimeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRuntimeNotifierHash();

  @$internal
  @override
  AppRuntimeNotifier create() => AppRuntimeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRuntimeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRuntimeState>(value),
    );
  }
}

String _$appRuntimeNotifierHash() =>
    r'60b2a8be5066dd98df0ff56050ecaf16dc92e986';

abstract class _$AppRuntimeNotifier extends $Notifier<AppRuntimeState> {
  AppRuntimeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppRuntimeState, AppRuntimeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppRuntimeState, AppRuntimeState>,
              AppRuntimeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
