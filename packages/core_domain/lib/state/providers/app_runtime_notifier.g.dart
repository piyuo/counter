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
    r'c4339db57dd6fbb260add54661a62d0fa7a2e0fe';

abstract class _$AppRuntimeNotifier extends $Notifier<AppRuntimeState> {
  AppRuntimeState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppRuntimeState, AppRuntimeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppRuntimeState, AppRuntimeState>,
              AppRuntimeState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
