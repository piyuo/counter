import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_link_service.g.dart';

abstract class AppLinkService {
  /// Initializes App Link handling.
  ///
  /// - Handles cold-start links (app opened via a link while terminated).
  /// - Subscribes to foreground / background link events.
  ///
  /// When a link containing a `code` parameter is received:
  /// - The code is stored in [invitationCodeProvider].
  /// - [AppFlowEvent.invitationClicked] is dispatched so the router navigates
  ///   to the invitation onboarding screen if the app flow is in a state that
  ///   accepts it (e.g. [CheckingBackend] or [OnboardingBegin]).
  ///
  Future<void> init();

  /// Simulates an incoming deep link as if the OS had delivered it.
  ///
  /// Useful for manual testing and debug tooling without needing a real device
  /// link. Example: `service.simulateLink(Uri.parse('myapp://invite?code=ABC123'))`
  void simulateLink(Uri link);
}

@riverpod
AppLinkService appLinkService(Ref ref) {
  throw UnimplementedError('appLinkServiceProvider must be overridden');
}
