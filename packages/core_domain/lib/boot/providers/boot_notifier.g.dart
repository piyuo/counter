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

String _$bootNotifierHash() => r'0d49f86921bcc7e3fde464bde474d695b250ebeb';

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
