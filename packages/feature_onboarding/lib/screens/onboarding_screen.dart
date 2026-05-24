import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'AI Traffic Counting',
      showSkipIntro: true,
      onNextButtonPressed: () => ref.push(const core_domain.OpenOnboarding1()),
      builder: (context) => [
        Text(
          'Piyuo Counter uses the built-in camera and on-device AI to detect pedestrians and vehicles in real time.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onboardingSpacer(),
        Text(
          'Track movement, count traffic flow, and measure occupancy automatically using local AI processing.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        onboardingSpacer(),
        onboardingImage('assets/images/welcome1.png'),
      ],
    );
  }
}
