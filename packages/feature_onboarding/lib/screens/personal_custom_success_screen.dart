import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class PersonalCustomSuccessScreen extends ConsumerWidget {
  const PersonalCustomSuccessScreen({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'Server Configured',

      nextButtonAction: NextButtonAction.start,

      onNextButtonPressed: () {
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);

        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },

      builder: (context) => [
        Text(
          'Traffic summaries will be sent to:',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        onboardingTextField(url),

        onboardingSpacer(),

        Text(
          "Press 'Start' below to begin counting.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        Text(
          'Uploads happen automatically every hour. '
          'You can also trigger manual uploads from the upload logs screen.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        Text(
          'Your server does not need to be online yet. '
          'You can start building and testing your backend after counting begins.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
