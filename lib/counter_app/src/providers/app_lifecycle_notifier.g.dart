// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lifecycle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Architecture note:
/// - AppLifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.

@ProviderFor(AppLifecycleNotifier)
final appLifecycleProvider = AppLifecycleNotifierProvider._();

/// Architecture note:
/// - AppLifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
final class AppLifecycleNotifierProvider
    extends $NotifierProvider<AppLifecycleNotifier, AppLifecycle> {
  /// Architecture note:
  /// - AppLifecycle is a synchronous state machine (event -> next state).
  /// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
  /// - build() triggers boot via ref.read(appBootProvider) without awaiting.
  /// - AppBoot keeps itself alive only during async boot, then auto-disposes.
  AppLifecycleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLifecycleNotifierHash();

  @$internal
  @override
  AppLifecycleNotifier create() => AppLifecycleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLifecycle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLifecycle>(value),
    );
  }
}

String _$appLifecycleNotifierHash() =>
    r'9906ac75f916041dcb8c5faf6b1c0af6fefe2f57';

/// Architecture note:
/// - AppLifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.

abstract class _$AppLifecycleNotifier extends $Notifier<AppLifecycle> {
  AppLifecycle build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppLifecycle, AppLifecycle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLifecycle, AppLifecycle>,
              AppLifecycle,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
