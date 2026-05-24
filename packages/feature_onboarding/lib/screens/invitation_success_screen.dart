import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class InvitationSuccessScreen extends ConsumerWidget {
  const InvitationSuccessScreen({required this.invitation, super.key});

  final core_domain.Invitation invitation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectName = core_domain.getProjectNameFromInvitation(invitation);
    final assignedName = core_domain.getAssignedNameFromInvitation(invitation);

    return OnboardingScaffold(
      automaticallyImplyLeading: false,
      title: 'Setup Complete',
      nextButtonAction: NextButtonAction.start,
      onNextButtonPressed: () {
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);

        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },
      builder: (context) => [
        if (projectName != null && assignedName != null)
          SelectableText(
            'Hello $assignedName, you are connected to $projectName.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

        onboardingSpacer(),

        SelectableText(
          invitation.instruction,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        SelectableText(
          "Press 'Start' below to begin counting. "
          'Traffic summaries will be uploaded automatically.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
