// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_area_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InterestAreaNotifier)
final interestAreaProvider = InterestAreaNotifierProvider._();

final class InterestAreaNotifierProvider
    extends $NotifierProvider<InterestAreaNotifier, InterestAreaState> {
  InterestAreaNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestAreaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestAreaNotifierHash();

  @$internal
  @override
  InterestAreaNotifier create() => InterestAreaNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InterestAreaState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InterestAreaState>(value),
    );
  }
}

String _$interestAreaNotifierHash() =>
    r'a8a0ffbe88ba4fc6402a0e168dddaf5f4e99f315';

abstract class _$InterestAreaNotifier extends $Notifier<InterestAreaState> {
  InterestAreaState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<InterestAreaState, InterestAreaState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InterestAreaState, InterestAreaState>,
              InterestAreaState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
