// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pip_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PipNotifier)
final pipProvider = PipNotifierProvider._();

final class PipNotifierProvider
    extends $NotifierProvider<PipNotifier, PipState> {
  PipNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pipProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pipNotifierHash();

  @$internal
  @override
  PipNotifier create() => PipNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PipState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PipState>(value),
    );
  }
}

String _$pipNotifierHash() => r'7a12ca811715efe623e025bf4015c1eaea2faf6c';

abstract class _$PipNotifier extends $Notifier<PipState> {
  PipState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PipState, PipState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PipState, PipState>,
              PipState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
