import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class Onboarding2Screen extends ConsumerWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'Runs Automatically 24/7',
      showSkipIntro: true,
      onNextButtonPressed: () => ref.go(const core_domain.OpenOnboardingSystem()),
      builder: (context) => [
        Text(
          'Just start the app and leave it running. Piyuo Counter continuously collects and stores traffic data automatically.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onboardingSpacer(),
        Text(
          'Data summaries are saved every 5 minutes and uploaded hourly to Piyuo Cloud or your own server.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        onboardingSpacer(),
        onboardingImage('assets/images/welcome3.png'),
      ],
    );
  }
}
