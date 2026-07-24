import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class Onboarding1Screen extends ConsumerWidget {
  const Onboarding1Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: context.l.onboarding_intro_title2,
      showSkipIntro: true,
      onNextButtonPressed: () => ref.push(const core_domain.OpenOnboarding2()),
      builder: (context) => [
        Text(
          context.l.onboarding_intro_text2.replaceAll('\\n', '\n\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onboardingSpacer(),
        onboardingImage('assets/images/welcome2.png'),
      ],
    );
  }
}
