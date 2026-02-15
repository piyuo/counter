// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lifecycle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.

@ProviderFor(LifecycleNotifier)
final lifecycleProvider = LifecycleNotifierProvider._();

/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
final class LifecycleNotifierProvider
    extends $NotifierProvider<LifecycleNotifier, Lifecycle> {
  /// Architecture note:
  /// - Lifecycle is a synchronous state machine (event -> next state).
  /// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
  /// - build() triggers boot via ref.read(appBootProvider) without awaiting.
  /// - AppBoot keeps itself alive only during async boot, then auto-disposes.
  LifecycleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lifecycleNotifierHash();

  @$internal
  @override
  LifecycleNotifier create() => LifecycleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Lifecycle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Lifecycle>(value),
    );
  }
}

String _$lifecycleNotifierHash() => r'ec7b2a8d9affb01731d38d4d9936ce085c0478c5';

/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.

abstract class _$LifecycleNotifier extends $Notifier<Lifecycle> {
  Lifecycle build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Lifecycle, Lifecycle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Lifecycle, Lifecycle>,
              Lifecycle,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
