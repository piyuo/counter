import 'package:feature_onboarding/widgets/onboarding_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class Onboarding2Screen extends ConsumerWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: context.l.onboarding_intro_title3,
      showSkipIntro: true,
      onNextButtonPressed: () => goToCameraTestOrAction(ref),
      builder: (context) => [
        Text(
          context.l.onboarding_intro_text3.replaceAll('\\n', '\n\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onboardingSpacer(),
        onboardingImage('assets/images/welcome3.png'),
      ],
    );
  }
}
