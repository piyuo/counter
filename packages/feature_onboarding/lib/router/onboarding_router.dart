import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/screens/invitation_screen.dart';
import 'package:go_router/go_router.dart';

class OnboardingRouter {
  static const String invitation = '/invitation';

  static final routes = [GoRoute(path: invitation, builder: (context, state) => InvitationScreen())];

  static String? _mapAppFlow(core_domain.AppFlow flow) {
    return flow.whenOrNull(onboardingByInvitation: () => invitation);
  }

  static String? guard({required core_domain.AppFlow appFlow, required String currentPath}) {
    // product flow priority
    final flowTarget = _mapAppFlow(appFlow);
    if (flowTarget != null && currentPath != flowTarget) {
      return flowTarget;
    }

    return null;
  }
}
