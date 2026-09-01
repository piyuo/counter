// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_vision_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FlutterVisionService)
final flutterVisionServiceProvider = FlutterVisionServiceProvider._();

final class FlutterVisionServiceProvider
    extends $NotifierProvider<FlutterVisionService, void> {
  FlutterVisionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flutterVisionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flutterVisionServiceHash();

  @$internal
  @override
  FlutterVisionService create() => FlutterVisionService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$flutterVisionServiceHash() =>
    r'19e9322e4201d3e56036cc2541b175efb955f0f0';

abstract class _$FlutterVisionService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
