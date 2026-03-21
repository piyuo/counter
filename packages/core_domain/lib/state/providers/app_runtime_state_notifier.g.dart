// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_runtime_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppRuntimeStateNotifier)
final appRuntimeStateProvider = AppRuntimeStateNotifierProvider._();

final class AppRuntimeStateNotifierProvider
    extends $NotifierProvider<AppRuntimeStateNotifier, AppRuntimeState> {
  AppRuntimeStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRuntimeStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRuntimeStateNotifierHash();

  @$internal
  @override
  AppRuntimeStateNotifier create() => AppRuntimeStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRuntimeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRuntimeState>(value),
    );
  }
}

String _$appRuntimeStateNotifierHash() =>
    r'821fe660b5a21f830d36370aab85a80e70b5a891';

abstract class _$AppRuntimeStateNotifier extends $Notifier<AppRuntimeState> {
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
