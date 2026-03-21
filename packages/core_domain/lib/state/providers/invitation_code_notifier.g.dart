// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_code_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Temporarily holds an invitation code extracted from a deep link.
///
/// ## Flow
/// 1. [AppLinkService] intercepts an incoming app link (e.g. `https://…/invite?code=ABC123`).
/// 2. It calls [setCode] to store the code here before the onboarding flow
///    has started (or while it is still in progress).
/// 3. During onboarding, the relevant screen reads the current state of this
///    notifier and, when a non-null code is present, pre-fills or auto-submits
///    the invitation code field.
/// 4. Once the code has been consumed, [clear] is called so stale data is not
///    accidentally reused on subsequent launches.
///
/// [keepAlive: true] ensures the code survives navigation and is not discarded
/// when there are temporarily no listeners (e.g. between route transitions).

@ProviderFor(InvitationCodeNotifier)
final invitationCodeProvider = InvitationCodeNotifierProvider._();

/// Temporarily holds an invitation code extracted from a deep link.
///
/// ## Flow
/// 1. [AppLinkService] intercepts an incoming app link (e.g. `https://…/invite?code=ABC123`).
/// 2. It calls [setCode] to store the code here before the onboarding flow
///    has started (or while it is still in progress).
/// 3. During onboarding, the relevant screen reads the current state of this
///    notifier and, when a non-null code is present, pre-fills or auto-submits
///    the invitation code field.
/// 4. Once the code has been consumed, [clear] is called so stale data is not
///    accidentally reused on subsequent launches.
///
/// [keepAlive: true] ensures the code survives navigation and is not discarded
/// when there are temporarily no listeners (e.g. between route transitions).
final class InvitationCodeNotifierProvider
    extends $NotifierProvider<InvitationCodeNotifier, String?> {
  /// Temporarily holds an invitation code extracted from a deep link.
  ///
  /// ## Flow
  /// 1. [AppLinkService] intercepts an incoming app link (e.g. `https://…/invite?code=ABC123`).
  /// 2. It calls [setCode] to store the code here before the onboarding flow
  ///    has started (or while it is still in progress).
  /// 3. During onboarding, the relevant screen reads the current state of this
  ///    notifier and, when a non-null code is present, pre-fills or auto-submits
  ///    the invitation code field.
  /// 4. Once the code has been consumed, [clear] is called so stale data is not
  ///    accidentally reused on subsequent launches.
  ///
  /// [keepAlive: true] ensures the code survives navigation and is not discarded
  /// when there are temporarily no listeners (e.g. between route transitions).
  InvitationCodeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invitationCodeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invitationCodeNotifierHash();

  @$internal
  @override
  InvitationCodeNotifier create() => InvitationCodeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$invitationCodeNotifierHash() =>
    r'ccdec16d1c49654fa1a3fe78eadd2a1b23b02a19';

/// Temporarily holds an invitation code extracted from a deep link.
///
/// ## Flow
/// 1. [AppLinkService] intercepts an incoming app link (e.g. `https://…/invite?code=ABC123`).
/// 2. It calls [setCode] to store the code here before the onboarding flow
///    has started (or while it is still in progress).
/// 3. During onboarding, the relevant screen reads the current state of this
///    notifier and, when a non-null code is present, pre-fills or auto-submits
///    the invitation code field.
/// 4. Once the code has been consumed, [clear] is called so stale data is not
///    accidentally reused on subsequent launches.
///
/// [keepAlive: true] ensures the code survives navigation and is not discarded
/// when there are temporarily no listeners (e.g. between route transitions).

abstract class _$InvitationCodeNotifier extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
