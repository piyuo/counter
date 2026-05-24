import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class LocalScreen extends ConsumerWidget {
  const LocalScreen({this.token, super.key});

  final String? token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'Ready to Start Counting',

      nextButtonAction: NextButtonAction.start,

      onNextButtonPressed: () async {
        final appController = ref.read(core_domain.appProvider.notifier);
        await appController.selectNoDataServer();
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },

      builder: (context) => [
        Text(
          'Piyuo Counter will run entirely on this device.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        Text(
          'Traffic data will be stored locally and not uploaded remotely.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        Text(
          'You can connect to Piyuo Cloud or your own server later in Settings.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
