// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppNotifier)
final appProvider = AppNotifierProvider._();

final class AppNotifierProvider
    extends $AsyncNotifierProvider<AppNotifier, AppState> {
  AppNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNotifierHash();

  @$internal
  @override
  AppNotifier create() => AppNotifier();
}

String _$appNotifierHash() => r'a1afcf1cb2833043f2a6fee86b8959d21f6ba19f';

abstract class _$AppNotifier extends $AsyncNotifier<AppState> {
  FutureOr<AppState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppState>, AppState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppState>, AppState>,
              AsyncValue<AppState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
