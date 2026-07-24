import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_l10n/shared_l10n.dart';

import '../widgets/onboarding_scaffold.dart';

class LocalScreen extends ConsumerWidget {
  const LocalScreen({this.token, super.key});

  final String? token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      title: context.l.cta_screen_local,

      nextButtonAction: NextButtonAction.start,

      onNextButtonPressed: () async {
        final appController = ref.read(core_domain.appProvider.notifier);
        await appController.selectNoDataServer();
        final appFlowController = ref.read(core_domain.appFlowProvider.notifier);
        appFlowController.dispatch(const core_domain.AppFlowEvent.startSession());
      },

      builder: (context) => [
        Text(
          context.l.local_screen_text.replaceAll('\\n', '\n\n'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
