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
    extends
        $NotifierProvider<InterestAreaNotifier, core_domain.InterestAreaState> {
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
  Override overrideWithValue(core_domain.InterestAreaState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<core_domain.InterestAreaState>(
        value,
      ),
    );
  }
}

String _$interestAreaNotifierHash() =>
    r'780529c9714a63be4c5e36ae79ea7b3fe2aebdb5';

abstract class _$InterestAreaNotifier
    extends $Notifier<core_domain.InterestAreaState> {
  core_domain.InterestAreaState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              core_domain.InterestAreaState,
              core_domain.InterestAreaState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                core_domain.InterestAreaState,
                core_domain.InterestAreaState
              >,
              core_domain.InterestAreaState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
