// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_boot.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppBoot)
final appBootProvider = AppBootProvider._();

final class AppBootProvider
    extends $AsyncNotifierProvider<AppBoot, BootStatus> {
  AppBootProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBootProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBootHash();

  @$internal
  @override
  AppBoot create() => AppBoot();
}

String _$appBootHash() => r'ba569436d66155c2ba8e74856f90be32d1f7c5e6';

abstract class _$AppBoot extends $AsyncNotifier<BootStatus> {
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
