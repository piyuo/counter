// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boot_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BootNotifier)
final bootProvider = BootNotifierProvider._();

final class BootNotifierProvider
    extends $AsyncNotifierProvider<BootNotifier, BootStatus> {
  BootNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bootProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bootNotifierHash();

  @$internal
  @override
  BootNotifier create() => BootNotifier();
}

String _$bootNotifierHash() => r'6b5a3920c2372e1d66ad1bc04f233413567fe177';

abstract class _$BootNotifier extends $AsyncNotifier<BootStatus> {
  FutureOr<BootStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BootStatus>, BootStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BootStatus>, BootStatus>,
              AsyncValue<BootStatus>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
