import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class Onboarding1Screen extends ConsumerWidget {
  const Onboarding1Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: 'Privacy-First by Design',
      showSkipIntro: true,
      onNextButtonPressed: () => ref.push(const core_domain.OpenOnboarding2()),
      builder: (context) => [
        Text(
          'All AI processing happens locally on your device. No video, images, faces, or identities are uploaded.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onboardingSpacer(),
        Text(
          'Only anonymous 5-minute summaries are shared, including counts, occupancy, entries, exits, and dwell time statistics.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        onboardingSpacer(),
        onboardingImage('assets/images/welcome2.png'),
      ],
    );
  }
}
