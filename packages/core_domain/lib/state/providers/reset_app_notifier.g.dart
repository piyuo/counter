// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_app_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetAppNotifier)
final resetAppProvider = ResetAppNotifierProvider._();

final class ResetAppNotifierProvider
    extends $NotifierProvider<ResetAppNotifier, void> {
  ResetAppNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetAppProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetAppNotifierHash();

  @$internal
  @override
  ResetAppNotifier create() => ResetAppNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$resetAppNotifierHash() => r'7897576ab76b39d2ab6430872bcec28cd9e2e485';

abstract class _$ResetAppNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
