// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_vision_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FlutterVisionNotifier)
final flutterVisionProvider = FlutterVisionNotifierProvider._();

final class FlutterVisionNotifierProvider
    extends $NotifierProvider<FlutterVisionNotifier, core_domain.VisionState> {
  FlutterVisionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flutterVisionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flutterVisionNotifierHash();

  @$internal
  @override
  FlutterVisionNotifier create() => FlutterVisionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(core_domain.VisionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.VisionState>(value),
    );
  }
}

String _$flutterVisionNotifierHash() =>
    r'a032b7cec1238a48824fc8acb2caec3927487a15';

abstract class _$FlutterVisionNotifier
    extends $Notifier<core_domain.VisionState> {
  core_domain.VisionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<core_domain.VisionState, core_domain.VisionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<core_domain.VisionState, core_domain.VisionState>,
              core_domain.VisionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
