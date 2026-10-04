import 'package:app_links/app_links.dart';
import 'package:core_domain/core_domain.dart' as core_domain;

class NativeAppLinkService implements core_domain.AppLinkService {
  NativeAppLinkService(
    this._appFlowController,
    this._invitationCodeController, {
    Future<Uri?> Function()? initialLinkResolver,
    Stream<Uri>? linkStream,
  }) {
    final links = AppLinks();
    _initialLinkResolver = initialLinkResolver ?? links.getInitialLink;
    _linkStream = linkStream ?? links.uriLinkStream;
  }

  late final Future<Uri?> Function() _initialLinkResolver;
  late final Stream<Uri> _linkStream;

  final core_domain.InvitationCodeController _invitationCodeController;

  final core_domain.AppFlowController _appFlowController;

  @override
  Future<void> init() async {
    // Cold start: app opened from a terminated state via a deep link.
    final initialLink = await _initialLinkResolver();
    if (initialLink != null) {
      _handleLink(initialLink);
    }

    // Foreground / background: app already running when a link is tapped.
    _linkStream.listen((uri) {
      _handleLink(uri);
    });
  }

  @override
  void simulateLink(Uri link) {
    _handleLink(link);
  }

  void _handleLink(Uri link) {
    final code = link.queryParameters['code'];
    if (code != null) {
      _invitationCodeController.setCode(code);
      //please  be aware that invitationClicked event will only change screen when app is in checking backend or onboarding state, otherwise this event will be ignored, and user need to restart app to trigger this event again.
      _appFlowController.dispatch(const core_domain.AppFlowEvent.invitationClicked());
    }
  }
}
