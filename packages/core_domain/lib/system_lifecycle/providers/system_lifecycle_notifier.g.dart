// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_lifecycle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SystemLifecycleNotifier)
final systemLifecycleProvider = SystemLifecycleNotifierProvider._();

final class SystemLifecycleNotifierProvider
    extends $NotifierProvider<SystemLifecycleNotifier, SystemLifecycle> {
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
    r'9f38571a07f985c51497c744bb446d8ef4a5a2e4';

abstract class _$SystemLifecycleNotifier extends $Notifier<SystemLifecycle> {
  SystemLifecycle build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SystemLifecycle, SystemLifecycle>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SystemLifecycle, SystemLifecycle>,
              SystemLifecycle,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
