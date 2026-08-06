// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portrait_orientation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PortraitOrientationNotifier)
final portraitOrientationProvider = PortraitOrientationNotifierProvider._();

final class PortraitOrientationNotifierProvider
    extends $NotifierProvider<PortraitOrientationNotifier, bool> {
  PortraitOrientationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'portraitOrientationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$portraitOrientationNotifierHash();

  @$internal
  @override
  PortraitOrientationNotifier create() => PortraitOrientationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$portraitOrientationNotifierHash() =>
    r'dd748eaba624ff148ae5cb456fa8eca7d5643e63';

abstract class _$PortraitOrientationNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
