// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_lifecycle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod notifier managing the system lifecycle state machine.
///
/// Tracks application state transitions from booting through hardware validation
/// to either ready or device-not-supported states. Uses pattern matching for
/// state reduction and logs all transitions for debugging purposes.
///
/// This notifier is kept alive across the app lifetime (keepAlive: true).

@ProviderFor(SystemLifecycleNotifier)
final systemLifecycleProvider = SystemLifecycleNotifierProvider._();

/// Riverpod notifier managing the system lifecycle state machine.
///
/// Tracks application state transitions from booting through hardware validation
/// to either ready or device-not-supported states. Uses pattern matching for
/// state reduction and logs all transitions for debugging purposes.
///
/// This notifier is kept alive across the app lifetime (keepAlive: true).
final class SystemLifecycleNotifierProvider
    extends $NotifierProvider<SystemLifecycleNotifier, SystemLifecycle> {
  /// Riverpod notifier managing the system lifecycle state machine.
  ///
  /// Tracks application state transitions from booting through hardware validation
  /// to either ready or device-not-supported states. Uses pattern matching for
  /// state reduction and logs all transitions for debugging purposes.
  ///
  /// This notifier is kept alive across the app lifetime (keepAlive: true).
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
    r'e97afaa946d3abefe3c4c086820501d8b1066104';

/// Riverpod notifier managing the system lifecycle state machine.
///
/// Tracks application state transitions from booting through hardware validation
/// to either ready or device-not-supported states. Uses pattern matching for
/// state reduction and logs all transitions for debugging purposes.
///
/// This notifier is kept alive across the app lifetime (keepAlive: true).

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
