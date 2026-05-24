import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invitation_code_notifier.g.dart';

abstract class InvitationCodeController {
  /// Stores [code] extracted by [AppLinkService] from an incoming deep link.
  /// Replaces any previously stored code.
  void setCode(String code);

  /// Clears the stored code after it has been consumed by the onboarding flow.
  void clear();
}

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
@Riverpod(keepAlive: true) // do not autoDispose , there are services that depend on, e.g. NativeAppLinkService
class InvitationCodeNotifier extends _$InvitationCodeNotifier implements InvitationCodeController {
  /// Initial state is null — no invitation code has been received yet.
  @override
  String? build() => null;

  /// Stores [code] extracted by [AppLinkService] from an incoming deep link.
  /// Replaces any previously stored code.
  @override
  void setCode(String code) => state = code;

  /// Clears the stored code after it has been consumed by the onboarding flow.
  @override
  void clear() => state = null;
}
