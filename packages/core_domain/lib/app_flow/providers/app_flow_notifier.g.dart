// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_flow_notifier.dart';

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

@ProviderFor(AppFlowNotifier)
final appFlowProvider = AppFlowNotifierProvider._();

/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.
final class AppFlowNotifierProvider
    extends $NotifierProvider<AppFlowNotifier, AppFlow> {
  /// Architecture note:
  /// - Lifecycle is a synchronous state machine (event -> next state).
  /// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
  /// - build() triggers boot via ref.read(appBootProvider) without awaiting.
  /// - AppBoot keeps itself alive only during async boot, then auto-disposes.
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

String _$appFlowNotifierHash() => r'd65288c5874cedf7f47e374f8b75755279b84121';

/// Architecture note:
/// - Lifecycle is a synchronous state machine (event -> next state).
/// - AppBoot handles asynchronous startup work and dispatches lifecycle events.
/// - build() triggers boot via ref.read(appBootProvider) without awaiting.
/// - AppBoot keeps itself alive only during async boot, then auto-disposes.

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
