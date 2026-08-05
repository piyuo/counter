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
    r'4cd3b724c4943df42dc79204964b5c7863ebae42';

abstract class _$FlutterVisionService extends $Notifier<void> {
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
