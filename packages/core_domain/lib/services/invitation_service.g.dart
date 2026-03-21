// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(invitationService)
final invitationServiceProvider = InvitationServiceProvider._();

final class InvitationServiceProvider
    extends
        $FunctionalProvider<
          InvitationService,
          InvitationService,
          InvitationService
        >
    with $Provider<InvitationService> {
  InvitationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invitationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invitationServiceHash();

  @$internal
  @override
  $ProviderElement<InvitationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InvitationService create(Ref ref) {
    return invitationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InvitationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InvitationService>(value),
    );
  }
}

String _$invitationServiceHash() => r'b26228bacc073f4943537399d4c90a508340f077';
