// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GuideNotifier)
final guideProvider = GuideNotifierProvider._();

final class GuideNotifierProvider
    extends $NotifierProvider<GuideNotifier, GuideState> {
  GuideNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guideProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guideNotifierHash();

  @$internal
  @override
  GuideNotifier create() => GuideNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuideState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuideState>(value),
    );
  }
}

String _$guideNotifierHash() => r'7a213d0d0ef095859cdb7b2888aff16c112a1c93';

abstract class _$GuideNotifier extends $Notifier<GuideState> {
  GuideState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GuideState, GuideState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GuideState, GuideState>,
              GuideState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
