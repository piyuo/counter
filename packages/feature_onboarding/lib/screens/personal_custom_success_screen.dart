import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class PersonalCustomSuccessScreen extends ConsumerWidget {
  const PersonalCustomSuccessScreen({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: context.l.personal_custom_success_screen_title,

      nextButtonAction: NextButtonAction.start,

      onNextButtonPressed: () {
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);

        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },

      builder: (context) => [
        Text(
          context.l.personal_custom_success_screen_send_to,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),
        onboardingTextField(context, url),
        onboardingSpacer(),

        Text(
          context.l.personal_custom_success_screen_help2.replaceAll('\\n', '\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onboardingSpacer(),
        Text(
          context.l.personal_custom_success_screen_help.replaceAll('\\n', '\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),
      ],
    );
  }
}
