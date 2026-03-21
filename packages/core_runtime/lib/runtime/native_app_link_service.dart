import 'package:app_links/app_links.dart';
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NativeAppLinkService implements core_domain.AppLinkService {
  NativeAppLinkService({Future<Uri?> Function()? initialLinkResolver, Stream<Uri>? linkStream}) {
    final links = AppLinks();
    _initialLinkResolver = initialLinkResolver ?? links.getInitialLink;
    _linkStream = linkStream ?? links.uriLinkStream;
  }

  late final Future<Uri?> Function() _initialLinkResolver;
  late final Stream<Uri> _linkStream;
  Ref? _ref;

  @override
  Future<void> init(Ref ref) async {
    _ref = ref;
    // Cold start: app opened from a terminated state via a deep link.
    final initialLink = await _initialLinkResolver();
    if (initialLink != null) {
      _handleLink(ref, initialLink);
    }

    // Foreground / background: app already running when a link is tapped.
    _linkStream.listen((uri) {
      _handleLink(ref, uri);
    });
  }

  @override
  void simulateLink(Uri link) {
    final ref = _ref;
    if (ref == null) return; // init() not yet called
    _handleLink(ref, link);
  }

  void _handleLink(Ref ref, Uri link) {
    final code = link.queryParameters['code'];
    if (code != null) {
      ref.read(core_domain.invitationCodeProvider.notifier).setCode(code);
      //please  be aware that invitationClicked event will only change screen when app is in checking backend or onboarding state, otherwise this event will be ignored, and user need to restart app to trigger this event again.
      ref.read(core_domain.appFlowProvider.notifier).dispatch(const core_domain.AppFlowEvent.invitationClicked());
    }
  }
}
