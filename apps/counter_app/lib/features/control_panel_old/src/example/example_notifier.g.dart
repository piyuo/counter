// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExampleNotifier)
final exampleProvider = ExampleNotifierProvider._();

final class ExampleNotifierProvider
    extends $NotifierProvider<ExampleNotifier, ExampleState> {
  ExampleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exampleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exampleNotifierHash();

  @$internal
  @override
  ExampleNotifier create() => ExampleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExampleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExampleState>(value),
    );
  }
}

String _$exampleNotifierHash() => r'92d9a925dcbe519fd1b1de205a1b2c369a1bd21f';

abstract class _$ExampleNotifier extends $Notifier<ExampleState> {
  ExampleState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExampleState, ExampleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExampleState, ExampleState>,
              ExampleState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
