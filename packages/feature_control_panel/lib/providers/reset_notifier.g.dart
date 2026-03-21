// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetNotifier)
final resetProvider = ResetNotifierProvider._();

final class ResetNotifierProvider
    extends $NotifierProvider<ResetNotifier, void> {
  ResetNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetNotifierHash();

  @$internal
  @override
  ResetNotifier create() => ResetNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$resetNotifierHash() => r'e5be09eecec97e3d03197df3212911600b5a5f47';

abstract class _$ResetNotifier extends $Notifier<void> {
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
