// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_lifecycle_notifier.dart';

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

@ProviderFor(SystemLifecycleNotifier)
final systemLifecycleProvider = SystemLifecycleNotifierProvider._();

/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
final class SystemLifecycleNotifierProvider
    extends $NotifierProvider<SystemLifecycleNotifier, SystemLifecycle> {
  /// Architecture note:
  /// - Lifecycle is a synchronous state machine (event -> next state).
  /// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
  /// - build() triggers boot via ref.read(appBootProvider) without awaiting.
  /// - AppBoot keeps itself alive only during async boot, then auto-disposes.
  SystemLifecycleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemLifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemLifecycleNotifierHash();

  @$internal
  @override
  SystemLifecycleNotifier create() => SystemLifecycleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemLifecycle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemLifecycle>(value),
    );
  }
}

String _$systemLifecycleNotifierHash() =>
    r'534c19f6632c789c81abd7edcc0eb1f811d0933b';

/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.

abstract class _$SystemLifecycleNotifier extends $Notifier<SystemLifecycle> {
  SystemLifecycle build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SystemLifecycle, SystemLifecycle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SystemLifecycle, SystemLifecycle>,
              SystemLifecycle,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
